root = exports ? this
    
$(document).ready ->
    console.log("Loading rtb_standards coffeescript")
    $("select.nosearch").select2
        minimumResultsForSearch:Infinity
        width: '100%'
    $("select.search").select2
         tags: false
         allowClear: true
         include_blank: true 
         placeholder: "Select or enter value, type to filter list"
         width: '100%'
   $("select.select2_single").select2
         tags: true
         allowClear: true
         include_blank: true 
         placeholder: "Select or enter value, type to filter list"
         width: '100%'
    $("select.select2_multiple").select2
         tags: true
         multiple: "multiple"
         allowClear: true
         include_blank: true 
         placeholder: "Select or enter value"
         width: '100%'
#   Operator map to        
    $("#rtb_standard_operator").on "select2:select", (e) ->
        op = $(this).val()
        ord = null
        type = null
        if op.match /^(EQUALS|NOT_EQUALS|LESS_THAN|LESS_THAN_EQUALS|GREATER_THAN|GREATER_THAN_EQUALS)$/
            ord = "Scalar"
        else if op.match /^(INTERSECTS|NOT_INTERSECTS|MEMBER|NOT_MEMBER)$/
            ord = "List"
        else if op.match /^(STRINGIN|NOT_STRINGIN|REGEX|NOT_REGEX)$/
            ord = "Scalar"
            type = "String" 
        else if op.match /^(INRANGE|NOT_INRANGE)$/
            ord = "List"
            type = "Double"
        else if op.match /^(EXISTS|NOT_EXISTS)$/
            ord = ""
            type = ""
        else #if op.match /^(OR|DOMAIN|NOT_DOMAIN)$/
            ord = null
            type = null
        if type or type==""
            $("#rtb_standard_operand_type option").filter(->
                this.text == type 
            ).attr('selected', true).trigger("change")
        if ord or ord==""
            $("#rtb_standard_operand_ordinal option").filter(->
                this.text == ord 
            ).attr('selected', true).trigger("change") 
#   Disable this. Force user         
#    $("select.select2_single").on "select2:select", (e) ->
#        type = $('option:selected', this).attr("operand_type")
#        ord = $('option:selected', this).attr("operand_ordinal")
#        # Set based on text, not value
#        $("#rtb_standard_operand_type option").filter(->
#            this.text == type 
#        ).attr('selected', true).trigger("change")
#        $("#rtb_standard_operand_ordinal option").filter(->
#            this.text == ord 
#        ).attr('selected', true).trigger("change")
    dtShowCols =  [0,1,2,3,4]
    dtActionCols =  [5,6,7,8]
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
