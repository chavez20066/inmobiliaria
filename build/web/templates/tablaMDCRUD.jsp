<%--
    Document   : tablaMD
    Created on : 21-dic-2016, 9:57:41
    Author     : jbasurco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/material-design-lite/1.1.0/material.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/dataTables.material.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="../css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
        <link href="../css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>


        <link href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css" rel="stylesheet">
        <link href="https://cdn.datatables.net/buttons/1.2.4/css/buttons.dataTables.min.css" rel="stylesheet">
        <link href="https://cdn.datatables.net/select/1.2.1/css/select.dataTables.min.css" rel="stylesheet">
        <link href="https://editor.datatables.net/extensions/Editor/css/editor.dataTables.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <table id="example" class="display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Position</th>
                        <th>Office</th>
                        <th>Extn.</th>
                        <th>Start date</th>
                        <th>Salary</th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th>Name</th>
                        <th>Position</th>
                        <th>Office</th>
                        <th>Extn.</th>
                        <th>Start date</th>
                        <th>Salary</th>
                    </tr>
                </tfoot>
            </table>
        </div>




        <!--<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
        -->
        <script src="http://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/1.2.4/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.datatables.net/select/1.2.1/js/dataTables.select.min.js"></script>
        <script src="https://editor.datatables.net/extensions/Editor/js/dataTables.editor.min.js"></script>


        <!--  Scripts-->

        <script src="../js/materialize.js"></script>
        <script>
            var editor; // use a global for the submit and return data rendering in the examples

            $(document).ready(function () {
                editor = new $.fn.dataTable.Editor({
                    ajax: "../php/staff.php",
                    table: "#example",
                    fields: [{
                            label: "First name:",
                            name: "first_name"
                        }, {
                            label: "Last name:",
                            name: "last_name"
                        }, {
                            label: "Position:",
                            name: "position"
                        }, {
                            label: "Office:",
                            name: "office"
                        }, {
                            label: "Extension:",
                            name: "extn"
                        }, {
                            label: "Start date:",
                            name: "start_date",
                            type: "datetime"
                        }, {
                            label: "Salary:",
                            name: "salary"
                        }
                    ]
                });

                $('#example').DataTable({
                    dom: "Bfrtip",
                    ajax: "../php/staff.php",
                    columns: [
                        {data: null, render: function (data, type, row) {
                                // Combine the first and last names into a single table field
                                return data.first_name + ' ' + data.last_name;
                            }},
                        {data: "position"},
                        {data: "office"},
                        {data: "extn"},
                        {data: "start_date"},
                        {data: "salary", render: $.fn.dataTable.render.number(',', '.', 0, '$')}
                    ],
                    select: true,
                    buttons: [
                        {extend: "create", editor: editor},
                        {extend: "edit", editor: editor},
                        {extend: "remove", editor: editor}
                    ]
                });
            });
        </script>
        <style>
            /* input:not([type]), input[type="text"],textarea
             {
                 text-transform: uppercase;
             }*/
            #example_wrapper select{
                display: inherit;
            }

        </style>

    </body>
</html>
