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
       <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/modules/drilldown.js"></script>
        <script type="text/javascript">
           $(function(){
               $('#container').highcharts({
                   chart:{
                       type:'column',
                       events:{
                           drilldown:function(e){
                               if(!e.seriesOptions){
                                   var chart=this,
                                           drilldowns={
                                                'Animals':{
                                                    name:'Animals',
                                                    data:[
                                                        ['Cows',2],
                                                        ['Sheep',3]
                                                    ]
                                                },
                                                'Fruits':{
                                                   name:'Fruits',
                                                   data:[
                                                       ['Apples',5],
                                                       ['Oranges',7],
                                                       ['Bannas',2]
                                                   ]
                                                },
                                                'Cars':{
                                                    name:'Cars',
                                                    data:[
                                                        ['Toyota',1],
                                                        ['Volkswagen',2],
                                                        ['Opel',5]
                                                    ]
                                                }
                                           },
                                           series = drilldowns[e.point.name];
                                   //show the loading label
                                   chart.showLoading('Simnulating Ajax ...');
                                   setTimeout(function(){
                                       chart.hideLoading();
                                       chart.addSeriesAsDrilldown(e.point,series);
                                   },1000);
                               }
                           }
                       }
                   },
                   title:{
                       text:'Async drilldown'
                   },
                   xAxis:{
                       type:'category'
                   },
                   legend:{
                       enabled: false
                   },
                   plotOptions:{
                       series:{
                           borderWidth:0,
                           dataLabels:{
                               enabled:false
                           }
                       }
                   },
                   series: [{
                           name:'Things',
                           colorByPoint: true,
                           data:[{
                                name:'Animals',
                                y:5,
                                drilldown:true
                           },{
                               name:'Fruits',
                               y:2,
                               drilldown:true
                           },{
                               name:'Cars',
                               y:4,
                               drilldown:true
                           }]
                           
                   }],
                   drilldown:{
                       series:[]
                   }
                   
               });
               
               
           });           
            
        </script>
    </head>
    <body>
        <div id="idDivCabecera">
            <%@include file="../menu/index.jsp" %>         
                          
        </div>
        <div id="idDivContenido" class="container">            
               
            <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto;">
                
            </div>   
                
            
        </div>
    </body>
</html>