import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ticketable"
export default class extends Controller {
  static values = { cancelId: String }
  static targets = [ "cancelBtn" ]

  connect() {
    document.addEventListener("turbo:frame-load", (event) => {
      console.log("frame loaded")
      console.log(event)
      this.showCancelBtns()
    })
  }

  showCancelBtns() {
    console.log("coucou")
    this.cancelBtnTargets.forEach((cancelBtn) => {
      if (cancelBtn.classList.contains(this.cancelIdValue)) {
        if (cancelBtn.classList.contains("hidden")) {
          cancelBtn.classList.remove("hidden")
          console.log("showing cancel btn")
        }
      }
    })
  }
}
