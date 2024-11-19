import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-wigs"
export default class extends Controller {
  static targets = [
    "form"
  ]
  connect() {
    console.log("search functionnality");
  }

  search(event) {
    event.preventDefault();
    console.log("searching");
    console.log(this.formTarget);
  }
}
