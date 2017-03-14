define ['jssor','public/arta_map','public/arta_weather'], ()->
  $.extend Arta,
    init: ()->
      Arta.gmap($('#google_map')[0]) if $('#google_map').length
      Arta.weather.init() if $('#xhr_weather').length
      $(document).tooltip
        content: ()->
          $(@).attr('title').replace(/\n/g, "<br/>")
      slider = new $JssorSlider$ 'banner_container'
      slider.$Play()
      slider.$On $JssorSlider$.$EVT_PROGRESS_CHANGE,  (slideIndex, progress, progressBegin, idleBegin, idleEnd, progressEnd)->
        if progress is progressEnd and slideIndex is slider.$SlidesCount() - 1 then slider.$Pause()
        return
      $('.toggle').click ()->
        $(this).next().toggle('blind')
        return
      $('.toggleTab').click ()->
        unless $(this).hasClass 'active'
          $('.toggleTab').toggleClass 'active'
          $('.toggle-tab').toggleClass 'hidden'
          return
      return
  Arta
