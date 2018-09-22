// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery.min
//= require jquery.easy-autocomplete
//= require moment-with-locales
//= require popper.min
//= require fullcalendar/fullcalendar.min
//= require fullcalendar/gcal.min
//= require fullcalendar/fr
//= require bootstrap4/alert
//= require bootstrap4/button
//= require bootstrap4/carousel
//= require bootstrap4/collapse
//= require bootstrap4/dropdown
//= require bootstrap4/index
//= require bootstrap4/modal
//= require bootstrap4/scrollspy
//= require bootstrap4/tab
//= require bootstrap4/tooltip
//= require bootstrap4/popover
//= require bootstrap4/util
//= require jquery.jcarousel
//= require jcarousel.responsive
//= require search
//= require filterrific/filterrific-jquery
//= require_tree .

document.addEventListener("turbolinks:load", function() {

  // page is now ready, initialize the calendar...

  $('#calendar').fullCalendar({
    eventSources: [
      'calendar.json'
    ],
    height: 300,
    header: {
      left:   'prev',
      center: 'title',
      right:  'next'
    },

  })

});