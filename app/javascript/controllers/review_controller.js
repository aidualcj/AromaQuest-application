import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="review"
export default class extends Controller {
  static targets = ["form"];

  connect() {
  }

  toggle(event) {
    event.preventDefault();
    if (this.formTarget.classList.contains("d-none")) {
      this.formTarget.classList.remove("d-none");
    } else {
      this.formTarget.classList.add("d-none");
    }
  }
}
