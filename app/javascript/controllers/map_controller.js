// app/javascript/controllers/map_controller.js
import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }
  static values = {
    apiKey: String,
    markers: Array,
  }

  
  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/navigation-day-v1",
    })
    
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    if (this.markersValue.length === 1) {
      this.#animateZoom(18)
    } else {
      this.#animateZoom(4)
    }
  }
  
  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const el = document.createElement('div')
      el.innerHTML = '📍'
      el.className = 'marker text-3xl'
      new mapboxgl.Marker(el)
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(new mapboxgl.Popup({ offset: 25 })
      .setHTML(marker.info_window_html))
      .addTo(this.map)
    })
  }
  
  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #animateZoom(zoomValue) {
    this.map.flyTo({
      zoom: zoomValue,
      duration: 2000,
      essential: true
    });
  }
}
