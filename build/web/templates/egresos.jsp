<div class="container">
    <div id="DivLocalidad" class="col s12">
        <h5>Egresos</h5>
        <div id="cuadro2">
            <form action="" method="POST">
                <div class="row center-align">
                    <h5 class="col s12 m8 l12 text-center">Formulario de Registro de Egresos</h5>
                </div>
                <input type="hidden" id="cod_egreso" name="cod_egreso" value="0">
                <input type="hidden" id="opcion" name="opcion" value="registrar">
                <div class="row">
                    <div class="input-field col s6 m4 offset-m2">
                        <select id="SelectTipoEgreso" name="SelectTipoEgreso">
                            <option value="0" disabled selected>Seleccione una opción</option>
                        </select>
                        <label>Tipo Egreso:</label>
                    </div>
                    <div class="input-field col s6 m4">
                        <select id="SelectSubTipoEgreso" name="SelectSubTipoEgreso">
                            <option value="0" disabled selected>Seleccione una opción</option>
                        </select>
                        <label>Sub Tipo Egreso:</label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s6 m4 offset-m2">
                        <select id="SelectLocalidad" name="SelectLocalidad">
                            <option value="0" disabled selected>Seleccione una opción</option>
                        </select>
                        <label>Localidad:</label>
                    </div>
                    <div class="input-field col s6 m4">
                        <select id="SelectEtapa" name="SelectEtapa">
                            <option value="0" disabled selected>Seleccione una opción</option>
                        </select>
                        <label>Etapa:</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s6 m2 offset-m2">
                        <input id="monto_egreso" name="monto_egreso" type="text" class="validate">
                        <label for="monto">Monto</label>
                    </div>
                </div>
                <div class="row">
                    <div class="col s2 m2 offset-m2">
                        <label for="inicial">Tipo de comprobante:</label>
                        <br>
                        <input name="TipoComprobante" type="radio" id="recibo" value="recibo"/>
                        <label for="recibo">Recibo</label>
                    </div>
                    <div class="col s2 m2">
                        <br>
                        <input name="TipoComprobante" type="radio" id="factura" value="factura" />
                        <label for="factura">Factura</label>
                    </div>
                    <div class="col s2 m2">
                        <br>
                        <input name="TipoComprobante" type="radio" id="otro" value="otro" />
                        <label for="otro">Otro</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12 m8 offset-m2">
                        <input id="nota" name="nota" type="text" class="validate">
                        <label for="nota">nota:</label>
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
            <table id="dt_egresos" class="mdl-data-table" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th></th>
                        <th>Tipo Egreso</th>
                        <th>Sub Tipo Egreso</th>
                        <th>Localidad</th>
                        <th>Etapa</th>
                        <th>Monto Egreso</th>
                        <th>Tipo Comprobante</th>
                        <th>Nota Egreso</th>
                        <th>Fecha</th>
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
                <input type="hidden" id="cod_egreso" name="cod_egreso" value="">
                <input type="hidden" id="opcion" name="opcion" value="eliminar">
                <!-- Modal Structure -->
                <div id="modalEliminar" class="modal">
                    <div class="modal-content">
                        <h4>Eliminar Egreso</h4>
                        <p>¿Está seguro de eliminar Egreso?</p>
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
        inicializar();
    });
    $("#btnListar").on("click", function () {
        listar();
    });
    function inicializar() {

        $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=listaTiposEgresos', {
        }, function (datos) {
            console.log(datos);
            var data_json = JSON.parse(datos);
            $('#SelectTipoEgreso').material_select('destroy');
            $('#SelectTipoEgreso').empty().html(' ');
            $("#SelectTipoEgreso").append('<option value="0" disabled selected>Seleccione una opción</option>');
            $.each(data_json.data, function (id, value) {
                //  $("#SelectTipoEgreso").append('<option value="' + value.cod_tipo_egreso + '">' + value.tipo_egreso + '</option>');
                $("#SelectTipoEgreso").append('<option value="' + value.cod_tipo_egreso + '">' + value.tipo_egreso + '</option>');
            });
            $('#SelectTipoEgreso').material_select();

            $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=listaLocalidad', {
            }, function (datos) {
                console.log(datos);
                var data_json = JSON.parse(datos);
                $('#SelectLocalidad').material_select('destroy');
                $('#SelectLocalidad').empty().html(' ');
                $("#SelectLocalidad").append('<option value="0" disabled selected>Seleccione una opción</option>');
                $.each(data_json.data, function (id, value) {
                    //  $("#SelectTipoEgreso").append('<option value="' + value.cod_tipo_egreso + '">' + value.tipo_egreso + '</option>');
                    $("#SelectLocalidad").append('<option value="' + value.localidad + '">' + value.localidad + '</option>');
                });
                $('#SelectLocalidad').material_select();

                $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=listaEtapa', {
                }, function (datos) {
                    console.log(datos);
                    var data_json = JSON.parse(datos);
                    $('#SelectEtapa').material_select('destroy');
                    $('#SelectEtapa').empty().html(' ');
                    $("#SelectEtapa").append('<option value="0" disabled selected>Seleccione una opción</option>');
                    $.each(data_json.data, function (id, value) {
                        //  $("#SelectTipoEgreso").append('<option value="' + value.cod_tipo_egreso + '">' + value.tipo_egreso + '</option>');
                        $("#SelectEtapa").append('<option value="' + value.etapa + '">' + value.etapa + '</option>');
                    });
                    $('#SelectEtapa').material_select();
                });
            });
        });
    }
    $("#SelectTipoEgreso").on("change", function () {

        var selectTipoEgreso = $("#SelectTipoEgreso").val();
        // var lote = $("#lote").val();

        $.ajax({
            method: "POST",
            url: "<%= request.getContextPath()%>/ControlServlet?parAccion=getSubtipoEgresos",
            data: {"selectTipoEgreso": selectTipoEgreso}
        }).done(function (data) {
            data = JSON.parse(data);
            console.log(data);
            $('#SelectSubTipoEgreso').material_select('destroy');
            $('#SelectSubTipoEgreso').empty().html(' ');
            $("#SelectSubTipoEgreso").append('<option value="0" disabled selected>Seleccione una opción</option>');
            $.each(data.subtiposegresos, function (id, value) {
                $("#SelectSubTipoEgreso").append('<option value="' + value.cod_sub_tipo_egreso + '">' + value.sub_tipo_egreso + '</option>');
            });
            $('#SelectSubTipoEgreso').material_select();

        });
    });

    function guardar() {
        $("form").on("submit", function (e) {
            e.preventDefault();
            var frm = $(this).serialize();
            console.log('guardar');
            console.log(frm);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarEgresos",
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
            var cod_egreso = $("#frmEliminar #cod_egreso").val(),
                    opcion = $("#frmEliminar #opcion").val();
            //console.log(idusuario);
            //console.log("eNTRO A ELIMINAR");
            // console.log(opcion);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarEgresos",
                data: {"cod_egreso": cod_egreso, "opcion": opcion}
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
                
        $("#monto_egreso").val("");       
        $("#nota").val("");
        
        $("#SelectTipoEgreso").find('option').attr("selected", false);
        $("#SelectTipoEgreso option[value=0]").attr("selected", true);
        $('#SelectTipoEgreso').val(0);
        $("#SelectTipoEgreso").material_select();
        
        $("#SelectSubTipoEgreso").find('option').attr("selected", false);
        $("#SelectSubTipoEgreso option[value=0]").attr("selected", true);
        $('#SelectSubTipoEgreso').val(0);
        $("#SelectSubTipoEgreso").material_select();
        
        $("#SelectLocalidad").find('option').attr("selected", false);
        $("#SelectLocalidad option[value=0]").attr("selected", true);
        $('#SelectLocalidad').val(0);
        $("#SelectLocalidad").material_select();
        
        $("#SelectEtapa").find('option').attr("selected", false);
        $("#SelectEtapa option[value=0]").attr("selected", true);
        $('#SelectEtapa').val(0);
        $("#SelectEtapa").material_select();
        
        $("#recibo").prop('checked', false);
        $("#factura").prop('checked', false);
        $("#otro").prop('checked', false);
        
        

        //$('#SelectTipoEgreso').empty().append('whatever');
    }
    function listar() {
        $("#cuadro2").slideUp("slow");
        $("#cuadro1").slideDown("slow");
        //var table = $('#dt_asesor').DataTable();


        var table = $("#dt_egresos").DataTable({
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
                "url": "<%= request.getContextPath()%>/ControlServlet?parAccion=listaEgresos"
            },
            "columns": [
                {"defaultContent": ""},
                {"data": "tipo_egreso"},
                {"data": "sub_tipo_egreso"},
                {"data": "localidad"},
                {"data": "etapa"},
                {"data": "monto_egreso"},
                {"data": "tipo_comprobante"},
                {"data": "nota_egreso"},
                {"data": "fecha_egreso"}
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
            $("#cuadro2").slideDown("slow");
            $("#cuadro1").slideUp("slow");
        });
    }
    function obtener_data_editar(table) {
        $("#btnEditar").on("click", function () {
            var dataSelect = table.row('.selected').data();
            console.log("EDITAR: ");
            console.log(dataSelect);
            if (dataSelect != null) {
                limpiar_datos();
               
                $("#cuadro2").slideDown("slow");
                $("#cuadro1").slideUp("slow");
                $("#cod_egreso").val(dataSelect.cod_egreso);
                
                $("#SelectTipoEgreso").find('option').attr("selected", false);
                $("#SelectTipoEgreso option[value=" + dataSelect.cod_tipo_egreso + "]").attr("selected", true);
                $('#SelectTipoEgreso').val(dataSelect.cod_tipo_egreso);
                $("#SelectTipoEgreso").material_select();               
                               
                $("#SelectLocalidad").find('option').attr("selected", false);
                $("#SelectLocalidad option[value=" + dataSelect.localidad + "]").attr("selected", true);
                $('#SelectLocalidad').val(dataSelect.localidad);
                $("#SelectLocalidad").material_select();
               
                $("#SelectEtapa").find('option').attr("selected", false);
                $("#SelectEtapa option[value='" + dataSelect.etapa + "']").attr("selected", true);
                $('#SelectEtapa').val(dataSelect.etapa);
                $("#SelectEtapa").material_select();
               
                $("#"+dataSelect.tipo_comprobante).prop('checked', true);
                $("#nota").val(dataSelect.nota_egreso);
                $("#monto_egreso").val(dataSelect.monto_egreso);
                Materialize.updateTextFields();
                
                 $.ajax({
                    method: "POST",
                    url: "<%= request.getContextPath()%>/ControlServlet?parAccion=getSubtipoEgresos",
                    data: {"selectTipoEgreso": dataSelect.cod_tipo_egreso}
                }).done(function (data) {
                    data = JSON.parse(data);
                    console.log(data);
                    $('#SelectSubTipoEgreso').material_select('destroy');
                    $('#SelectSubTipoEgreso').empty().html(' ');
                    $("#SelectSubTipoEgreso").append('<option value="0" disabled selected>Seleccione una opción</option>');
                    $.each(data.subtiposegresos, function (id, value) {
                        $("#SelectSubTipoEgreso").append('<option value="' + value.cod_sub_tipo_egreso + '">' + value.sub_tipo_egreso + '</option>');
                    });
                    $('#SelectSubTipoEgreso').material_select();
                    
                    $("#SelectSubTipoEgreso").find('option').attr("selected", false);
                    $("#SelectSubTipoEgreso option[value=" + dataSelect.cod_sub_tipo_egreso + "]").attr("selected", true);
                    $('#SelectSubTipoEgreso').val(dataSelect.cod_sub_tipo_egreso);
                    $("#SelectSubTipoEgreso").material_select();
                });
                
                //alert(data.SubTipoEgreso);
                //var codigoTipoEgreso = dataSelect.cod_tipo_egreso;

                              

                $("#opcion").val("modificar");
                $("#cuadro2").slideDown("slow");
                $("#cuadro1").slideUp("slow");


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
                $("#frmEliminar #cod_egreso").val(data.cod_egreso);
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