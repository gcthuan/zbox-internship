# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $(".item").each (event) -> # select all divs with the item class
    max_length = 600 # set the max content length before a read more link will be added
    if $(this).html().length > max_length # check for content length
      short_content = $(this).html().substr(0, max_length) # split the content in two parts
      long_content = $(this).html().substr(max_length)
      $(this).html short_content + "<a href=\"#\" class=\"read_more\"><br/>Read More</a>" + "<span class=\"more_text\" style=\"display:none;\">" + long_content + "</span>" # Alter the html to allow the read more functionality
      $(this).find("a.read_more").click (event) -> # find the a.read_more element within the new html and bind the following code to it
        event.preventDefault() # prevent the a from changing the url
        $(this).hide() # hide the read more button
        $(this).parents(".item").find(".more_text").show() # show the .more_text span
        return
    return
  return

$(document).ready(ready)
$(document).on('page:load', ready)

