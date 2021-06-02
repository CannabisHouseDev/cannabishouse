import { Controller } from "stimulus"

import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["dispensary"]

  showParticipant (e) {
    e.preventDefault();
    const code = document.getElementById("code").value;
    Rails.ajax({
     type: "get",
     url: `/search?code=${code}`,
     success: function(data){
      console.log(data.body.innerHTML);
      root.innerHTML = data.body.innerHTML;
     }
    });
  }

  initialize () {
    window.root = this.dispensaryTarget;
    console.log(root);
    }

  connect () {}

  disconnect () {}
}
