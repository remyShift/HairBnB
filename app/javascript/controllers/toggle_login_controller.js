import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-login"
export default class extends Controller {
  static targets = ["loginSignup"];

  connect() {
  }

  toggle() {
    this.loginSignupTarget.classList.toggle("hidden")
    this.loginSignupTarget.classList.toggle("flex")
    setTimeout(() => {
      this.loginSignupTarget.classList.toggle("opacity-0")
    }, 100)
  }
}
