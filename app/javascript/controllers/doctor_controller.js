import { Controller } from "stimulus"

import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["doctor"]

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
    window.root = this.doctorTarget;
    }

  connect () {}

  disconnect () {}
}
