import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flashes"
export default class extends Controller {
  connect() {
    this.fadeAndRemove()
  }

  fadeAndRemove() {
    setTimeout(() => {
      this.element.classList.add('opacity-0')
    }, 3000);
    setTimeout(() => {
      this.element.remove()
    }, 5000);
  }
}
