import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-wigs"
export default class extends Controller {
  static targets = [
    "form",
    "wigsContainer",
    "wigName",
    "wigLocation"
  ]
  connect() {

  }

  reset(event) {
    this.wigNameTarget.innerHTML = "";
    this.wigLocationTarget.innerHTML = "";
  }
}
