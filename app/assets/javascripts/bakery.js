(function () {
  "use strict";

  document.addEventListener("DOMContentLoaded", function () {
    var drawer = document.getElementById("drawer");
    var toggle = document.querySelector("[data-drawer-toggle]");
    var backdrop = document.querySelector("[data-drawer-backdrop]");
    var links = document.querySelectorAll("[data-drawer-link]");
    var fab = document.querySelector("[data-whatsapp-fab]");
    var carousel = document.querySelector("[data-packs-carousel]");
    var customOfferForm = document.querySelector("[data-custom-offer-form]");

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

    if (carousel) {
      var slides = carousel.querySelectorAll("[data-pack-slide]");
      var dots = carousel.querySelectorAll("[data-carousel-dot]");
      var customOfferSection = document.querySelector(".custom-offer-section");
      var currentSlide = 0;
      var track = carousel.querySelector(".packs-track");

      function showSlide(index) {
        currentSlide = (index + slides.length) % slides.length;
        track.dataset.currentSlide = currentSlide;
        track.style.transform = "translate3d(-" + (currentSlide * 100) + "%, 0, 0)";
        dots.forEach(function (dot, dotIndex) {
          dot.classList.toggle("is-active", dotIndex === currentSlide);
          dot.setAttribute("aria-current", dotIndex === currentSlide ? "true" : "false");
        });
        if (currentSlide === slides.length - 1) {
          customOfferSection.classList.add("is-ready");
        }
      }

      dots.forEach(function (dot) {
        dot.setAttribute("aria-current", dot.getAttribute("data-carousel-dot") === "0" ? "true" : "false");
        dot.addEventListener("click", function (event) {
          event.preventDefault();
          event.stopPropagation();
          showSlide(Number(dot.getAttribute("data-carousel-dot")));
        });
      });

      carousel.querySelector("[data-open-custom-offer]").addEventListener("click", function (event) {
        event.preventDefault();
        event.stopPropagation();
        customOfferSection.classList.add("is-visible");
        window.requestAnimationFrame(function () {
          window.requestAnimationFrame(function () {
            customOfferSection.scrollIntoView({ behavior: "smooth", block: "start" });
            customOfferForm.querySelector("[data-product-quantity]").focus({ preventScroll: true });
          });
        });
      });

      showSlide(0);

      var pointerStart = 0;
      carousel.addEventListener("pointerdown", function (event) {
        if (event.target.closest("button, a, input")) {
          pointerStart = null;
          return;
        }
        pointerStart = event.clientX;
      });
      carousel.addEventListener("pointerup", function (event) {
        if (pointerStart === null) return;
        var distance = event.clientX - pointerStart;
        pointerStart = null;
        if (Math.abs(distance) > 45) {
          showSlide(currentSlide + (distance < 0 ? 1 : -1));
        }
      });

      var autoplay = window.setInterval(function () {
        showSlide(currentSlide + 1);
      }, 9000);

      carousel.addEventListener("mouseenter", function () {
        window.clearInterval(autoplay);
      });

      carousel.addEventListener("mouseleave", function () {
        autoplay = window.setInterval(function () {
          showSlide(currentSlide + 1);
        }, 9000);
      });
    }

    if (customOfferForm) {
      var count = customOfferForm.querySelector("[data-selection-count]");
      var feedback = customOfferForm.querySelector("[data-custom-offer-feedback]");
      var quantities = customOfferForm.querySelectorAll("[data-product-quantity]");

      function updateSelection() {
        var total = 0;
        quantities.forEach(function (quantity) {
          total += Number(quantity.value) || 0;
        });
        count.textContent = total;
      }

      quantities.forEach(function (quantity) {
        quantity.addEventListener("input", updateSelection);
      });

      customOfferForm.addEventListener("submit", function (event) {
        event.preventDefault();
        var selected = Array.from(quantities).filter(function (quantity) {
          return Number(quantity.value) > 0;
        }).map(function (quantity) {
          return quantity.value + " " + quantity.name.match(/\[(.*?)\]/)[1];
        });

        if (selected.length === 0) {
          feedback.textContent = "Selecciona al menos un producto para crear tu oferta.";
          return;
        }

        feedback.textContent = "¡Perfecto! Escríbenos para confirmar tu oferta personalizada.";
        var whatsappNumber = customOfferForm.dataset.whatsappNumber;
        window.open("https://wa.me/" + whatsappNumber + "?text=" + encodeURIComponent("Hola, quiero crear una oferta con: " + selected.join(", ") + "."), "_blank", "noopener");
      });
    }

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
