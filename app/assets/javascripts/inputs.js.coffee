$ ->
  # needed for semanic ui interactions
  $('.ui.dropdown').dropdown()
  $(".message .close").on "click", ->
    $(this).closest(".message").fadeOut()

  # switch between member lists for different years
  $('#year_selector').on "change", ->
    window.location.href = window.location.href.replace( /[\?#].*|$/, "?year=#{this.value}" )
