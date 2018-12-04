<div class="container">
    <div id="DivUsuarios" class="col s12">
        <h2 class="header center blue-text">Usuarios</h2>
        <div id="cuadro2">
            <form action="" method="POST">
                <div class="row center-align">
                    <h5 class="col s12 m8 l12 text-center">Formulario de Registro de Clientes</h5>
                </div>
                <input type="hidden" id="cod_dni" name="cod_dni" value="0">
                <input type="hidden" id="opcion" name="opcion" value="registrar">
                <div class="row">
                    <div class="input-field col s12 m4">
                        <input id="dni" name="dni" type="text" class="validate">
                        <label for="Dni">Dni</label>
                    </div>
                </div>
                <div class="row ">
                    <div class="input-field col s12 m6">
                        <input id="nombres" name="nombres" type="text" class="validate">
                        <label for="nombres">Nombres</label>
                    </div>
                    <div class="input-field col s12 m6">
                        <input id="apellidos" name="apellidos" type="text" class="validate">
                        <label for="apellidos">Apellidos</label>
                    </div>
                </div>
                <div class="row ">
                    <div class="input-field col s12 m4">
                        <input id="contrasenia" name="contrasenia" type="text" class="validate">
                        <label for="contrasenia">Contraseña:</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s6 m4">
                        <select id="SelectTipoUsuario" name="SelectTipoUsuario">
                            <option value="0" disabled selected>Seleccione una opción</option>
                            <option value="ADMINISTRADOR">ADMINISTRADOR</option>
                            <option value="ASESOR">ASESOR</option>
                            <option value="CAJERO">CAJERO</option>
                        </select>
                        <label>Tipo de Usuario</label>
                    </div>
                </div>
                <div class="row">
                    <div class="center-align">
                        <input id="btnGuardar" type="submit" class="btn btn-primary" value="Guardar">
                        <input id="btnListar" type="button" class="btn btn-primary" value="Listar">
                    </div>
                </div>
            </form>
        </div>
        <div class="row">
            <div class="center-align">
                <p id="mensaje" class="mensaje"></p>
            </div>
        </div>
        <div id="cuadro1">
            <table id="dt_usuarios" class="mdl-data-table" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th></th>
                        <th>DNI</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>Constraseña</th>
                        <th>Tipo de Usuario</th>
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
            <form id="frmEliminar" action="" method="POST">
                <input type="hidden" id="cod_dni" name="cod_dni" value="0">
                <input type="hidden" id="opcion" name="opcion" value="eliminar">
                <!-- Modal Structure -->
                <div id="modalEliminar" class="modal">
                    <div class="modal-content">
                        <h4>Eliminar Usuario</h4>
                        <p>¿Está seguro de eliminar al usuario?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button"  class="modal-action modal-close waves-effect waves-green btn-flat">Cancelar</button>
                        <button type="button" id="btnEliminar" class="btn btn-primary modal-action modal-close waves-effect red white-text" >Aceptar</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

</div>

<script>
    $(document).ready(function () {
        $('.modal').modal();
        $('select').material_select();
        listar();
        guardar();
        eliminar();
        agregar();
    });
    $("#btnListar").on("click", function () {
        listar();
    });
    function guardar() {
        $("form").on("submit", function (e) {
            e.preventDefault();
            var frm = $(this).serialize();
            console.log(frm);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServletV?parAccion=guardarUsuario",
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
        $("#btnEliminar").on("click", function () {
            var cod_dni = $("#frmEliminar #cod_dni").val(),
                    opcion = $("#frmEliminar #opcion").val();
            console.log(cod_dni);
            console.log("eNTRO A ELIMINAR");
            // console.log(opcion);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServletV?parAccion=guardarUsuario",
                data: {"cod_dni": cod_dni, "opcion": opcion}
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
        $("#dni").val("");
        $("#apellidos").val("");
        $("#nombres").val("");
        $("#contrasenia").val("");

        $("#tipo_usuario").find('option').attr("selected", false);
        $("#tipo_usuario option[value=0]").attr("selected", true);
        $('#tipo_usuario').val(0);
        $("#tipo_usuario").material_select();
        Materialize.updateTextFields();
    }
    function listar() {
        $("#cuadro2").slideUp("slow");
        $("#cuadro1").slideDown("slow");
        //var table = $('#dt_asesor').DataTable();


        var table = $("#dt_usuarios").DataTable({
            columnDefs: [{
                    orderable: false,
                    className: 'select-checkbox',
                    targets: 0
                }],
            select: {
                style: 'os',
                selector: 'td:first-child'
            },
            order: [[1, 'asc']],
            "destroy": true,
            "ajax": {
                "method": "POST",
                "url": "<%= request.getContextPath()%>/ControlServletV?parAccion=listaUsuarios"
            },
            "columns": [
                {"defaultContent": ""},
                {"data": "dni"},
                {"data": "nombres"},
                {"data": "apellidos"},
                {"data": "contrasenia"},
                {"data": "tipo_usuario"},
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

        obtener_data_editar(table);
        obtener_id_eliminar(table);
        agregar();
    }
    function agregar() {
        $("#btnAdd").on("click", function () {
            limpiar_datos();
            $("#dni").prop('disabled', false);
            $("#cuadro2").slideDown("slow");
            $("#cuadro1").slideUp("slow");
        });
    }
    function obtener_data_editar(table) {
        $("#btnEditar").on("click", function () {
            var data = table.row('.selected').data();
            console.log(data);
            if (data != null) {
                limpiar_datos();
                $("#cuadro2").slideDown("slow");
                $("#cuadro1").slideUp("slow");
                console.log("EDITAR");
                //alert(data.TipoEgreso);
                $("#cod_dni").val(data.dni);
                $("#dni").val(data.dni);
                $("#dni").prop('disabled', true);
                $("#nombres").val(data.nombres);
                $("#apellidos").val(data.apellidos);
                $("#contrasenia").val(data.contrasenia);
                //$("#tipo_usuario").val(data.tipo_usuario);

                $("#SelectTipoUsuario").find('option').attr("selected", false);
                $("#SelectTipoUsuario option[value='" + data.tipo_usuario + "']").attr("selected", true);
                $('#SelectTipoUsuario').val(data.tipo_usuario);
                $("#SelectTipoUsuario").material_select();

                $("#opcion").val("modificar");
                $("#cuadro2").slideDown("slow");
                $("#cuadro1").slideUp("slow");
                Materialize.updateTextFields();
            } else {
                alert('seleccione una fila');
            }
        });
    }
    function obtener_id_eliminar(table) {

        $("#btnBorrar").on("click", function () {
            console.log("entro eliminar ok");
            var data = table.row('.selected').data();
            if (data != null) {
                console.log(data);
                $("#frmEliminar #cod_dni").val(data.dni);
                $('#modalEliminar').modal('open');
            } else {
                alert('seleccione una fila');
            }
        });
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