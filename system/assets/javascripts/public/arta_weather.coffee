define ()->
  $.extend true,Arta,
    weather:
      setData: (data)->
        $.each data, (k,v)->
          node = $('#xhr_weather')
          if k == 'oicon'
            node.find("img.#{k}").attr('src',v)
          else if k == 'title'
            node.find("img.oicon").attr('title',v)
          else if k == 'forec'
            node.find("a.#{k}").attr('href',v)
          else
            node.find("span.#{k}").text(v)
          return
        return
      getData: ()->
        $request = $.ajax
          url: 'http://api.wunderground.com/api/8130f5f482a61116/astronomy/conditions/lang:RO/q/Romania/Cluj.json'
        .done (data)->
          wco = data.current_observation
          wsp = data.sun_phase
          wmp = data.moon_phase
          wdata =
            otime: wco.observation_time_rfc822.split(' ')[4].slice(0,-3)
            title: wco.weather
            oicon: wco.icon_url.replace('/k/', '/f/')
            tempC: wco.temp_c
            press: (parseFloat(wco.pressure_mb) * 0.75006375541921).toFixed(0)
            prest: switch wco.pressure_trend
                      when '+' then "↑"
                      when '-' then "↓"
                      else ""
            winds: wco.wind_kph
            windd: wco.wind_dir
            humid: wco.relative_humidity
            sunsr: wmp.sunrise.hour + ':' + wmp.sunrise.minute
            sunss: wmp.sunset.hour + ':' + wmp.sunset.minute
            forec: wco.forecast_url
          Arta.weather.setData(wdata)
          return
      init: ()->
        Arta.weather.getData()
        return
  Arta
