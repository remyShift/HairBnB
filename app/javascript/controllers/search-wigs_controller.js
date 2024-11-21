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

  search(event) {
    event.preventDefault();
    console.log(this.wigNameTarget.value, this.wigLocationTarget.value);
    const url = `${this.formTarget.action}?product=${this.wigNameTarget.value}&location=${this.wigLocationTarget.value}`
    fetch(url, {
      method: "GET",
      headers: { "Accept": "application/json" }
    })
      .then(response => response.json())
      .then((data) => {
        this.wigsContainerTarget.innerHTML = "";
        this.wigsContainerTarget.insertAdjacentHTML('afterbegin', data.filtered_wigs)
      })
  }
}
