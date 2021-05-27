import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "map", "lat", "lng" ]

  connect() {
    if (typeof(google) != "undefined") {
      this.initMap()
    }
  }

  initMap() {
    this.map = new google.maps.Map(this.mapTarget, {
      center: new google.maps.LatLng(52.10, 19.30),
      zoom: 6
    })
    this.marker = new google.maps.Marker({
      position: new google.maps.LatLng(52.23,19.88),
      map: this.map,
      anchorPoint: new google.maps.Point(52.23,19.88),
      title: "Dyspensaria Cannabis House"
    })
  }
}
