import { Controller } from "stimulus"

import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["participant"]

  updateAnswer (e) {
    let form_id = `${e.currentTarget.dataset.answer}_form`
    let form = document.getElementById(form_id)
    console.log(form)
    Rails.fire(form, 'submit');
  }

  initialize () {
    window.root = this.participantTarget;
    }

  connect () {}

  disconnect () {}
}
