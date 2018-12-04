<div class="container">

    <div class="col s12 m12 l12" style="padding-top: 5%">
        <!--<h2 class="header">Horizontal Card</h2>-->
        <div class="card horizontal">
            <div class="card-stacked">
                <div class="card-content">
                    <h3 class="center-align">BALANCE</h3>
                    <br>
                    <div class="row">
                        <div class="row">
                            <div class="col s12 m6">
                                <h5>Fecha de Inicio:</h5>
                                <input type="date" class="datepicker">
                            </div>
                            <div class="col s12 m6">
                                <h5>Fecha de Fin:</h5>
                                <input type="date" class="datepicker">
                            </div>
                        </div>
                        <div class="row center-align">
                            <div class="col s4 m4 center-align">
                                <label for="tipo">Tipo:</label>
                                <br>
                                <input name="Rbalance" type="radio" id="Ringresos" value="ingresos"/>
                                <label for="Ringresos">Ingresos</label>
                            </div>
                            <div class="col s4 m4 center-align">
                                <br>
                                <input name="Rbalance" type="radio" id="Regresos" value="egresos" />
                                <label for="Regresos">Egresos</label>
                            </div>
                            <div class="col s4 m4 center-align">
                                <br>
                                <input name="Rbalance" type="radio" id="Rutilidad" value="utilidad" />
                                <label for="Rutilidad">Utilidad</label>
                            </div>
                        </div>
                        <div class="col s12 m8 l12 center-align">
                            <a id="btnBalance" class="center modal-action modal-close waves-effect waves-green btn">Generar Balances</a>
                        </div>

                        <div class="row">
                            <div class="col s12">
                                <ul class="tabs">
                                    <li class="tab col s3"><a href="#test1">Ingresos</a></li>
                                    <li class="tab col s3"><a class="active" href="#test2">Egresos</a></li>
                                    <li class="tab col s3"><a href="#test3">Utilidad</a></li>
                                </ul>
                            </div>
                            <div id="test1" class="col s12">
                                <h4>Ingresos</h4>
                                <div class="row">
                                    <table class="striped">
                                        <thead>
                                            <tr>
                                                <th data-field="id">Código Operación</th>
                                                <th data-field="id">Descripción</th>
                                                <th data-field="name">Monto</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>0005</td>
                                                <td>1.- CUOTA TERRENO</td>
                                                <td>S/.570</td>
                                            </tr>
                                            <tr>
                                                <td>0005</td>
                                                <td>2.- CUOTA UNICA LUZ</td>
                                                <td>S/.250</td>
                                            </tr>
                                            <tr>
                                                <td>0005</td>
                                                <td>3.- CUOTA VIGILANCIA: ENERO- 2017, FEBRERO-2017, MARZO-2017</td>
                                                <td>S/.60</td>
                                            </tr>
                                            <tr>

                                                <td class="center-align" colspan="2">TOTAL</td>
                                                <td>S/.880</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div id="test2" class="col s12">
                                <h5>Egresos</h5>
                                <div class="row">
                                    <table class="striped">
                                        <thead>
                                            <tr>
                                                <th data-field="name">Codigo</th>
                                                <th data-field="id">Tipo</th>
                                                <th data-field="name">SubTipo</th>
                                                <th data-field="name">Localidad</th>
                                                <th data-field="name">Etapa</th>
                                                <th data-field="name">TipoComprobante</th>
                                                <th data-field="name">Nota</th>
                                                <th data-field="name">Monto</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <tr>
                                                <td>0001</td>
                                                <td>TERRENO</td>
                                                <td>SUB-TIPO</td>
                                                <td>CHIGUATA</td>
                                                <td>15</td>
                                                <td>FACTURA</td>
                                                <td></td>
                                                <td>25000</td>
                                            </tr>
                                        <td class="center-align" colspan="7">TOTAL</td>
                                        <td>S/.880</td>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div id="test3" class="col s12">
                                <h5>UTILIDAD</h5>
                                <div class="row">
                                    <table class="striped">
                                        <thead>
                                            <tr>
                                                <th data-field="id">Código Operación</th>
                                                <th data-field="id">Descripción</th>
                                                <th data-field="name">S/. Monto</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>0005</td>
                                                <td>CUOTA TERRENO</td>
                                                <td>+570</td>
                                            </tr>
                                            <tr>
                                                <td>0005</td>
                                                <td>CUOTA UNICA LUZ</td>
                                                <td>+250</td>
                                            </tr>
                                            <tr>
                                                <td>0005</td>
                                                <td>CUOTA VIGILANCIA: ENERO- 2017, FEBRERO-2017, MARZO-2017</td>
                                                <td>+60</td>
                                            </tr>
                                            <tr>
                                                <td>0001</td>
                                                <td>COMPRA TERRENO</td>
                                                <td>-60</td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="center-align">TOTAL</td>
                                                <td>820</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script>
    $(document).ready(function () {
        $('.modal').modal();
        $('select').material_select();
        $("input[name=cuota]").click(function () {

            if ($(this).val() === "on") {
                $("#Nrocuota").removeAttr("disabled");
            } else {
                $("#Nrocuota").attr('disabled', 'disabled');
            }
        });

        $('.datepicker').pickadate({
            selectMonths: true, // Creates a dropdown to control month
            selectYears: 15, // Creates a dropdown of 15 years to control year
            format: 'yyyy/mm/dd'
        });
        $('ul.tabs').tabs();

    });
</script>
