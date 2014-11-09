$ ->
  $('.ui.selection.dropdown').dropdown()
  $('#year_selector').on "change", ->
    window.location.href = window.location.href.replace( /[\?#].*|$/, "?year=#{this.value}" )
