# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
    console.log("Loading reports coffeescript")
    $("#load_time").text("Updated "+moment().format("lll (Z)")) 
    $("select.nosearch").select2
        minimumResultsForSearch:Infinity
        width: '150px'
    $("select.search_rules").select2
        tags: false
        allowClear: true
        multiple: "multiple"
        placeholder: "select multiple entries, enter text to filter list"
    $('.datepicker').datetimepicker
        format: "MM/DD/YYYY HH:mm" 
        sideBySide: true

        