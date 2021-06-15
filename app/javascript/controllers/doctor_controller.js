import { Controller } from "stimulus"

import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["doctor", "slot"]

  orderScreen(e){
    Rails.ajax({
     type: "get",
     url: `${window.locale == 'en' ? '/en' : ''}/order?material=${e.currentTarget.dataset.material}`,
     success: function(data){
      root.innerHTML = data.body.innerHTML;
     }
    });
  }

  filterTransfer(){
    let start = this.startTarget.value
    let end = this.endTarget.value
    console.log(start)
    console.log(end)
    window.location= `${window.locale == 'en' ? '/en' : ''}/dispensary/transfers?${start ? 'start='+start+'&' : ''}${end ? 'end='+end : ''+'&'}`
  }

  initialize () {
    window.root = this.doctorTarget;
    console.log('initializing')
    }

  connect () {}

  disconnect () {}

  highlightColumn(el) {
    document.getElementById(`time_${el.target.dataset.col}`).classList.toggle('text-green-500')
    document.getElementById(`day_${el.target.dataset.row}`).classList.toggle('text-green-500')
  }
  unhighlightColumn(el) {
    document.getElementById(`time_${el.target.dataset.col}`).classList.toggle('text-green-500')
    document.getElementById(`day_${el.target.dataset.row}`).classList.toggle('text-green-500')
  }
  setAvailable(el) {
    el.target.classList.toggle('bg-green-700')
    el.target.classList.toggle('bg-opacity-50')
  }
}
