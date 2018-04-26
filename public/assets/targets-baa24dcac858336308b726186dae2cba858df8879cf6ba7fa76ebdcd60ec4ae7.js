(function() {
  var addCircleOverlay, checkNumber, deleteCircleOverlay, mapHtml, mapId, root, setMapZoom;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.map = null;

  root.mapOverlay = null;

  mapId = "mapCanvasId";

  mapHtml = '<div id="mapCanvasId" class="form-control" style="width:100%;height:400px;padding:0px;">Map goes here</div>';

  mapHtml += '<span id="mapAddCircle" class="badge badge-pink crosshair" title="Add a circle overlay to the map">Add Area</span>';

  mapHtml += '&nbsp;&nbsp;&nbsp;&nbsp;<span id="mapDeleteCircle" class="badge badge-grey crosshair" title="Remove the circle overlay.">Remove Area</span>';

  mapHtml += '<input type="hidden" id="mapzoom">';

  mapHtml += '<input type="hidden" id="mapcenter_lat">';

  mapHtml += '<input type="hidden" id="mapcenter_lng">';

  setMapZoom = function() {
    var zoomlevel;
    zoomlevel = root.map.getZoom();
    return $("#mapzoom").val(zoomlevel);
  };

  addCircleOverlay = function(radius) {
    var center, color, lat, lng;
    center = root.map.getCenter();
    lat = center.lat();
    lng = center.lng();
    color = "#FF0066";
    if (isNaN(radius) || radius === null || radius === "") {
      radius = 1000;
    } else {
      radius = Number(radius);
    }
    if (root.mapOverlay) {
      root.mapOverlay.setMap(null);
    }
    return root.mapOverlay = new google.maps.Circle({
      strokeColor: color,
      strokeOpacity: 0.8,
      strokeWeight: 2,
      fillColor: color,
      fillOpacity: 0.35,
      editable: true,
      map: root.map,
      center: new google.maps.LatLng(lat, lng),
      radius: radius
    });
  };

  deleteCircleOverlay = function() {
    if (root.mapOverlay) {
      root.mapOverlay.setMap(null);
    }
    return root.mapOverlay = null;
  };

  checkNumber = function(val, default_val) {
    if (isNaN(val) || val === "" || val === null) {
      val = default_val;
    }
    return Number(val);
  };

  $(document).ready(function() {
    var dtActionCols, dtShowCols;
    console.log("Loading targets coffeescript");
    $("select.nosearch").select2({
      minimumResultsForSearch: Infinity,
      width: '100%'
    });
    $("select.search").select2({
      multiple: "multiple",
      placeholder: "select multiple entries, enter text to filter list",
      width: '100%'
    });
    $('.datepicker').datetimepicker({
      format: "MM/DD/YYYY HH:mm",
      sideBySide: true
    });
    $('select[name="target[campaign_id]"').on('change', function() {
      var id;
      id = $(this).val();
      return $.ajax("/getCampaignDates", {
        type: 'GET',
        data: {
          id: $(this).val()
        },
        success: function(data) {
          data = JSON.parse(data);
          $('input[name="activate_time"]').val(data.start).change();
          return $('input[name="expire_time"]').val(data.end).change();
        }
      });
    });
    $('.mapdialog').on('click', function() {
      return BootstrapDialog.show({
        size: BootstrapDialog.SIZE_WIDE,
        message: mapHtml,
        onshown: function(dialog) {
          var default_lat, default_lng, initZoom, lat, lng, mapOptions, radius;
          default_lat = 37.8236;
          default_lng = -122.4211;
          lat = checkNumber($("input[name='target[geo_latitude]']").val(), default_lat);
          lng = checkNumber($("input[name='target[geo_longitude]']").val(), default_lng);
          radius = $("input[name='target[geo_range]']").val();
          initZoom = 8;
          mapOptions = {
            zoom: initZoom,
            center: {
              lat: lat,
              lng: lng
            },
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            disableDefaultUI: false,
            zoomControl: true
          };
          root.map = new google.maps.Map(document.getElementById("mapCanvasId"), mapOptions);
          if (!isNaN(radius) && radius !== "" && radius !== null) {
            addCircleOverlay(Number(radius));
          }
          $("#mapAddCircle").on('click', function() {
            return addCircleOverlay(radius);
          });
          return $("#mapDeleteCircle").on('click', function() {
            return deleteCircleOverlay();
          });
        },
        buttons: [
          {
            label: 'Cancel',
            cssClass: "btn btn-sm btn-default",
            action: function(dialog) {
              return dialog.close();
            }
          }, {
            label: 'Save',
            cssClass: "btn btn-sm btn-primary",
            action: function(dialog) {
              var center, lat, lng, radius;
              if (!root.mapOverlay) {
                lat = "";
                lng = "";
                radius = "";
              } else {
                radius = parseInt(root.mapOverlay.getRadius());
                center = root.mapOverlay.getCenter();
                lat = Math.round(center.lat() * 100000) / 100000;
                lng = Math.round(center.lng() * 100000) / 100000;
                console.log("circle lat=" + lat + ",lng=" + lng);
              }
              $("input[name='target[geo_latitude]']").val(lat);
              $("input[name='target[geo_longitude]']").val(lng);
              $("input[name='target[geo_range]']").val(radius);
              return dialog.close();
            }
          }
        ]
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
