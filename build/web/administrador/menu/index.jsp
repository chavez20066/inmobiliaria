<%-- 
    Document   : menu
    Created on : 26-sep-2016, 8:50:28
    Author     : jbasurco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">       
       
       <%-- <%@include file="../../WEB-INF/jspf/import.jspf" %>  --%> 
        
        <title>JSP Page</title>     
        <script>
            function jsRemoveWindowLoad() {
                    // eliminamos el div que bloquea pantalla
                $("#WindowLoad").remove();
            }
            function jsShowWindowLoad(mensaje) {
                    //eliminamos si existe un div ya bloqueando
                jsRemoveWindowLoad();

                //si no enviamos mensaje se pondra este por defecto
                if (mensaje === undefined) mensaje = "Procesando la información<br>Espere por favor";

                //centrar imagen gif
                height = 20;//El div del titulo, para que se vea mas arriba (H)
                var ancho = 0;
                var alto = 0;

                    //obtenemos el ancho y alto de la ventana de nuestro navegador, compatible con todos los navegadores
                if (window.innerWidth == undefined) ancho = window.screen.width;
                else ancho = window.innerWidth;
                if (window.innerHeight == undefined) alto = window.screen.height;
                else alto = window.innerHeight;

                    //operación necesaria para centrar el div que muestra el mensaje
                var heightdivsito = alto/2 - parseInt(height)/2;//Se utiliza en el margen superior, para centrar

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
                function cuboNoBiblio(){
                    jsShowWindowLoad('Cargando Cubo');
                    
                    $.get('<%= request.getContextPath()%>/srvEntidades?parAccion=olapNoBiblio', {
                          //  txtbuscarDocente : BusquedaDocente                                                      
                    }, function(data) {    
                        window.location.href = '/bibliografia/administrador/olap/cubo.jsp';
                        //$('#EntidadesContainer').jtable('load'); 
                        // document.getElementById('divBusqueda').style.display ='inherit';
                    });
                }
                 function cuboBiblio(){
                    jsShowWindowLoad('Cargando Cubo');
                    
                    $.get('<%= request.getContextPath()%>/srvEntidades?parAccion=olap', {
                          //  txtbuscarDocente : BusquedaDocente                                                      
                    }, function(data) {    
                        window.location.href = '/bibliografia/administrador/olap/index.jsp';
                        //$('#EntidadesContainer').jtable('load');                         
                        
                        // document.getElementById('divBusqueda').style.display ='inherit';
                    });
                }
                
                
            </script>
    </head>
    <body>
         <%
             String NomDocente=null;
             String CodDocente=null;
             String Semestre=null;
            if (session != null) {
                if (session.getAttribute("user") != null && session.getAttribute("CodDocente")!=null && session.getAttribute("TipoSemestre")!=null ) {
                    NomDocente = (String) session.getAttribute("user");
                    CodDocente = (String) session.getAttribute("CodDocente");
                    Semestre= (String) session.getAttribute("TipoSemestre");
                //out.print("Bienvenido(a): " + name );
                }
                else
                {
                   // response.sendRedirect("login.html");
                    out.println("<script language=\"javascript\" type=\"text/javascript\">");
                    out.println("alert(\"Inicie Sessión ;)\");");
                    out.println("location=\"/bibliografia/\";");
                    out.println("</script>");
                }
             }
        %>
        <%@include file="../../WEB-INF/jspf/cabecera.jspf" %> 
                
        <nav class="navbar navbar-inverse">
            <div class="container">
              <!-- Brand and toggle get grouped for better mobile display -->
              <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                  <span class="sr-only">Toggle navigation</span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>
                <!-- <a class="navbar-brand" href="#">Brand</a>-->
              </div>

              <!-- Collect the nav links, forms, and other content for toggling -->
              <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="#">Administrador</a></li>
                    <li><a href="<%= request.getContextPath()%>/administrador/docente/"><span class="glyphicon glyphicon-edit"></span> Docentes</a></li>
                    <li><a href="#"><span class="glyphicon glyphicon-refresh"></span> Sincronizar Docentes</a></li>
                    <li><a href="<%= request.getContextPath()%>/administrador/reporte/"><span class="glyphicon glyphicon-list-alt"></span> Reportes</a></li>
                     <li><a href="<%= request.getContextPath()%>/administrador/charts/"><span class="glyphicon glyphicon-stats"></span> Graficos</a></li>
                    
                     <li class="dropdown"> 
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            <span class="glyphicon glyphicon-stats"></span> Olap <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:cuboBiblio()">Cubo Bibliografia</a></li>                            
                             <li><a href="javascript:cuboNoBiblio()">Cubo No Bibliografia</a></li> 
                        </ul>

                    </li>
                     
                   
                </ul>
                
                <ul class="nav navbar-nav  navbar-right">
                    <li class="dropdown"> 
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            <span class="glyphicon glyphicon-user"></span> <%=NomDocente %> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="<%= request.getContextPath()%>/mantenimientos/sesion"><span class="glyphicon glyphicon-cog"></span> Cambiar Contraseña</a></li>  
                            <li><a href="<%= request.getContextPath()%>/srvEntidades?parAccion=logout"><span class="glyphicon glyphicon-log-out"></span> Cerrar Sesión</a></li>                 
                        </ul>

                    </li>                    
                </ul>                    
              </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
          </nav>  
          <!--<div id="WindowLoad" style="width: 1920px; height: 950px;">
              <div style="text-align:center;height:950px;">
                  <div style="color:#000;margin-top:465px; font-size:20px;font-weight:bold">Generando Cubo</div>
                  <img src="img/load.gif">
              </div>
          </div>-->
    </body>
</html>
