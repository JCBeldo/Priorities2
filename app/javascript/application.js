// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Sortable from "sortablejs";

document.addEventListener("turbo:load", () => {
  const list = document.getElementById("sortable-list");
  const saveBtn = document.getElementById("save-order-button");
  if (!list || !saveBtn) return;

  Sortable.create(list, {
    animation: 150,
  });

    saveBtn.addEventListener( "click", async () => {
      const setId = list.dataset.setId;
      const entries = Array.from(list.querySelectorAll('.sortable-item'));
      const positions = entries.map((el, index) => ({
        id: el.dataset.entryId,
        position: index + 1
      }));

      const response = await fetch(`/submission_sets/${setId}`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
        },
        body: JSON.stringify({ entries: positions })
      });

      let message = document.getElementById("silly-status");
      message.textContent = response.ok ? "Order saved!" : "Error saving order.";
      message.style.color = response.ok ? "green" : "red";
      // setTimeout(() => message.textContent = "", 1500);
  });
});

