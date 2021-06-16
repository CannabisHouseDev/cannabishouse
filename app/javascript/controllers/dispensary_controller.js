import { Controller } from "stimulus"

import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["dispensary", "transfer", "start", "end"]
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

  orderScreen(e){
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/order?material=${e.currentTarget.dataset.material}`,
     success: function(data){
      root.innerHTML = data.body.innerHTML;
     }
    });
  }

  filterTransfer(e){
    let start = this.startTarget.value
    let end = this.endTarget.value
    console.log(start)
    console.log(end)
    window.location= `${window.locale == 'en' ? '/en' : ''}/dispensary/transfers?${start ? 'start='+start+'&' : ''}${end ? 'end='+end : ''+'&'}`
  }

  initialize () {
    window.root = this.dispensaryTarget;
    }

  connect () {}

  disconnect () {}
}
