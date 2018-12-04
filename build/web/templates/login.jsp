
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <%@include file="../WEB-INF/jspf/importCSS.jspf" %>  
        <link href="../css/estilosBasicos.css" rel="stylesheet" type="text/css"/>
        <title>Inmobiliaria</title>
    </head>
    <body class="body" onload="nobackbutton();">
      

        <div class="container">
            <br>
            <!--<div class="clearfix visible-sm-block"></div>-->
            <div id="divLogin" class="row">
                <!--<div class="col s12 m12 l4 center-align ">
                    <img src="imagenes/ucsm_logo.jpg" alt="...">
                </div>!-->
                <div class="col s12 m12 l5 ">
                    <hgroup>
                        <h4><strong> Autenticación Usuario</strong> </h4>
                        <h5><em><small>Fondo de retiro UCSM</small></em></h5>
                    </hgroup>
                    <p style=" text-align: justify;">Ingrese usuario y contraseña para poder iniciar.</p>
                    <a href="#" class="link">Ayuda <i class="icon-chevron-sign-right"></i></a>
                    <!-- Icon Box / End -->
                </div>
                <div class="col s12 m12  l7">
                    <form action="srvEntidades?parAccion=login" method="post" id="login-form" class="contact-form input-blocks">
                        <div class="input-field col s12">
                            <input id="inputUsuario" name="inputUsuario" type="text" class="validate">
                            <label for="usuario" >Usuario</label>
                        </div>
                        <div class="input-field col s12">
                            <input id="inputClave"  type="password" name="inputClave"  class="validate">
                            <label for="example-password-input" >Contraseña</label>
                        </div>
                        <div class="input-field col s12">
                            <!--<input class="btn btn-primary" type="submit" value="Iniciar Sesión"/>-->
                            <button type="submit" class="btn btn-primary">
                                <span class="glyphicon glyphicon-log-in"></span> Iniciar Sesión
                            </button>
                        </div>

                    </form>

                </div>
            </div>
        </div>
        <%@include file="../WEB-INF/jspf/pie.jspf" %>
        <%@include file="../WEB-INF/jspf/importJS.jspf" %>  
    </body>
</html>
