import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = [
    "days",
    "amount"
  ];
  static values = {
    price: Number
  };
  connect() {
    flatpickr(this.element, {
      onClose: this.handleDateChange.bind(this),
      minDate: "today",
      mode: "range"
    });
  }

  handleDateChange(selectedDates) {
    const bookingElement = this.element.parentNode
    const startDate = selectedDates[0];
    const endDate = selectedDates[1];
    if (endDate) {
      const dateRange = (endDate - startDate) / (1000 * 60 * 60 * 24) + 1;
      const template = bookingElement.querySelector("#booking-template");
      const clone = template.content.cloneNode(true);
      clone.querySelector("#days").innerText = dateRange;
      clone.querySelector("#price").innerText = dateRange * this.priceValue;
      bookingElement.appendChild(clone);
    }
  }
}
