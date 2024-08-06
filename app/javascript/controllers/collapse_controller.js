import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"];
  connect() {
  }

  toggle() {
      this.contentTarget.classList.toggle("d-none");
  }
}
