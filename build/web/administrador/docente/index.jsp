<%--
    Document   : index
    Created on : 19-nov-2015, 17:16:33
    Author     : Toshiba
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

        <title>Docentes</title>
        <%@include file="../../WEB-INF/jspf/import.jspf" %>
        <script type="text/javascript">

            $(document).ready(function () {
                $('#EntidadesContainer').jtable({
                    // selecting: true,
                    //edit: true,
                    // selectingCheckboxes: true, //Show checkboxes on first column
                    paging: true, //Enable paging
                    pageSize: 10, //Set page size (default: 10)
                    sorting: true, //Enable sorting
                    defaultSorting: 'ApellidoPaterno ASC', //Set default sorting
                    toolbar: {
                        items: [{
                                icon: '<%= request.getContextPath()%>/imagenes/update.png',
                                text: 'Recargar',
                                click: function () {
                                    $('#EntidadesContainer').jtable('load');
                                }
                            }]
                    },
                    title: 'Docentes',
                    actions: {
                        listAction: '<%= request.getContextPath()%>/srvEntidades?parAccion=listDocente',
                        createAction: '<%= request.getContextPath()%>/srvEntidades?parAccion=createDocente',
                        updateAction: '<%= request.getContextPath()%>/srvEntidades?parAccion=updateDocente'
                                /* deleteAction: '<%= request.getContextPath()%>/srvEntidades?parAccion=delete'*/
                    },
                    fields: {
                        CodigoDocente: {
                            title: 'Codigo',
                            width: 'auto'

                        },
                        ApellidoPaterno: {
                            title: 'ApellidoPaterno',
                            width: 'auto'
                        },
                        ApellidoMaterno: {
                            title: 'ApellidoMaterno',
                            width: 'auto'
                        },
                        Nombres: {
                            title: 'Nombres',
                            width: 'auto'
                        },
                        CodigoDepartamento: {
                            title: 'Departamento',
                            width: 'auto',
                            options: {
                                '16': 'ARQUITECTURA INGENIERIA CIVIL Y DEL AMBIENTE',
                                '01': 'CIENCIAS DE LA COMUNICACION SOCIAL Y PSICOLOGIA',
                                '09': 'CIENCIAS E INGENIERIAS FISICAS Y FORMALES',
                                '04': 'CIENCIAS JURIDICAS',
                                '34': 'CONFUCIO',
                                '05': 'CONTABILIDAD',
                                '13': 'CS E INGENIERIAS BIOLOGICAS Y QUIMICAS',
                                '14': 'CS Y TECNOLOGIAS SOCIALES Y HUMANIDADES',
                                '06': 'ECONOMIA Y ADMINISTRACION',
                                '07': 'ENFERMERIA',
                                '30': 'ESCUELA DE POSTGRADO',
                                '17': 'FARMACIA BIOQUIMICA Y BIOTECNOLOGIA',
                                '08': 'FARMACIA Y BIOQUIMICA',
                                '11': 'HISTORIA Y ARQUEOLOGIA',
                                '03': 'HUMANIDADES Y EDUCACION',
                                '31': 'IDIOMAS',
                                '32': 'INFORMATICA',
                                '24': 'MEDICINA HUMANA',
                                '12': 'OBSTETRICIA Y PUERICULTURA',
                                '10': 'ODONTO-ESTOMATOLOGIA',
                                '33': 'PRECATOLICA',
                                '02': 'TRABAJO SOCIAL',
                                '15': 'UNIDAD ACADEMICA DE ARQUITECTURA',
                                '00': 'NO CORRESPONDE'
                            }
                        },
                        Categoria: {
                            title: 'Categoria',
                            width: 'auto'
                        },
                        Contrasenia: {
                            title: 'Contraseña',
                            width: 'auto'
                        },
                        TipoUsuario: {
                            title: 'TipoUsuario',
                            width: 'auto',
                            options: {
                                '1': 'ADMINISTRADOR',
                                '2': 'DOCENTE'
                            }
                        }
                    }

                });

                $('#EntidadesContainer').jtable('load');


            });
            function Buscar() {


                var BusquedaDocente = document.getElementById("txtbusquedaDocente").value;
                if (BusquedaDocente !== "") {
                    $.get('<%= request.getContextPath()%>/srvEntidades?parAccion=buscarDocente', {
                        txtbuscarDocente: BusquedaDocente
                    }, function (data) {
                        $('#EntidadesContainer').jtable('load');

                        // document.getElementById('divBusqueda').style.display ='inherit';
                    });

                } else {
                    swal({title: "Ingrese datos del Docente para poder buscar", text: "Sistema de Registro de Bibliografía", type: "error", confirmButtonText: "Aceptar"});

                    //alert("Ingrese datos para poder buscar");
                }
            }

        </script>
    </head>
    <body>
        <div id="idDivCabecera">
            <%@include file="../menu/index.jsp" %>

        </div>
        <div id="idDivContenido" class="container">

            <h2>Mostrando Docentes</h2>

            <br>
            <label for="usr">Buscar:</label>
            <div class="row">
                <div class="col-xs-12 col-md-6">
                    <input type="text" class="form-control" id="txtbusquedaDocente" placeholder="Codigo/Nombres/Apellidos">
                </div>
                <button id="btnbuscar" class="text-center btn btn-success" onclick="Buscar()" ><span class="glyphicon glyphicon-search" aria-hidden="true"></span> Buscar</button>
            </div>
            <br>
            <div id="EntidadesContainer" class="table-responsive"></div>

        </div>
    </body>
</html>