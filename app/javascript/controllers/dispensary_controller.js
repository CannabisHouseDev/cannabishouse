import { Controller } from "stimulus"

import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["dispensary", "transfer"]
  static values = { material: Number}

  searchScreen(){
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/dispensary_search`,
     success: function(data){
      root.innerHTML = data.body.innerHTML;
     }
    });
  }

  participantScreen () {
    const code = document.getElementById("code").value;
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/dispensary_participant?code=${code}`,
     success: function(data){
      root.innerHTML = data.body.innerHTML;
     }
    });
  }

  materialScreen(){
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/material_choice`,
     success: function(data){
      root.innerHTML = data.body.innerHTML;
     }
    });
  }

  transferScreen (e) {
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/transfer?material=${e.currentTarget.dataset.material}`,
     success: function(data){
      root.innerHTML = data.body.innerHTML;
     }
    });
  }

  finalizeTransfer() {
    let amount = this.transferTarget.value
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/finalize_transfer?amount=${amount}`,
     success: function(data){
      root.innerHTML = data.body.innerHTML;
      toastr.success(`${amount} grams transferred`, 'Success!')
      }
    });
  }

  warehouseScreen() {
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/warehouse_stock`,
     success: function(data){
      root.innerHTML = data.body.innerHTML;
     }
    });
  }

  orderScreen(){
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/order`,
     success: function(data){
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
