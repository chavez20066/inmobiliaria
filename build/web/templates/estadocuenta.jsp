<div class="container">
    <div class="col s12 m12 l12" style="padding-top: 5%">
        <!--<h2 class="header">Horizontal Card</h2>-->
        <div class="card horizontal">
            <div class="card-stacked">
                <div class="card-content">
                    <h3 class="center-align">ESTADO DE CUENTA DEL CLIENTE</h3>
                    <h4>Busqueda</h4>
                    <div class="row">
                        <br>
                        <div class="row">
                            <div class="input-field col s6 m4">
                                <i class="material-icons prefix">search</i>
                                <input id="dni" name="dni" type="number" class="validate solo-numero">
                                <label for="dni">D.N.I.</label>
                            </div>
                            <div class="col s6 m4">
                                <a id="btnBuscarCliente" class="modal-action waves-effect waves-green btn"><i class="large material-icons">search</i> Buscar</a>
                            </div>
                        </div>
                        <h4>Resultado</h4>
                        <div class="row ">
                            <!--<input type="hidden" id="dniCliente" name="dniCliente" value="0">-->
                            <div class="input-field col s12 m8 l4">
                                <i class="material-icons prefix">account_circle</i>
                                <input disabled id="dniCliente" name="dniCliente" type="text" class="validate">
                                <label for="apellido">D.N.I.</label>
                            </div>
                            <div class="input-field col s12 m6 l4">
                                <input disabled id="apellidos" name="apellidos" type="text" class="validate">
                                <label for="apellido">Apellidos</label>
                            </div>
                            <div class="input-field col s12 m6 l4">
                                <input disabled id="nombres" name="nombres" type="text" class="validate">
                                <label for="nombres">Nombres</label>
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

                        <div class="row ">
                            <input type="hidden" id="cod_venta" name="cod_venta" value="0">
                            <div class="input-field col s12 m3">
                                <input disabled id="Total" name="Total" type="text" class="validate">
                                <label for="Total">Total:</label>
                            </div>
                            <div class="input-field col s12 m3">
                                <input disabled id="PagoAcumulado" name="PagoAcumulado" type="text" class="validate">
                                <label for="PAcumulado">Pago Acumulado:</label>
                            </div>
                            <div class="input-field col s12 m2">
                                <input disabled id="NroCuotas" name="NroCuotas" type="text" class="validate">
                                <label for="NroCuotas">Nro Cuotas</label>
                            </div>
                            <div class="input-field col s12 m2">
                                <input disabled id="Saldo" name="Saldo" type="text" class="validate">
                                <label for="saldo">Saldo:</label>
                            </div>
                            <div class="input-field col s12 m2">
                                <input disabled id="FechaVenta" name="FechaVenta" type="text" class="validate">
                                <label for="saldo">Fecha de Venta:</label>
                            </div>
                        </div>
                        <h5>Pagos Únicos</h5>
                        <div class="row ">
                            <div class="col s1 right-align">
                                <br>
                                <input type="checkbox" class="filled-in" id="checkPAgua" name="checkPAgua"/>
                                <label for="checkPAgua"></label>
                            </div>
                            <div class="input-field col s1">
                                <input disabled id="PAgua" name="PAgua" type="text" class="validate">
                                <label for="PAgua">Agua:</label>
                            </div>
                            <div class="col s1 right-align">
                                <br>
                                <input type="checkbox" class="filled-in" id="checkPLuz" name="checkPLuz"/>
                                <label for="checkPLuz"></label>
                            </div>
                            <div class="input-field col s1">
                                <input disabled id="PLuz" name="PLuz" type="text" class="validate">
                                <label for="PLuz">Luz:</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s1 right-align">
                                <br>
                                <input type="checkbox" class="filled-in" id="checkPOtros" name="checkPOtros"/>
                                <label for="checkPOtros"></label>
                            </div>
                            <div class="input-field col s1">
                                <input disabled id="POtros" name="POtros" type="text" class="validate">
                                <label for="POtros">Otros:</label>
                            </div>
                            <div class="input-field col s12 m8">
                                <input disabled id="POtrosDes" name="POtrosDes" type="text" class="validate">
                                <label for="POtrosDes">Descripción otro pago:</label>
                            </div>
                        </div>
                        <h4>Pago</h4>
                        <div class="row">
                            <div class="col s6 m3">
                                <label for="inicial">Tipo de Pago:</label>
                                <br>
                                <input name="TipoPago" type="radio" id="CuotaMensual" value="on"/>
                                <label for="CuotaMensual">Cancelación Cuota Mensual</label>
                            </div>
                            <div class="col s6 m3">
                                <br>
                                <input name="TipoPago" type="radio" id="Amortizacion" value="off" />
                                <label for="Amortizacion">Cancelación Total</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field col s2">
                                <input  disabled id="PCuotaMensual" name="PCuotaMensual" type="text" class="validate">
                                <label for="PCuotaMensual">Monto a Pagar: S/.</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s10 offset-s1" id="divCalendarioCuotas" style="display: none;">
                                <!--<table id="dt_CalendarioCuotas" class="mdl-data-table" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Numero Cuota</th>
                                            <th>Fecha</th>
                                            <th>Monto S/.</th>
                                        </tr>
                                    </thead>
                                </table>-->

                            </div>
                        </div>
                        <h4><strong>Servicios</strong></h4>
                        <h5><strong>Seguridad</strong></h5>
                        <div class="row">
                            <div class="input-field col s6 m4">
                                <select id="SelectAnioSegu">
                                    <option value="" disabled selected>Seleccione una opción</option>
                                </select>
                                <label>Año</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s12 m12">
                                <input type="checkbox" class="seguridad" id="PSENERO"/> <label for="PSENERO">Enero</label>
                                <input type="checkbox" class="seguridad" id="PSFEBRERO" /> <label for="PSFEBRERO">Febrero</label>
                                <input type="checkbox" class="seguridad" id="PSMARZO" /><label for="PSMARZO">Marzo</label>
                                <input type="checkbox" class="seguridad" id="PSABRIL" /><label for="PSABRIL">Abril</label>
                                <input type="checkbox" class="seguridad" id="PSMAYO" /><label for="PSMAYO">Mayo</label>
                                <input type="checkbox" class="seguridad" id="PSJUNIO" /><label for="PSJUNIO">Junio</label>
                                <input type="checkbox" class="seguridad" id="PSJULIO" /><label for="PSJULIO">Julio</label>
                                <input type="checkbox" class="seguridad" id="PSAGOSTO" /><label for="PSAGOSTO">Agosto</label>
                                <input type="checkbox" class="seguridad" id="PSSEPTIEMBRE" /><label for="PSSEPTIEMBRE">Septiembre</label>
                                <input type="checkbox" class="seguridad" id="PSOCTUBRE" /><label for="PSOCTUBRE">Octubre</label>
                                <input type="checkbox" class="seguridad" id="PSNOVIEMBRE" /><label for="PSNOVIEMBRE">Noviembre</label>
                                <input type="checkbox" class="seguridad" id="PSDICIEMBRE" /><label for="PSDICIEMBRE">Diciembre</label>
                            </div>
                        </div>
                        <h5><strong>Agua</strong></h5>
                        <div class="row">
                            <div class="input-field col s6 m4">
                                <select id="SelectAnioAgua">
                                    <option value="" disabled selected>Seleccione una opción</option>
                                </select>
                                <label>Año</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s12 m12">
                                <input type="checkbox" class="agua" id="PAENERO"/> <label for="PAENERO">Enero</label>
                                <input type="checkbox" class="agua" id="PAFEBRERO" /> <label for="PAFEBRERO">Febrero</label>
                                <input type="checkbox" class="agua" id="PAMARZO" /><label for="PAMARZO">Marzo</label>
                                <input type="checkbox" class="agua" id="PAABRIL" /><label for="PAABRIL">Abril</label>
                                <input type="checkbox" class="agua" id="PAMAYO" /><label for="PAMAYO">Mayo</label>
                                <input type="checkbox" class="agua" id="PAJUNIO" /><label for="PAJUNIO">Junio</label>
                                <input type="checkbox" class="agua" id="PAJULIO" /><label for="PAJULIO">Julio</label>
                                <input type="checkbox" class="agua" id="PAAGOSTO" /><label for="PAAGOSTO">Agosto</label>
                                <input type="checkbox" class="agua" id="PASEPTIEMBRE" /><label for="PASEPTIEMBRE">Septiembre</label>
                                <input type="checkbox" class="agua" id="PAOCTUBRE" /><label for="PAOCTUBRE">Octubre</label>
                                <input type="checkbox" class="agua" id="PANOVIEMBRE" /><label for="PANOVIEMBRE">Noviembre</label>
                                <input type="checkbox" class="agua" id="PADICIEMBRE" /><label for="PADICIEMBRE">Diciembre</label>
                            </div>
                        </div>
                        <h5><strong>Luz</strong></h5>
                        <div class="row">
                            <div class="input-field col s6 m4">
                                <select id="SelectAnioLuz">
                                    <option value="" disabled selected>Seleccione una opción</option>
                                </select>
                                <label>Año</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s12 m12">
                                <input type="checkbox" class="luz" id="PLENERO"/> <label for="PLENERO">Enero</label>
                                <input type="checkbox" class="luz" id="PLFEBRERO" /> <label for="PLFEBRERO">Febrero</label>
                                <input type="checkbox" class="luz" id="PLMARZO" /><label for="PLMARZO">Marzo</label>
                                <input type="checkbox" class="luz" id="PLABRIL" /><label for="PLABRIL">Abril</label>
                                <input type="checkbox" class="luz" id="PLMAYO" /><label for="PLMAYO">Mayo</label>
                                <input type="checkbox" class="luz" id="PLJUNIO" /><label for="PLJUNIO">Junio</label>
                                <input type="checkbox" class="luz" id="PLJULIO" /><label for="PLJULIO">Julio</label>
                                <input type="checkbox" class="luz" id="PLAGOSTO" /><label for="PLAGOSTO">Agosto</label>
                                <input type="checkbox" class="luz" id="PLSEPTIEMBRE" /><label for="PLSEPTIEMBRE">Septiembre</label>
                                <input type="checkbox" class="luz" id="PLOCTUBRE" /><label for="PLOCTUBRE">Octubre</label>
                                <input type="checkbox" class="luz" id="PLNOVIEMBRE" /><label for="PLNOVIEMBRE">Noviembre</label>
                                <input type="checkbox" class="luz" id="PLDICIEMBRE" /><label for="PLDICIEMBRE">Diciembre</label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container" style="padding: 2%">
            <div class="col s12 m8 l12 center-align">
                <a id="Guardar" class="center modal-action modal-close waves-effect waves-green btn">REPORTE</a>
                <a  id="btnCalcular" class="center modal-action modal-close waves-effect waves-green btn blue">CALCULAR</a>
                <a href="#modalPre" id="Guardar" class="center modal-action modal-close waves-effect waves-green btn blue">PAGAR</a>
                <a href="principal.jsp" class="center modal-action modal-close waves-effect waves-green btn red">Cancelar</a>
            </div>
            <!-- Modal Structure -->
            <div id="modalPre" class="modal">
                <div class="modal-content">
                    <h4>PRELIMINAR PAGOS</h4><br>
                    <div  id="divPreliminar" class="row">
                        <!--<table class="striped">
                            <thead>
                                <tr>
                                    <th data-field="id">Descripción</th>
                                    <th data-field="name">Monto</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1.- CUOTA TERRENO</td>
                                    <td>S/.570</td>
                                </tr>
                                <tr>
                                    <td>2.- CUOTA UNICA LUZ</td>
                                    <td>S/.250</td>
                                </tr>
                                <tr>
                                    <td>3.- CUOTA VIGILANCIA: ENERO- 2017, FEBRERO-2017, MARZO-2017</td>
                                    <td>S/.60</td>
                                </tr>
                                <tr>
                                    <td class="center-align">TOTAL</td>
                                    <td>S/.880</td>
                                </tr>
                            </tbody>
                        </table>-->

                    </div>



                    <div class="modal-footer">
                        <a id="btnPagar" class="modal-action waves-effect waves-green btn">PAGAR</a>
                        <a href="#!" class=" modal-action modal-close waves-effect waves-green btn red">CANCELAR</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var pagos = {
        cuotas: []
    };
    var pagosTotales = {
        pagos: []
    };
    var pagosUnicos = {
    };
    var TipoPago = {
    };
    var pagosMServicios = {
        pagoLuz: [],
        pagoAgua: [],
        pagoSeguridad: [],
        PrecioMensual: 20,
        AnioPagoLuz: 0,
        AnioPagoAgua: 0,
        AnioPagoSeguridad: 0
    };

    $(document).ready(function () {
        Materialize.updateTextFields();
        $('.modal').modal();
        $('select').material_select();

    });
    $("input[name=TipoPago]").click(function () {
        if ($(this).val() === "on") { //cuotas
            $("#PCuotaMensual").val(0);
            crearTable();
            Materialize.updateTextFields();
            listar();
        } else {
            /*var table = $('#dt_CalendarioCuotas').DataTable();
             table.destroy();
             $('#dt_CalendarioCuotas').empty();*/
            $("#divCalendarioCuotas").empty();
            $("#divCalendarioCuotas").slideUp("slow");
            total();

        }
    });
    function crearTable() {
        $("#divCalendarioCuotas").html(" <table id='dt_CalendarioCuotas' class='mdl-data-table' cellspacing='0' width='100%'>" +
                "<thead>" +
                "<tr>" +
                "<th></th>" +
                "<th>Numero Cuota</th>" +
                "<th>Fecha</th>" +
                "<th>Monto S/.</th>" +
                "</tr>" +
                "</thead>" +
                " </table>");
    }
    function total() {
        var cod_venta = $("#cod_venta").val();
        $.ajax({
            method: "POST",
            url: "<%= request.getContextPath()%>/ControlServletV?parAccion=vConsultaClienteTotal",
            data: {"cod_venta": cod_venta}
        }).done(function (data) {
            data = JSON.parse(data);
            console.log(data);
            if (data.Result === "OK") {
                $("#PCuotaMensual").val(data.total);
                Materialize.updateTextFields();
            }
            if (data.Result === "SINDEUDA") {
                $("#PCuotaMensual").val(data.total);
                Materialize.updateTextFields();
                sweetAlert("Correcto", "Sin deuda", "success");
            }
            if (data.Result === "ERROR") {
                sweetAlert("Error", "al intentar calcular monto, vuelve a intentar", "error");
            }
        });
    }
    function listar() {
        // $("#divCalendarioCuotas").slideUp("slow");
        $("#divCalendarioCuotas").slideDown("slow");
        //var table = $('#dt_cliente').DataTable();
        var cod_venta = $("#cod_venta").val();

        var table = $("#dt_CalendarioCuotas").DataTable({
            columnDefs: [{
                    orderable: false,
                    className: 'select-checkbox',
                    targets: 0
                }],
            select: {
                style: 'multi',
                selector: 'td:first-child'
            },
            order: [[1, 'asc']],
            "destroy": true,
            "ajax": {
                "method": "POST",
                "url": "<%= request.getContextPath()%>/ControlServletV?parAccion=listaCuotas",
                data: {"cod_venta": cod_venta}
            },
            "columns": [
                {"defaultContent": ""},
                {"data": "nro_cuota"},
                {"data": "fecha_pago"},
                {"data": "cuota_mensual"}
            ],
            "language": idioma_espanol,
            "dom": "<'row'<'form-inline' <'col s5 s-offset-5'B>>>"
                    + "<'row' <'form-inline' <'col s10 m8 l2 toolbar left-align'><'col s10 m8 l4 offset-l6'f>>>"
                    + "<rt>"
                    + "<'dataTable'<'row espacioFooter'"
                    + "<'col s12 m2 'l>"
                    + "<'col s12 m10 'p>>>"
        });
        /*   $("div.toolbar").html('<a id="btnAdd" title="Agregar usuario" class="btn-floating btn-large waves-effect waves-light"><i class="material-icons">add</i></a>\n\
         <a id="btnEditar" class="btn-floating btn-large waves-effect waves-light blue"><i class="material-icons">mode_edit</i></a>\n\
         <a id="btnBorrar" class="btn-floating btn-large waves-effect waves-light red"><i class="material-icons">delete</i></a>');*/

        /* obtener_data_editar(table);
         obtener_id_eliminar(table);
         agregar();*/
        selecion(table);
    }
    function selecion(table) {

        table.on('click', 'tr', function () {
            $(this).toggleClass('selected');
            //table.toggleClass('selected');
            //console.log(table.rows('.selected').data());
            // alert(table.rows('.selected').data().length + ' row(s) selected');
            var monto = 0;
            if (table.rows('.selected').data().length === 0) {
                $("#PCuotaMensual").val(monto);
            }

            var json_cuotas = [];
            var nro_cuotas = [];
            for (var i = 0; i < table.rows('.selected').data().length; i++) {
                var item = table.rows('.selected').data()[i];
                console.log(item.nro_cuota);
                monto = monto + parseInt(item.cuota_mensual);
                $("#PCuotaMensual").val(monto);
                json_cuotas.push({
                    "nro_cuota": item.nro_cuota,
                    "monto": item.cuota_mensual
                });
            }
            console.log(json_cuotas);
            Materialize.updateTextFields();
            pagos.cuotas = json_cuotas;
            pagos.nro_cuotas = nro_cuotas;
            console.log(pagos);
        });


    }
    $("input[name=checkPAgua]").click(function () {
        var opcion = $(this).prop("checked");
        if (opcion === true) {
            $("#PAgua").removeAttr("disabled");
        } else {
            $("#PAgua").attr('disabled', 'disabled');
        }
    });
    $("input[name=checkPLuz]").click(function () {
        var opcion = $(this).prop("checked");
        if (opcion === true) {
            $("#PLuz").removeAttr("disabled");
        } else {
            $("#PLuz").attr('disabled', 'disabled');
        }
    });
    $("input[name=checkPOtros]").click(function () {
        var opcion = $(this).prop("checked");
        if (opcion === true) {
            $("#POtros").removeAttr("disabled");
            $("#POtrosDes").removeAttr("disabled");

        } else {
            $("#POtros").attr('disabled', 'disabled');
            $("#POtrosDes").attr('disabled', 'disabled');
        }
    });
    $("#btnPagar").on("click", function () {

        /* var pagosUnicos = {
         agua: {},
         luz: {},
         otro: {}
         };
         var TipoPago = {
         };
         var pagosMServicios = {
         pagoLuz: [],
         pagoAgua: [],
         pagoSeguridad: []
         };*/
        console.log(pagosTotales);
        $.get('<%= request.getContextPath()%>/ControlServletV?parAccion=guardarPago', {
            PagosUnicos: JSON.stringify(pagosUnicos), //JSON.stringify(myjson)
            TipoPago: JSON.stringify(TipoPago),
            pagosMServicios: JSON.stringify(pagosMServicios),
            cod_venta: $("#cod_venta").val()
        }, function (data) {
            console.log(data);
            /*  var data_json = JSON.parse(data);
             console.log(data_json);
             if (data_json.Result === true) {
             swal({
             title: "Registro Satisfactorio",
             text: "Por favor acérquese a Biblioteca con los ejemplares de su tesis.",
             type: "success"
             },
             function () {
             window.location.href = '/autorizaciontesis/index.jsp';
             window.open('<%= request.getContextPath()%>/ServletConstancia', '_blank');
             }
             );
             } else {
             //alert('No se pudo registrar Autorización, Por favor revisar sus datos');
             swal({title: "Error", text: "No se pudo registrar su Autorización, Por favor revisar sus datos y vuelva a intentarlo.", type: "error", confirmButtonText: "Aceptar"});
             }*/
        });

    });
    $("#btnCalcular").on("click", function () {

        /*var pagosTotales = {
         pagos: []
         };
         var pagosUnicos = {
         agua: {},
         luz: {},
         otro: {}
         };
         var TipoPago = {
         };
         var pagosMServicios = {
         pagoLuz: [],
         pagoAgua: [],
         pagoSeguridad: []
         };*/

        ////***     PAGO UNICO DE AGUA   ****/
        var opcion = $("#checkPAgua").prop("checked");
        if (opcion === true) {
            //$("#PAgua").removeAttr("disabled");
            //console.log($("#PAgua").val());
            pagosUnicos.PAguaEstado = 'on';
            pagosUnicos.PAgua = $("#PAgua").val();
            pagosTotales.pagos.push({
                "Descripcion": "PAGO ÚNICO AGUA",
                "Monto": $("#PAgua").val()
            });
        } else {
            // pagosUnicos.agua = {estado: 'off', monto: $("#PAgua").val()}
            pagosUnicos.PAguaEstado = 'off';
            pagosUnicos.PAgua = $("#PAgua").val();
        }

        ////***     PAGO UNICO DE LUZ   ****/
        var opcion = $("#checkPLuz").prop("checked");
        if (opcion === true) {
            //$("#PAgua").removeAttr("disabled");
            //console.log($("#PAgua").val());
            // pagosUnicos.luz = {estado: 'on', monto: $("#PLuz").val()}
            pagosUnicos.PLuzEstado = 'on';
            pagosUnicos.PLuz = $("#PLuz").val();
            pagosTotales.pagos.push({
                "Descripcion": "PAGO ÚNICO LUZ",
                "Monto": $("#PLuz").val()
            });
        } else {
            //pagosUnicos.luz = {estado: 'off', monto: $("#PLuz").val()}
            pagosUnicos.PLuzEstado = 'off';
            pagosUnicos.PLuz = $("#PLuz").val();
        }
        ////***     PAGO OTROS ****/
        var opcion = $("#checkPOtros").prop("checked");
        if (opcion === true) {
            //$("#PAgua").removeAttr("disabled");
            //console.log($("#PAgua").val());
            //pagosUnicos.otro = {estado: 'on', monto: $("#POtros").val(), nota: $("#POtrosDes").val()}
            pagosUnicos.POtroEstado = 'on';
            pagosUnicos.POtro = $("#POtros").val();
            pagosUnicos.POtroDes = $("#POtrosDes").val();
            pagosTotales.pagos.push({
                "Descripcion": "PAGO OTROS: " + $("#POtrosDes").val(),
                "Monto": $("#POtros").val()
            });
        } else {
            // pagosUnicos.otro = {estado: 'off', monto: $("#POtros").val()}
            pagosUnicos.POtroEstado = 'off';
            pagosUnicos.POtro = $("#POtros").val();
            pagosUnicos.POtroDes = $("#POtrosDes").val();
        }
        console.log(pagosUnicos);

        var opt = $('input[name=TipoPago]:checked').val();
        console.log(opt);

        if (opt === "on") {//CUOTAS
            TipoPago.tipo = 1;
            TipoPago.cuotas = pagos.cuotas;
            TipoPago.Monto = $("#PCuotaMensual").val();

            pagos.cuotas.forEach(function (item) {
                pagosTotales.pagos.push({
                    "Descripcion": "PAGO CUOTA NRO: " + item.nro_cuota,
                    "Monto": item.monto
                });
            });
        }
        if (opt === "off") {//TOTAL
            TipoPago.tipo = 2;
            TipoPago.cuotas = [];
            TipoPago.Monto = $("#PCuotaMensual").val();
            pagosTotales.pagos.push({
                "Descripcion": "CANCELACION TOTAL DE LA DEUDA",
                "Monto": $("#PCuotaMensual").val()
            });
        }
        console.log(TipoPago);

        /**PAGO LUZ MENSUAL*/
        var anioLuz = $("#SelectAnioLuz").val();
        if (anioLuz) {
            $('input.luz:checkbox:checked').not(":disabled").each(function () {
                // console.log($("label[for='" + $(this).attr("id") + "']"));
                var mescompletoLuz = $(this).attr("id");
                var mesLuz = mescompletoLuz.substring(2);
                pagosMServicios.pagoLuz.push(mesLuz);
                pagosTotales.pagos.push({
                    "Descripcion": "PAGO LUZ: " + anioLuz + "-" + mesLuz,
                    "Monto": 20
                });
            });
            pagosMServicios.AnioPagoLuz = anioLuz;
        }
        /***********PAGO AGUA**********/
        var anioAgua = $("#SelectAnioAgua").val();
        if (anioAgua) {
            $('input.agua:checkbox:checked').not(":disabled").each(function () {

                //console.log($("label[for='" + $(this).attr("id") + "']"));
                var mescompleto = $(this).attr("id");
                var mesAgua = mescompleto.substring(2);
                pagosMServicios.pagoAgua.push(mesAgua);
                pagosTotales.pagos.push({
                    "Descripcion": "PAGO AGUA:" + anioAgua + "-" + mesAgua,
                    "Monto": 20
                });
            });
            pagosMServicios.AnioPagoAgua = anioAgua;
        }
        /********SEGURIDAD*******/
        var anioSeg = $("#SelectAnioSegu").val();
        if (anioSeg) {
            $('input.seguridad:checkbox:checked').not(":disabled").each(function () {
                //var sThisVal = $(this).val();
                //console.log($("label[for='" + $(this).attr("id") + "']"));
                var mescompletoSeg = $(this).attr("id");
                var mesSeg = mescompletoSeg.substring(2);
                pagosMServicios.pagoSeguridad.push(mesSeg);
                pagosTotales.pagos.push({
                    "Descripcion": "PAGO SEGURIDAD:" + anioSeg + "-" + mesSeg,
                    "Monto": 20
                });
            });
            pagosMServicios.AnioPagoSeguridad = anioSeg;
        }
        console.log(pagosMServicios);
        console.log(pagosTotales);
        preeliminar(pagosTotales);
        $('#modalPre').modal('open');
    });

    function preeliminar(pagosTotales) {

        var registroshtml = "";
        var total = 0;
        pagosTotales.pagos.forEach(function (item) {
            registroshtml += "<tr>" +
                    "<td>" + item.Descripcion + "</td>" +
                    "<td>" + item.Monto + "</td>" +
                    "</tr>";
            total = total + parseInt(item.Monto);
        });

        $("#divPreliminar").html("<table class='striped'>" +
                "<thead>" +
                "<tr>" +
                "<th data-field='id'>Descripción</th>" +
                "<th data-field='name'>S/. Monto</th>" +
                "</tr>" +
                "</thead>" +
                "<tbody>" +
                registroshtml +
                "<tr>" +
                "<td class='center-align'>TOTAL</td>" +
                "<td>S/." + total + "</td>" +
                "</tr>" +
                "</tbody>" +
                "</table>");


    }

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
                    $("#dniCliente").val(data.dni);
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
    $("#SelectTerreno").on("change", function () {
        var cod_terreno = $("#SelectTerreno").val();
        var cod_cliente = $("#dniCliente").val();
        $.get('<%= request.getContextPath()%>/ControlServletV?parAccion=getEstadoCuenta', {
            cod_terreno: cod_terreno,
            cod_cliente: cod_cliente
        }, function (data) {

            console.log(data);
            data = JSON.parse(data);

            $("#cod_venta").val(data.cod_venta);
            $("#Total").val(data.monto_total);
            $("#PagoAcumulado").val(data.monto_pagado);
            $("#NroCuotas").val(data.nro_cuotas);
            $("#Saldo").val(data.monto_deuda);
            $("#PLuz").val(data.pagoLuz);
            $("#PAgua").val(data.pagoAgua);
            $("#POtros").val(data.pagoOtro);
            $("#POtrosDes").val(data.pagoOtroDes);
            $("#FechaVenta").val(data.fecha_venta);


            Materialize.updateTextFields();

            /*var data_json = JSON.parse(data);
             $('#SelectEtapa').material_select('destroy');
             $('#SelectEtapa').empty().html(' ');
             $("#SelectEtapa").append('<option value="" disabled selected>Seleccione una opción</option>');
             $.each(data_json.etapas, function (id, value) {
             $("#SelectEtapa").append('<option value="' + value.etapa + '">' + value.etapa + '</option>');
             });
             $('#SelectEtapa').material_select();*/
            $.ajax({
                method: "POST",
                url: "<%= request.getContextPath()%>/ControlServletV?parAccion=getAnios",
                data: {"cod_venta": data.cod_venta}
            }).done(function (data) {

                //alert(info);
                // var array_return =  $.parseJSON ( info );
                // console.log("valor: "+ array_return);
                data = JSON.parse(data);
                console.log(data);
                $('#SelectAnioSegu').material_select('destroy');
                $('#SelectAnioSegu').empty().html(' ');
                $("#SelectAnioSegu").append('<option value="" disabled selected>Seleccione una opción</option>');
                $.each(data.anios, function (id, value) {
                    $("#SelectAnioSegu").append('<option value="' + value.anio + '">' + value.anio + '</option>');
                });
                $('#SelectAnioSegu').material_select();
                /***/
                $('#SelectAnioAgua').material_select('destroy');
                $('#SelectAnioAgua').empty().html(' ');
                $("#SelectAnioAgua").append('<option value="" disabled selected>Seleccione una opción</option>');
                $.each(data.anios, function (id, value) {
                    $("#SelectAnioAgua").append('<option value="' + value.anio + '">' + value.anio + '</option>');
                });
                $('#SelectAnioAgua').material_select();
                /***/
                $('#SelectAnioLuz').material_select('destroy');
                $('#SelectAnioLuz').empty().html(' ');
                $("#SelectAnioLuz").append('<option value="" disabled selected>Seleccione una opción</option>');
                $.each(data.anios, function (id, value) {
                    $("#SelectAnioLuz").append('<option value="' + value.anio + '">' + value.anio + '</option>');
                });
                $('#SelectAnioLuz').material_select();

            });

        });
    });
    $("#SelectAnioLuz").on("change", function () {
        var anio_luz = $("#SelectAnioLuz").val();
        var cod_venta = $("#cod_venta").val();
        // var lote = $("#lote").val();

        $.ajax({
            method: "POST",
            url: "<%= request.getContextPath()%>/ControlServletV?parAccion=getServicioLuz",
            data: {"anio_luz": anio_luz, "cod_venta": cod_venta}
        }).done(function (data) {

            //alert(info);
            // var array_return =  $.parseJSON ( info );
            // console.log("valor: "+ array_return);
            data = JSON.parse(data);
            console.log(data);
            $.each(data.meses, function (id, value) {
                var mes = "#PL" + value.mes;
                // console.log(mes);

                $(mes).prop('checked', true);
                //$("input.group1").attr("disabled", true);
                $(mes).attr("disabled", true);
                //$(mes).append('<option value="' + value.lote + '">' + value.lote + '</option>');
            });
            // $('#PLMAYO').prop('checked', true);
        });
    });
    $("#SelectAnioAgua").on("change", function () {
        var anio_agua = $("#SelectAnioAgua").val();
        var cod_venta = $("#cod_venta").val();
        // var lote = $("#lote").val();

        $.ajax({
            method: "POST",
            url: "<%= request.getContextPath()%>/ControlServletV?parAccion=getServicioAgua",
            data: {"anio_agua": anio_agua, "cod_venta": cod_venta}
        }).done(function (data) {

            //alert(info);
            // var array_return =  $.parseJSON ( info );
            // console.log("valor: "+ array_return);
            data = JSON.parse(data);
            console.log(data);
            $.each(data.meses, function (id, value) {
                var mes = "#PA" + value.mes;
                // console.log(mes);

                $(mes).prop('checked', true);
                $(mes).attr("disabled", true);
                //$(mes).append('<option value="' + value.lote + '">' + value.lote + '</option>');
            });
            // $('#PLMAYO').prop('checked', true);
        });
    });
    $("#SelectAnioSegu").on("change", function () {
        var anio_seguridad = $("#SelectAnioSegu").val();
        var cod_venta = $("#cod_venta").val();
        // var lote = $("#lote").val();

        $.ajax({
            method: "POST",
            url: "<%= request.getContextPath()%>/ControlServletV?parAccion=getServicioSeguridad",
            data: {"anio_seguridad": anio_seguridad, "cod_venta": cod_venta}
        }).done(function (data) {

            //alert(info);
            // var array_return =  $.parseJSON ( info );
            // console.log("valor: "+ array_return);
            data = JSON.parse(data);
            console.log(data);
            $.each(data.meses, function (id, value) {
                var mes = "#PS" + value.mes;
                // console.log(mes);

                $(mes).prop('checked', true);
                $(mes).attr("disabled", true);
                //$(mes).append('<option value="' + value.lote + '">' + value.lote + '</option>');
            });
            // $('#PLMAYO').prop('checked', true);
        });
    });

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
