<div class="container">
     <div id="DivManzanas" class="col s12">
        <h5>Manzanas</h5>
        <div id="cuadro2">
            <form action="" method="POST">
                <div class="row center-align">
                    <h5 class="col s12 m8 l12 text-center">Formulario de Registro de Manzanas</h5>
                </div>
                <input type="hidden" id="cod_manzana" name="cod_manzana" value="0">
                <input type="hidden" id="opcion" name="opcion" value="registrar">
                <div class="row">
                    <div class="input-field col s12 m4">
                        <input id="manzana" name="manzana" type="text" class="validate">
                        <label for="manzana">Manzana</label>
                    </div>
                </div>                            
                <div class="row">
                    <div class="center-align">
                        <input id="btnguardarManzana" type="submit" class="btn btn-primary" value="Guardar">
                        <input id="btnListarManzana" type="button" class="btn btn-primary" value="Listar">
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
            <table id="dt_manzana" class="mdl-data-table" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th></th>
                        <th>Código Manzana</th>
                        <th>Manzana</th>                                   
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
                <input type="hidden" id="cod_manzana" name="cod_manzana" value="">
                <input type="hidden" id="opcion" name="opcion" value="eliminar">
                <!-- Modal Structure -->
                <div id="modalEliminarLocalidad" class="modal">
                    <div class="modal-content">
                        <h4>Eliminar Manzana</h4>
                        <p>¿Está seguro de eliminar a la manzana?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button"  class="modal-action modal-close waves-effect waves-green btn-flat">Cancelar</button>
                        <button type="button" id="btnEliminarManzana" class="btn btn-primary modal-action modal-close waves-effect red white-text" >Aceptar</button>
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
        listarManzana();
        guardarManzana();
        eliminarManzana();
        agregarManzana();
    });
    $("#btnListarManzana").on("click", function () {
        listarManzana();
    });
    function guardarManzana() {
        $("form").on("submit", function (e) {
            e.preventDefault();
            var frm = $(this).serialize();
            console.log(frm);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarManzana",
                data: frm
            }).done(function (info) {
                console.log(info);
                //alert(info);
                // var array_return =  $.parseJSON ( info );
                // console.log("valor: "+ array_return);
                var json_info = JSON.parse(info);
                mostrar_mensaje(json_info);
                limpiar_datosLocalidad();
                listarManzana();
            });
        });
    }
    function eliminarManzana() {
        $("#btnEliminarManzana").on("click", function () {
            var cod_manzana = $("#frmEliminar #cod_manzana").val(),
                    opcion = $("#frmEliminar #opcion").val();
            //console.log(idusuario);
            //console.log("eNTRO A ELIMINAR");
            // console.log(opcion);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarManzana",
                data: {"cod_manzana": cod_manzana, "opcion": opcion}
            }).done(function (info) {
                console.log(info);
                var json_info = JSON.parse(info);
                mostrar_mensaje(json_info);
                limpiar_datosLocalidad();
                listarManzana();
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
        $("#manzana").val("");       
    }
    function listarManzana() {
        $("#cuadro2").slideUp("slow");
        $("#cuadro1").slideDown("slow");
        //var table = $('#dt_asesor').DataTable(); 
              
        
        var table = $("#dt_manzana").DataTable({   
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
                "url": "<%= request.getContextPath()%>/ControlServlet?parAccion=listaManzana"
            },
            "columns": [
                {"defaultContent":""},
                {"data": "cod_manzana"},
                {"data": "manzana"},
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
        
         obtener_data_editar_manzana(table);
         obtener_id_eliminar_manzana(table);
         agregarManzana();
    }
     function agregarManzana() {
        $("#btnAdd").on("click", function () {
            limpiar_datosLocalidad();
            $("#cuadro2").slideDown("slow");
            $("#cuadro1").slideUp("slow");
        });
    }
     function obtener_data_editar_manzana(table) {
        $("#btnEditar").on("click", function () {
            var data = table.row('.selected').data();
            console.log(data);
             if(data!=null){
                limpiar_datosLocalidad();
                $("#cuadro2").slideDown("slow");
                $("#cuadro1").slideUp("slow");
                console.log("EDITAR");
                //alert(data.manzana);
                $("#cod_manzana").val(data.cod_manzana);
                //$("#manzana").val("valor");
                $("#manzana").val(data.manzana);
               
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
    function obtener_id_eliminar_manzana(table) {

        $("#btnBorrar").on("click", function () {
            console.log("entro eliminar ok");            
            var data = table.row('.selected').data();
            if(data!=null){
            console.log(data);
            $("#frmEliminar #cod_manzana").val(data.cod_manzana);
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