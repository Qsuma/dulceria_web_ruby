(function () {
  "use strict";

  document.addEventListener("DOMContentLoaded", function () {
    var drawer = document.getElementById("drawer");
    var toggle = document.querySelector("[data-drawer-toggle]");
    var backdrop = document.querySelector("[data-drawer-backdrop]");
    var links = document.querySelectorAll("[data-drawer-link]");
    var fab = document.querySelector("[data-whatsapp-fab]");

    function openDrawer() {
      drawer.classList.add("drawer-open");
      backdrop.classList.add("drawer-backdrop-visible");
      toggle.setAttribute("aria-expanded", "true");
    }

    function closeDrawer() {
      drawer.classList.remove("drawer-open");
      backdrop.classList.remove("drawer-backdrop-visible");
      toggle.setAttribute("aria-expanded", "false");
    }

    if (toggle && drawer && backdrop) {
      toggle.addEventListener("click", function () {
        if (drawer.classList.contains("drawer-open")) {
          closeDrawer();
        } else {
          openDrawer();
        }
      });

      backdrop.addEventListener("click", closeDrawer);
    }

    links.forEach(function (link) {
      link.addEventListener("click", closeDrawer);
    });

    // Reveal the WhatsApp floating button once the visitor has scrolled near
    // the bottom of the page (within one viewport height of the end).
    if (fab) {
      function updateFabVisibility() {
        var scrollBottom = window.scrollY + window.innerHeight;
        var pageHeight = document.documentElement.scrollHeight;
        var nearEnd = pageHeight - scrollBottom < window.innerHeight;
        fab.classList.toggle("whatsapp-floating-button-visible", nearEnd);
      }

      window.addEventListener("scroll", updateFabVisibility, { passive: true });
      window.addEventListener("resize", updateFabVisibility);
      updateFabVisibility();
    }
  });
})();
