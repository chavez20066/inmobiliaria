<%--
    Document   : logeo
    Created on : 20-feb-2017, 18:12:09
    Author     : Diego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<style>
    html,
    body {
        height: 100%;
        margin: 0;
        padding: 0;
    }
    #contenedor {
        min-height: 100%;
        height: auto !important;
        height: 100%;
        margin: 0 auto -60px;
    }
    body {
        display: table;
        width: 100%;
    }
    .clase-general{
        display: table-row;
    }
    footer {
        background: red; height: 100px;
    }

    html, body {
        height: 100%;
    }
    #contenedor {
        min-height: 100%;
        height: auto !important;
        height: 100%;
        margin: 0 auto -60px;
    }
    #footer{
        height: 60px;
    }

</style>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <%@include file="../WEB-INF/jspf/importCSS.jspf" %>
        <title>Testing footer</title>
    </head>
    <body>
        <header class="clase-general">
            <nav class="light-blue lighten-1" role="navigation">
                <div class="nav-wrapper container"><a id="logo-container" href="#" class="brand-logo">Logo</a>
                    <ul class="right hide-on-med-and-down">
                        <li><a href="logeo.jsp"><i class="large material-icons">perm_identity</i>Login</a></li>
                    </ul>

                    <ul id="nav-mobile" class="side-nav">
                        <li><a href="logeo.jsp"><i class="material-icons">perm_identity</i>Login</a></li>

                    </ul>
                    <a href="#" data-activates="nav-mobile" class="button-collapse"><i class="material-icons">menu</i></a>
                </div>
            </nav>
        </header>
        <div id="contenedor" class="clase-general">
            <div class="container">
                <br>
                <!--<div class="clearfix visible-sm-block"></div>-->
                <div id="divLogin" class="row">
                    <div class="col s12 m12 l4 center-align ">
                        <!--<img src="imagenes/ucsm_logo.jpg" alt="...">-->
                        <hgroup>
                            <h3><strong>JMP Inmobiliaria</strong> </h3>
                            <h5><em><small>Trabajando juntos</small></em></h5>
                        </hgroup>
                    </div>
                    <div class="col s12 m12 l4 ">
                        <hgroup>
                            <h4><strong> Autenticación Usuario</strong> </h4>
                            <h5><em><small>JMP Inmobiliaria</small></em></h5>
                        </hgroup>
                        <p style=" text-align: justify;">Ingrese usuario y contraseña para poder iniciar.</p>
                        <a href="#" class="link">Ayuda <i class="icon-chevron-sign-right"></i></a>

                        <!-- Icon Box / End -->
                    </div>
                    <div class="col s12 m12  l4">
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
                                <!-- <button type="submit" href="principal.jsp" class="btn btn-primary">
                                    Iniciar Sesión
                                 </button>-->
                                <a href="principal.jsp" class="btn btn-primary">Iniciar Sesión</a></p>

                            </div>

                        </form>

                    </div>
                </div>
            </div>
        </div>

        <%@include file="../WEB-INF/jspf/importJS.jspf" %>
    </body>
</html>