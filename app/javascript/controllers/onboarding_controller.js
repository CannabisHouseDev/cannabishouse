import { Controller } from "stimulus"

import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["avatarDrop", "input"]

  avatarUpload(e){
    this.inputTarget.click()
  }

  avatarReplace(e){
    let drop = this.avatarDropTarget
    if (e.currentTarget.files && e.currentTarget.files[0]) {
      var reader = new FileReader();

      reader.onload = function(e) {
        drop.getElementsByTagName('img')[0].src = e.target.result
      }

      reader.readAsDataURL(e.currentTarget.files[0]); // convert to base64 string
    }
  }

  initialize () {}

  connect () {}

  disconnect () {}
}
