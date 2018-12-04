<div class="container">
    <h2 class="header center blue-text">Visitas</h2>
    <div id="cuadro2">
        <form action="" method="POST">
            <div class="row center-align">
                <h5 class="col s12 m8 l6 text-center">Formulario de Registro de Visitas</h5>
            </div>
            <input type="hidden" id="cod_visita" name="cod_visita" value="0">
            <input type="hidden" id="opcion" name="opcion" value="registrar">
            <div class="row">
                <div class="input-field col s12 m6">
                    <select id="SelectLocalidad" name="SelectLocalidad">
                        <option value="" disabled selected>Seleccione una opción</option>
                    </select>
                    <label>Localidad</label>
                </div>
                <div class="input-field col s12 m6">
                    <select id="SelectEtapa" name="SelectEtapa">
                        <option value="" disabled selected>Seleccione una opción</option>
                    </select>
                    <label>Etapa</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s10 m6">
                    <select id="SelectCandidato" name="SelectCandidato">
                        <option value="" disabled selected>Seleccione una opción</option>
                    </select>
                    <label>Candidato</label>
                </div>
                <div class="col s2 m6 left-align">
                    <a href="#modal1" id="btnAgregarCandidato" class="btn-floating btn-large waves-effect waves-light"><i class="material-icons">add</i></a>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12 m6">
                    <label for="nota">Fecha:</label>
                    <input id="fecha" name="fecha" type="date" class="datepicker">
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12">
                    <textarea id="nota" name="nota" class="materialize-textarea"></textarea>
                    <label for="nota">Nota:</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12 m12 l6">
                    <select id="SelectEstado" name="SelectEstado">
                        <option value="" disabled>Seleccione una opción</option>
                        <option value="PENDIENTE" selected="">PENDIENTE</option>
                        <option value="REALIZADA">REALIZADA</option>
                        <option value="CANCELADA">CANCELADA</option>
                    </select>
                    <label>Estado</label>
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
    <!-- Modal Structure -->
    <form action="" name="formCandidato" id="formCandidato" method="POST">
        <input type="hidden" id="cod_candidato" name="cod_candidato" value="0">
        <input type="hidden" id="opcion" name="opcion" value="registrar">
        <div id="modal1" class="modal">
            <div class="modal-content">
                <h4>Complete los datos del Candidato</h4>
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
            </div>

            <div class="modal-footer">
                <a id="btnGuardarCandidato" class="modal-action waves-effect waves-green btn">Guardar</a>
                <a href="#!" class=" modal-action modal-close waves-effect waves-green btn">Cancelar</a>
            </div>
        </div>
    </form>


    <div>
        <table id="dt_visitas" class="mdl-data-table" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th></th>
                    <th>Localidad</th>
                    <th>Etapa</th>
                    <th>Candidato</th>
                    <th>Asesor</th>
                    <th>Fecha</th>
                    <th>Nota</th>
                    <th>Estado</th>                   
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
        <form id="frmEliminarVisita" action="" method="POST">
            <input type="hidden" id="cod_visita" name="cod_visita" value="">
            <input type="hidden" id="opcion" name="opcion" value="eliminar">
            <!-- Modal Structure -->
            <div id="modalEliminar" class="modal">
                <div class="modal-content">
                    <h4>Eliminar Visita</h4>
                    <p>¿Está seguro de eliminar la visita?</p>
                </div>
                <div class="modal-footer">
                    <button type="button"  class="modal-action modal-close waves-effect waves-green btn-flat">Cancelar</button>
                    <button type="button" id="eliminar-visita" class="btn btn-primary modal-action modal-close waves-effect red white-text" >Aceptar</button>

                </div>
            </div>
        </form>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('select').material_select();
        listar();
        guardar();
        eliminar();
        agregar();
        $('.modal').modal();
        $('.datepicker').pickadate({
            selectMonths: true, // Creates a dropdown to control month
            selectYears: 15, // Creates a dropdown of 15 years to control year
            format: 'yyyy/mm/dd'
        });

    });

    //alert('entro java');
    /*  $(document).on("ready", function () {
     alert('hola ready');

     });*/

    $("#btn_listar").on("click", function () {
        listar();

    });

    $("#btnGuardarCandidato").on("click", function () {
        //alert('entro agregar candidato');

        //e.preventDefault();
        var frm = $("#formCandidato").serialize();
        console.log(frm);
        $.ajax({
            method: "POST",
            url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarCandidato",
            data: frm
        }).done(function (info) {
            console.log(info);
            //alert(info);
            // var array_return =  $.parseJSON ( info );
            // console.log("valor: "+ array_return);
            var json_info = JSON.parse(info);
            mostrar_mensaje(json_info);
            //limpiar_datos();
            //listar();
            $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=getLocalidadesCandidatos', {
            }, function (data) {
                console.log(data);

                var data_json = JSON.parse(data);
                console.log(data_json);
                $('#SelectCandidato').material_select('destroy');
                $('#SelectCandidato').empty().html(' ');
                $("#SelectCandidato").append('<option value="" disabled>Seleccione una opción</option>');
                $.each(data_json.candidatos, function (id, value) {
                    $("#SelectCandidato").append('<option value="' + value.cod_candidato + '">' + value.candidato + '</option>');
                });
                //$("#SelectCandidato option[value=" + data.cod_candidato + "]").attr("selected", true);
                $('#SelectCandidato').material_select();
            });

        });
        $('#modal1').modal('close');
        $('#modal1 input').val('');
        Materialize.updateTextFields();


    });



    function guardar() {
        $("form").on("submit", function (e) {
            e.preventDefault();
            var frm = $(this).serialize();
            console.log("entro");
            console.log(frm);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarVisitas",
                data: frm
            }).done(function (info) {
                console.log("regreso")
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
        $("#eliminar-visita").on("click", function () {
            var cod_visita = $("#frmEliminarVisita #cod_visita").val(),
                    opcion = $("#frmEliminarVisita #opcion").val();
            //console.log(idusuario);
            //console.log("eNTRO A ELIMINAR");
            // console.log(opcion);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarVisitas",
                data: {"cod_visita": cod_visita, "opcion": opcion}
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
        $("#fecha").val("");
        $("#nota").val("");
        
        $("#SelectLocalidad").find('option').attr("selected", false);
        $("#SelectLocalidad option[value=0]").attr("selected", true);
        $('#SelectLocalidad').val(0);
        $("#SelectLocalidad").material_select();
        
        $('#SelectEtapa').material_select('destroy');
         $('#SelectEtapa').empty().html(' ');
         $("#SelectEtapa").append('<option value="" disabled selected>Seleccione una opción</option>');
         $('#SelectEtapa').material_select();
         
        /*  $('#SelectLocalidad').material_select('destroy');
         $('#SelectLocalidad').empty().html(' ');
         $("#SelectLocalidad").append('<option value="" disabled selected>Seleccione una opción</option>');
         $('#SelectLocalidad').material_select();

         $('#SelectEtapa').material_select('destroy');
         $('#SelectEtapa').empty().html(' ');
         $("#SelectEtapa").append('<option value="" disabled selected>Seleccione una opción</option>');
         $('#SelectEtapa').material_select();

         $('#SelectCandidato').material_select('destroy');
         $('#SelectCandidato').empty().html(' ');
         $("#SelectCandidato").append('<option value="" disabled selected>Seleccione una opción</option>');
         $('#SelectCandidato').material_select();*/
    }

    function listar() {
        setVariables();
        $("#cuadro2").slideUp("slow");
        $("#cuadro1").slideDown("slow");
        var table = $("#dt_visitas").DataTable({
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
                "url": "<%= request.getContextPath()%>/ControlServlet?parAccion=listaVisita"
            },
            "columns": [
                {"defaultContent":""},
                {"data": "localidad"},
                {"data": "etapa"},
                {"data": "candidato"},
                {"data": "asesor"},
                {"data": "fecha_tentativa"},
                {"data": "nota"},
                {"data": "estado"}
            ],
            "language": idioma_espanol,
            "dom": "<'row'<'form-inline' <'col s5 s-offset-5'B>>>"
                    + "<'row' <'form-inline' <'col s10 m8 l2 toolbar left-align'><'col s10 m8 l4 offset-l6'f>>>"
                    + "<rt>"
                    + "<'dataTable'<'row espacioFooter'"
                    + "<'col s12 m2 l1'l>"
                    + "<'col s12 m10 l11'p>>>",
        });
        $("div.toolbar").html('<a id="btnAdd" title="Agregar usuario" class="btn-floating btn-large waves-effect waves-light"><i class="material-icons">add</i></a>\n\
         <a id="btnEditar" class="btn-floating btn-large waves-effect waves-light blue"><i class="material-icons">mode_edit</i></a>\n\
        <a id="btnBorrar" class="btn-floating btn-large waves-effect waves-light red"><i class="material-icons">delete</i></a>');
        
        obtener_data_editar(table);
        obtener_id_eliminar(table);
        agregar();



    }

    function setVariables() {
        $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=getLocalidadesCandidatos', {
        }, function (data) {
            console.log(data);
            var data_json = JSON.parse(data);
            console.log(data_json);
            $('#SelectLocalidad').material_select('destroy');
            $('#SelectLocalidad').empty().html(' ');
            $("#SelectLocalidad").append('<option value="0" disabled selected>Seleccione una opción</option>');
            $.each(data_json.localidades, function (id, value) {
                $("#SelectLocalidad").append('<option value="' + value.localidad + '">' + value.localidad + '</option>');
            });
            $('#SelectLocalidad').material_select();


            $('#SelectCandidato').material_select('destroy');
            $('#SelectCandidato').empty().html(' ');
            $("#SelectCandidato").append('<option value="" disabled selected>Seleccione una opción</option>');
            $.each(data_json.candidatos, function (id, value) {
                $("#SelectCandidato").append('<option value="' + value.cod_candidato + '">' + value.candidato + '</option>');
            });
            $('#SelectCandidato').material_select();
        });

    }

    function agregar() {
        $("#btnAdd").on("click", function () {
            limpiar_datos();
            // setVariables();
            $("#cuadro2").slideDown("slow");
            $("#cuadro1").slideUp("slow");

        });
    }
    $("#SelectLocalidad").on("change", function () {

        var LocalidadSelect = $("#SelectLocalidad").val();
        $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=getEtapas', {
            idLocalidad: LocalidadSelect
        }, function (data) {

            console.log(data);
            var data_json = JSON.parse(data);
            $('#SelectEtapa').material_select('destroy');
            $('#SelectEtapa').empty().html(' ');           
            $("#SelectEtapa").append('<option value="0" disabled selected>Seleccione una opción</option>');
            $.each(data_json.etapas, function (id, value) {
                $("#SelectEtapa").append('<option value="' + value.etapa + '">' + value.etapa + '</option>');
            });
            $('#SelectEtapa').material_select();
        });
    });


    function obtener_data_editar(table) {
        $("#btnEditar").on("click",function () {
            //limpiar_datos();
            //setVariables();
            //var data = table.row($(this).parents("tr")).data();
            var data = table.row('.selected').data();
            console.log(data);
            //console.log(data.estado);
             if(data!=null){
                $("#cod_visita").val(data.cod_visita);
                $("#fecha").val(data.fecha_tentativa);
                $("#nota").val(data.nota);
                $("#opcion").val("modificar");
                $("#SelectLocalidad").find('option').attr("selected", false);
                $("#SelectLocalidad option[value=" + data.localidad + "]").attr("selected", true);
                $('#SelectLocalidad').material_select();

                $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=getEtapas', {
                    idLocalidad: data.localidad
                }, function (etapas) {

                    console.log(etapas);
                    var data_json = JSON.parse(etapas);
                    $('#SelectEtapa').material_select('destroy');
                    $('#SelectEtapa').empty().html(' ');
                    $("#SelectEtapa").append('<option value="0" disabled>Seleccione una opción</option>');
                    $.each(data_json.etapas, function (id, value) {
                        $("#SelectEtapa").append('<option value="' + value.etapa + '">' + value.etapa + '</option>');
                    });
                    //$('#SelectEtapa').material_select();
                    $("#SelectEtapa option[value='" + data.etapa + "']").attr("selected", true);
                    $('#SelectEtapa').material_select();
                });



                $("#SelectCandidato option[value=" + data.cod_candidato + "]").attr("selected", true);
                $('#SelectCandidato').material_select();

                $("#SelectEstado option[value=" + data.estado + "]").attr("selected", true);
                $('#SelectEstado').material_select();
                $("#cuadro2").slideDown("slow");
                $("#cuadro1").slideUp("slow");
                Materialize.updateTextFields();
            }
            else{
                    alert('seleccione una fila');
                }
        });
    }

    function obtener_id_eliminar(table) {
        $("#btnBorrar").on("click", function () {
            console.log("entro eliminar");
           // var data = table.row($(this).parents("tr")).data();
            var data = table.row('.selected').data();
            // console.log($(this).parents("tr"));
             if(data!=null){
                console.log(data);
                $("#frmEliminarVisita #cod_visita").val(data.cod_visita);
                $('#modalEliminar').modal('open');
                //console.log(idusuario);
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
