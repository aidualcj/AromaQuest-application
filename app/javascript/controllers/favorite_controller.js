import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorite"
export default class extends Controller {
  static targets = ["icon", "notice"];
  changeFavorite(event) {
    event.preventDefault();
    fetch(this.element.href, {
      method: "POST",
      headers: {"Accept": "application/json", "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content')},
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      if (data.favorite) {
        this.iconTarget.classList.remove("fa-regular");
        this.iconTarget.classList.add("fa-solid");
      } else {
        this.iconTarget.classList.remove("fa-solid")
        this.iconTarget.classList.add("fa-regular")
      }
      if (data.notice) {
        this.showNotice(data.notice)
      } else if (data.alert) {
        this.showAlert(data.alert)
      }
    });
  }
  showNotice(message) {
    this.noticeTarget.innerHTML = `<div class="alert alert-success">${message}</div>`;
    setTimeout(() => {
      this.noticeTarget.innerHTML = "";
    }, 3000);
  }

  showAlert(message) {
    this.noticeTarget.innerHTML = `<div class="alert alert-danger">${message}</div>`;
    setTimeout(() => {
      this.noticeTarget.innerHTML = "";
    }, 3000);
  }
}
