<%--<%@include file="../../WEB-INF/jspf/import.jspf" %>--%>

<!-- external libs from cdnjs -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>

<!-- PivotTable.js libs from ../dist -->

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/js/dist_olap/pivot.css">
<script type="text/javascript" src="<%= request.getContextPath()%>/js/dist_olap/pivot.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/dist_olap/export_renderers.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/dist_olap/d3_renderers.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/dist_olap/c3_renderers.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/dist_olap/jspdf.debug.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/dist_olap/jspdf.min.js"></script>

<style>
    body {font-family: Verdana;}
    .node {
        border: solid 1px white;
        font: 10px sans-serif;
        line-height: 12px;
        overflow: hidden;
        position: absolute;
        text-indent: 2px;
    }
    .c3-line, .c3-focused {stroke-width: 3px !important;}
    .c3-bar {stroke: white !important; stroke-width: 1;}
    .c3 text { font-size: 12px; color: grey;}
    .tick line {stroke: white;}
    .c3-axis path {stroke: grey;}
    .c3-circle { opacity: 1 !important; }
</style>



            <script type="text/javascript">
                    // This example has all the renderers loaded,
                    // and should workwith touch devices.
    $(function () {
                    var derivers = $.pivotUtilities.derivers;
                    var renderers = $.extend(
            $.pivotUtilities.renderers,
            $.pivotUtilities.c3_renderers,
            $.pivotUtilities.d3_renderers,
            $.pivotUtilities.export_renderers
            );
                     $.getJSON("<%= request.getContextPath()%>/administrador/data/data_json.json", function (mps) {
    $("#output").pivotUI(mps, {
                     renderers: renderers,
                     /* derivedAttributes: {
                     "Age Bin": derivers.bin("Age", 10),
                     "Gender Imbalance": function(mp) {
                    return mp["Gender"] == "Male" ? 1 : -1;
             }
             },*/
            /*cols: ["Provincia"], rows: ["Genero"],*/
            rendererName: "Table"
    });
            });
    });
    var tableToExcel = (function () {
    var uri = 'data:application/vnd.ms-excel;base64,'
            , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--><meta http-equiv="content-type" content="text/plain; charset=UTF-8"/></head><body><table>{table}</table></body></html>'
                , base64 = function (s) {
                    return window.btoa(unescape(encodeURIComponent(s)))
                }
        , format = function (s, c) {
            return s.replace(/{(\w+)}/g, function (m, p) {
                return c[p];
            })
        }
        return function (table, name) {
            if (!table.nodeType)
                table = document.getElementById(table)
            //if (!table.nodeType) table = document.getElementsByClassName(table)
            var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}
            window.location.href = uri + base64(format(template, ctx))
        }
    })();

    function exportPdf() {

        var pdf = new jsPDF('landscape');

        var specialElementHandlers = {
            '.pvtTable': function (element, renderer) {
                return true;
            }
        };

        var options = {
            pagesplit: true
        };

        pdf.addHTML($('.pvtTable')[0], 15, 30, {
            'elementHandlers': specialElementHandlers,
        }, function () {
            pdf.save('Test.pdf');
        });

    }

</script>
<div id="idDivContenido" class="container">
    <h2>Cubo Ventas</h2>
    <br>
    <input type="button" class="btn btn-success" onclick="tableToExcel('testTable', 'Export Table')" value="Exportar a Excel">
    <!--<input type="button" onclick="exportPdf();" value="Exportar a PDF">-->
    <div id="output" class="table-responsive" style="margin: 30px;"></div>
</div>
