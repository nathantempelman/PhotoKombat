$(document).on "ready page:load", ->
  $('.see-more').on "click", ->
    id = $(this).data("id")
    shown = $(this).data("shown")
    changes_id = "#changes-#{id}"
 
    if shown
      $(changes_id).addClass("hide")
      $(this).data("shown", false)
      $(this).text("See More...")
    else
      $(changes_id).removeClass("hide")
      $(this).data("shown", true)
      $(this).text("See Less...")
