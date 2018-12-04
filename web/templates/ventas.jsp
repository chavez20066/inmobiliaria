<div class="container">
    <div>
        <form action="" name="formCliente" id="formCliente" method="POST">
            <input type="hidden" id="cod_cliente" name="cod_cliente" value="0">
            <input type="hidden" id="opcion" name="opcion" value="registrar">
            <div id="modal1" class="modal">
                <div class="modal-content">
                    <div class="row center-align">
                        <h5 class="col s12 m8 l12 text-center">Formulario de Registro de Clientes</h5>
                    </div>
                    <div class="row">
                        <div class="input-field col s12 m4">
                            <input id="dni" name="dni" type="text" class="validate">
                            <label for="Dni">Dni</label>
                        </div>
                    </div>
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
                            <input id="email" name="email" type="text" class="validate">
                            <label for="email">Email</label>
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
                    <div class="center-align">
                        <button type="button"  class="modal-action modal-close waves-effect waves-green btn-flat">Cancelar</button>
                        <button type="button" id="btnGuardarCliente" class="btn btn-primary modal-action modal-close waves-effect" >Guardar</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="col s12 m12 l12" style="padding-top: 5%">
        <form name="frmVentas" id="frmVentas" action="" method="POST">
            <!--<h2 class="header">Horizontal Card</h2>-->
            <div class="card horizontal">
                <div class="card-stacked">
                    <div class="card-content">
                        <h3 class="center-align">VENTAS</h3>
                        <h4>Cliente</h4>
                        <div class="row">
                            <br>
                            <div class="row">
                                <div class="input-field col s12 m6">
                                    <i class="material-icons prefix">search</i>
                                    <input id="dni" name="dni" type="number" class="validate solo-numero">
                                    <label for="dni">D.N.I.</label>
                                </div>
                                <div class="col s12 m6">
                                    <a id="btnBuscarCliente" class="btn-floating btn-large waves-effect waves-light"><i class="large material-icons">search</i> Buscar</a>
                                    <a href="#modal1" id="btnAgregarCandidato" class="btn-floating btn-large waves-effect waves-light"><i class="material-icons">add</i></a>
                                </div>
                            </div>

                            <div class="row ">
                                <input type="hidden" id="dnidb" name="dnidb" value="0">
                                <input type="hidden" id="idTerreno" name="idTerreno" value="0">
                                <div class="input-field col s12 m6">
                                    <i class="material-icons prefix">account_circle</i>
                                    <input disabled id="apellidos" name="apellidos" type="text" class="validate">
                                    <label for="apellido">Apellidos</label>
                                </div>
                                <div class="input-field col s12 m6">
                                    <input disabled id="nombres" name="nombres" type="text" class="validate">
                                    <label for="nombre">Nombres</label>
                                </div>
                            </div>
                            <div class="row ">
                                <div class="input-field col s12 m4">
                                    <i class="material-icons prefix">email</i>
                                    <input disabled id="email" name="email" type="email" class="validate">
                                    <label for="email" data-error="wrong" data-success="right">Email</label>
                                </div>
                                <div class="input-field col s12 m4">
                                    <i class="material-icons prefix">call_end</i>
                                    <input disabled id="telefono" name="telefono" type="number" class="validate solo-numero">
                                    <label for="telefono">Teléfono</label>
                                </div>
                                <div class="input-field col s12 m4">
                                    <i class="material-icons prefix">phone</i>
                                    <input disabled id="celular" name="celular" type="number" class="validate solo-numero">
                                    <label for="celular">celular</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s12 m12">
                                    <input disabled id="direccion" name="direccion" type="text" class="validate">
                                    <label for="direccion">Dirección</label>
                                </div>
                            </div>
                        </div>
                        <h4>Terreno</h4>
                        <div class="row">
                            <div class="input-field col s12 m12 l6">
                                <select id="SelectLocalidad" name="SelectLocalidad">
                                </select>
                                <label>Localidad</label>
                            </div>
                            <div class="input-field col s12 m12 l6">
                                <select id="SelectEtapa" name="SelectEtapa">
                                    <option value="" disabled selected>Seleccione una opción</option>
                                </select>
                                <label>Etapa</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field col s12 l6">
                                <select id="SelectMZ"name="SelectMZ">
                                    <option value="" disabled selected>Seleccione una opción</option>
                                </select>
                                <label>Manzana</label>
                            </div>
                            <!--<div class="input-field col s12 m12 l6">
                                <select id="SelectLote">
                                    <option value="" disabled selected>Seleccione una opción</option>
                                </select>
                                <label>Lote</label>
                            </div>-->
                            <div class="input-field col s6 m2">
                                <select id="SelectLote"name="SelectLote">
                                    <option value="" disabled selected>Seleccione una opción</option>
                                </select>
                                <label>Lote:</label>
                            </div>
                            <div class="col s2 m4 left-align">
                                <a id="btnVerificaTerreno" class="btn-floating btn-large waves-effect waves-light"><i class="material-icons">done</i></a>
                            </div>
                        </div>

                        <h4>Precio</h4>
                        <div class="row">
                            <div class="input-field col s6 m2">
                                <i class="material-icons prefix">payment</i>
                                <input id="pInscripcion" name="pInscripcion" value="100" type="number" min="0" class="validate solo-numero">
                                <label for="inscripcion">Inscripción</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field col s6 m3">
                                <i class="material-icons prefix">payment</i>
                                <input id="precio" name="precio" type="number" min="0" class="validate solo-numero">
                                <label for="precio">Precio</label>
                            </div>
                            <div class="input-field col s6 m3">
                                <input id="pInicial" name="pInicial" type="number" min="0" value="0" class="validate solo-numero">
                                <label for="inicial">Inicial</label>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col s6 m3">
                                <label for="inicial">Cuota:</label>
                                <br>
                                <input name="cuota" type="radio" id="si" value="on"/>
                                <label for="si">Si</label>
                            </div>
                            <div class="col s6 m3">
                                <br>
                                <input name="cuota" type="radio" id="no" value="off" />
                                <label for="no">No</label>
                            </div>
                            <div class="input-field col s12 m3">
                                <input disabled id="NroCuota" name="NroCuota" type="number" min="0" class="validate solo-numero" >
                                <label for="inscripcion">#Cuota</label>
                            </div>

                        </div>
                        <div class="row">
                            <div class="input-field col s12 m3">
                                <i class="material-icons prefix">payment</i>
                                <input disabled id="cuotaMensual" name="cuotaMensual" type="number" min="0" class="validate solo-numero">
                                <label for="cuotaMensual">Cuota Mensual</label>
                            </div>

                        </div>
                        <h4>Asesor de Venta</h4>
                        <div class="row">
                            <div class="input-field col s12 m6 l6">
                                <select id="SelectAsesor" name="SelectAsesor">
                                    <option value="" disabled selected>Seleccione una opción</option>
                                </select>
                                <label>Asesor:</label>
                            </div>

                        </div>
                        <div class="row">
                            <div class="input-field col s12 m12">
                                <i class="material-icons prefix">today</i>
                                <textarea id="nota" name="nota" class="materialize-textarea"></textarea>
                                <label for="notas">Notas:</label>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div class="container" style="padding: 2%">
                <div class="col s12 m8 l12 center-align">
                    <!-- <input id="btnGuardar"  class="center modal-action modal-close waves-effect waves-green btn" value="Guardar">-->
                    <a href="principal.jsp" class="center modal-action modal-close waves-effect waves-green btn red">Cancelar</a>
                    <button type="button" id="btnGuardarVenta" class="btn btn-primary modal-action modal-close waves-effect " >Guardar</button>
                </div>
            </div>
        </form>
    </div>

</div>
<script>
    $(document).ready(function () {

        $('select').material_select();
        Materialize.updateTextFields();
        setVariables();
        $('.modal').modal();
    });
    $("input[name=cuota]").click(function () {
        if ($(this).val() === "on") {
            $("#NroCuota").removeAttr("disabled");
        } else {
            $("#NroCuota").attr('disabled', 'disabled');
        }
    });
    $("#NroCuota").keypress(function (e) {
        if (e.which == 13) {
            var precio = $("#precio").val();
            var inicial = $("#pInicial").val();
            var nroCuota = $("#NroCuota").val();
            console.log(nroCuota)
            //$("#cuotaMensual").val((precio-inicial)/nroCuota);
            var total = precio - inicial;
            var cuota = total / nroCuota;
            $("#cuotaMensual").val(cuota);
            Materialize.updateTextFields();
        }

    });
    $("#btnGuardarCliente").on("click", function () {
        //  alert('entro agregar candidato');
        var dni = $("#formCliente #dni").val();
        //e.preventDefault();
        var frm = $("#formCliente").serialize();
        console.log(frm);
        $.ajax({
            method: "POST",
            url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardarCliente",
            data: frm
        }).done(function (info) {
            console.log(info);
            //var dni = $("#formCliente #dni").val();
            // alert(dni);
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServletV?parAccion=vConsultaCliente",
                data: {"dni": dni}
            }).done(function (data) {

                //alert(info);
                // var array_return =  $.parseJSON ( info );
                // console.log("valor: "+ array_return);
                data = JSON.parse(data);
                console.log(data);
                if (data.Result === "OK") {
                    $("#frmVentas #dnidb").val(data.dni);
                    $("#frmVentas #nombres").val(data.nombres);
                    $("#frmVentas #apellidos").val(data.apellidos);
                    $("#frmVentas #email").val(data.email);
                    $("#frmVentas #telefono").val(data.telefono);
                    $("#frmVentas #celular").val(data.celular);
                    $("#frmVentas #direccion").val(data.direccion);
                    Materialize.updateTextFields();
                }
                if (data.Result === "VACIO") {
                    alert("cliente no existe");
                    limpiar();
                }

            });

        });
        $('#modal1').modal('close');
        $('#modal1 input').val('');
        Materialize.updateTextFields();


    });

    $("#btnGuardarVenta").on("click", function (e) {

        //e.preventDefault();
        var dni = $("#frmVentas #dnidb").val();
        var idLocalidad = $("#SelectLocalidad").val();
        var idEtapa = $("#SelectEtapa").val();
        var idManzana = $("#SelectMZ").val();
        var lote = $("#lote").val();
        var precio = $("#precio").val();


        var frm = $("#frmVentas").serialize();
        console.log(frm);
        //dni=71216502&dnidb=71216502&SelectLocalidad=1&SelectEtapa=ETAPA+2
        //&SelectMZ=A&lote=45&pInscripcion=100&precio=1500&pInicial=100&cuota=on&NroCuota=10&CuotaMensual=450&SelectAsesor=1&nota=notas

        $.ajax({
            method: "POST",
            url: "<%= request.getContextPath()%>/ControlServletV?parAccion=guardarVentas",
            data: frm
        }).done(function (info) {
            console.log(info);
            var json_info = JSON.parse(info);
            if (json_info.respuesta === "BIEN") {
                swal({
                    title: "Venta",
                    text: "registrada exitosamente",
                    type: "success"
                },
                    function () {
                        // window.location.href = '/bibliografia/inicio/index.jsp';
                        window.location.href = '<%= request.getContextPath()%>/SrvRptVenta';
                    }
                );       
            }
            //alert(info);
            // var array_return =  $.parseJSON ( info );
            // console.log("valor: "+ array_return);
            /* var json_info = JSON.parse(info);
             mostrar_mensaje(json_info);
             limpiar_datos();
             listar();*/
        });
    });

    $("#btnVerificaTerreno").on("click", function () {
        var idLocalidad = $("#SelectLocalidad").val();
        var idEtapa = $("#SelectEtapa").val();
        var idManzana = $("#SelectMZ").val();
        var lote = $("#lote").val();
        $.ajax({
            method: "POST",
            url: "<%= request.getContextPath()%>/ControlServletV?parAccion=verficaTerreno",
            data: {"idLocalidad": idLocalidad, "idEtapa": idEtapa, "idManzana": idManzana, "lote": lote}
        }).done(function (data) {

            //alert(info);
            // var array_return =  $.parseJSON ( info );
            // console.log("valor: "+ array_return);
            data = JSON.parse(data);
            console.log(data);
            if (data.Result === "OK") {

                if (data.idTerreno === 0) {
                    alert("Terreno no existe, por favor registrar el terreno");
                } else {
                    alert("Terreno disponible");
                    $("#idTerreno").val(data.idTerreno);
                }
            }
            if (data.Result === "VENDIDO") {
                alert("terreno VENDIDO");
            }

            /* mostrar_mensaje(json_info);
             limpiar_datos();
             listar();*/
        });
    });

    $("#btnBuscarCliente").on("click", function () {
        var dni = $("#frmVentas #dni").val();
        alert(dni);
        $.ajax({
            method: "POST",
            url: "<%= request.getContextPath()%>/ControlServletV?parAccion=vConsultaCliente",
            data: {"dni": dni}
        }).done(function (data) {

            //alert(info);
            // var array_return =  $.parseJSON ( info );
            // console.log("valor: "+ array_return);
            data = JSON.parse(data);
            console.log(data);
            if (data.Result === "OK") {
                $("#frmVentas #dnidb").val(data.dni);
                $("#frmVentas #nombres").val(data.nombres);
                $("#frmVentas #apellidos").val(data.apellidos);
                $("#frmVentas #email").val(data.email);
                $("#frmVentas #telefono").val(data.telefono);
                $("#frmVentas #celular").val(data.celular);
                $("#frmVentas #direccion").val(data.direccion);
                Materialize.updateTextFields();
            }
            if (data.Result === "VACIO") {
                alert("cliente no existe");
                limpiar();
            }

        });
    });

    $("#SelectLocalidad").on("change", function () {

        var LocalidadSelect = $("#SelectLocalidad").val();
        $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=getEtapas', {
            idLocalidad: LocalidadSelect
        }, function (data) {

            console.log(data);
            var data_json = JSON.parse(data);
            $('#SelectEtapa').material_select('destroy');
            $('#SelectEtapa').empty().html(' ');
            $("#SelectEtapa").append('<option value="" disabled selected>Seleccione una opción</option>');
            $.each(data_json.etapas, function (id, value) {
                $("#SelectEtapa").append('<option value="' + value.etapa + '">' + value.etapa + '</option>');
            });
            $('#SelectEtapa').material_select();
        });
    });
    $("#SelectEtapa").on("change", function () {

        var LocalidadSelect = $("#SelectLocalidad").val();
        var EtapaSelect = $("#SelectEtapa").val();
        $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=getManzanas', {
            idEtapa: EtapaSelect,
            idLocalidad: LocalidadSelect
        }, function (data) {

            console.log(data);
            var data_json = JSON.parse(data);
            $('#SelectMZ').material_select('destroy');
            $('#SelectMZ').empty().html(' ');
            $("#SelectMZ").append('<option value="" disabled selected>Seleccione una opción</option>');
            $.each(data_json.manzanas, function (id, value) {
                $("#SelectMZ").append('<option value="' + value.manzana + '">' + value.manzana + '</option>');
            });
            $('#SelectMZ').material_select();
        });
    });
    $("#SelectMZ").on("change", function () {
        var idLocalidad = $("#SelectLocalidad").val();
        var idEtapa = $("#SelectEtapa").val();
        var idManzana = $("#SelectMZ").val();
        // var lote = $("#lote").val();

        $.ajax({
            method: "POST",
            url: "<%= request.getContextPath()%>/ControlServlet?parAccion=getLotes",
            data: {"idLocalidad": idLocalidad, "idEtapa": idEtapa, "idManzana": idManzana}
        }).done(function (data) {

            //alert(info);
            // var array_return =  $.parseJSON ( info );
            // console.log("valor: "+ array_return);
            data = JSON.parse(data);
            console.log(data);
            $('#SelectLote').material_select('destroy');
            $('#SelectLote').empty().html(' ');
            $("#SelectLote").append('<option value="" disabled selected>Seleccione una opción</option>');
            $.each(data.lotes, function (id, value) {
                $("#SelectLote").append('<option value="' + value.lote + '">' + value.lote + '</option>');
            });
            $('#SelectLote').material_select();

        });

    });

    function setVariables() {
        $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=getLocalidades', {
        }, function (data) {
            console.log(data);
            var data_json = JSON.parse(data);
            console.log(data_json);
            $('#SelectLocalidad').material_select('destroy');
            $('#SelectLocalidad').empty().html(' ');
            $("#SelectLocalidad").append('<option value="" disabled selected>Seleccione una opción</option>');
            $.each(data_json.localidades, function (id, value) {
                $("#SelectLocalidad").append('<option value="' + value.localidad + '">' + value.localidad + '</option>');
            });
            $('#SelectLocalidad').material_select();

            $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=listaAsesor', {
            }, function (data) {
                var data_json = JSON.parse(data);
                console.log(data_json);
                $('#SelectAsesor').material_select('destroy');
                $('#SelectAsesor').empty().html(' ');
                $("#SelectAsesor").append('<option value="" disabled selected>Seleccione una opción</option>');
                $.each(data_json.data, function (id, value) {
                    $("#SelectAsesor").append('<option value="' + value.cod_asesor + '">' + value.apellidos + ' ' + value.nombres + '</option>');
                });
                $('#SelectAsesor').material_select();
            });
        });
    }

    function limpiar() {
        $("#dnidb").val("");
        $("#nombres").val("");
        $("#apellidos").val("");
        $("#email").val("");
        $("#telefono").val("");
        $("#celular").val("");
        $("#direccion").val("");
    }


</script>

