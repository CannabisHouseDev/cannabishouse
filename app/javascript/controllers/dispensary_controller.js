import { Controller } from "stimulus"

import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["dispensary"]

  showParticipant (e) {
    e.preventDefault();
    const code = document.getElementById("code").value;
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/search?code=${code}`,
     success: function(data){
      console.log(data.body.innerHTML);
      root.innerHTML = data.body.innerHTML;
     }
    });
  }

  transferScreen (e) {
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/trasnfer`,
     success: function(data){
      console.log(data.body.innerHTML);
      root.innerHTML = data.body.innerHTML;
     }
    });
  }

  initialize () {
    window.root = this.dispensaryTarget;
    }

  connect () {}

  disconnect () {}
}
