import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ticketable"
export default class extends Controller {
  static values = { cancelId: String }
  static targets = [ "cancelBtn" ]

  connect() {
    this.showCancelBtns()

  }

  showCancelBtns() {
    this.cancelBtnTargets.forEach((cancelBtn) => {
      if (cancelBtn.classList.contains(this.cancelIdValue)) { cancelBtn.classList.remove("hidden") }
    })
  }
}
