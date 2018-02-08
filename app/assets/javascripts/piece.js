Array.prototype.where = function(fun /*, thisp */) {
  "use strict";
  if (this == null) throw new TypeError();
  if (typeof fun != "function") throw new TypeError();

  var t = Object(this), res = [], len = t.length >>> 0, thisp = arguments[1];
  for (var i = 0; i < len; i++) {
    if (i in t) {
      var val = t[i];
      if (fun.call(thisp, val, i, t)) res.push(i);
    }
  }
  return res;
};

function modifyStringAsDom(src, func) {
  return $('<div></div>').append(func($(src))).html();
}

rails = {}

function initializePiecesTable(config) {
  var yadcf_columns = config.map(function(v, i) {
    if(v.filter === 'text')
      return {
        column_number: i,
        filter_type: 'text',
        externally_triggered: true,
        filter_container_id: 'col' + i + '_filter',
        filter_reset_button_text: false
      };
    else
      return {
        column_number: i,
        filter_type: 'none',
      };
  });

  // init
  var table = $('#pieces_table').DataTable({
    language: {
      url: "//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Japanese.json",
    },
    dom: 'lrtip',
    processing: true,
    serverSide: true,
    ajax: $('#pieces_table').data('source'),
    pagingType: "full_numbers",
    columns: config.map(function(v) {
      return {
        title: v.title,
        data: v.data,
        filter: v.filter,
        sortable: v.sortable,
        className: v.className,
        render: v.render,
      };
    }),
  });

   rails.dataTable = table;
  yadcf.init(table, yadcf_columns);
}

