$ ->
  if $("#home_hero_image").length
    hero_image = $("#home_hero_image").data("imagePath")
    $.vegas src: hero_image
