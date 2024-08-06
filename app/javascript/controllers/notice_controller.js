import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "button" ]
  connect() {
    console.log(this.element)
    setTimeout(() => {
      this.buttonTarget.click()
    }, 3000)
  }
}
