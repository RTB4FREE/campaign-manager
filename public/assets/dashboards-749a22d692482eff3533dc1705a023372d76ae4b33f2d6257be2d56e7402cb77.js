(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  $(document).ready(function() {
    var dtShowCols;
    console.log("Loaded dashboard coffeescript.");
    $("#load_time").text("Updated " + moment().format("lll (Z)"));
    $('[data-toggle="popover"]').popover();
    dtShowCols = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18];
    return $('#listtable').DataTable({
      dom: 'Bfrtip',
      paging: false,
      order: [[0, "asc"]],
      colReorder: true,
      fixedHeader: true,
      buttons: [
        {
          extend: 'colvis',
          className: "btn-xs",
          columns: dtShowCols
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
