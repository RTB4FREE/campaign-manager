# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
    console.log("loading categories coffeescript")
    $("select.nosearch").select2
        minimumResultsForSearch:Infinity
        width: '100%'
    $("select.search_documents").select2
        tags: false
        allowClear: true
        multiple: "multiple"
        placeholder: "select multiple entries, enter text to filter list"
        width: '100%'