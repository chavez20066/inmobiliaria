<div class="container">
    <div class="col s12 m12 l12" style="padding-top: 5%">
        <form name="frmValores" id="frmValores" action="" method="POST">
            <!--<h2 class="header">Horizontal Card</h2>-->
            <div class="card horizontal">
                <div class="card-stacked">
                    <div class="card-content">
                        <h3 class="center-align">Valores por Defecto</h3>
                        <h4>Pago Mensual de Servicios</h4>
                        <div class="row">
                            <br>
                            <div class="row">
                                <div class="input-field col s6 m2">
                                    <i class="material-icons prefix">payment</i>
                                    <input id="pagoMensual" name="pagoMensual" type="number" min="0" class="validate solo-numero">
                                    <label for="pagoMensual">Monto S/.</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container" style="padding: 2%">
                <div class="col s12 m8 l12 center-align">
                    <!-- <input id="btnGuardar"  class="center modal-action modal-close waves-effect waves-green btn" value="Guardar">-->
                    <a href="principal.jsp" class="center modal-action modal-close waves-effect waves-green btn red">Cancelar</a>
                    <button type="button" id="btnGuardar" class="btn btn-primary modal-action modal-close waves-effect " >Guardar</button>
                </div>
            </div>
        </form>
    </div>

</div>
<script>
    $(document).ready(function () {
        setVariables();
    });
    $("#btnGuardar").on("click", function (e) {

        var frm = $("#frmValores").serialize();
        console.log(frm);

        $.ajax({
            method: "POST",
            url: "<%= request.getContextPath()%>/ControlServletV?parAccion=setValorDefecto",
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
                            window.location.href = '/inmobiliaria/templates/principal.jsp';
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

    function setVariables() {
        $.get('<%= request.getContextPath()%>/ControlServletV?parAccion=getvalorDefecto', {
        }, function (data) {
            console.log(data);
            var data_json = JSON.parse(data);
            console.log(data_json);
            $('#pagoMensual').val(data_json.monto_pago_servicios);
            Materialize.updateTextFields();
        });
    }

</script>

