root = exports ? this
    
$(document).ready ->
    console.log("Loaded dashboard coffeescript.")
    $("#load_time").text("Updated "+moment().format("lll (Z)")) 
    $('[data-toggle="popover"]').popover() 
    dtShowCols_head =  [0,1,2]
    dtShowCols_1hr =  [3,4,5,6,7]
    dtShowCols_8hr =  [8,9,10,11,12]
    dtShowCols_24hr =  [13,14,15,16,17]
    dtShowCols_all =  [18..22]
    dtShowCols = dtShowCols_head.concat(dtShowCols_1hr).concat(dtShowCols_8hr).concat(dtShowCols_24hr).concat(dtShowCols_all)
    $('.listtable').DataTable
        dom: 'Bfrtip'
        paging: false
        order: [[ 0, "asc" ]],
        columnDefs: [
            {"targets":dtShowCols_head,"visible": true,"sortable": true}	
            {"targets":dtShowCols_1hr,"visible": true,"sortable": true, "className": "col_1hr"}	
            {"targets":dtShowCols_8hr,"visible": true,"sortable": true, "className": "col_8hr"}	
            {"targets":dtShowCols_24hr,"visible": true,"sortable": true, "className": "col_24hr"}	
            {"targets":dtShowCols_all,"visible": true,"sortable": true, "className": "col_all"}	
        ]
        colReorder: true
        fixedHeader: false
        stateSave: true
        buttons: [
            { extend:'colvis', className:"btn-xs", columns: dtShowCols, postfixButtons: [ 'colvisRestore' ]}
            { extend:'copyHtml5', className:"btn-xs", columns: dtShowCols}
            { extend:'csvHtml5', className:"btn-xs", columns: dtShowCols}
        ]
