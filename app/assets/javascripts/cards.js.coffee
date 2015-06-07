$(document).on 'page:change', ->

  $(window).on 'resize', ->
    $('.card-container').masonry itemSelector: '.card'

  $('img').load ->
    $('.card-container').masonry itemSelector: '.card'

  $('.card-container').masonry itemSelector: '.card'
  
  $('.card a').hover (->
    $(this).find('h2').addClass 'hover'
    $(this).find('.top_image_message').addClass 'hover'
  ), ->
    $(this).find('h2').removeClass 'hover'
    $(this).find('.top_image_message').removeClass 'hover'
