<%--
    Document   : newjsp
    Created on : 05-abr-2017, 9:24:02
    Author     : jbasurco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"/>
        <!--Import Google Icon Font-->
      <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
      <!--Import materialize.css-->
      <link type="text/css" rel="stylesheet" href="<%= request.getContextPath()%>/css/materialize.min.css"  media="screen,projection"/>
      <link type="text/css" rel="stylesheet" href="https://cdn.datatables.net/select/1.2.1/css/select.dataTables.min.css"/>

      <!--Let browser know website is optimized for mobile-->
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
        <div id="cuadro2">
        <form action="" method="POST">
            <div class="row center-align">
                <h5 class="col s12 m8 l6 text-center">Formulario de Registro de Asesores</h5>
            </div>
            <input type="hidden" id="cod_asesor" name="cod_asesor" value="0">
            <input type="hidden" id="opcion" name="opcion" value="registrar">
            <div class="row ">
                <div class="input-field col s12 m6">
                    <input id="nombre" name="nombre" type="text" class="validate">
                    <label for="nombre">Nombres</label>
                </div>
                <div class="input-field col s12 m6">
                    <input id="apellidos" name="apellidos" type="text" class="validate">
                    <label for="apellidos">Apellidos</label>
                </div>
            </div>
            <div class="row ">
                <div class="input-field col s12 m12">
                    <input id="direccion" name="direccion" type="text" class="validate">
                    <label for="apellidos">Dirección</label>
                </div>
            </div>
            <div class="row ">
                <div class="input-field col s12 m4">
                    <input id="dni" name="dni" type="text" class="validate">
                    <label for="Dni">Dni</label>
                </div>
                <div class="input-field col s12 m4">
                    <input id="telefono" name="telefono" type="text" class="validate">
                    <label for="apellidos">Teléfono</label>
                </div>
                <div class="input-field col s12 m4">
                    <input id="celular" name="celular" type="text" class="validate">
                    <label for="apellidos">Celular</label>
                </div>
            </div>
            <div class="row">
                <div class="center-align">
                    <input id="btnguardar" type="submit" class="btn btn-primary" value="Guardar">
                    <input id="btn_listar" type="button" class="btn btn-primary" value="Listar">
                </div>
            </div>
        </form>
    </div>
    <div class="row">
        <div class="center-align">
            <p id="mensaje" class="mensaje"></p>
        </div>
    </div>
        
        
        <!--<table id="example" class="display" cellspacing="0" width="100%">-->
        <table id="dt_asesor" class="mdl-data-table" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th></th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Dirección</th>
                    <th>DNI</th>
                    <th>Teléfono</th>
                    <th>Celular</th>
                    <!-- <th>Acciones</th>-->
                </tr>
            </thead>
            <!--<tfoot>
                <tr>
                    <th>Nombre</th>
                    <th>Apellidos</th>
                    <th>Dni</th>
                    <th></th>
                </tr>
            </tfoot>-->
        </table>
        <div>
        <form id="frmEliminarUsuario" action="" method="POST">
            <input type="hidden" id="cod_asesor" name="cod_asesor" value="">
            <input type="hidden" id="opcion" name="opcion" value="eliminar">
            <!-- Modal Structure -->
            <div id="modalEliminar" class="modal">
                <div class="modal-content">
                    <h4>Eliminar Candidato</h4>
                    <p>¿Está seguro de eliminar al candidato?</p>
                </div>
                <div class="modal-footer">
                    <button type="button"  class="modal-action modal-close waves-effect waves-green btn-flat">Cancelar</button>
                    <button type="button" id="eliminar-usuario" class="btn btn-primary modal-action modal-close waves-effect red white-text" >Aceptar</button>

                </div>
            </div>
        </form>
    </div>
        </div>
        <script src="<%= request.getContextPath()%>/js/jquery2.1.1.js" type="text/javascript"></script> 
        
        <script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js" type="text/javascript"></script>         
        <script type="text/javascript" src="https://cdn.datatables.net/select/1.2.1/js/dataTables.select.min.js"></script>
        
      <script type="text/javascript" src="<%= request.getContextPath()%>/js/materialize.min.js"></script>
      
        <script>
            /*$(document).ready(function () {
             var table = $('#example').DataTable();

             $('#example tbody').on('click', 'tr', function () {
             if ($(this).hasClass('selected')) {
             $(this).removeClass('selected');
             } else {
             table.$('tr.selected').removeClass('selected');
             $(this).addClass('selected');
             }
             });

             $('#button').click(function () {
             //table.row('.selected').remove().draw(false);
             var row = table.row('.selected').data();
             console.log(row);

             });
             });*/
             $(document).ready(function () {
                $('.modal').modal();
                listar();
                guardar();
                eliminar();
                agregar();
               

            });
    //alert('entro java');
    /*  $(document).on("ready", function () {
     alert('hola ready');

     });*/

    $("#btn_listar").on("click", function () {
        listar();

    });
    function guardar() {
        $("form").on("submit", function (e) {
            e.preventDefault();
            var frm = $(this).serialize();
            console.log(frm);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarAsesor",
                data: frm
            }).done(function (info) {
                console.log(info);
                //alert(info);
                // var array_return =  $.parseJSON ( info );
                // console.log("valor: "+ array_return);
                var json_info = JSON.parse(info);
                mostrar_mensaje(json_info);
                limpiar_datos();
                listar();
            });
        });
    }
    function eliminar() {
        $("#eliminar-usuario").on("click", function () {
            var cod_asesor = $("#frmEliminarUsuario #cod_asesor").val(),
                    opcion = $("#frmEliminarUsuario #opcion").val();
            //console.log(idusuario);
            //console.log("eNTRO A ELIMINAR");
            // console.log(opcion);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarAsesor",
                data: {"cod_asesor": cod_asesor, "opcion": opcion}
            }).done(function (info) {
                console.log(info);
                var json_info = JSON.parse(info);
                mostrar_mensaje(json_info);
                limpiar_datos();
                listar();
            });
        });
    }

    function mostrar_mensaje(informacion) {
        var texto = "", color = "";
        if (informacion.respuesta == "BIEN") {
            texto = "<strong>Bien!</strong> Se han guardado los cambios correctamente.";
            color = "#379911";
        } else if (informacion.respuesta == "ERROR") {
            texto = "<strong>Error</strong>, no se ejecutó la consulta.";
            color = "#C9302C";
        } else if (informacion.respuesta == "EXISTE") {
            texto = "<strong>Información!</strong> el usuario ya existe.";
            color = "#5b94c5";
        } else if (informacion.respuesta == "VACIO") {
            texto = "<strong>Advertencia!</strong> debe llenar todos los campos solicitados.";
            color = "#ddb11d";
        }
        // console.log(texto);
        $("#mensaje").html(texto).css({"color": color});
        $("#mensaje").fadeOut(5000, function () {
            $(this).html("");
            $(this).fadeIn(3000);
        });
    }

    function limpiar_datos() {
        $("#opcion").val("registrar");
        $("#cod_asesor").val("");
        $("#nombre").val("").focus();
        $("#apellidos").val("");
        $("#dni").val("");
        $("#direccion").val("");
        $("#telefono").val("");
        $("#celular").val("");
    }

    function listar() {
        $("#cuadro2").slideUp("slow");
        $("#cuadro1").slideDown("slow");
        //var table = $('#dt_asesor').DataTable(); 
        
       
        
        var table = $("#dt_asesor").DataTable({   
            columnDefs: [ {
                orderable: false,
                className: 'select-checkbox',
                targets:   0
            } ],
            select: {
                style:    'os',
                selector: 'td:first-child'
            },
            order: [[ 1, 'asc' ]],
            "destroy": true,
            "ajax": {
                "method": "POST",
                //"url":"http://localhost:8082/DataTableBootstrap/lista3.php"
                "url": "<%= request.getContextPath()%>/ControlServlet?parAccion=listaAsesor"
            },
            "columns": [
                {"defaultContent":""},
                {"data": "nombres"},
                {"data": "apellidos"},
                {"data": "direccion"},
                {"data": "dni"},
                {"data": "telefono"},
                {"data": "celular"}/*,
                 {"defaultContent": "<button type='button' class='editar btn-floating btn-small waves-effect waves-light'><i class='material-icons'>edit</i></button>	<button type='button' class='eliminar btn-floating btn-small waves-effect waves-light red'  data-target='modalEliminar'><i class='material-icons'>delete</i></button>"}*/
            ],
            "language": idioma_espanol,
            "dom": "<'row'<'form-inline' <'col s5 s-offset-5'B>>>"
                    + "<'row' <'form-inline' <'col s10 m8 l2 toolbar left-align'><'col s10 m8 l4 offset-l6'f>>>"
                    + "<rt>"
                    + "<'dataTable'<'row espacioFooter'"
                    + "<'col s12 m2 l1'l>"
                    + "<'col s12 m10 l11'p>>>"
        });
        $("div.toolbar").html('<a id="btnAdd" title="Agregar usuario" class="btn-floating btn-large waves-effect waves-light"><i class="material-icons">add</i></a>\n\
         <a id="btnEditar" class="btn-floating btn-large waves-effect waves-light blue"><i class="material-icons">mode_edit</i></a>\n\
        <a id="btnBorrar" class="btn-floating btn-large waves-effect waves-light red"><i class="material-icons">delete</i></a>');

        /*$('#dt_asesor tbody').on('click', 'tr', function () {
            alert('hola');
            if ($(this).hasClass('selected')) {
                $(this).removeClass('selected');
            } else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
        });*/
         obtener_data_editar(table);
         obtener_id_eliminar(table);
         agregar();
    }

    function agregar() {
        $("#btnAdd").on("click", function () {
            limpiar_datos();
            $("#cuadro2").slideDown("slow");
            $("#cuadro1").slideUp("slow");
        });
    }


    function obtener_data_editar(table) {
        $("#btnEditar").on("click", function () {
            var data = table.row('.selected').data();
            console.log(data);
             if(data!=null){
                limpiar_datos();
                $("#cuadro2").slideDown("slow");
                $("#cuadro1").slideUp("slow");
                console.log("EDITAR");

                $("#cod_asesor").val(data.cod_asesor),
                $("#nombre").val(data.nombres),
                $("#apellidos").val(data.apellidos),
                $("#direccion").val(data.direccion),
                $("#dni").val(data.dni),
                $("#telefono").val(data.telefono),
                $("#celular").val(data.celular),
                $("#opcion").val("modificar");
                $("#cuadro2").slideDown("slow");
                $("#cuadro1").slideUp("slow");
                Materialize.updateTextFields();
        }
        else{
            alert('seleccione una fila');
        }
             
        });

        /*$(tbody).on("click", "button.editar", function () {
         var data = table.row($(this).parents("tr")).data();
         console.log(data);
         var cod_asesor = $("#cod_asesor").val(data.cod_asesor),
         nombre = $("#nombre").val(data.nombres),
         apellidos = $("#apellidos").val(data.apellidos),
         direccion = $("#direccion").val(data.direccion),
         dni = $("#dni").val(data.dni),
         telefono = $("#telefono").val(data.telefono),
         celular = $("#celular").val(data.celular),
         opcion = $("#opcion").val("modificar");
         $("#cuadro2").slideDown("slow");
         $("#cuadro1").slideUp("slow");
         Materialize.updateTextFields();
         });*/
    }

    function obtener_id_eliminar(table) {

        $("#btnBorrar").on("click", function () {
            console.log("entro eliminar ok");
            var data = table.row('.selected').data();
            console.log(data);
            $("#frmEliminarUsuario #cod_asesor").val(data.cod_asesor);
             $('#modalEliminar').modal('open');
        });

       /* $(tbody).on("click", "button.eliminar", function () {
            console.log("entro eliminar");
            var data = table.row($(this).parents("tr")).data();
            //console.log($(this).parents("tr"));
            console.log(data);
            var cod_asesor = $("#frmEliminarUsuario #cod_asesor").val(data.cod_asesor);
            //console.log(idusuario);
        });*/
    }

    var idioma_espanol = {
        "sProcessing": "Procesando...",
        "sLengthMenu": "Mostrar _MENU_ registros",
        "sZeroRecords": "No se encontraron resultados",
        "sEmptyTable": "Ningún dato disponible en esta tabla",
        "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
        "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
        "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
        "sInfoPostFix": "",
        "sSearch": "Buscar:",
        "sUrl": "",
        "sInfoThousands": ",",
        "sLoadingRecords": "Cargando...",
        "oPaginate": {
            "sFirst": "Primero",
            "sLast": "Último",
            "sNext": "Siguiente",
            "sPrevious": "Anterior"
        },
        "oAria": {
            "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
            "sSortDescending": ": Activar para ordenar la columna de manera descendente"
        }
    }

        
        </script>
        
    </body>
</html>
