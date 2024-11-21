import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      onChange: this.handleDateChange.bind(this)
    });
  }

  handleDateChange(selectedDates, dateStr, instance) {
    const startDate = selectedDates[0];
    const endDate = selectedDates[1];

    if (startDate && endDate) {
      const days = this.calculateDateRangeDays(startDate, endDate);
      console.log(`Nombre de jours: ${days}`);
    }
  }

  calculateDateRangeDays(startDate, endDate) {
    return (endDate - startDate) / (1000 * 60 * 60 * 24) + 1;
  }
}