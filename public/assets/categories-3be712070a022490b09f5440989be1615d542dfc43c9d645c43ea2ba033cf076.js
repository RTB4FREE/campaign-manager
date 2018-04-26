(function() {
  $(document).ready(function() {
    console.log("loading categories coffeescript");
    $("select.nosearch").select2({
      minimumResultsForSearch: Infinity,
      width: '100%'
    });
    return $("select.search_documents").select2({
      tags: false,
      allowClear: true,
      multiple: "multiple",
      placeholder: "select multiple entries, enter text to filter list",
      width: '100%'
    });
  });

}).call(this);
