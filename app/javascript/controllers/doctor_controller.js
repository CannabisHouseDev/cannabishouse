import { Controller } from "stimulus"

import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["doctor", "slot"]

  evaluate () {
    document.getElementById('evaluation_form').submit()
  }

  initialize () {
    window.root = this.doctorTarget;
  }

  connect () {}

  disconnect () {}

  highlightColumn(el) {
    document.getElementById(`time_${el.target.dataset.col}`).classList.toggle('text-green-500')
    document.getElementById(`day_${el.target.dataset.row}`).classList.toggle('text-green-500')
  }
  unhighlightColumn(el) {
    document.getElementById(`time_${el.target.dataset.col}`).classList.toggle('text-green-500')
    document.getElementById(`day_${el.target.dataset.row}`).classList.toggle('text-green-500')
  }
  setAvailable(el) {
    el.target.classList.toggle('bg-green-700')
    el.target.classList.toggle('bg-opacity-50')
  }
}
