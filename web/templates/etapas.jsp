<div class="container">
     <div id="DivEtapas" class="col s12">
        <h5>Etapas</h5>
        <div id="cuadro2">
            <form action="" method="POST">
                <div class="row center-align">
                    <h5 class="col s12 m8 l12 text-center">Formulario de Registro de Etapas</h5>
                </div>
                <input type="hidden" id="cod_etapa" name="cod_etapa" value="0">
                <input type="hidden" id="opcion" name="opcion" value="registrar">
                <div class="row">
                    <div class="input-field col s12 m4">
                        <input id="etapa" name="etapa" type="text" class="validate">
                        <label for="Etapa">Etapa</label>
                    </div>
                </div>                            
                <div class="row">
                    <div class="center-align">
                        <input id="btnguardarEtapa" type="submit" class="btn btn-primary" value="Guardar">
                        <input id="btnListarEtapa" type="button" class="btn btn-primary" value="Listar">
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
            <table id="dt_etapa" class="mdl-data-table" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th></th>
                        <th>código Etapa</th>
                        <th>Etapa</th>                                   
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
                <input type="hidden" id="cod_etapa" name="cod_etapa" value="">
                <input type="hidden" id="opcion" name="opcion" value="eliminar">
                <!-- Modal Structure -->
                <div id="modalEliminarLocalidad" class="modal">
                    <div class="modal-content">
                        <h4>Eliminar Candidato</h4>
                        <p>¿Está seguro de eliminar al candidato?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button"  class="modal-action modal-close waves-effect waves-green btn-flat">Cancelar</button>
                        <button type="button" id="btnEliminarEtapa" class="btn btn-primary modal-action modal-close waves-effect red white-text" >Aceptar</button>
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
        listarEtapa();
        guardarEtapa();
        eliminarEtapa();
        agregarEtapa();
    });
    $("#btnListarEtapa").on("click", function () {
        listarEtapa();
    });
    function guardarEtapa() {
        $("form").on("submit", function (e) {
            e.preventDefault();
            var frm = $(this).serialize();
            console.log(frm);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarEtapa",
                data: frm
            }).done(function (info) {
                console.log(info);
                //alert(info);
                // var array_return =  $.parseJSON ( info );
                // console.log("valor: "+ array_return);
                var json_info = JSON.parse(info);
                mostrar_mensaje(json_info);
                limpiar_datosLocalidad();
                listarEtapa();
            });
        });
    }
    function eliminarEtapa() {
        $("#btnEliminarEtapa").on("click", function () {
            var cod_etapa = $("#frmEliminar #cod_etapa").val(),
                    opcion = $("#frmEliminar #opcion").val();
            //console.log(idusuario);
            //console.log("eNTRO A ELIMINAR");
            // console.log(opcion);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarEtapa",
                data: {"cod_etapa": cod_etapa, "opcion": opcion}
            }).done(function (info) {
                console.log(info);
                var json_info = JSON.parse(info);
                mostrar_mensaje(json_info);
                limpiar_datosLocalidad();
                listarEtapa();
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
     function limpiar_datosLocalidad() {
        $("#opcion").val("registrar");
        $("#etapa").val("");       
    }
    function listarEtapa() {
        $("#cuadro2").slideUp("slow");
        $("#cuadro1").slideDown("slow");
        //var table = $('#dt_asesor').DataTable(); 
              
        
        var table = $("#dt_etapa").DataTable({   
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
                "url": "<%= request.getContextPath()%>/ControlServlet?parAccion=listaEtapa"
            },
            "columns": [
                {"defaultContent":""},
                {"data": "cod_etapa"},
                {"data": "etapa"},
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
        
         obtener_data_editar_etapa(table);
         obtener_id_eliminar_etapa(table);
         agregarEtapa();
    }
     function agregarEtapa() {
        $("#btnAddLocalidad").on("click", function () {
            limpiar_datosLocalidad();
            $("#cuadro2").slideDown("slow");
            $("#cuadro1").slideUp("slow");
        });
    }
     function obtener_data_editar_etapa(table) {
        $("#btnEditarLocalidad").on("click", function () {
            var data = table.row('.selected').data();
            console.log(data);
             if(data!=null){
                limpiar_datosLocalidad();
                $("#cuadro2").slideDown("slow");
                $("#cuadro1").slideUp("slow");
                console.log("EDITAR");
                //alert(data.etapa);
                $("#cod_etapa").val(data.cod_etapa);
                //$("#etapa").val("valor");
                $("#etapa").val(data.etapa);
               
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
    function obtener_id_eliminar_etapa(table) {

        $("#btnBorrarLocalidad").on("click", function () {
            console.log("entro eliminar ok");            
            var data = table.row('.selected').data();
            if(data!=null){
            console.log(data);
            $("#frmEliminar #cod_etapa").val(data.cod_etapa);
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