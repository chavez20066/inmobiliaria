-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 23-08-2018 a las 21:32:02
-- Versión del servidor: 10.2.17-MariaDB
-- Versión de PHP: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `jmpinmob_bdinmobiliaria`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`jmpinmob`@`localhost` PROCEDURE `cursor_registrar_pago_parcial` (IN `p_cod_venta` INT, IN `p_cod_trans` INT, IN `p_monto` INT, IN `pp_monto` INT)  BEGIN
  DECLARE v_cuota_mensual int;
  DECLARE v_nro_cuota int;
  DECLARE v_saldo int;
  DECLARE v_estado char(1);
  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR 
    select cuota_mensual,nro_cuota,saldo,estado from calendario_pago where cod_venta=p_cod_venta and (estado='A' or estado='P') order by nro_cuota;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;
  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_cuota_mensual, v_nro_cuota, v_saldo, v_estado;    
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
  -- SELECT v_cuota_mensual, v_nro_cuota, v_saldo, v_estado;
	if p_monto > 0 then
		if v_estado='A' then -- saldo 0
			if p_monto > v_cuota_mensual then -- 1500  1250
				UPDATE calendario_pago SET estado='C', saldo=0 WHERE cod_venta=p_cod_venta AND nro_cuota=v_nro_cuota; 
                INSERT INTO pagos(NRO_TRANSACCION,MONTO_PAGO,INTERES,NRO_CUOTA,COD_TIPO_PAGO) values(p_cod_trans,v_saldo,0,v_nro_cuota,3);                   
				set p_monto=p_monto-v_cuota_mensual;   
			else
				if p_monto = v_cuota_mensual then -- 1500  1250
					UPDATE calendario_pago SET estado='C', saldo=0 WHERE cod_venta=p_cod_venta AND nro_cuota=v_nro_cuota;  
					INSERT INTO pagos(NRO_TRANSACCION,MONTO_PAGO,INTERES,NRO_CUOTA,COD_TIPO_PAGO) values(p_cod_trans,p_monto,0,v_nro_cuota,3);
					set p_monto=0;       
				else
					if p_monto < v_cuota_mensual then -- 1500  1250
						-- select 'entro '+ p_monto +' cuota '+ v_cuota_mensual; 
						UPDATE calendario_pago SET estado='P', saldo=v_saldo-p_monto WHERE cod_venta=p_cod_venta AND nro_cuota=v_nro_cuota; 
						INSERT INTO pagos(NRO_TRANSACCION,MONTO_PAGO,INTERES,NRO_CUOTA,COD_TIPO_PAGO) values(p_cod_trans,p_monto,0,v_nro_cuota,3);
						set p_monto=0;                      
					end if;	                    
				end if;			            
			end if;			
		else
			if v_estado='P' then -- saldo pendiente            
				if p_monto > v_saldo then -- 1500  1250
					UPDATE calendario_pago SET estado='C', saldo=0 WHERE cod_venta=p_cod_venta AND nro_cuota=v_nro_cuota; 
					INSERT INTO pagos(NRO_TRANSACCION,MONTO_PAGO,INTERES,NRO_CUOTA,COD_TIPO_PAGO) values(p_cod_trans,v_saldo,0,v_nro_cuota,3);
					set p_monto=p_monto-v_saldo; 
				else
					if p_monto = v_saldo then -- 1500  1250
						UPDATE calendario_pago SET estado='C', saldo=0 WHERE cod_venta=p_cod_venta AND nro_cuota=v_nro_cuota;  
						INSERT INTO pagos(NRO_TRANSACCION,MONTO_PAGO,INTERES,NRO_CUOTA,COD_TIPO_PAGO) values(p_cod_trans,p_monto,0,v_nro_cuota,3);
						set p_monto=0;  
					else
						if p_monto < v_saldo then -- 1500  1250
							UPDATE calendario_pago SET estado='P', saldo=saldo-p_monto WHERE cod_venta=p_cod_venta AND nro_cuota=v_nro_cuota;  
							INSERT INTO pagos(NRO_TRANSACCION,MONTO_PAGO,INTERES,NRO_CUOTA,COD_TIPO_PAGO) values(p_cod_trans,p_monto,0,v_nro_cuota,3);
							set p_monto=0;                      
						end if;		
					end if;					
				end if;			
			end if;	        
		end if;		
	end if;	
  END LOOP get_runners;  
  CLOSE runners_cursor;
  UPDATE venta SET MONTO_DEUDA=MONTO_DEUDA-pp_monto, MONTO_PAGADO=MONTO_PAGADO+pp_monto WHERE COD_VENTA=p_cod_venta;
END$$

CREATE DEFINER=`jmpinmob`@`localhost` PROCEDURE `cursor_registrar_pago_total` (IN `p_cod_venta` INT, IN `p_cod_trans` INT, IN `p_monto` INT)  BEGIN
  DECLARE v_cuota_mensual int;
  DECLARE v_nro_cuota int;
  DECLARE v_saldo int;
  DECLARE v_estado char(1);
  DECLARE fin INTEGER DEFAULT 0;
  DECLARE runners_cursor CURSOR FOR 
    select cuota_mensual,nro_cuota,saldo,estado from calendario_pago where cod_venta=p_cod_venta and (estado='A' or estado='P') order by nro_cuota;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;
  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO v_cuota_mensual, v_nro_cuota, v_saldo, v_estado;    
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
  -- SELECT v_cuota_mensual, v_nro_cuota, v_saldo, v_estado;
	if p_monto > 0 then    
		INSERT INTO pagos(NRO_TRANSACCION,MONTO_PAGO,INTERES,NRO_CUOTA,COD_TIPO_PAGO) values(p_cod_trans,v_saldo,0,v_nro_cuota,2);    
	end if;	
  END LOOP get_runners;  
  CLOSE runners_cursor;
  UPDATE calendario_pago SET estado='C', saldo=0 WHERE cod_venta=p_cod_venta;
  UPDATE venta SET MONTO_DEUDA=0, MONTO_PAGADO=MONTO_TOTAL WHERE COD_VENTA=p_cod_venta;
END$$

CREATE DEFINER=`jmpinmob`@`localhost` PROCEDURE `spregistrartransferencia` (IN `p_cod_venta` INT, IN `p_dni_vendedor` VARCHAR(8), IN `p_dni_comprador` VARCHAR(8), IN `p_comision` INT, OUT `p_cod_transac` INT)  begin
	/*declare fecha date;
	declare hora time;	*/
    /*declare cod_trans int;*/
	/*set fecha=curdate();
	set hora =curtime();*/
	insert into transaccion(cod_venta,fecha_transaccion,hora_transaccion,cod_tipo_operacion)
    values(p_cod_venta,curdate(),curtime(),'T04');
    set p_cod_transac=last_insert_id(); 
	insert into transferencia(nro_transaccion,cod_cliente_vendedor,cod_cliente_comprador,comision_trans)
	values(p_cod_transac,p_dni_vendedor,p_dni_comprador,p_comision);		
	update venta set estado='T', cod_cliente=p_dni_comprador where cod_venta=p_cod_venta;
    select p_cod_transac;
end$$

CREATE DEFINER=`jmpinmob`@`localhost` PROCEDURE `spregistrarventa` (IN `cod_cliente` CHAR(8), IN `p_cod_terreno` INT, IN `p_inscripcion` INT, IN `p_inicial` INT, IN `nro_cuotas` INT, IN `monto_mensual` INT, IN `cod_asesor` INT, IN `monto_total` INT, IN `nota` VARCHAR(50), OUT `cod_venta` INT)  begin
	declare fecha date;
	declare hora time;
	declare monto_deuda int default 0;
	/*declare cod_venta int;*/
    declare mydate datetime;
	declare fecha_pago date;
	declare cuota_mensual int default 0;
	declare nro_cuota int default 0;
	declare i int default 0;   
    declare cuota_redondeada int default 0;
    declare total_cuotas_acumulas int default 0;
	set fecha=curdate();
	set hora =curtime();
	set monto_deuda=monto_total-p_inicial;	
    if  nro_cuotas <> 0 then 	
		set cuota_mensual=monto_deuda/nro_cuotas; 
        set monto_mensual=cuota_mensual;
	end if;
	insert into venta(cod_cliente,cod_terreno,p_inscripcion,p_inicial,nro_cuotas,monto_mensual,cod_asesor,fecha_venta,hora_venta,monto_total,estado,nota,monto_deuda,monto_pagado) 
		values(cod_cliente,p_cod_terreno,p_inscripcion,p_inicial,nro_cuotas,monto_mensual,cod_asesor,fecha,hora,monto_total,'V',nota,monto_deuda,p_inicial);
	set cod_venta=last_insert_id();   
	if p_inicial <> 0 then
		update terreno set estado='VENDIDO' where cod_terreno=p_cod_terreno;        
	end if;
    if p_inicial = 0 then
		update terreno set estado='RESERVADO' where cod_terreno=p_cod_terreno;        
	end if;
	if  nro_cuotas <> 0 then 	
		-- 23000/12  
		set cuota_mensual=monto_deuda/nro_cuotas;    
        set cuota_redondeada=ceiling(ceiling(monto_deuda/nro_cuotas)/5)*5;
		if dayofmonth(now()) <= 15 then	
		   set mydate = concat(year(now()),'-',month(now()),'-',15);
		else
		   set mydate = last_day(now()); -- ultimo dia del mes			
		end if;   
		while i < nro_cuotas do -- i va dar vuelta el nro de cuotas seleccionadas
			set nro_cuota=i+1;	-- 1
				set fecha_pago=date(date_add(mydate, interval nro_cuota month)); -- le suma 1 2 3 meses a la fecha
                if (total_cuotas_acumulas+cuota_redondeada)<=monto_deuda then
					insert into calendario_pago(cod_venta,fecha_pago,cuota_mensual,interes,nro_cuota,saldo,estado)
					values(cod_venta,fecha_pago,cuota_redondeada,0,nro_cuota,cuota_redondeada,'A');	
					set total_cuotas_acumulas=total_cuotas_acumulas+cuota_redondeada;
				else
					insert into calendario_pago(cod_venta,fecha_pago,cuota_mensual,interes,nro_cuota,saldo,estado)
					values(cod_venta,fecha_pago,((total_cuotas_acumulas+cuota_redondeada)-monto_deuda),0,nro_cuota,((total_cuotas_acumulas+cuota_redondeada)-monto_deuda),'A');	
					set total_cuotas_acumulas=total_cuotas_acumulas+cuota_redondeada;
				end if;                
			set i = i + 1;
		end while;
	end if;    
    select cod_venta;    
end$$

CREATE DEFINER=`jmpinmob`@`localhost` PROCEDURE `spregistrar_egresos_devo` (IN `p_cod_venta` INT, IN `p_monto` INT, OUT `p_cod_egreso` INT)  begin	
	declare p_localidad varchar(50);
    declare p_etapa varchar(50);
	declare p_cod_terreno int;
    set p_localidad=(select t.localidad from venta v inner join terreno t on v.cod_terreno=t.cod_terreno where v.cod_venta=p_cod_venta);
    set p_etapa=(select t.etapa from venta v inner join terreno t on v.cod_terreno=t.cod_terreno where v.cod_venta=p_cod_venta);
    set p_cod_terreno=(select t.cod_terreno from venta v inner join terreno t on v.cod_terreno=t.cod_terreno where v.cod_venta=p_cod_venta);    
	insert into egresos(cod_tipo_egreso,cod_sub_tipo_egreso,localidad,etapa,monto_egreso,tipo_comprobante,nota_egreso,fecha_egreso)
    values(4,6,p_localidad,p_etapa,p_monto,'RECIBO','DEVOLUCION',curdate());      
    set p_cod_egreso=last_insert_id();     
    update terreno set estado='DISPONIBLE' where cod_terreno=p_cod_terreno;   
    update transaccion set estado_transaccion='C' where cod_venta=p_cod_venta;
	update venta set estado='D' where cod_venta=p_cod_venta;
   	select p_cod_egreso;    
end$$

CREATE DEFINER=`jmpinmob`@`localhost` PROCEDURE `spregistrar_pago_parcial` (IN `p_cod_venta` INT, IN `p_cod_trans` INT, IN `p_monto` INT)  BEGIN
	declare p_monto_mensual int default 0;
    declare nro_cuota_actual int default 0;
    declare p_saldo int default 0;
    set p_monto_mensual= (select monto_mensual from venta where cod_venta=p_cod_venta);
    set nro_cuota_actual=(select MAX(nro_cuota) from calendario_pago where cod_venta=p_cod_venta and estado='P');
    IF nro_cuota_actual IS NULL THEN
		SET nro_cuota_actual=0;
    END IF;
	set nro_cuota_actual=nro_cuota_actual+1;
    if p_monto = p_monto_mensual then
        UPDATE calendario_pago SET estado='P', saldo=0 WHERE cod_venta=p_cod_venta AND nro_cuota=nro_cuota_actual;
        set p_monto=0;
	end if;
    /*AMORTIZACION*/
    SELECT 'nro_cuota_actual' + nro_cuota_actual ;
    while p_monto > 0 do		
		   set p_saldo=(select saldo from calendario_pago WHERE cod_venta=p_cod_venta AND nro_cuota=nro_cuota_actual);
             SELECT 'saldo' + p_saldo ;
            if p_monto > p_monto_mensual then
                if p_saldo <> p_monto_mensual  then
					UPDATE calendario_pago SET estado='P', saldo=0 WHERE cod_venta=p_cod_venta AND nro_cuota=nro_cuota_actual;    
					set nro_cuota_actual=nro_cuota_actual+1;
					set p_monto=p_monto-p_saldo;                
				end if;
                if p_saldo =p_monto_mensual then
					UPDATE calendario_pago SET estado='P', saldo=0 WHERE cod_venta=p_cod_venta AND nro_cuota=nro_cuota_actual;    
					set nro_cuota_actual=nro_cuota_actual+1;
					set p_monto=p_monto-p_monto_mensual;
                end if;	
			end if;
			if p_monto < p_monto_mensual then
				if p_saldo <> p_monto_mensual then					
                    if p_saldo > p_monto then
						UPDATE calendario_pago SET estado='P', saldo=saldo-p_monto WHERE cod_venta=p_cod_venta AND nro_cuota=nro_cuota_actual;    
						set nro_cuota_actual=nro_cuota_actual+1;
						set p_monto=0;  
                    end if;
                    if p_saldo < p_monto then
						UPDATE calendario_pago SET estado='P', saldo=0 WHERE cod_venta=p_cod_venta AND nro_cuota=nro_cuota_actual;    
						set nro_cuota_actual=nro_cuota_actual+1;
						set p_monto=p_monto-p_saldo;  
                    end if;                    
                end if;
                if p_saldo=p_monto_mensual then                 
					UPDATE calendario_pago SET estado='A', saldo=p_monto_mensual-p_monto WHERE cod_venta=p_cod_venta AND nro_cuota=nro_cuota_actual;      
					set p_monto=0;
				end if;
			end if;            
	end while;      
END$$

CREATE DEFINER=`jmpinmob`@`localhost` PROCEDURE `spregistrar_transac_pagos` (IN `p_cod_venta` INT, IN `p_tipo_operacion` CHAR(3), OUT `p_cod_transac` INT)  begin	
	insert into transaccion(cod_venta,fecha_transaccion,hora_transaccion,cod_tipo_operacion)
    values(p_cod_venta,curdate(),curtime(),p_tipo_operacion);
    set p_cod_transac=last_insert_id();      
   	select p_cod_transac;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `anio`
--

CREATE TABLE `anio` (
  `ANIO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `anio`
--

INSERT INTO `anio` (`ANIO`) VALUES
(2000),
(2001),
(2002),
(2003),
(2004),
(2005),
(2006),
(2007),
(2008),
(2009),
(2010),
(2011),
(2012),
(2013),
(2014),
(2015),
(2016),
(2017),
(2018),
(2019),
(2020),
(2021),
(2022),
(2024),
(2025),
(2026),
(2027),
(2028),
(2029),
(2030);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calendario_pago`
--

CREATE TABLE `calendario_pago` (
  `COD_VENTA` int(11) NOT NULL,
  `FECHA_PAGO` date NOT NULL,
  `CUOTA_MENSUAL` decimal(18,2) NOT NULL,
  `INTERES` int(11) NOT NULL,
  `NRO_CUOTA` int(11) NOT NULL,
  `SALDO` int(11) DEFAULT NULL,
  `ESTADO` char(1) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `calendario_pago`
--

INSERT INTO `calendario_pago` (`COD_VENTA`, `FECHA_PAGO`, `CUOTA_MENSUAL`, `INTERES`, `NRO_CUOTA`, `SALDO`, `ESTADO`) VALUES
(1, '2017-11-15', '19000.00', 0, 1, 0, 'C'),
(2, '2017-11-30', '650.00', 0, 1, 0, 'C'),
(2, '2017-12-31', '650.00', 0, 2, 0, 'C'),
(2, '2018-01-31', '650.00', 0, 3, 250, 'P'),
(2, '2018-02-28', '650.00', 0, 4, 650, 'A'),
(2, '2018-03-31', '650.00', 0, 5, 650, 'A'),
(2, '2018-04-30', '650.00', 0, 6, 650, 'A'),
(2, '2018-05-31', '650.00', 0, 7, 650, 'A'),
(2, '2018-06-30', '650.00', 0, 8, 650, 'A'),
(2, '2018-07-31', '650.00', 0, 9, 650, 'A'),
(2, '2018-08-31', '650.00', 0, 10, 650, 'A'),
(2, '2018-09-30', '650.00', 0, 11, 650, 'A'),
(2, '2018-10-31', '650.00', 0, 12, 650, 'A'),
(2, '2018-11-30', '650.00', 0, 13, 650, 'A'),
(2, '2018-12-31', '650.00', 0, 14, 650, 'A'),
(2, '2019-01-31', '650.00', 0, 15, 650, 'A'),
(2, '2019-02-28', '650.00', 0, 16, 650, 'A'),
(2, '2019-03-31', '650.00', 0, 17, 650, 'A'),
(2, '2019-04-30', '650.00', 0, 18, 650, 'A'),
(2, '2019-05-31', '650.00', 0, 19, 650, 'A'),
(2, '2019-06-30', '650.00', 0, 20, 650, 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `candidato`
--

CREATE TABLE `candidato` (
  `COD_CANDIDATO` int(11) NOT NULL,
  `APELLIDOS` varchar(100) NOT NULL DEFAULT '',
  `NOMBRES` varchar(100) NOT NULL DEFAULT '',
  `DIRECCION` varchar(120) DEFAULT NULL,
  `DNI` char(8) NOT NULL DEFAULT '',
  `TELEFONO` varchar(50) DEFAULT NULL,
  `CELULAR` varchar(50) DEFAULT NULL,
  `ESTADO` tinyint(3) UNSIGNED NOT NULL,
  `COD_ASESOR` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `COD_CLIENTE` int(11) NOT NULL,
  `DNI` char(8) NOT NULL DEFAULT '',
  `APELLIDOS` varchar(150) DEFAULT NULL,
  `NOMBRES` varchar(150) DEFAULT NULL,
  `DIRECCION` varchar(250) DEFAULT NULL,
  `TELEFONO` varchar(50) DEFAULT NULL,
  `CELULAR` varchar(50) DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `ESTADO` tinyint(3) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`COD_CLIENTE`, `DNI`, `APELLIDOS`, `NOMBRES`, `DIRECCION`, `TELEFONO`, `CELULAR`, `EMAIL`, `ESTADO`) VALUES
(1, '47323896', 'RODRIGUEZ GOMEZ', 'JAVIER', 'URB PRIVADA VIRGEN DEL CARMEN', '', '958729828', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_egreso`
--

CREATE TABLE `detalle_egreso` (
  `COD_EGRESO` int(11) NOT NULL,
  `COD_VENTA` int(11) DEFAULT NULL,
  `NRO_TRANSACION` int(11) DEFAULT NULL,
  `MONTO` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `detalle_egreso`
--

INSERT INTO `detalle_egreso` (`COD_EGRESO`, `COD_VENTA`, `NRO_TRANSACION`, `MONTO`) VALUES
(3, 1, 0, 1000),
(3, 1, 2, 19000),
(4, 2, 0, 2000),
(4, 2, 4, 650),
(4, 2, 5, 650),
(4, 2, 7, 400);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `egresos`
--

CREATE TABLE `egresos` (
  `COD_EGRESO` int(11) NOT NULL,
  `COD_TIPO_EGRESO` int(11) DEFAULT NULL,
  `COD_SUB_TIPO_EGRESO` int(11) DEFAULT NULL,
  `LOCALIDAD` varchar(50) DEFAULT NULL,
  `ETAPA` varchar(50) DEFAULT NULL,
  `MONTO_EGRESO` int(11) DEFAULT NULL,
  `TIPO_COMPROBANTE` varchar(50) DEFAULT NULL,
  `nro_comprobante` varchar(50) DEFAULT 'NO DEFINIDO',
  `NOTA_EGRESO` varchar(100) DEFAULT NULL,
  `FECHA_EGRESO` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `egresos`
--

INSERT INTO `egresos` (`COD_EGRESO`, `COD_TIPO_EGRESO`, `COD_SUB_TIPO_EGRESO`, `LOCALIDAD`, `ETAPA`, `MONTO_EGRESO`, `TIPO_COMPROBANTE`, `nro_comprobante`, `NOTA_EGRESO`, `FECHA_EGRESO`) VALUES
(1, 2, 4, 'CHIGUATA', '1', 1000, 'OTRO', 'RECIBO INTERNO NRO 1625', 'ALEX JAVER QUISPE CARI', '2017-10-06'),
(2, 1, 3, 'CHIGUATA', '1', 12000, 'RECIBO', 'NO DEFINIDO', 'RECIBOS DE COMPRA', '2017-10-06'),
(3, 4, 6, 'CHIGUATA', '1', 20000, 'RECIBO', 'NO DEFINIDO', 'DEVOLUCION', '2017-10-06'),
(4, 4, 6, 'CHIGUATA', '1', 3700, 'RECIBO', 'NO DEFINIDO', 'DEVOLUCION', '2017-11-28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etapa`
--

CREATE TABLE `etapa` (
  `COD_ETAPA` int(11) NOT NULL,
  `ETAPA` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `etapa`
--

INSERT INTO `etapa` (`COD_ETAPA`, `ETAPA`) VALUES
(1, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidad`
--

CREATE TABLE `localidad` (
  `COD_LOCALIDAD` int(11) NOT NULL,
  `LOCALIDAD` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `localidad`
--

INSERT INTO `localidad` (`COD_LOCALIDAD`, `LOCALIDAD`) VALUES
(1, 'CHIGUATA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lote`
--

CREATE TABLE `lote` (
  `LOTE` varchar(10) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `lote`
--

INSERT INTO `lote` (`LOTE`) VALUES
('1'),
('10'),
('11'),
('12'),
('13'),
('14'),
('15'),
('16'),
('17'),
('18'),
('19'),
('2'),
('20'),
('21'),
('22'),
('23'),
('24'),
('25'),
('3'),
('4'),
('5'),
('6'),
('7'),
('8'),
('9');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maestro_pagos`
--

CREATE TABLE `maestro_pagos` (
  `pre_mpago` char(2) DEFAULT 'MP',
  `cod_mpago` int(11) NOT NULL,
  `mpago_descripcion` varchar(80) DEFAULT NULL,
  `tipo_mpago` char(2) DEFAULT NULL,
  `cod_tipo_egreso` int(11) DEFAULT NULL,
  `cod_sub_tipo_egreso` int(11) DEFAULT NULL,
  `mpmonto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `maestro_pagos`
--

INSERT INTO `maestro_pagos` (`pre_mpago`, `cod_mpago`, `mpago_descripcion`, `tipo_mpago`, `cod_tipo_egreso`, `cod_sub_tipo_egreso`, `mpmonto`) VALUES
('MP', 1, 'LUZ', 'PU', 1, 3, 350),
('MP', 6, 'AGUA', 'PU', 1, 5, 100),
('MP', 8, 'LUZ', 'PM', 1, 3, 30),
('MP', 9, 'INTERNET', 'PM', 2, 4, 180),
('MP', 10, 'CABLE', 'PM', 2, 4, 150);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `manzana`
--

CREATE TABLE `manzana` (
  `COD_MANZANA` int(11) NOT NULL,
  `manzana` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `manzana`
--

INSERT INTO `manzana` (`COD_MANZANA`, `manzana`) VALUES
(1, 'A'),
(2, 'B');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `meses`
--

CREATE TABLE `meses` (
  `cod_mes` int(11) NOT NULL,
  `mes` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `meses`
--

INSERT INTO `meses` (`cod_mes`, `mes`) VALUES
(1, 'ENERO'),
(2, 'FEBRERO'),
(3, 'MARZO'),
(4, 'ABRIL'),
(5, 'MAYO'),
(6, 'JUNIO'),
(7, 'JULIO'),
(8, 'AGOSTO'),
(9, 'SEPTIEMBRE'),
(10, 'OCTUBRE'),
(11, 'NOVIEMBRE'),
(12, 'DICIEMBRE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `COD_PAGO` int(11) NOT NULL,
  `NRO_TRANSACCION` int(11) DEFAULT NULL,
  `MONTO_PAGO` int(11) NOT NULL,
  `INTERES` int(11) NOT NULL,
  `NRO_CUOTA` int(11) NOT NULL,
  `COD_TIPO_PAGO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`COD_PAGO`, `NRO_TRANSACCION`, `MONTO_PAGO`, `INTERES`, `NRO_CUOTA`, `COD_TIPO_PAGO`) VALUES
(1, 2, 19000, 0, 1, 2),
(2, 4, 650, 0, 1, 1),
(3, 5, 650, 0, 2, 1),
(4, 7, 400, 0, 3, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_mensuales`
--

CREATE TABLE `pagos_mensuales` (
  `COD_PAGO_MENSUAL` int(11) NOT NULL,
  `NRO_TRANSACCION` int(11) DEFAULT NULL,
  `COD_TIPO_SERV_MENSUAL` int(11) DEFAULT NULL,
  `MES` varchar(50) DEFAULT NULL,
  `ANIO` varchar(50) DEFAULT NULL,
  `MONTO_PAGO` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_servicios`
--

CREATE TABLE `pagos_servicios` (
  `pre_pagos_servicios` char(2) DEFAULT 'PS',
  `cod_pagos_servicios` int(11) NOT NULL,
  `nro_transaccion` int(11) DEFAULT NULL,
  `cod_mpago` int(11) DEFAULT NULL,
  `monto_pago` int(11) DEFAULT NULL,
  `descripcion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pagos_servicios`
--

INSERT INTO `pagos_servicios` (`pre_pagos_servicios`, `cod_pagos_servicios`, `nro_transaccion`, `cod_mpago`, `monto_pago`, `descripcion`) VALUES
('PS', 1, 1, 1, 0, 'PAGO UNICO LUZ'),
('PS', 2, 1, 6, 0, 'PAGO UNICO AGUA'),
('PS', 3, 3, 8, 30, '2017-10'),
('PS', 4, 3, 9, 180, '2017-10'),
('PS', 5, 6, 8, 30, '2017-10'),
('PS', 6, 6, 9, 180, '2017-10'),
('PS', 7, 6, 10, 150, '2017-10'),
('PS', 8, 8, 8, 30, '2017-11'),
('PS', 9, 8, 9, 180, '2017-11'),
('PS', 10, 8, 10, 150, '2017-11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_unicos`
--

CREATE TABLE `pagos_unicos` (
  `COD_PAGO_UNICO` int(11) NOT NULL,
  `NRO_TRANSACCION` int(11) DEFAULT NULL,
  `COD_TIPO_SERVICIO` int(11) NOT NULL,
  `MONTO_PAGO` int(11) NOT NULL,
  `NOTA` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sub_tipo_egreso`
--

CREATE TABLE `sub_tipo_egreso` (
  `COD_SUB_TIPO_EGRESO` int(11) NOT NULL,
  `SUB_TIPO_EGRESO` varchar(50) DEFAULT NULL,
  `COD_TIPO_EGRESO` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `sub_tipo_egreso`
--

INSERT INTO `sub_tipo_egreso` (`COD_SUB_TIPO_EGRESO`, `SUB_TIPO_EGRESO`, `COD_TIPO_EGRESO`) VALUES
(1, 'PAGO MAQUINARIA', 3),
(3, 'PROYECTO DE LUZ', 1),
(4, 'ADELANTOS DE SUELDO', 2),
(5, 'PRESTAMOS ESPECIALES', 1),
(6, 'TERRENO', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `terreno`
--

CREATE TABLE `terreno` (
  `COD_TERRENO` int(11) NOT NULL,
  `LOCALIDAD` varchar(50) DEFAULT NULL,
  `ETAPA` varchar(50) DEFAULT NULL,
  `manzana` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `LOTE` varchar(10) DEFAULT '',
  `ESTADO` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `terreno`
--

INSERT INTO `terreno` (`COD_TERRENO`, `LOCALIDAD`, `ETAPA`, `manzana`, `LOTE`, `ESTADO`) VALUES
(1, 'CHIGUATA', '1', 'A', '1', 'DISPONIBLE'),
(6, 'CHIGUATA', '1', 'B', '2', 'DISPONIBLE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_egreso`
--

CREATE TABLE `tipo_egreso` (
  `COD_TIPO_EGRESO` int(11) NOT NULL,
  `TIPO_EGRESO` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_egreso`
--

INSERT INTO `tipo_egreso` (`COD_TIPO_EGRESO`, `TIPO_EGRESO`) VALUES
(1, 'TERRENO'),
(2, 'ADMINISTRATIVO'),
(3, 'GENERALES'),
(4, 'DEVOLUCION');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_operacion`
--

CREATE TABLE `tipo_operacion` (
  `COD_TIPO_OPERACION` char(3) NOT NULL DEFAULT '',
  `TIPO_OPERACION` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_operacion`
--

INSERT INTO `tipo_operacion` (`COD_TIPO_OPERACION`, `TIPO_OPERACION`) VALUES
('T01', 'PAGO CUOTA'),
('T02', 'PAGO SERVICIO MENSUAL'),
('T03', 'PAGO UNICO SERVICIO'),
('T04', 'PAGO TRANSFERENCIA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_pago`
--

CREATE TABLE `tipo_pago` (
  `COD_TIPO_PAGO` int(11) NOT NULL,
  `TIPO_PAGO` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_pago`
--

INSERT INTO `tipo_pago` (`COD_TIPO_PAGO`, `TIPO_PAGO`) VALUES
(1, 'CANCELACION DE CUOTA'),
(2, 'CANCELACION TOTAL'),
(3, 'CANCELACION PARCIAL');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_servicio`
--

CREATE TABLE `tipo_servicio` (
  `COD_TIPO_SERVICIO` int(11) NOT NULL,
  `DESCRIPCION` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_servicio`
--

INSERT INTO `tipo_servicio` (`COD_TIPO_SERVICIO`, `DESCRIPCION`) VALUES
(1, 'PAGO UNICO LUZ'),
(2, 'PAGO AGUA'),
(3, 'PAGO OTROS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_servicio_mensual`
--

CREATE TABLE `tipo_servicio_mensual` (
  `COD_TIPO_SERV_MENSUAL` int(11) NOT NULL,
  `DESCRIPCION` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_servicio_mensual`
--

INSERT INTO `tipo_servicio_mensual` (`COD_TIPO_SERV_MENSUAL`, `DESCRIPCION`) VALUES
(1, 'PAGO MENSUAL LUZ'),
(2, 'PAGO MENSUAL AGUA'),
(3, 'PAGO MENSUAL SEGURIDAD');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transaccion`
--

CREATE TABLE `transaccion` (
  `NRO_TRANSACCION` int(11) NOT NULL,
  `COD_VENTA` int(11) DEFAULT NULL,
  `FECHA_TRANSACCION` date DEFAULT NULL,
  `HORA_TRANSACCION` time DEFAULT NULL,
  `COD_TIPO_OPERACION` char(3) DEFAULT NULL,
  `ESTADO_TRANSACCION` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `transaccion`
--

INSERT INTO `transaccion` (`NRO_TRANSACCION`, `COD_VENTA`, `FECHA_TRANSACCION`, `HORA_TRANSACCION`, `COD_TIPO_OPERACION`, `ESTADO_TRANSACCION`) VALUES
(1, 1, '2017-10-06', '09:01:18', 'T03', 'C'),
(2, 1, '2017-10-06', '09:01:19', 'T01', 'C'),
(3, 1, '2017-10-06', '09:01:19', 'T02', 'C'),
(4, 2, '2017-10-21', '15:49:28', 'T01', 'C'),
(5, 2, '2017-10-21', '15:50:49', 'T01', 'C'),
(6, 2, '2017-10-21', '15:50:50', 'T02', 'C'),
(7, 2, '2017-10-21', '15:52:23', 'T01', 'C'),
(8, 2, '2017-10-21', '15:52:24', 'T02', 'C');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transferencia`
--

CREATE TABLE `transferencia` (
  `COD_TRANS` int(11) NOT NULL,
  `NRO_TRANSACCION` int(11) DEFAULT NULL,
  `COD_CLIENTE_VENDEDOR` char(8) NOT NULL DEFAULT '',
  `COD_CLIENTE_COMPRADOR` char(8) DEFAULT NULL,
  `COMISION_TRANS` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `dni` char(8) NOT NULL DEFAULT '',
  `apellidos` varchar(150) DEFAULT NULL,
  `nombres` varchar(50) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `celular` varchar(45) DEFAULT NULL,
  `contrasenia` varchar(50) DEFAULT NULL,
  `tipo_usuario` varchar(50) DEFAULT NULL,
  `fecha_usuario` date DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`dni`, `apellidos`, `nombres`, `direccion`, `telefono`, `celular`, `contrasenia`, `tipo_usuario`, `fecha_usuario`, `estado`) VALUES
('47323895', 'QUISPE CARI', 'ALEX JAVIER', 'URB', '45785', '798789', 'Clave$17', 'ADMINISTRADOR', '2017-08-18', 'ACTIVO'),
('71216509', 'CHAVEZ ZUÑIGA', 'DIEGO ISMAEL', 'URB', '45124556', '9878546756', 'Clave$19', 'ASESOR', '2017-08-19', 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `COD_VENTA` int(11) NOT NULL,
  `COD_CLIENTE` char(8) DEFAULT NULL,
  `COD_ASESOR` int(11) DEFAULT NULL,
  `COD_TERRENO` int(11) DEFAULT NULL,
  `P_INSCRIPCION` int(11) DEFAULT NULL,
  `P_INICIAL` int(11) DEFAULT NULL,
  `NRO_CUOTAS` int(11) DEFAULT NULL,
  `FECHA_VENTA` date DEFAULT NULL,
  `HORA_VENTA` time DEFAULT NULL,
  `MONTO_MENSUAL` int(11) DEFAULT NULL,
  `MONTO_TOTAL` int(11) DEFAULT NULL,
  `MONTO_DEUDA` int(11) DEFAULT NULL,
  `MONTO_PAGADO` int(11) DEFAULT NULL,
  `ESTADO` char(1) DEFAULT NULL,
  `NOTA` varchar(2500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`COD_VENTA`, `COD_CLIENTE`, `COD_ASESOR`, `COD_TERRENO`, `P_INSCRIPCION`, `P_INICIAL`, `NRO_CUOTAS`, `FECHA_VENTA`, `HORA_VENTA`, `MONTO_MENSUAL`, `MONTO_TOTAL`, `MONTO_DEUDA`, `MONTO_PAGADO`, `ESTADO`, `NOTA`) VALUES
(1, '47323896', 71216509, 1, 100, 1000, 1, '2017-10-06', '08:52:49', 19000, 20000, 0, 20000, 'D', 'CLIENTE TIENE PLAZO HASTA 10 DE OCTUBRE '),
(2, '47323896', 71216509, 6, 100, 2000, 20, '2017-10-21', '15:48:05', 650, 15000, 11300, 3700, 'D', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `visita`
--

CREATE TABLE `visita` (
  `cod_visita` int(11) NOT NULL,
  `localidad` varchar(50) DEFAULT NULL,
  `etapa` varchar(50) DEFAULT NULL,
  `cod_candidato` int(11) DEFAULT NULL,
  `cod_usuario` char(8) DEFAULT NULL,
  `fecha_tentativa` date DEFAULT NULL,
  `nota` varchar(150) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `estado_visita` tinyint(3) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='	';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `calendario_pago`
--
ALTER TABLE `calendario_pago`
  ADD KEY `FK_CALENDARIO_PAGO_VENTA` (`COD_VENTA`);

--
-- Indices de la tabla `candidato`
--
ALTER TABLE `candidato`
  ADD PRIMARY KEY (`COD_CANDIDATO`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`DNI`),
  ADD KEY `ix_CLIENTE_autoinc` (`COD_CLIENTE`);

--
-- Indices de la tabla `detalle_egreso`
--
ALTER TABLE `detalle_egreso`
  ADD KEY `FK_detalle_egreso_egresos` (`COD_EGRESO`);

--
-- Indices de la tabla `egresos`
--
ALTER TABLE `egresos`
  ADD PRIMARY KEY (`COD_EGRESO`),
  ADD KEY `ix_EGRESOS_autoinc` (`COD_EGRESO`),
  ADD KEY `FK_EGRESOS_ETAPA` (`ETAPA`),
  ADD KEY `FK_EGRESOS_LOCALIDAD` (`LOCALIDAD`),
  ADD KEY `FK_EGRESOS_SUB_TIPO_EGRESO` (`COD_SUB_TIPO_EGRESO`),
  ADD KEY `FK_EGRESOS_TIPO_EGRESO` (`COD_TIPO_EGRESO`);

--
-- Indices de la tabla `etapa`
--
ALTER TABLE `etapa`
  ADD PRIMARY KEY (`ETAPA`),
  ADD KEY `ix_ETAPA_autoinc` (`COD_ETAPA`);

--
-- Indices de la tabla `localidad`
--
ALTER TABLE `localidad`
  ADD PRIMARY KEY (`LOCALIDAD`),
  ADD KEY `ix_LOCALIDAD_autoinc` (`COD_LOCALIDAD`);

--
-- Indices de la tabla `lote`
--
ALTER TABLE `lote`
  ADD PRIMARY KEY (`LOTE`);

--
-- Indices de la tabla `maestro_pagos`
--
ALTER TABLE `maestro_pagos`
  ADD PRIMARY KEY (`cod_mpago`);

--
-- Indices de la tabla `manzana`
--
ALTER TABLE `manzana`
  ADD PRIMARY KEY (`manzana`),
  ADD KEY `ix_MANZANA_autoinc` (`COD_MANZANA`);

--
-- Indices de la tabla `meses`
--
ALTER TABLE `meses`
  ADD PRIMARY KEY (`cod_mes`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`COD_PAGO`),
  ADD KEY `FK_PAGOS_TIPO_PAGO` (`COD_TIPO_PAGO`),
  ADD KEY `FK_pagos_transaccion` (`NRO_TRANSACCION`);

--
-- Indices de la tabla `pagos_mensuales`
--
ALTER TABLE `pagos_mensuales`
  ADD PRIMARY KEY (`COD_PAGO_MENSUAL`),
  ADD KEY `FK_PAGOS_MENSUALES_TIPO_SERVICIO_MENSUAL` (`COD_TIPO_SERV_MENSUAL`);

--
-- Indices de la tabla `pagos_servicios`
--
ALTER TABLE `pagos_servicios`
  ADD PRIMARY KEY (`cod_pagos_servicios`),
  ADD KEY `fgn_key_fk_cod_mpago_idx` (`cod_mpago`),
  ADD KEY `fgn_key_FK_pagos_servicios_transaccion_idx` (`nro_transaccion`);

--
-- Indices de la tabla `pagos_unicos`
--
ALTER TABLE `pagos_unicos`
  ADD PRIMARY KEY (`COD_PAGO_UNICO`),
  ADD KEY `FK_PAGOS_UNICOS_TIPO_PAGO` (`COD_TIPO_SERVICIO`),
  ADD KEY `FK_pagos_unicos_transaccion` (`NRO_TRANSACCION`);

--
-- Indices de la tabla `sub_tipo_egreso`
--
ALTER TABLE `sub_tipo_egreso`
  ADD PRIMARY KEY (`COD_SUB_TIPO_EGRESO`),
  ADD KEY `FK_SUB_TIPO_EGRESO_TIPO_EGRESO` (`COD_TIPO_EGRESO`);

--
-- Indices de la tabla `terreno`
--
ALTER TABLE `terreno`
  ADD PRIMARY KEY (`COD_TERRENO`),
  ADD KEY `FK_TERRENO_ETAPA` (`ETAPA`),
  ADD KEY `FK_TERRENO_LOCALIDAD` (`LOCALIDAD`),
  ADD KEY `FK_TERRENO_LOTE` (`LOTE`),
  ADD KEY `fgn_key_FK_TERRENO_MANZANA_idx` (`manzana`);

--
-- Indices de la tabla `tipo_egreso`
--
ALTER TABLE `tipo_egreso`
  ADD PRIMARY KEY (`COD_TIPO_EGRESO`);

--
-- Indices de la tabla `tipo_operacion`
--
ALTER TABLE `tipo_operacion`
  ADD PRIMARY KEY (`COD_TIPO_OPERACION`);

--
-- Indices de la tabla `tipo_pago`
--
ALTER TABLE `tipo_pago`
  ADD PRIMARY KEY (`COD_TIPO_PAGO`);

--
-- Indices de la tabla `tipo_servicio`
--
ALTER TABLE `tipo_servicio`
  ADD PRIMARY KEY (`COD_TIPO_SERVICIO`);

--
-- Indices de la tabla `tipo_servicio_mensual`
--
ALTER TABLE `tipo_servicio_mensual`
  ADD PRIMARY KEY (`COD_TIPO_SERV_MENSUAL`);

--
-- Indices de la tabla `transaccion`
--
ALTER TABLE `transaccion`
  ADD PRIMARY KEY (`NRO_TRANSACCION`),
  ADD KEY `FK_transaccion_TIPO_OPERACION` (`COD_TIPO_OPERACION`),
  ADD KEY `FK_transaccion_venta` (`COD_VENTA`);

--
-- Indices de la tabla `transferencia`
--
ALTER TABLE `transferencia`
  ADD PRIMARY KEY (`COD_TRANS`),
  ADD KEY `FK_transferencia_transaccion` (`NRO_TRANSACCION`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`dni`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`COD_VENTA`),
  ADD KEY `FK_VENTA_CLIENTE` (`COD_CLIENTE`),
  ADD KEY `FK_VENTA_TERRENO` (`COD_TERRENO`);

--
-- Indices de la tabla `visita`
--
ALTER TABLE `visita`
  ADD PRIMARY KEY (`cod_visita`),
  ADD KEY `fgn_key_FK_VISITA_USUARIO_idx` (`cod_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `candidato`
--
ALTER TABLE `candidato`
  MODIFY `COD_CANDIDATO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `COD_CLIENTE` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `egresos`
--
ALTER TABLE `egresos`
  MODIFY `COD_EGRESO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `etapa`
--
ALTER TABLE `etapa`
  MODIFY `COD_ETAPA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `localidad`
--
ALTER TABLE `localidad`
  MODIFY `COD_LOCALIDAD` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `maestro_pagos`
--
ALTER TABLE `maestro_pagos`
  MODIFY `cod_mpago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `manzana`
--
ALTER TABLE `manzana`
  MODIFY `COD_MANZANA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `COD_PAGO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `pagos_mensuales`
--
ALTER TABLE `pagos_mensuales`
  MODIFY `COD_PAGO_MENSUAL` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos_servicios`
--
ALTER TABLE `pagos_servicios`
  MODIFY `cod_pagos_servicios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `pagos_unicos`
--
ALTER TABLE `pagos_unicos`
  MODIFY `COD_PAGO_UNICO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sub_tipo_egreso`
--
ALTER TABLE `sub_tipo_egreso`
  MODIFY `COD_SUB_TIPO_EGRESO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `terreno`
--
ALTER TABLE `terreno`
  MODIFY `COD_TERRENO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tipo_egreso`
--
ALTER TABLE `tipo_egreso`
  MODIFY `COD_TIPO_EGRESO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_pago`
--
ALTER TABLE `tipo_pago`
  MODIFY `COD_TIPO_PAGO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_servicio_mensual`
--
ALTER TABLE `tipo_servicio_mensual`
  MODIFY `COD_TIPO_SERV_MENSUAL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `transaccion`
--
ALTER TABLE `transaccion`
  MODIFY `NRO_TRANSACCION` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `transferencia`
--
ALTER TABLE `transferencia`
  MODIFY `COD_TRANS` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `COD_VENTA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `visita`
--
ALTER TABLE `visita`
  MODIFY `cod_visita` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calendario_pago`
--
ALTER TABLE `calendario_pago`
  ADD CONSTRAINT `fgn_key_FK_CALENDARIO_PAGO_VENTA` FOREIGN KEY (`COD_VENTA`) REFERENCES `venta` (`COD_VENTA`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_egreso`
--
ALTER TABLE `detalle_egreso`
  ADD CONSTRAINT `FK_detalle_egreso_egresos` FOREIGN KEY (`COD_EGRESO`) REFERENCES `egresos` (`COD_EGRESO`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `egresos`
--
ALTER TABLE `egresos`
  ADD CONSTRAINT `fgn_key_FK_EGRESOS_ETAPA` FOREIGN KEY (`ETAPA`) REFERENCES `etapa` (`ETAPA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fgn_key_FK_EGRESOS_LOCALIDAD` FOREIGN KEY (`LOCALIDAD`) REFERENCES `localidad` (`LOCALIDAD`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fgn_key_FK_EGRESOS_SUB_TIPO_EGRESO` FOREIGN KEY (`COD_SUB_TIPO_EGRESO`) REFERENCES `sub_tipo_egreso` (`COD_SUB_TIPO_EGRESO`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fgn_key_FK_EGRESOS_TIPO_EGRESO` FOREIGN KEY (`COD_TIPO_EGRESO`) REFERENCES `tipo_egreso` (`COD_TIPO_EGRESO`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `fgn_key_FK_PAGOS_TIPO_PAGO` FOREIGN KEY (`COD_TIPO_PAGO`) REFERENCES `tipo_pago` (`COD_TIPO_PAGO`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fgn_key_FK_pagos_transaccion` FOREIGN KEY (`NRO_TRANSACCION`) REFERENCES `transaccion` (`NRO_TRANSACCION`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pagos_mensuales`
--
ALTER TABLE `pagos_mensuales`
  ADD CONSTRAINT `fgn_key_FK_PAGOS_MENSUALES_TIPO_SERVICIO_MENSUAL` FOREIGN KEY (`COD_TIPO_SERV_MENSUAL`) REFERENCES `tipo_servicio_mensual` (`COD_TIPO_SERV_MENSUAL`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pagos_servicios`
--
ALTER TABLE `pagos_servicios`
  ADD CONSTRAINT `fgn_key_FK_pagos_servicios_maestro_pagos` FOREIGN KEY (`cod_mpago`) REFERENCES `maestro_pagos` (`cod_mpago`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fgn_key_FK_pagos_servicios_transaccion` FOREIGN KEY (`nro_transaccion`) REFERENCES `transaccion` (`NRO_TRANSACCION`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pagos_unicos`
--
ALTER TABLE `pagos_unicos`
  ADD CONSTRAINT `fgn_key_FK_PAGOS_UNICOS_TIPO_PAGO` FOREIGN KEY (`COD_TIPO_SERVICIO`) REFERENCES `tipo_servicio` (`COD_TIPO_SERVICIO`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fgn_key_FK_pagos_unicos_transaccion` FOREIGN KEY (`NRO_TRANSACCION`) REFERENCES `transaccion` (`NRO_TRANSACCION`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `sub_tipo_egreso`
--
ALTER TABLE `sub_tipo_egreso`
  ADD CONSTRAINT `fgn_key_FK_SUB_TIPO_EGRESO_TIPO_EGRESO` FOREIGN KEY (`COD_TIPO_EGRESO`) REFERENCES `tipo_egreso` (`COD_TIPO_EGRESO`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `terreno`
--
ALTER TABLE `terreno`
  ADD CONSTRAINT `fgn_key_FK_TERRENO_ETAPA` FOREIGN KEY (`ETAPA`) REFERENCES `etapa` (`ETAPA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fgn_key_FK_TERRENO_LOCALIDAD` FOREIGN KEY (`LOCALIDAD`) REFERENCES `localidad` (`LOCALIDAD`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fgn_key_FK_TERRENO_LOTE` FOREIGN KEY (`LOTE`) REFERENCES `lote` (`LOTE`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fgn_key_FK_TERRENO_MANZANA` FOREIGN KEY (`manzana`) REFERENCES `manzana` (`manzana`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `transaccion`
--
ALTER TABLE `transaccion`
  ADD CONSTRAINT `fgn_key_FK_transaccion_TIPO_OPERACION` FOREIGN KEY (`COD_TIPO_OPERACION`) REFERENCES `tipo_operacion` (`COD_TIPO_OPERACION`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fgn_key_FK_transaccion_venta` FOREIGN KEY (`COD_VENTA`) REFERENCES `venta` (`COD_VENTA`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `transferencia`
--
ALTER TABLE `transferencia`
  ADD CONSTRAINT `fgn_key_FK_transferencia_transaccion` FOREIGN KEY (`NRO_TRANSACCION`) REFERENCES `transaccion` (`NRO_TRANSACCION`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fgn_key_FK_VENTA_CLIENTE` FOREIGN KEY (`COD_CLIENTE`) REFERENCES `cliente` (`DNI`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fgn_key_FK_VENTA_TERRENO` FOREIGN KEY (`COD_TERRENO`) REFERENCES `terreno` (`COD_TERRENO`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `visita`
--
ALTER TABLE `visita`
  ADD CONSTRAINT `fgn_key_FK_VISITA_USUARIO` FOREIGN KEY (`cod_usuario`) REFERENCES `usuario` (`dni`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
