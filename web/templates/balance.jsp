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
                            <div class="col s12 m4 offset-m2 center-align">
                                <h5>Fecha de Inicio:</h5>
                                <input type="date" class="datepicker center-align">
                            </div>
                            <div class="col s12 m4 center-align">
                                <h5>Fecha de Fin:</h5>
                                <input type="date" class="datepicker center-align">
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
                        <div class="row center-align">
                            <div class="input-field col s12 m4 offset-m2">
                                <select id="SelectLocalidad" name="SelectLocalidad">
                                    <option value="0" selected>Todas</option>
                                </select>
                                <label>Localidad</label>
                            </div>
                            <div class="input-field col s12 m4">
                                <select id="SelectEtapa" name="SelectEtapa">
                                    <option value="0" selected>Todas</option>
                                </select>
                                <label>Etapa</label>
                            </div>
                        </div>

                        <div class="col s12 m8 l12 center-align">
                            <a id="btnBalance" class="center modal-action modal-close waves-effect waves-green btn">Generar Balances</a>
                        </div>

                        <div class="row">

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

        /*$('.datepicker').pickadate({
            selectMonths: true, // Creates a dropdown to control month
            selectYears: 15, // Creates a dropdown of 15 years to control year
            format: 'yyyy/mm/dd'
        });*/
        $('.datepicker').pickadate({
            selectMonths: true, // Creates a dropdown to control month
            selectYears: 15, // Creates a dropdown of 15 years to control year
            format: 'yyyy/mm/dd',
            labelMonthNext: 'siguiente mes',
            labelMonthPrev: 'anterior mes',
            labelMonthSelect: 'Seleccionar un mes',
            labelYearSelect: 'Seleccionar un año',
            monthsFull: [ 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre' ],
            monthsShort: [ 'Ene', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic' ],
            weekdaysFull: [ 'Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado' ],
            weekdaysShort: [ 'Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab' ],
            weekdaysLetter: [ 'D', 'L', 'M', 'M', 'J', 'V', 'S' ],
            today: 'Hoy',
            clear: 'Cancelar',
            close: 'Cerrar'
          });
        setVariables();
    });
    $("#btnBalance").on("click", function () {
        

    });
    function setVariables() {
        $.get('<%= request.getContextPath()%>/ControlServlet?parAccion=listaLocalidad', {
        }, function (datos) {
            console.log(datos);
            var data_json = JSON.parse(datos);
            $('#SelectLocalidad').material_select('destroy');
            $('#SelectLocalidad').empty().html(' ');
            $("#SelectLocalidad").append('<option value="0" selected>Todas</option>');
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
                $("#SelectEtapa").append('<option value="0" selected>Todas</option>');
                $.each(data_json.data, function (id, value) {
                    //  $("#SelectTipoEgreso").append('<option value="' + value.cod_tipo_egreso + '">' + value.tipo_egreso + '</option>');
                    $("#SelectEtapa").append('<option value="' + value.etapa + '">' + value.etapa + '</option>');
                });
                $('#SelectEtapa').material_select();
            });
        });
    }
    
</script>
