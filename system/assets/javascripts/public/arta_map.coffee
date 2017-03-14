define ['async!http://maps.google.com/maps/api/js?sensor=false'],()->
  $.extend true,Arta,
    gmap: (node)->
      latlng = new google.maps.LatLng(46.698150, 23.456035);
      myOptions =
        zoom: 14,
        center: latlng,
        scaleControl: false,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      map = new google.maps.Map(node, myOptions)
      marker = new google.maps.Marker
        position: latlng,
        map: map,
        title: "Ladislau Kovács"
      return
  Arta
