import { Controller } from "stimulus"

import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["participant"]

  updateSurvey (e) {
    let form = document.getElementsByTagName('form')[0].submit()
  }

  initialize () {
    window.root = this.participantTarget;
    }

  connect () {}

  disconnect () {}
}
