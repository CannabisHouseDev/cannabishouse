import { Controller } from "stimulus"

import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["researcher", "update"]

  saveQuestion (e) {
    const submit = document.getElementById("save_".concat(e.target.dataset.q))
    submit.click()
  }

  editStudy () {
    const form = document.getElementById("study_edit_form")
    form.submit()
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
