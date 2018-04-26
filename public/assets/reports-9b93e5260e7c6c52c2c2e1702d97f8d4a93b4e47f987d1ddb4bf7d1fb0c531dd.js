(function() {
  $(document).ready(function() {
    console.log("Loading reports coffeescript");
    $("#load_time").text("Updated " + moment().format("lll (Z)"));
    $("select.nosearch").select2({
      minimumResultsForSearch: Infinity,
      width: '150px'
    });
    $("select.search_rules").select2({
      tags: false,
      allowClear: true,
      multiple: "multiple",
      placeholder: "select multiple entries, enter text to filter list"
    });
    return $('.datepicker').datetimepicker({
      format: "MM/DD/YYYY HH:mm",
      sideBySide: true
    });
  });

}).call(this);
