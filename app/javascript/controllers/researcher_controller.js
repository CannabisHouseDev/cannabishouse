import { Controller } from "stimulus"

import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["researcher", "update"]

  saveQuestion (e) {
    console.log("save_".concat(e.target.dataset.q))
    const submit = document.getElementById("save_".concat(e.target.dataset.q))
    submit.click()
  }

  confirmResearchUpdate (e) {
    e.preventDefault()
    this.updateTarget.click()
  }

  initialize () {
    window.root = this.researcherTarget;
    }

  connect () {}

  disconnect () {}
}
