#= require jquery
#= require bootstrap
#= require jquery.awesomeCloud-0.2.min

$ ->
  $("#link-form").submit (e) -> #use on if jQuery 1.7+
    $("#wordcloud").remove()
    $(".alert").hide()
    e.preventDefault() #prevent form from submitting
    data = $("#link-form :input").serializeArray()
    data[0].value = "https://www.reddit.com/r/AskReddit/comments/2lrb1w/redditors_20_what_was_the_first_thing_you/"  if data[0].value is ""
    if data[0].value.indexOf(".com/r/") < 0
      $(".alert").show()
      return
    $(".sk-spinner").show()
    $.getJSON "tf_idf_values",
      link: data[0].value
    , (result) ->
      arr = $.makeArray(result)
      element = "<div id='wordcloud' style='width:100%;height:100%;'>"
      $.map arr, (value, i) ->
        $.each value, (key, value) ->
          element += "<span data-weight='" + value + "'>" + key + "</span>"
          return

        return

      element += "</div>"
      settings =
        size:
          grid: 8 # word spacing, smaller is more tightly packed
          factor: 0 # font resize factor, 0 means automatic
          normalize: false # reduces outliers for more attractive output

        color:
          background: "rgba(255,255,255,0)" # background color, transparent by default
          start: "#20f" # color of the smallest font, if options.color = "gradient""
          end: "rgb(200,0,0)" # color of the largest font, if options.color = "gradient"

        options:
          color: "gradient" # if "random-light" or "random-dark", color.start and color.end are ignored
          rotationRatio: 0.3 # 0 is all horizontal, 1 is all vertical
          printMultiplier: 1 # set to 3 for nice printer output; higher numbers take longer
          sort: "highest" # "highest" to show big words first, "lowest" to do small words first, "random" to not care

        font: "Helvetica, Arial, sans-serif" # the CSS font-family string
        shape: "circle"
		
      $("#visualization").append element
      $(".sk-spinner").hide()
      $("#wordcloud").awesomeCloud settings
      return

    return

  $("#link").focus ->
    
    #alert('Hello');
    $(this).attr "placeholder", ""
    return

  $("#link").blur ->
    
    #alert('Hello');
    $(this).attr "placeholder", "https://www.reddit.com/r/AskReddit/comments/2lrb1w/redditors_20_what_was_the_first_thing_you/"
    return

  return