import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-login"
export default class extends Controller {
  static targets = ["loginSignup", "overlay", "modalSignup", "modalLogin"];

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
    this.overlayTarget.classList.toggle("hidden")
    this.overlayTarget.classList.toggle("flex")
  }

  toggleOverlaySignup() {
    this.toggle()
    this.toggleOverlay()
    
    setTimeout(() => {
      this.overlayTarget.classList.toggle("opacity-0")
      this.modalSignupTarget.classList.remove("hidden")
      this.modalSignupTarget.classList.toggle("translate-y-10")
      this.modalLoginTarget.classList.add("hidden")
    }, 10)
  }

  toggleOverlayLogin() {
    this.toggle()
    this.toggleOverlay()
    
    setTimeout(() => {
      this.overlayTarget.classList.toggle("opacity-0")
      this.modalLoginTarget.classList.remove("hidden")
      this.modalLoginTarget.classList.toggle("translate-y-10")
      this.modalSignupTarget.classList.add("hidden")
    }, 10)
  }

  closeOnOverlayClick(event) {
    if (event.target === this.overlayTarget && !this.modalSignupTarget.classList.contains("hidden")) {
      this.overlayTarget.classList.add("opacity-0")
      this.modalSignupTarget.classList.add("translate-y-10")
      this.modalLoginTarget.classList.add("translate-y-10")
      
      setTimeout(() => {
        this.overlayTarget.classList.remove("flex")
        this.overlayTarget.classList.add("hidden")
        this.modalSignupTarget.classList.add("hidden")
        this.modalLoginTarget.classList.add("hidden")
        this.toggle()
      }, 300)
    }
  }
}
