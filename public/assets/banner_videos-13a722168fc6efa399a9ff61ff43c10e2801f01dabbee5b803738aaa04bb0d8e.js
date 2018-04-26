(function() {
  $(document).ready(function() {
    var dtActionCols, dtShowCols, editor;
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
    return $('#listtable').DataTable({
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
  });

}).call(this);
