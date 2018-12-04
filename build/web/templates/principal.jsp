

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <%@include file="../WEB-INF/jspf/importCSS.jspf" %>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Inmobiliaria</title>
        <script>
            /* $(document).ready(function () {

             });*/
            function jsRemoveWindowLoad() {
                // eliminamos el div que bloquea pantalla
                $("#WindowLoad").remove();
            }
            function jsShowWindowLoad(mensaje) {
                //eliminamos si existe un div ya bloqueando
                jsRemoveWindowLoad();

                //si no enviamos mensaje se pondra este por defecto
                if (mensaje === undefined)
                    mensaje = "Procesando la información<br>Espere por favor";

                //centrar imagen gif
                height = 20;//El div del titulo, para que se vea mas arriba (H)
                var ancho = 0;
                var alto = 0;

                //obtenemos el ancho y alto de la ventana de nuestro navegador, compatible con todos los navegadores
                if (window.innerWidth == undefined)
                    ancho = window.screen.width;
                else
                    ancho = window.innerWidth;
                if (window.innerHeight == undefined)
                    alto = window.screen.height;
                else
                    alto = window.innerHeight;

                //operación necesaria para centrar el div que muestra el mensaje
                var heightdivsito = alto / 2 - parseInt(height) / 2;//Se utiliza en el margen superior, para centrar

                //imagen que aparece mientras nuestro div es mostrado y da apariencia de cargando
                imgCentro = "<div style='text-align:center;height:" + alto + "px;'><div  style='color:#000;margin-top:" + heightdivsito + "px; font-size:20px;font-weight:bold'>" + mensaje + "</div><img  src='<%= request.getContextPath()%>/imagenes/loading.gif'></div>";

                //creamos el div que bloquea grande------------------------------------------
                div = document.createElement("div");
                div.id = "WindowLoad"
                div.style.width = ancho + "px";
                div.style.height = alto + "px";
                $("body").append(div);

                //creamos un input text para que el foco se plasme en este y el usuario no pueda escribir en nada de atras
                input = document.createElement("input");
                input.id = "focusInput";
                input.type = "text"

                //asignamos el div que bloquea
                $("#WindowLoad").append(input);

                //asignamos el foco y ocultamos el input text
                $("#focusInput").focus();
                $("#focusInput").hide();

                //centramos el div del texto
                $("#WindowLoad").html(imgCentro);

            }
            function cuboBiblio() {
                jsShowWindowLoad('Cargando Cubo');

                $.get('<%= request.getContextPath()%>/ControlServletV?parAccion=olap', {
                    //  txtbuscarDocente : BusquedaDocente
                }, function (data) {
                    window.location.href = '/inmobiliaria/administrador/olap/index.jsp';
                    //$('#EntidadesContainer').jtable('load');

                    // document.getElementById('divBusqueda').style.display ='inherit';
                });
            }
            function menuUsuariosAdm() {
                limpiar();
                $("#divContenido").load('usuariosAdm.jsp');
            }
            function menuPredeterminados() {
                limpiar();
                $("#divContenido").load('valoresDefault.jsp');
            }
            function menuEgresos() {
                limpiar();
                $("#divContenido").load('egresos.jsp');

            }
            function menuSubTipoEgresos() {
                limpiar();
                $("#divContenido").load('SubTiposEgresos.jsp');
            }
            function menuTiposEgresos() {
                limpiar();
                $("#divContenido").load('TiposEgresos.jsp');
            }
            function menuManzanas() {
                limpiar()
                $("#divContenido").load('manzanas.jsp');
            }
            function menuEtapas() {
                limpiar()
                $("#divContenido").load('etapas.jsp');
            }

            function menuLocalidades() {
                limpiar()
                $("#divContenido").load('localidades.jsp');
            }
            function menuTerrenos() {
                limpiar()
                $("#divContenido").load('terrenos.jsp');
            }
            function menuVisitas() {
                limpiar()
                $("#divContenido").load('visita.jsp');
            }
            function menuAsesor() {
                limpiar()
                $("#divContenido").load('asesorOK.jsp');
            }
            function menuCandidatos() {
                limpiar()
                $("#divContenido").load('candidato.jsp');
            }
            function menuClientes() {

                //  alert('Menu Socios');
                limpiar();
                $("#divContenido").load('clientes.jsp');

            }
            function menuVentas() {

                limpiar();
                $("#divContenido").load('ventas.jsp');

            }
            function menuTransferencias() {
                limpiar();
                $("#divContenido").load('transferencia.jsp');
            }
            function menuEstadoCuenta() {
                limpiar();
                $("#divContenido").load('estadocuenta.jsp');
            }
            function menuBalance() {
                limpiar();
                $("#divContenido").load('balance.jsp');
            }
            function limpiar() {
                $('#divContenido').empty();
            }
        </script>

    </head>
    <body>
        <!-- Dropdown Structure -->
        <ul id="dropdown1" class="dropdown-content">
            <li><a href="javascript:menuTerrenos()">Terrenos</a></li>
            <li class="divider"></li>
            <li><a href="javascript:menuLocalidades()">Localidades</a></li>
            <li><a href="javascript:menuEtapas()">Etapas</a></li>
            <li><a href="javascript:menuManzanas()">Manzanas</a></li>
        </ul>
        <!-- Dropdown Structure -->
        <ul id="dropdown2" class="dropdown-content">
            <li><a href="javascript:menuEgresos()">Egresos</a></li>
            <li class="divider"></li>
            <li><a href="javascript:menuTiposEgresos()">Tipos de Egresos</a></li>
            <li><a href="javascript:menuSubTipoEgresos()">Sub-Tipos de Egresos </a></li>
        </ul>
        <nav class="light-blue lighten-1" role="navigation">
            <div class="nav-wrapper container"><a id="logo-container" href="#" class="brand-logo"></a>
                <ul class="right hide-on-med-and-down">
                    <li><a href="javascript:menuVisitas()"><i class="large material-icons">perm_contact_calendar</i>Visitas</a></li>
                    <li><a href="javascript:menuAsesor()"><i class="large material-icons">perm_identity</i>Asesor</a></li>
                    <li><a href="javascript:menuCandidatos()"><i class="large material-icons">person_pin</i>Candidatos</a></li>
                    <li><a href="javascript:menuClientes()"><i class="large material-icons">perm_identity</i>Clientes</a></li>
                    <!-- Dropdown Trigger -->
                    <li><a class="dropdown-button" href="javascript:menuTerrenos()" data-activates="dropdown1">Terrenos<i class="material-icons right">arrow_drop_down</i></a></li>

                    <li><a href="javascript:menuVentas()"><i class="large material-icons">shopping_cart</i>Ventas</a></li>
                    <li><a href="javascript:menuTransferencias()"><i class="large material-icons">swap_horiz</i>Transferencia</a></li>
                    <li><a href="javascript:menuEstadoCuenta()"><i class="large material-icons">supervisor_account</i>Estado Cuenta</a></li>
                    <!-- Dropdown Trigger -->
                    <li><a class="dropdown-button" href="javascript:menuTerrenos()" data-activates="dropdown2">Egresos<i class="material-icons right">arrow_drop_down</i></a></li>
                    <li><a href="javascript:menuUsuariosAdm()"><i class="large material-icons">supervisor_account</i>Usuarios</a></li>
                    <li><a href="javascript:menuPredeterminados()"><i class="large material-icons">settings</i>Valores</a></li>
                    <li><a href="javascript:menuBalance()"><i class="large material-icons">trending_up</i>Balance</a></li>
                    <li><a href="javascript:cuboBiblio()"><i class="large material-icons">trending_up</i>Graficos</a></li>

                </ul>
                <ul id="nav-mobile" class="side-nav">
                    <li><a href="javascript:menuVisitas()"><i class="large material-icons">perm_contact_calendar</i>Visitas</a></li>
                    <li><a href="javascript:menuAsesor()"><i class="large material-icons">perm_identity</i>Asesor</a></li>
                    <li><a href="javascript:menuCandidatos()"><i class="large material-icons">person_pin</i>Candidatos</a></li>
                    <li><a href="javascript:menuClientes()"><i class="large material-icons">perm_identity</i>Clientes</a></li>
                    <li><a href="javascript:menuVentas()"><i class="large material-icons">shopping_cart</i>Ventas</a></li>
                    <li><a href="javascript:menuTransferencias()"><i class="large material-icons">swap_horiz</i>Transferencia</a></li>
                    <li><a href="javascript:menuEstadoCuenta()"><i class="large material-icons">supervisor_account</i>Estado de Cuenta</a></li>

                    <li><a href="javascript:menuBalance()"><i class="large material-icons">trending_up</i>Balance</a></li>

                </ul>
                <a href="#" data-activates="nav-mobile" class="button-collapse"><i class="material-icons">menu</i></a>
            </div>
        </nav>

        <div id="divContenido">
        </div>

        <!--  Scripts-->
        <%@include file="../WEB-INF/jspf/importJS.jspf" %>
        <script src="../js/init.js"></script>
        <!--Import jQuery before materialize.js-->


    </body>
</html>

