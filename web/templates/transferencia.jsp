<div class="container">

    <div class="col s12 m12 l12" style="padding-top: 5%">
        <!--<h2 class="header">Horizontal Card</h2>-->
        <div class="card horizontal">
            <div class="card-stacked">
                <div class="card-content">
                    <h3 class="center-align">Transferencia de lote</h3>

                    <h4>Propietario Actual</h4>
                    <div class="row">
                        <br>
                        <div class="row">
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">search</i>
                                <input id="dni" name="dni" type="number" class="validate solo-numero">
                                <label for="dni">D.N.I.</label>
                            </div>
                            <div class="col s12 m6 l4">
                                <a id="btnBuscarCliente" class="modal-action waves-effect waves-green btn"><i class="large material-icons">search</i> Buscar</a>
                            </div>
                        </div>
                        <h4>Resultado</h4>
                        <div class="row ">
                            <input type="hidden" id="dniVendedor" name="dniVendedor" value="0">
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
                        <h5>Terreno(s)</h5>
                        <div class="row">
                            <div class="input-field col s12 m12 l6">
                                <select id="SelectTerreno" name="SelectTerreno">
                                    <option value="" disabled selected>Seleccione una opción</option>
                                </select>
                                <label>Terreno</label>
                            </div>
                        </div>
                    </div>
                    <h4>Propietario Nuevo</h4>
                    <div class="row">
                        <br>
                        <div class="row">
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">search</i>
                                <input id="dniNuevo" type="number" class="validate solo-numero">
                                <label for="dni">D.N.I.</label>
                            </div>
                            <div class="col s12 m6 l4">
                                <a id="btnBuscarClienteNuevo" class="modal-action waves-effect waves-green btn"><i class="large material-icons">search</i> Buscar</a>
                            </div>
                        </div>
                        <h4>Resultado</h4>
                        <div class="row ">
                            <input type="hidden" id="dniComprador" name="dniComprador" value="0">
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">account_circle</i>
                                <input disabled id="apellidosNuevo" name="apellidosNuevo" type="text" class="validate">
                                <label for="apellido">Apellidos</label>
                            </div>
                            <div class="input-field col s12 m6">
                                <input disabled id="nombresNuevo" name="nombresNuevo" type="text" class="validate">
                                <label for="nombre">Nombres</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">payment</i>
                            <input id="comision" type="number" min="0" class="validate solo-numero">
                            <label for="inscripcion">Comisión de Transferencia S/.</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container" style="padding: 2%">
            <div class="col s12 m8 l12 center-align">
                <a id="btnGuardarTrans" class="center modal-action modal-close waves-effect waves-green btn">Guardar</a>
                <!--<a id="btnImprimir" class="center modal-action modal-close waves-effect waves-green btn blue">Imprimir Recibo</a>-->
                <a href="principal.jsp" class="center modal-action modal-close waves-effect waves-green btn red">Cancelar</a>
            </div>
        </div>
    </div>

</div>
<script>
    $(document).ready(function () {

        $('select').material_select();
        Materialize.updateTextFields();
        $('.modal').modal();
    });

    $("#btnBuscarCliente").on("click", function () {
        var dni = $("#dni").val();
        // alert(dni);
        if (dni != "") {
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServletV?parAccion=vConsultaCliente",
                data: {"dni": dni}
            }).done(function (data) {
                data = JSON.parse(data);
                console.log(data);
                if (data.Result === "OK") {
                    $("#dniVendedor").val(data.dni);
                    $("#nombres").val(data.nombres);
                    $("#apellidos").val(data.apellidos);
                    Materialize.updateTextFields();
                    $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=buscarTerreno', {
                        dniVendedor: dni
                    }, function (data) {

                        console.log(data);
                        var data_json = JSON.parse(data);
                        $('#SelectTerreno').material_select('destroy');
                        $('#SelectTerreno').empty().html(' ');
                        $("#SelectTerreno").append('<option value="" disabled selected>Seleccione una opción</option>');
                        $.each(data_json.terrenos, function (id, value) {
                            $("#SelectTerreno").append('<option value="' + value.cod_terreno + '">Localidad:' + value.localidad + ", Etapa:" + value.etapa + ", Manzana:" + value.manzana + ", Lote:" + value.lote + '</option>');
                        });
                        $('#SelectTerreno').material_select();
                    });

                }
                if (data.Result === "VACIO") {
                    sweetAlert("Error", "Cliente no existe", "error");
                }
            });
        } else {
            sweetAlert("Error", "Ingrese el dni", "error");
        }
    });

    $("#btnBuscarClienteNuevo").on("click", function () {
        var dni = $("#dniNuevo").val();
        // alert(dni);
        if (dni != "") {
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServletV?parAccion=vConsultaCliente",
                data: {"dni": dni}
            }).done(function (data) {
                data = JSON.parse(data);
                console.log(data);
                if (data.Result === "OK") {
                    $("#dniComprador").val(data.dni);
                    $("#nombresNuevo").val(data.nombres);
                    $("#apellidosNuevo").val(data.apellidos);
                    Materialize.updateTextFields();

                }
                if (data.Result === "VACIO") {
                    sweetAlert("Error", "Cliente no existe", "error");
                }
            });
        } else {
            sweetAlert("Error", "Ingrese el dni", "error");
        }
    });
    $("#btnGuardarTrans").on("click", function () {
        var dniVendedor = $("#dniVendedor").val();
        var dniComprador = $("#dniComprador").val();
        var comision = $("#comision").val();
        var cod_terreno = $("#SelectTerreno").val();

        if (dniVendedor != "" && dniComprador != "" && cod_terreno != "" && comision != "") {
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServletV?parAccion=vGuardarTrans",
                data: {"dniVendedor": dniVendedor, "dniComprador": dniComprador, "comision": comision, "cod_terreno": cod_terreno}
            }).done(function (data) {
                data = JSON.parse(data);
                console.log(data);
                if (data.respuesta === "BIEN") {
                    swal({
                        title: "Tranferencia",
                        text: "registrada correctamente",
                        type: "success"
                    },
                            function () {
                                window.location.href = '/inmobiliaria/templates/principal.jsp';
                            }
                    );

                } else {
                    swal("Tranferencia!", "No registrada", "error");
                }
            });
        } else {
            sweetAlert("Error", "Complete los datos", "error");
        }
    });


</script>

