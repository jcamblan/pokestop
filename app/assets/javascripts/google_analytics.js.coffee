$(document).on 'turbolinks:load', ->
  if typeof gtag is 'function'
    gtag('config', '127678810-1', {'page_path': window.location.pathname})