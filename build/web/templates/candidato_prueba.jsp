<div class="container">
    <h2 class="header center blue-text">Candidatos</h2>
    <div id="cuadro2">
        <form action="" method="POST">
            <div class="row center-align">
                <h5 class="col s12 m8 l6 text-center">Formulario de Registro de Candidatos</h5>
            </div>
            <input type="hidden" id="idusuario" name="idusuario" value="0">
            <input type="hidden" id="opcion" name="opcion" value="registrar">
            <div class="row ">
                <div class="input-field col s12 m6">
                    <input id="nombre" name="nombre" type="text" class="validate">
                    <label for="nombre">Nombres</label>
                </div>
            </div>
            <div class="row ">
                <div class="input-field col s12 m6">
                    <input id="apellidos" name="apellidos" type="text" class="validate">
                    <label for="apellidos">Apellidos</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12 m6">
                    <input id="dni" name="dni" type="text" class="validate">
                    <label for="Dni">Dni</label>
                </div>
            </div>
            <div class="row">
                <div class="col s8 offset-s2">
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

    <div>
        <table id="dt_cliente" class="mdl-data-table" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Apellidos</th>
                    <th>Dni</th>
                    <th>Acciones</th>
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
    </div>

    <div>
        <form id="frmEliminarUsuario" action="" method="POST">
            <input type="hidden" id="idusuario" name="idusuario" value="">
            <input type="hidden" id="opcion" name="opcion" value="eliminar">
            <!-- Modal Structure -->
            <div id="modalEliminar" class="modal">
                <div class="modal-content">
                    <h4>Eliminar Usuario</h4>
                    <p>�Est� seguro de eliminar al usuario?</p>
                </div>
                <div class="modal-footer">
                    <button type="button"  class="modal-action modal-close waves-effect waves-green btn-flat">Cancelar</button>
                    <button type="button" id="eliminar-usuario" class="btn btn-primary modal-action modal-close waves-effect red white-text" >Aceptar</button>

                </div>
            </div>
        </form>
    </div>
</div>
<script>
    $(document).ready(function () {
        listar();
        guardar();
        eliminar();
        agregar();
        $('.modal').modal();

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
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardar",
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
            var idusuario = $("#frmEliminarUsuario #idusuario").val(),
                    opcion = $("#frmEliminarUsuario #opcion").val();
            //console.log(idusuario);
            //console.log("eNTRO A ELIMINAR");
            // console.log(opcion);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardar",
                data: {"idusuario": idusuario, "opcion": opcion}
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
            texto = "<strong>Error</strong>, no se ejecut� la consulta.";
            color = "#C9302C";
        } else if (informacion.respuesta == "EXISTE") {
            texto = "<strong>Informaci�n!</strong> el usuario ya existe.";
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
        $("#idusuario").val("");
        $("#nombre").val("").focus();
        $("#apellidos").val("");
        $("#dni").val("");
    }

    function listar() {
        $("#cuadro2").slideUp("slow");
        $("#cuadro1").slideDown("slow");
        var table = $("#dt_cliente").DataTable({
            "destroy": true,
            "ajax": {
                "method": "POST",
                //"url":"http://localhost:8082/DataTableBootstrap/lista3.php"
                "url": "<%= request.getContextPath()%>/ControlServlet?parAccion=lista"
            },
            "columns": [
                {"data": "nombre"},
                {"data": "apellidos"},
                {"data": "dni"},
                {"defaultContent": "<button type='button' class='editar btn-floating btn-small waves-effect waves-light'><i class='material-icons'>edit</i></button>	<button type='button' class='eliminar btn-floating btn-small waves-effect waves-light red'  data-target='modalEliminar'><i class='material-icons'>delete</i></button>"}
            ],
            "language": idioma_espanol,
            "dom": "<'row'<'form-inline' <'col s5 s-offset-5'B>>>"
                    + "<'row' <'form-inline' <'col s10 m8 l2 toolbar left-align'><'col s10 m8 l4 offset-l6'f>>>"
                    + "<rt>"
                    + "<'dataTable'<'row espacioFooter'"
                    + "<'col s12 m2 l1'l>"
                    + "<'col s12 m10 l11'p>>>",
        });
        $("div.toolbar").html('<a id="btnAdd" title="Agregar usuario" class="btn-floating btn-large waves-effect waves-light red"><i class="material-icons">add</i></a>');
        obtener_data_editar("#dt_cliente tbody", table);
        obtener_id_eliminar("#dt_cliente tbody", table);
        agregar();
    }

    function agregar() {
        $("#btnAdd").on("click", function () {
            limpiar_datos();
            $("#cuadro2").slideDown("slow");
            $("#cuadro1").slideUp("slow");
        });
    }



    function obtener_data_editar(tbody, table) {
        $(tbody).on("click", "button.editar", function () {
            var data = table.row($(this).parents("tr")).data();
            var idusuario = $("#idusuario").val(data.idusuario),
                    nombre = $("#nombre").val(data.nombre),
                    apellidos = $("#apellidos").val(data.apellidos),
                    dni = $("#dni").val(data.dni),
                    opcion = $("#opcion").val("modificar");
            $("#cuadro2").slideDown("slow");
            $("#cuadro1").slideUp("slow");
            Materialize.updateTextFields();
        });
    }

    function obtener_id_eliminar(tbody, table) {
        $(tbody).on("click", "button.eliminar", function () {
            console.log("entro eliminar");
            var data = table.row($(this).parents("tr")).data();
            // console.log($(this).parents("tr"));
            console.log(data);
            var idusuario = $("#frmEliminarUsuario #idusuario").val(data.idusuario);
            //console.log(idusuario);
        });
    }

    var idioma_espanol = {
        "sProcessing": "Procesando...",
        "sLengthMenu": "Mostrar _MENU_ registros",
        "sZeroRecords": "No se encontraron resultados",
        "sEmptyTable": "Ning�n dato disponible en esta tabla",
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
            "sLast": "�ltimo",
            "sNext": "Siguiente",
            "sPrevious": "Anterior"
        },
        "oAria": {
            "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
            "sSortDescending": ": Activar para ordenar la columna de manera descendente"
        }
    }

</script>
