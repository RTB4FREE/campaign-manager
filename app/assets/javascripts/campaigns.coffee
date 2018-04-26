# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
    console.log("Loading campaign coffeescript")
    $("select.nosearch").select2
        minimumResultsForSearch: Infinity
        width: '100%' 
    $("select.search").select2
        tags: false
        allowClear: true
        placeholder: "select one"
        width: '100%'
    $("select.search_rules").select2
        tags: false
        allowClear: true
        multiple: "multiple"
        placeholder: "select multiple entries, enter text to filter list"
        width: '100%'
    $('.datepicker').datetimepicker
        format: "MM/DD/YYYY HH:mm" 
        sideBySide: true
    $('select[name="exchanges[]"]').on 'change', ->
        console.log("exchange selected "+$(this).val())
        if String($(this).val()).match(/adx/)
           $("#noadx_budget").hide()
           $("#adx_budget").show()
        else
           $("#noadx_budget").show()
           $("#adx_budget").hide()
    dtShowCols =  [0,1,2,3,4,5,6]
    dtActionCols =  [7,8,9]
    $('#listtable').DataTable
        dom: 'Bfrtip'
        paging: false
        order: [[ 0, "asc" ]],
        columnDefs: [
            {"targets": dtActionCols,"visible": true,"sortable": false, "className": "noVis"}
            {"targets":dtShowCols,"visible": true,"sortable": true}	
        ]
        colReorder: true
        fixedHeader: true
        stateSave: true
        buttons: [
            { extend:'colvis', className:"btn-xs", columns: dtShowCols, postfixButtons: [ 'colvisRestore' ]}
            { extend:'copyHtml5', className:"btn-xs", columns: dtShowCols}
            { extend:'csvHtml5', className:"btn-xs", columns: dtShowCols}
        ]
    $('#bidder_sync_all').on 'click', ->
        document.body.style.cursor = 'wait'
        $("#bidder_sync_all_response").html('<span class="text-info">Synching bidders. Please wait...</span>')
        id = $(this).val()
        $.ajax "/biddersSynchAll",
            type: 'GET'
            success: (data) ->
                data = JSON.parse(data)
                document.body.style.cursor = 'default'
                if (data.status=="OK")
                    $("#bidder_sync_all_response").html('<span class="text-success">Bidders synch completed OK.</span>')
                else
                    $("#bidder_sync_all_response").html('<span class="text-danger">Error synching bidders.</span>')                
             error: (jqXHR, textStatus, errorThrown) ->
                 document.body.style.cursor = 'default'
                 $("#bidder_sync_all_response").html('<span class="text-danger">Failed sending command. Please try again.</span>')