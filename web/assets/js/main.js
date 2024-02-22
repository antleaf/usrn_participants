$('document').ready(function() {
    $('.unsorted-table').dataTable({
        "bSort": false,
        "bInfo": false,
        "bFilter": false,
        "bPaginate": false,
        "fixedHeader": false,
        "order": [[0, "asc"]]
    });

    $('.sorted-table').dataTable({
        "bSort": true,
        "bInfo": false,
        "bFilter": false,
        "bPaginate": false,
        "fixedHeader": false,
        "order": [[0, "asc"]],
        "columnDefs": [{targets: ['unsorted-column','actions'], orderable: false}],
        stateSave: true
    });

    $('.reverse-sorted-table').dataTable({
        "bSort": true,
        "bInfo": false,
        "bFilter": false,
        "bPaginate": false,
        "fixedHeader": false,
        "order": [[0, "desc"]],
        "columnDefs": [{targets: ['unsorted-column','actions'], orderable: false}],
    });
});

bb.defaults({
    data: {
        type: "bar",
        // color: function (color, d) {
        //     return "#6082B6";
        // }
    }
});