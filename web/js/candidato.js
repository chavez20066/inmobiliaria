$(document).on("ready", function () {
    listar();
    guardar();
    eliminar();
    agregar();
    $('.modal').modal();
});
$("#btn_listar").on("click", function () {
    listar();

});
var guardar = function () {
    $("form").on("submit", function (e) {

        e.preventDefault();
        var frm = $(this).serialize();
        console.log(frm);
        $.ajax({
            method: "POST",
            url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardar",
            data: frm
        }).done(function (info) {
            console.log(info);
            //alert(info);
            // var array_return =  $.parseJSON ( info );
            // console.log("valor: "+ array_return);
            var json_info = JSON.parse(info);
            mostrar_mensaje(json_info);
            limpiar_datos();
            listar();
        });
    });
}
var eliminar = function () {
    $("#eliminar-usuario").on("click", function () {
        var idusuario = $("#frmEliminarUsuario #idusuario").val(),
                opcion = $("#frmEliminarUsuario #opcion").val();
        //console.log(idusuario);
        //console.log("eNTRO A ELIMINAR");
        // console.log(opcion);
        $.ajax({
            method: "POST",
            url: "<%= request.getContextPath()%>/ControlServlet?parAccion=guardar",
            data: {"idusuario": idusuario, "opcion": opcion}
        }).done(function (info) {
            console.log(info);
            var json_info = JSON.parse(info);
            mostrar_mensaje(json_info);
            limpiar_datos();
            listar();
        });
    });
}

var mostrar_mensaje = function (informacion) {
    var texto = "", color = "";
    if (informacion.respuesta == "BIEN") {
        texto = "<strong>Bien!</strong> Se han guardado los cambios correctamente.";
        color = "#379911";
    } else if (informacion.respuesta == "ERROR") {
        texto = "<strong>Error</strong>, no se ejecutó la consulta.";
        color = "#C9302C";
    } else if (informacion.respuesta == "EXISTE") {
        texto = "<strong>Información!</strong> el usuario ya existe.";
        color = "#5b94c5";
    } else if (informacion.respuesta == "VACIO") {
        texto = "<strong>Advertencia!</strong> debe llenar todos los campos solicitados.";
        color = "#ddb11d";
    }
    // console.log(texto);
    $("#mensaje").html(texto).css({"color": color});
    $("#mensaje").fadeOut(5000, function () {
        $(this).html("");
        $(this).fadeIn(3000);
    });
}

var limpiar_datos = function () {
    $("#opcion").val("registrar");
    $("#idusuario").val("");
    $("#nombre").val("").focus();
    $("#apellidos").val("");
    $("#dni").val("");
}

var listar = function () {
    $("#cuadro2").slideUp("slow");
    $("#cuadro1").slideDown("slow");
    var table = $("#dt_cliente").DataTable({
        "destroy": true,
        "ajax": {
            "method": "POST",
            //"url":"http://localhost:8082/DataTableBootstrap/lista3.php"
            "url": "<%= request.getContextPath()%>/ControlServlet?parAccion=lista"
        },
        "columns": [
            {"data": "nombre"},
            {"data": "apellidos"},
            {"data": "dni"},
            {"defaultContent": "<button type='button' class='editar btn-floating btn-small waves-effect waves-light'><i class='material-icons'>edit</i></button>	<button type='button' class='eliminar btn-floating btn-small waves-effect waves-light red'  data-target='modalEliminar'><i class='material-icons'>delete</i></button>"}
        ],
        "language": idioma_espanol,
        "dom": "<'row'<'form-inline' <'col s5 s-offset-5'B>>>"
                + "<'row' <'form-inline' <'col s10 m8 l2 toolbar left-align'><'col s10 m8 l4 offset-l6'f>>>"
                + "<rt>"
                + "<'dataTable'<'row espacioFooter'"
                + "<'col s12 m2 l1'l>"
                + "<'col s12 m10 l11'p>>>",
    });
    $("div.toolbar").html('<a id="btnAdd" title="Agregar usuario" class="btn-floating btn-large waves-effect waves-light red"><i class="material-icons">add</i></a>');
    obtener_data_editar("#dt_cliente tbody", table);
    obtener_id_eliminar("#dt_cliente tbody", table);
    agregar();
}

var agregar = function () {
    $("#btnAdd").on("click", function () {
        limpiar_datos();
        $("#cuadro2").slideDown("slow");
        $("#cuadro1").slideUp("slow");
    });
}



var obtener_data_editar = function (tbody, table) {
    $(tbody).on("click", "button.editar", function () {
        var data = table.row($(this).parents("tr")).data();
        var idusuario = $("#idusuario").val(data.idusuario),
                nombre = $("#nombre").val(data.nombre),
                apellidos = $("#apellidos").val(data.apellidos),
                dni = $("#dni").val(data.dni),
                opcion = $("#opcion").val("modificar");
        $("#cuadro2").slideDown("slow");
        $("#cuadro1").slideUp("slow");
        Materialize.updateTextFields();
    });
}

var obtener_id_eliminar = function (tbody, table) {
    $(tbody).on("click", "button.eliminar", function () {
        console.log("entro eliminar");
        var data = table.row($(this).parents("tr")).data();
        // console.log($(this).parents("tr"));
        console.log(data);
        var idusuario = $("#frmEliminarUsuario #idusuario").val(data.idusuario);
        //console.log(idusuario);
    });
}

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
