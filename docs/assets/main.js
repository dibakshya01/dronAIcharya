/* dronAIcharya site — shared behavior
   No external dependencies, no network calls, no eval, no untrusted HTML.
   All motion respects prefers-reduced-motion and pauses when the tab is hidden. */
(function () {
  "use strict";

  var root = document.documentElement;
  var mqReduce = window.matchMedia
    ? window.matchMedia("(prefers-reduced-motion: reduce)")
    : null;
  var reduceMotion = mqReduce ? mqReduce.matches : false;
  var finePointer = window.matchMedia
    ? window.matchMedia("(hover: hover) and (pointer: fine)").matches
    : false;

  function raf(fn) {
    return (window.requestAnimationFrame || function (cb) { return window.setTimeout(cb, 16); })(fn);
  }

  /* ---- Theme toggle (manual, persisted, OS-aware) ------------------- */
  function storedTheme() {
    try { return localStorage.getItem("dron-theme"); } catch (e) { return null; }
  }
  function storeTheme(v) {
    try { localStorage.setItem("dron-theme", v); } catch (e) { /* private mode */ }
  }
  function systemDark() {
    return window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches;
  }
  function effectiveTheme() {
    var t = root.getAttribute("data-theme");
    if (t === "dark" || t === "light") return t;
    return systemDark() ? "dark" : "light";
  }
  function applyTheme(theme) {
    root.setAttribute("data-theme", theme);
    var btns = document.querySelectorAll(".theme-toggle");
    for (var i = 0; i < btns.length; i++) {
      var isDark = theme === "dark";
      btns[i].setAttribute("aria-pressed", String(isDark));
      btns[i].setAttribute(
        "aria-label",
        isDark ? "Switch to light theme" : "Switch to dark theme"
      );
    }
  }

  // Set initial state from storage (inline script in <head> already set the
  // attribute to avoid flash; here we just sync the buttons).
  var initial = storedTheme();
  if (initial === "dark" || initial === "light") {
    applyTheme(initial);
  } else {
    applyTheme(systemDark() ? "dark" : "light");
  }

  document.addEventListener("click", function (e) {
    var toggle = e.target.closest ? e.target.closest(".theme-toggle") : null;
    if (!toggle) return;
    var next = effectiveTheme() === "dark" ? "light" : "dark";
    applyTheme(next);
    storeTheme(next);
  });

  /* ---- Mobile nav disclosure ---------------------------------------- */
  var header = document.querySelector(".site-header");
  var navToggle = document.querySelector(".nav-toggle");
  if (header && navToggle) {
    navToggle.addEventListener("click", function () {
      var open = header.classList.toggle("nav-open");
      navToggle.setAttribute("aria-expanded", String(open));
    });
    header.addEventListener("click", function (e) {
      if (e.target.closest(".nav-links a")) {
        header.classList.remove("nav-open");
        navToggle.setAttribute("aria-expanded", "false");
      }
    });
    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape" && header.classList.contains("nav-open")) {
        header.classList.remove("nav-open");
        navToggle.setAttribute("aria-expanded", "false");
        navToggle.focus();
      }
    });
  }

  /* ---- Scroll reveals (IntersectionObserver + sweep safety net) ----- */
  var revealables = document.querySelectorAll("[data-reveal]");
  if (reduceMotion || !("IntersectionObserver" in window)) {
    for (var r = 0; r < revealables.length; r++) {
      revealables[r].classList.add("is-visible");
    }
  } else {
    var io = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add("is-visible");
            io.unobserve(entry.target);
          }
        });
      },
      { rootMargin: "0px 0px -8% 0px", threshold: 0.12 }
    );
    for (var k = 0; k < revealables.length; k++) io.observe(revealables[k]);

    // Safety net: IntersectionObserver never fires for elements you jump
    // *past* (End key, deep-link anchors, programmatic scroll). On scroll,
    // reveal anything that has reached — or is already above — the fold so
    // no content can get stuck invisible.
    var swTick = false;
    function sweepReveals() {
      swTick = false;
      var vh = window.innerHeight || 0;
      var rem = document.querySelectorAll("[data-reveal]:not(.is-visible)");
      for (var i = 0; i < rem.length; i++) {
        if (rem[i].getBoundingClientRect().top < vh * 0.9) {
          rem[i].classList.add("is-visible");
          io.unobserve(rem[i]);
        }
      }
    }
    function queueSweep() { if (!swTick) { swTick = true; raf(sweepReveals); } }
    window.addEventListener("scroll", queueSweep, { passive: true });
    window.addEventListener("resize", queueSweep, { passive: true });
  }

  /* ---- Copy-to-clipboard buttons ------------------------------------ */
  function execFallback(text) {
    return new Promise(function (resolve, reject) {
      try {
        var ta = document.createElement("textarea");
        ta.value = text;
        ta.setAttribute("readonly", "");
        ta.style.position = "absolute";
        ta.style.left = "-9999px";
        document.body.appendChild(ta);
        ta.select();
        var ok = document.execCommand("copy");
        document.body.removeChild(ta);
        ok ? resolve() : reject();
      } catch (err) { reject(err); }
    });
  }
  function copyText(text) {
    if (navigator.clipboard && navigator.clipboard.writeText) {
      return navigator.clipboard.writeText(text).catch(function () {
        return execFallback(text);
      });
    }
    return execFallback(text);
  }

  var liveRegion = document.getElementById("copy-live");
  function announce(msg) { if (liveRegion) liveRegion.textContent = msg; }

  document.addEventListener("click", function (e) {
    var btn = e.target.closest ? e.target.closest(".copy-btn") : null;
    if (!btn) return;
    var sel = btn.getAttribute("data-copy-target");
    var source = sel ? document.querySelector(sel) : null;
    if (!source) return;
    var text = (source.innerText || source.textContent || "").trim();
    var label = btn.querySelector(".copy-label");
    copyText(text).then(
      function () {
        btn.classList.add("copied");
        if (label) label.textContent = "Copied";
        announce("Command copied to clipboard.");
        window.clearTimeout(btn._t);
        btn._t = window.setTimeout(function () {
          btn.classList.remove("copied");
          if (label) label.textContent = "Copy";
        }, 2200);
      },
      function () {
        if (label) label.textContent = "Press Ctrl+C";
        announce("Copy failed. Select the text and press Ctrl or Cmd + C.");
      }
    );
  });

  /* ---- Footer year -------------------------------------------------- */
  var y = document.getElementById("year");
  if (y) y.textContent = String(new Date().getFullYear());

  /* ==================================================================
     LEVEL-UP MOTION LAYER
     Each module below is purely decorative, transform/opacity/filter
     only, rAF-driven, and skipped entirely under reduced motion.
     ================================================================== */

  /* ---- Scroll progress bar ------------------------------------------ */
  (function scrollProgress() {
    var bar = document.querySelector(".scroll-progress");
    if (!bar || reduceMotion) return;
    var ticking = false;
    function update() {
      ticking = false;
      var h = document.documentElement;
      var max = (h.scrollHeight - h.clientHeight) || 1;
      var p = Math.min(1, Math.max(0, (h.scrollTop || window.pageYOffset) / max));
      bar.style.transform = "scaleX(" + p.toFixed(4) + ")";
    }
    window.addEventListener("scroll", function () {
      if (!ticking) { ticking = true; raf(update); }
    }, { passive: true });
    window.addEventListener("resize", update, { passive: true });
    update();
  })();

  /* ---- Install A/B segmented switch --------------------------------- */
  (function installSwitch() {
    var sw = document.querySelector(".install-switch");
    var chooser = document.querySelector(".chooser");
    if (!sw || !chooser) return;
    var btns = sw.querySelectorAll("button[data-opt]");
    var thumb = sw.querySelector(".switch-thumb");
    chooser.classList.add("has-switch");

    function select(key, focusPanel) {
      for (var i = 0; i < btns.length; i++) {
        var active = btns[i].getAttribute("data-opt") === key;
        btns[i].setAttribute("aria-pressed", String(active));
      }
      if (thumb) thumb.style.setProperty("--thumb", key === "b" ? "100%" : "0%");
      var panels = chooser.querySelectorAll(".opt");
      for (var j = 0; j < panels.length; j++) {
        var match = panels[j].getAttribute("data-opt") === key;
        panels[j].classList.toggle("is-active", match);
        if (match && focusPanel) {
          try { panels[j].scrollIntoView({ block: "nearest", behavior: reduceMotion ? "auto" : "smooth" }); } catch (e) {}
        }
      }
    }
    for (var i = 0; i < btns.length; i++) {
      (function (b) {
        b.addEventListener("click", function () { select(b.getAttribute("data-opt"), true); });
      })(btns[i]);
    }
    select("a", false);
  })();

  /* ---- Pointer-reactive 3D tilt + sheen on cards -------------------- */
  (function cardTilt() {
    if (reduceMotion || !finePointer) return;
    var cards = document.querySelectorAll(".tilt");
    for (var i = 0; i < cards.length; i++) {
      (function (card) {
        var frame = 0;
        card.addEventListener("pointermove", function (e) {
          var rect = card.getBoundingClientRect();
          var mx = e.clientX - rect.left;
          var my = e.clientY - rect.top;
          var rx = (my / rect.height - 0.5) * -6;   // tilt back/forward
          var ry = (mx / rect.width - 0.5) * 6;     // tilt left/right
          if (frame) return;
          frame = raf(function () {
            frame = 0;
            card.style.setProperty("--mx", mx + "px");
            card.style.setProperty("--my", my + "px");
            card.style.transform =
              "perspective(820px) rotateX(" + rx.toFixed(2) + "deg) rotateY(" +
              ry.toFixed(2) + "deg) translateY(-4px)";
          });
        });
        card.addEventListener("pointerleave", function () {
          card.style.transform = "";
        });
      })(cards[i]);
    }
  })();

  /* ---- Hero pointer / scroll parallax ------------------------------- */
  (function heroParallax() {
    var hero = document.querySelector(".hero");
    if (!hero || reduceMotion) return;
    var px = 0, py = 0, frame = 0;
    function apply() {
      frame = 0;
      hero.style.setProperty("--px", px.toFixed(2));
      hero.style.setProperty("--py", py.toFixed(2));
    }
    if (finePointer) {
      hero.addEventListener("pointermove", function (e) {
        var rect = hero.getBoundingClientRect();
        px = ((e.clientX - rect.left) / rect.width - 0.5) * 18;
        py = ((e.clientY - rect.top) / rect.height - 0.5) * 14;
        if (!frame) frame = raf(apply);
      });
      hero.addEventListener("pointerleave", function () {
        px = 0; py = 0;
        if (!frame) frame = raf(apply);
      });
    }
    // gentle scroll drift so it feels alive on touch devices too
    var sTick = false;
    window.addEventListener("scroll", function () {
      if (sTick) return;
      sTick = true;
      raf(function () {
        sTick = false;
        var yoff = (window.pageYOffset || 0);
        py = Math.max(-16, Math.min(16, -yoff * 0.02)) + (finePointer ? py * 0 : 0);
        hero.style.setProperty("--py", py.toFixed(2));
      });
    }, { passive: true });
  })();

  /* ---- Hero particle field (canvas, rAF, visibility-aware) ---------- */
  (function heroParticles() {
    var holder = document.querySelector(".hero-canvas");
    if (!holder || reduceMotion || !("requestAnimationFrame" in window)) return;

    var canvas = document.createElement("canvas");
    var ctx = canvas.getContext ? canvas.getContext("2d") : null;
    if (!ctx) return;
    holder.appendChild(canvas);

    var dpr = Math.min(2, window.devicePixelRatio || 1);
    var w = 0, h = 0, parts = [], running = false, rafId = 0, inView = true;

    function colorFor() {
      return effectiveTheme() === "dark"
        ? "rgba(96,165,250,"
        : "rgba(37,99,235,";
    }

    function size() {
      var rect = holder.getBoundingClientRect();
      w = Math.max(1, rect.width);
      h = Math.max(1, rect.height);
      canvas.width = Math.round(w * dpr);
      canvas.height = Math.round(h * dpr);
      canvas.style.width = w + "px";
      canvas.style.height = h + "px";
      ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
      seed();
    }
    function seed() {
      var area = w * h;
      var count = Math.max(14, Math.min(64, Math.round(area / 16000)));
      parts = [];
      for (var i = 0; i < count; i++) {
        parts.push({
          x: Math.random() * w,
          y: Math.random() * h,
          r: Math.random() * 1.6 + 0.5,
          vx: (Math.random() - 0.5) * 0.14,
          vy: (Math.random() - 0.5) * 0.14 - 0.04,
          a: Math.random() * 0.4 + 0.15
        });
      }
    }
    function frame() {
      if (!running) return;
      ctx.clearRect(0, 0, w, h);
      var base = colorFor();
      for (var i = 0; i < parts.length; i++) {
        var p = parts[i];
        p.x += p.vx; p.y += p.vy;
        if (p.x < -4) p.x = w + 4; else if (p.x > w + 4) p.x = -4;
        if (p.y < -4) p.y = h + 4; else if (p.y > h + 4) p.y = -4;
        ctx.beginPath();
        ctx.fillStyle = base + p.a.toFixed(3) + ")";
        ctx.arc(p.x, p.y, p.r, 0, 6.2832);
        ctx.fill();
      }
      rafId = raf(frame);
    }
    function start() {
      if (running || !inView || document.hidden) return;
      running = true;
      rafId = raf(frame);
    }
    function stop() {
      running = false;
      if (rafId) { (window.cancelAnimationFrame || function () {})(rafId); rafId = 0; }
    }

    size();
    start();

    window.addEventListener("resize", function () {
      dpr = Math.min(2, window.devicePixelRatio || 1);
      size();
    }, { passive: true });

    document.addEventListener("visibilitychange", function () {
      if (document.hidden) stop(); else start();
    });

    if ("IntersectionObserver" in window) {
      var pio = new IntersectionObserver(function (entries) {
        inView = entries[0].isIntersecting;
        if (inView) start(); else stop();
      }, { threshold: 0.01 });
      pio.observe(holder);
    }
  })();

  /* ---- Signature scroll moment: journey trajectory rail ------------- */
  (function journeyRail() {
    var journey = document.querySelector(".journey");
    if (!journey) return;
    var steps = journey.querySelectorAll(".jstep");
    var fill = journey.querySelector(".rail-fill");
    var arrow = journey.querySelector(".rail-arrow");
    var nodes = journey.querySelectorAll(".node");
    if (!steps.length) return;

    // Static / reduced-motion state: everything complete & legible.
    if (reduceMotion) return;

    journey.classList.add("is-enhanced");

    // node Y positions in the rail SVG viewBox (0 0 44 600)
    var ys = [];
    for (var n = 0; n < nodes.length; n++) {
      ys.push(parseFloat(nodes[n].getAttribute("cy")) || 0);
    }
    var last = -1, ticking = false;

    function setActive(idx) {
      if (idx === last) return;
      last = idx;
      for (var i = 0; i < steps.length; i++) {
        steps[i].classList.toggle("is-active", i === idx);
      }
      for (var j = 0; j < nodes.length; j++) {
        nodes[j].classList.toggle("on", j <= idx);
        nodes[j].classList.toggle("dim", j > idx);
      }
      if (fill) {
        var frac = steps.length > 1 ? idx / (steps.length - 1) : 1;
        fill.style.strokeDashoffset = String(1 - frac);
      }
      if (arrow && ys.length) {
        var yPos = ys[Math.max(0, Math.min(ys.length - 1, idx))];
        arrow.style.transform = "translate(22px," + yPos + "px)";
      }
    }

    function compute() {
      ticking = false;
      var line = window.innerHeight * 0.42;
      var active = 0;
      for (var i = 0; i < steps.length; i++) {
        var rect = steps[i].getBoundingClientRect();
        if (rect.top <= line) active = i;
      }
      setActive(active);
    }
    window.addEventListener("scroll", function () {
      if (!ticking) { ticking = true; raf(compute); }
    }, { passive: true });
    window.addEventListener("resize", function () {
      if (!ticking) { ticking = true; raf(compute); }
    }, { passive: true });
    compute();
  })();

  /* ---- Decorative mock terminal (the guru's greeting) --------------- */
  (function terminalTyper() {
    var term = document.querySelector("[data-terminal]");
    if (!term) return;
    var body = term.querySelector(".term-body");
    if (!body) return;

    // Script to type. Static fallback lives in the HTML for no-JS / reduced motion.
    var script = [
      { cls: "term-line", parts: [["term-prompt", "$ "], ["term-cmd", "/dronaicharya:start"]] },
      { cls: "term-line term-resp", parts: [["", "dronAIcharya: "], ["b", "Welcome, student."], ["", " Let’s take aim —"]] },
      { cls: "term-line term-resp", parts: [["", "what shall we build, and understand, today?"]] }
    ];

    if (reduceMotion) return; // keep the static HTML content as-is

    function buildLine(def, withCursor) {
      var line = document.createElement("div");
      line.className = def.cls;
      for (var i = 0; i < def.parts.length; i++) {
        var seg = document.createElement(def.parts[i][0] === "b" ? "b" : "span");
        if (def.parts[i][0] && def.parts[i][0] !== "b") seg.className = def.parts[i][0];
        seg.textContent = "";
        seg.dataset.full = def.parts[i][1];
        line.appendChild(seg);
      }
      if (withCursor) {
        var cur = document.createElement("span");
        cur.className = "term-cursor";
        cur.setAttribute("aria-hidden", "true");
        line.appendChild(cur);
      }
      return line;
    }

    function typeSegment(seg, done) {
      var full = seg.dataset.full || "";
      var i = 0;
      (function tick() {
        if (document.hidden) { window.setTimeout(tick, 120); return; }
        seg.textContent = full.slice(0, i);
        i++;
        if (i <= full.length) window.setTimeout(tick, 34 + Math.random() * 26);
        else done();
      })();
    }

    function typeLine(line, done) {
      var segs = line.querySelectorAll("span[data-full], b[data-full]");
      var idx = 0;
      (function next() {
        if (idx >= segs.length) { done(); return; }
        typeSegment(segs[idx], function () { idx++; next(); });
      })();
    }

    function run() {
      // clear static content, re-type
      body.textContent = "";
      var li = 0;
      (function nextLine() {
        if (li >= script.length) return;
        var isLast = li === script.length - 1;
        var line = buildLine(script[li], isLast);
        body.appendChild(line);
        typeLine(line, function () {
          li++;
          window.setTimeout(nextLine, isLast ? 0 : 420);
        });
      })();
    }

    var started = false;
    function kick() {
      if (started) return;
      started = true;
      window.setTimeout(run, 650);
    }
    if ("IntersectionObserver" in window) {
      var tio = new IntersectionObserver(function (entries) {
        if (entries[0].isIntersecting) { kick(); tio.disconnect(); }
      }, { threshold: 0.3 });
      tio.observe(term);
    } else {
      kick();
    }
  })();

})();
