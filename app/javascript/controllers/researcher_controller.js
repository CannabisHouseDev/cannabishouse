import { Controller } from "stimulus"

import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["researcher", "update"]

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
