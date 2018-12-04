<div class="container">
     <div id="DivLocalidad" class="col s12">
        <h5>Localidad</h5>
        <div id="cuadro2">
            <form action="" method="POST">
                <div class="row center-align">
                    <h5 class="col s12 m8 l12 text-center">Formulario de Registro de Localidades</h5>
                </div>
                <input type="hidden" id="cod_localidad" name="cod_localidad" value="0">
                <input type="hidden" id="opcion" name="opcion" value="registrar">
                <div class="row">
                    <div class="input-field col s12 m4">
                        <input id="localidad" name="localidad" type="text" class="validate">
                        <label for="Localidad">Localidad</label>
                    </div>
                </div>                            
                <div class="row">
                    <div class="center-align">
                        <input id="btnguardarLocalidad" type="submit" class="btn btn-primary" value="Guardar">
                        <input id="btn_listarLocalidad" type="button" class="btn btn-primary" value="Listar">
                    </div>
                </div>
            </form>
        </div>
        <div class="row">
            <div class="center-align">
                <p id="mensajeLocalidad" class="mensaje"></p>
            </div>
        </div>    
        <div id="cuadro1">
            <table id="dt_localidad" class="mdl-data-table" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th></th>
                        <th>codigo Localidad</th>
                        <th>localidad</th>                                   
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
            <form id="frmEliminarLocalidad" action="" method="POST">
                <input type="hidden" id="cod_localidad" name="cod_localidad" value="">
                <input type="hidden" id="opcion" name="opcion" value="eliminar">
                <!-- Modal Structure -->
                <div id="modalEliminarLocalidad" class="modal">
                    <div class="modal-content">
                        <h4>Eliminar Candidato</h4>
                        <p>¿Está seguro de eliminar al candidato?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button"  class="modal-action modal-close waves-effect waves-green btn-flat">Cancelar</button>
                        <button type="button" id="btnEliminarLocalidad" class="btn btn-primary modal-action modal-close waves-effect red white-text" >Aceptar</button>
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
        listarLocalidad();
        guardarLocalidad();
        eliminarLocalidad();
        agregarLocalidad();
    });
    $("#btn_listarLocalidad").on("click", function () {
        listarLocalidad();
    });
    function guardarLocalidad() {
        $("form").on("submit", function (e) {
            e.preventDefault();
            var frm = $(this).serialize();
            console.log(frm);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarLocalidad",
                data: frm
            }).done(function (info) {
                console.log(info);
                //alert(info);
                // var array_return =  $.parseJSON ( info );
                // console.log("valor: "+ array_return);
                var json_info = JSON.parse(info);
                mostrar_mensajeLocalidad(json_info);
                limpiar_datosLocalidad();
                listarLocalidad();
            });
        });
    }
    function eliminarLocalidad() {
        $("#btnEliminarLocalidad").on("click", function () {
            var cod_localidad = $("#frmEliminarLocalidad #cod_localidad").val(),
                    opcion = $("#frmEliminarLocalidad #opcion").val();
            //console.log(idusuario);
            //console.log("eNTRO A ELIMINAR");
            // console.log(opcion);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarLocalidad",
                data: {"cod_localidad": cod_localidad, "opcion": opcion}
            }).done(function (info) {
                console.log(info);
                var json_info = JSON.parse(info);
                mostrar_mensajeLocalidad(json_info);
                limpiar_datosLocalidad();
                listarLocalidad();
            });
        });
    }
    function mostrar_mensajeLocalidad(informacion) {
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
        $("#mensajeLocalidad").html(texto).css({"color": color});
        $("#mensajeLocalidad").fadeOut(5000, function () {
            $(this).html("");
            $(this).fadeIn(3000);
        });
    }
     function limpiar_datosLocalidad() {
        $("#opcion").val("registrar");
        $("#localidad").val("");       
    }
    function listarLocalidad() {
        $("#cuadro2").slideUp("slow");
        $("#cuadro1").slideDown("slow");
        //var table = $('#dt_asesor').DataTable(); 
              
        
        var table = $("#dt_localidad").DataTable({   
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
                "url": "<%= request.getContextPath()%>/ControlServlet?parAccion=listaLocalidad"
            },
            "columns": [
                {"defaultContent":""},
                {"data": "cod_localidad"},
                {"data": "localidad"},
            ],
            "language": idioma_espanol,
            "dom": "<'row'<'form-inline' <'col s5 s-offset-5'B>>>"
                    + "<'row' <'form-inline' <'col s10 m8 l2 toolbar left-align'><'col s10 m8 l4 offset-l6'f>>>"
                    + "<rt>"
                    + "<'dataTable'<'row espacioFooter'"
                    + "<'col s12 m2 l1'l>"
                    + "<'col s12 m10 l11'p>>>"
        });
        $("div.toolbar").html('<a id="btnAddLocalidad" title="Agregar usuario" class="btn-floating btn-large waves-effect waves-light"><i class="material-icons">add</i></a>\n\
         <a id="btnEditarLocalidad" class="btn-floating btn-large waves-effect waves-light blue"><i class="material-icons">mode_edit</i></a>\n\
        <a id="btnBorrarLocalidad" class="btn-floating btn-large waves-effect waves-light red"><i class="material-icons">delete</i></a>');
        
         obtener_data_editar_localidad(table);
         obtener_id_eliminar_localidad(table);
         agregarLocalidad();
    }
     function agregarLocalidad() {
        $("#btnAddLocalidad").on("click", function () {
            limpiar_datosLocalidad();
            $("#cuadro2").slideDown("slow");
            $("#cuadro1").slideUp("slow");
        });
    }
     function obtener_data_editar_localidad(table) {
        $("#btnEditarLocalidad").on("click", function () {
            var data = table.row('.selected').data();
            console.log(data);
             if(data!=null){
                limpiar_datosLocalidad();
                $("#cuadro2").slideDown("slow");
                $("#cuadro1").slideUp("slow");
                console.log("EDITAR");
                //alert(data.localidad);
                $("#cod_localidad").val(data.cod_localidad);
                //$("#localidad").val("valor");
                $("#localidad").val(data.localidad);
               
                $("#opcion").val("modificar");
                $("#cuadro2").slideDown("slow");
                $("#cuadro1").slideUp("slow");
                Materialize.updateTextFields();
            }
            else{
                alert('seleccione una fila');
            }             
        });       
    }
    function obtener_id_eliminar_localidad(table) {

        $("#btnBorrarLocalidad").on("click", function () {
            console.log("entro eliminar ok");            
            var data = table.row('.selected').data();
            if(data!=null){
            console.log(data);
            $("#frmEliminarLocalidad #cod_localidad").val(data.cod_localidad);
            $('#modalEliminarLocalidad').modal('open');
            }
            else{
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