# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
    console.log("loading documents coffeescript")
    $("select.nosearch").select2
        minimumResultsForSearch:Infinity
        width: '100%'
    $("select.search_categories").select2
        tags: false
        allowClear: true
        multiple: "multiple"
        placeholder: "select categories"
        width: '100%'
    if ($("#editor_container").length > 0) 
        editor = ace.edit("editor")
        editor.setShowPrintMargin(false)
        editor.setTheme("ace/theme/chrome")
        require("ace/config").set("workerPath", "/ace")
        editor.getSession().setMode("ace/mode/html")
        editor.getSession().setUseWrapMode(true)		
        editor.setValue($('textarea[name="document[code]"]').val())
        editor.clearSelection()
        editor.focus()
        editor.resize()
        $("form").submit () ->
            code = editor.getValue();
            $('textarea[name="document[code]"]').val(code)
        $("#editor_container").resizable
            resize: ( event, ui ) -> 
                editor.resize();
