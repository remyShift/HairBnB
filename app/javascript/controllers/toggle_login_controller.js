import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-login"
export default class extends Controller {
  static targets = ["loginSignup", "overlay", "modal"];

  connect() {
  }

  toggle() {
    this.loginSignupTarget.classList.toggle("hidden")
    this.loginSignupTarget.classList.toggle("flex")
    setTimeout(() => {
      this.loginSignupTarget.classList.toggle("opacity-0")
    }, 100)
  }

  toggleOverlay() {
    this.toggle()
    this.overlayTarget.classList.toggle("hidden")
    this.overlayTarget.classList.toggle("flex")
    
    setTimeout(() => {
      this.overlayTarget.classList.toggle("opacity-0")
      this.modalTarget.classList.toggle("translate-y-10")
    }, 10)
  }

  closeOnOverlayClick(event) {
    if (event.target === this.overlayTarget) {
      this.overlayTarget.classList.add("opacity-0")
      this.modalTarget.classList.add("translate-y-10")
      
      setTimeout(() => {
        this.overlayTarget.classList.remove("flex")
        this.overlayTarget.classList.add("hidden")
        this.toggle()
      }, 300)
    }
  }
}
