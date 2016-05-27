$(document).on 'turbolinks:load', ->
  $('.collapse').collapse('hide')
  $('.dropdown-toggle').dropdown()
  
  $('#filter-form').change ->
    $(this).submit()
