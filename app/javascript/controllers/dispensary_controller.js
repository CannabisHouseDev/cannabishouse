import { Controller } from "stimulus"

import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["dispensary"]
  static values = { material: Number}

  searchScreen(e){
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/dispensary_search`,
     success: function(data){
      console.log(data.body.innerHTML);
      root.innerHTML = data.body.innerHTML;
     }
    });
  }

  participantScreen (e) {
    e.preventDefault();
    const code = document.getElementById("code").value;
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/dispensary_participant?code=${code}`,
     success: function(data){
      console.log(data.body.innerHTML);
      root.innerHTML = data.body.innerHTML;
     }
    });
  }

  materialScreen(e){
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/material_choice`,
     success: function(data){
      console.log(data.body.innerHTML);
      root.innerHTML = data.body.innerHTML;
     }
    });
  }

  transferScreen (e) {
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/transfer?material=${e.currentTarget.dataset.material}`,
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
