Darkswarm.factory "MapConfiguration", ->
  new class MapConfiguration
    options:
      center:
        latitude: 44.5520
        longitude: -69.6317
      cluster_icon: 'assets/map_009-cluster.svg'
      zoom: 12
      additional_options:
        # mapTypeId: 'satellite'
        mapTypeId: 'OSM'
        mapTypeControl: false
        streetViewControl: false
      styles: [{"featureType":"landscape","stylers":[{"saturation":-100},{"lightness":65},{"visibility":"on"}]},{"featureType":"poi","stylers":[{"saturation":-100},{"lightness":51},{"visibility":"simplified"}]},{"featureType":"road.highway","stylers":[{"saturation":-100},{"visibility":"simplified"}]},{"featureType":"road.arterial","stylers":[{"saturation":-100},{"lightness":30},{"visibility":"on"}]},{"featureType":"road.local","stylers":[{"saturation":-100},{"lightness":40},{"visibility":"on"}]},{"featureType":"transit","stylers":[{"saturation":-100},{"visibility":"simplified"}]},{"featureType":"administrative.province","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"labels","stylers":[{"visibility":"on"},{"lightness":-25},{"saturation":-100}]},{"featureType":"water","elementType":"geometry","stylers":[{"hue":"#ffff00"},{"lightness":-25},{"saturation":-97}]},{"featureType":"road","elementType": "labels.icon","stylers":[{"visibility":"off"}]}]

