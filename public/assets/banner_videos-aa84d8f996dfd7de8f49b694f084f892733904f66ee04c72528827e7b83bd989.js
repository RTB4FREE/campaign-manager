(function() {
  $(document).ready(function() {
    var dtActionCols, dtShowCols, editor, propertyRowTemplate;
    console.log("Loading banner_videos coffeescript");
    $("select.nosearch").select2({
      allowClear: true,
      placeholder: "Select an option",
      minimumResultsForSearch: Infinity,
      width: '100%'
    });
    $("select.search_rules").select2({
      tags: false,
      allowClear: true,
      multiple: "multiple",
      placeholder: "select multiple entries, enter text to filter list",
      width: '100%'
    });
    if ($("#editor_container").length > 0) {
      editor = ace.edit("editor");
      editor.setShowPrintMargin(false);
      editor.setTheme("ace/theme/chrome");
      editor.getSession().setUseWorker(false);
      editor.getSession().setMode("ace/mode/html");
      editor.getSession().setUseWrapMode(true);
      editor.setValue($('textarea[name="banner_video[vast_video_outgoing_file]"]').val());
      editor.clearSelection();
      editor.focus();
      editor.resize();
      $("form").submit(function() {
        var code;
        code = editor.getValue();
        return $('textarea[name="banner_video[vast_video_outgoing_file]"]').val(code);
      });
      $("#editor_container").resizable({
        resize: function(event, ui) {
          return editor.resize();
        }
      });
    }
    $('.datepicker').datetimepicker({
      format: "MM/DD/YYYY HH:mm",
      sideBySide: true
    });
    $('select[name="banner_video[campaign_id]"').on('change', function() {
      var id;
      id = $(this).val();
      $.ajax("/getCampaignDates", {
        type: 'GET',
        data: {
          id: $(this).val()
        },
        success: function(data) {
          data = JSON.parse(data);
          $('input[name="interval_start"]').val(data.start).change();
          return $('input[name="interval_end"]').val(data.end).change();
        }
      });
      return $.ajax("/getExchangeAttributes", {
        type: 'GET',
        data: {
          id: id
        },
        success: function(html) {
          $("#exchange_attributes_div").html(html);
          $("select.nosearch").select2({
            allowClear: true,
            placeholder: "Select an option",
            minimumResultsForSearch: Infinity,
            width: '100%'
          });
          return $("select.search_rules").select2({
            tags: false,
            allowClear: true,
            multiple: "multiple",
            placeholder: "select multiple entries, enter text to filter list",
            width: '100%'
          });
        }
      });
    });
    dtShowCols = [0, 1, 2, 3, 4];
    dtActionCols = [5, 6, 7];
    $('#listtable').DataTable({
      dom: 'Bfrtip',
      paging: false,
      order: [[0, "asc"]],
      columnDefs: [
        {
          "targets": dtActionCols,
          "visible": true,
          "sortable": false,
          "className": "noVis"
        }, {
          "targets": dtShowCols,
          "visible": true,
          "sortable": true
        }
      ],
      colReorder: true,
      fixedHeader: true,
      stateSave: true,
      buttons: [
        {
          extend: 'colvis',
          className: "btn-xs",
          columns: dtShowCols,
          postfixButtons: ['colvisRestore']
        }, {
          extend: 'copyHtml5',
          className: "btn-xs",
          columns: dtShowCols
        }, {
          extend: 'csvHtml5',
          className: "btn-xs",
          columns: dtShowCols
        }
      ]
    });
    propertyRowTemplate = '<tr><td><input type="text" class="form-control input-sm" name="deal_id[]"  value=""/></td>';
    propertyRowTemplate += '<td><div class="input-group input-group-sm">';
    propertyRowTemplate += '<span class="input-group-addon">$</span><input type="text" class="form-control input-sm" name="deal_price[]"  value=""/>';
    propertyRowTemplate += '</div></td>';
    propertyRowTemplate += '<td style="vertical-align:middle"><span class="input-sm"><span class="glyphicon glyphicon-plus-sign tableRowAdd"></span></span>';
    propertyRowTemplate += '<span class="input-sm"><span class="glyphicon glyphicon-minus-sign tableRowRemove"></span></span>';
    propertyRowTemplate += '</td></tr>';
    $("#deals_table").on("click", ".tableRowRemove", function() {
      return $(this).closest('tr').remove();
    });
    $("#deals_table").on("click", ".tableRowAdd", function() {
      return $(this).closest('tr').after(propertyRowTemplate);
    });
    $('input[type=radio][name=deal_type]').on('change', function() {
      var val;
      val = $(this).val();
      if (val === "none") {
        return $("#deals_table_div").hide();
      } else {
        $("#deals_table_div").show();
        if (val === "private_only") {
          return $('input[name="banner_video[bid_ecpm]"]').val("0");
        }
      }
    });
    return $('input[type=radio][name=size_match_type]').on('change', function() {
      var val;
      val = $(this).val();
      if (val === "none") {
        $("#width_height_only_div").hide();
        $("#width_height_range_div").hide();
        return $("#width_height_list_div").hide();
      } else if (val === "width_height_only") {
        $("#width_height_only_div").show();
        $("#width_height_range_div").hide();
        return $("#width_height_list_div").hide();
      } else if (val === "width_height_range") {
        $("#width_height_only_div").hide();
        $("#width_height_range_div").show();
        return $("#width_height_list_div").hide();
      } else if (val === "width_height_list") {
        $("#width_height_only_div").hide();
        $("#width_height_range_div").hide();
        return $("#width_height_list_div").show();
      }
    });
  });

}).call(this);
