<div class="container">
    <div id="DivTerrenos" class="col s12">
        <h5>Terreno</h5>
        <div id="cuadro2">
            <form action="" method="POST">
                <div class="row center-align">
                    <h5 class="col s12 m8 l12 text-center">Formulario de Registro de Terrenos</h5>
                </div>
                <input type="hidden" id="cod_terreno" name="cod_terreno" value="0">
                <input type="hidden" id="opcion" name="opcion" value="registrar">
                <div class="row">                    
                    <div class="input-field col s6 m4">
                        <select id="SelectLocalidad" name="SelectLocalidad">
                            <option value="0" disabled selected>Seleccione una opción</option>
                        </select>
                        <label>Localidad:</label>
                    </div>
                </div>
                <div class="row ">
                    <div class="input-field col s6 m4">
                        <select id="SelectEtapa" name="SelectEtapa">
                            <option value="0" disabled selected>Seleccione una opción</option>
                        </select>
                        <label>Etapa:</label>
                    </div>                   
                </div>
                <div class="row ">                    
                    <div class="input-field col s6 m4">
                        <select id="SelectManzana" name="SelectManzana">
                            <option value="0" disabled selected>Seleccione una opción</option>
                        </select>
                        <label>Manzana:</label>
                    </div>    
                </div>
                <div class="row ">                   
                    <div class="input-field col s6 m4">
                        <select id="SelectLote" name="SelectLote">
                            <option value="0" disabled selected>Seleccione una opción</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                        </select>
                        <label>Lote:</label>
                    </div> 
                </div>
                <div class="row">
                    <div class="center-align">
                        <input id="btnguardarTerreno" type="submit" class="btn btn-primary" value="Guardar">
                        <input id="btnListarTerreno" type="button" class="btn btn-primary" value="Listar">
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
            <table id="dt_terreno" class="mdl-data-table" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th></th>
                        <th>Código</th>
                        <th>Localidad</th>
                        <th>Etapa</th>
                        <th>Manzana</th>
                        <th>Lote</th>
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
                <input type="hidden" id="cod_terreno" name="cod_terreno" value="">
                <input type="hidden" id="opcion" name="opcion" value="eliminar">
                <!-- Modal Structure -->
                <div id="modalEliminarTerreno" class="modal">
                    <div class="modal-content">
                        <h4>Eliminar terreno</h4>
                        <p>¿Está seguro de eliminar el terreno?</p>
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
        listarTerreno();
        guardarTerreno();
        eliminarTerreno();
        agregarTerreno();
       
    });
    $("#btnListarTerreno").on("click", function () {
        listarTerreno();
    });   
    function guardarTerreno() {
        $("form").on("submit", function (e) {
            e.preventDefault();
            var frm = $(this).serialize();
            console.log("formulario");
            console.log(frm);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarTerreno",
                data: frm
            }).done(function (info) {
                console.log(info);
                //alert(info);
                // var array_return =  $.parseJSON ( info );
                // console.log("valor: "+ array_return);
                var json_info = JSON.parse(info);
                mostrar_mensaje(json_info);
                limpiar_datos();
                listarTerreno();
            });
        });
    }
    function eliminarTerreno() {
        $("#btnEliminar").on("click", function () {
            var cod_terreno = $("#frmEliminar #cod_terreno").val(),
                    opcion = $("#frmEliminar #opcion").val();
            //console.log(idusuario);
            //console.log("eNTRO A ELIMINAR");
            // console.log(opcion);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarTerreno",
                data: {"cod_terreno": cod_terreno, "opcion": opcion}
            }).done(function (info) {
                console.log(info);
                var json_info = JSON.parse(info);
                mostrar_mensaje(json_info);
                limpiar_datos();
                listarTerreno();
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
        $("#localidad").val("");
        $("#etapa").val("");
        $("#manzana").val("");
        $("#lote").val("");
    }
    function listarTerreno() {
        $("#cuadro2").slideUp("slow");
        $("#cuadro1").slideDown("slow");
        //var table = $('#dt_asesor').DataTable();


        var table = $("#dt_terreno").DataTable({
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
                "url": "<%= request.getContextPath()%>/ControlServlet?parAccion=listaTerreno"
            },
            "columns": [
                {"defaultContent": ""},
                {"data": "cod_terreno"},
                {"data": "localidad"},
                {"data": "etapa"},
                {"data": "manzana"},
                {"data": "lote"},
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

        obtener_data_editar_terreno(table);
        obtener_id_eliminar_terreno(table);
        agregarTerreno();
    }
     function setLocalidadEtapaManzana(){
        $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=getLocalEtapaManzana', {
            }, function (datos) {
                console.log(datos);
                var data_json = JSON.parse(datos);
                $('#SelectLocalidad').material_select('destroy');
                $('#SelectLocalidad').empty().html(' ');
                $("#SelectLocalidad").append('<option value="0" disabled selected>Seleccione una opción</option>');
                $.each(data_json.localidades, function (id, value) {
                    //  $("#SelectTipoEgreso").append('<option value="' + value.cod_tipo_egreso + '">' + value.tipo_egreso + '</option>');
                    $("#SelectLocalidad").append('<option value="' + value.localidad + '">' + value.localidad + '</option>');
                });
                $('#SelectLocalidad').material_select();
                
                 $('#SelectEtapa').material_select('destroy');
                $('#SelectEtapa').empty().html(' ');
                $("#SelectEtapa").append('<option value="0" disabled selected>Seleccione una opción</option>');
                $.each(data_json.etapas, function (id, value) {
                    //  $("#SelectTipoEgreso").append('<option value="' + value.cod_tipo_egreso + '">' + value.tipo_egreso + '</option>');
                    $("#SelectEtapa").append('<option value="' + value.etapa + '">' + value.etapa + '</option>');
                });
                $('#SelectEtapa').material_select();
                
                $('#SelectManzana').material_select('destroy');
                $('#SelectManzana').empty().html(' ');
                $("#SelectManzana").append('<option value="0" disabled selected>Seleccione una opción</option>');
                $.each(data_json.manzanas, function (id, value) {
                    //  $("#SelectTipoEgreso").append('<option value="' + value.cod_tipo_egreso + '">' + value.tipo_egreso + '</option>');
                    $("#SelectManzana").append('<option value="' + value.manzana + '">' + value.manzana + '</option>');
                });
                $('#SelectManzana').material_select();               
            });
      
    }
    function agregarTerreno() {
        $("#btnAdd").on("click", function () {
            limpiar_datos();
            $("#cuadro2").slideDown("slow");
            $("#cuadro1").slideUp("slow");            
            setLocalidadEtapaManzana();
        });
    }
   
    function obtener_data_editar_terreno(table) {
        $("#btnEditar").on("click", function () {
            var data = table.row('.selected').data();
            console.log(data);
            if (data != null) {
                limpiar_datos();
                $("#cuadro2").slideDown("slow");
                $("#cuadro1").slideUp("slow");
                console.log("EDITAR");
                //alert(data.terreno);
                 $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=getLocalEtapaManzana', {
                }, function (datos) {
                    console.log(datos);
                    var data_json = JSON.parse(datos);
                    $("#cod_terreno").val(data.cod_terreno);

                    $('#SelectLocalidad').material_select('destroy');
                    $('#SelectLocalidad').empty().html(' ');
                    $("#SelectLocalidad").append('<option value="0" disabled>Seleccione una opción</option>');
                    $.each(data_json.localidades, function (id, value) {
                        //  $("#SelectTipoEgreso").append('<option value="' + value.cod_tipo_egreso + '">' + value.tipo_egreso + '</option>');
                        $("#SelectLocalidad").append('<option value="' + value.localidad + '">' + value.localidad + '</option>');
                    });
                    $("#SelectLocalidad option[value='" + data.localidad + "']").attr("selected", true);
                    $('#SelectLocalidad').val(data.localidad);
                    $('#SelectLocalidad').material_select();

                     $('#SelectEtapa').material_select('destroy');
                    $('#SelectEtapa').empty().html(' ');
                    $("#SelectEtapa").append('<option value="0" disabled>Seleccione una opción</option>');
                    $.each(data_json.etapas, function (id, value) {
                        //  $("#SelectTipoEgreso").append('<option value="' + value.cod_tipo_egreso + '">' + value.tipo_egreso + '</option>');
                        $("#SelectEtapa").append('<option value="' + value.etapa + '">' + value.etapa + '</option>');
                    });
                    $("#SelectEtapa option[value='" + data.etapa + "']").attr("selected", true);
                    $('#SelectEtapa').val(data.etapa);
                    $('#SelectEtapa').material_select();

                    $('#SelectManzana').material_select('destroy');
                    $('#SelectManzana').empty().html(' ');
                    $("#SelectManzana").append('<option value="0" disabled>Seleccione una opción</option>');
                    $.each(data_json.manzanas, function (id, value) {
                        //  $("#SelectTipoEgreso").append('<option value="' + value.cod_tipo_egreso + '">' + value.tipo_egreso + '</option>');
                        $("#SelectManzana").append('<option value="' + value.manzana + '">' + value.manzana + '</option>');
                    });
                    $("#SelectManzana option[value='" + data.manzana + "']").attr("selected", true);
                    $('#SelectManzana').val(data.manzana);
                    $('#SelectManzana').material_select();    

                    $("#SelectLote").find('option').attr("selected", false);
                    $("#SelectLote option[value='" + data.lote + "']").attr("selected", true);
                    $('#SelectLote').val(data.lote);
                    $("#SelectLote").material_select();
                });
                 
                $("#opcion").val("modificar");
                $("#cuadro2").slideDown("slow");
                $("#cuadro1").slideUp("slow");
                Materialize.updateTextFields();
            } else {
                alert('seleccione una fila');
            }
        });
    }
    function obtener_id_eliminar_terreno(table) {

        $("#btnBorrar").on("click", function () {
            console.log("entro eliminar ok");
            var data = table.row('.selected').data();
            if (data != null) {
                console.log(data);
                $("#frmEliminar #cod_terreno").val(data.cod_terreno);
                $('#modalEliminarTerreno').modal('open');
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