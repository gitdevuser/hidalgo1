<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<script>
$().ready(function(){
    menu_select(5);
});
</script>
<div id="content">
<div class="top-shadow" >&nbsp;</div>
<?php echo $content_top; ?>

 <div id="pages-container"  >
  <div class="page-title" >
     <h1><?php echo $heading_title; ?></h1>
  </div>
  <div class="pages-content" style="margin-bottom: 23px;" >
    <div>
    <?php if( isset($desc) ) { echo $desc; } ?>

<!--
<h1 style="color: #cc6633; font-size: 14px; font-weight: bolder;">PARA EL INTERIOR DE LA REP&Uacute;BLICA</h1>
<p>
1.El costo de envi&oacute;o ampara, empaquetado de la mercanc&iacute;a, y traslado v&iacute;a terrestra a domicilio solicitado.
<br>
2.El costo depender&aacute; del art&iacute;culo anunciado y estar&aacute;n  marcados los costos en la parte baja del anuncio.
<br>
3.El costo del env&iacute;o se deber&aacute; pagar junto con el costo del art&iacute;culo ofertado.
<br>
4.Manejamos una paqueter&iacute;a y en la parte baja del anuncio el costo de la misma.
<p>
<h1 style="color:#999999; font-size: 14px; font-weight: bold;" >Tiempos de entrega</h1>
1.El tiempo de entrega empieza a partir de que se confirme que se ha hecho el pago.
<br>
2.Se mandar&aacute; la mercancia el mismo d&iacute;a si la compra se hace antes de las 11:00pm, de no ser as&iacute; se mandara el d&iacute;a siguente h&aacute;bil, a partir de ah&iacute; se cuentan los d&iacute;as h&aacute;biles de entrega.
<br>
3.El m&aacute;ximo de entrega de los paquetes es de 3 d&iacute;s h&aacute;biles, sin embargo en algunas partes de la rep&uacute;blica el tiempo de entrega ser&aacute; de 5a 7 d&iacute;s h&aacute;biles por reexpedici&oacute;n.
<br>
4.Al comprar el usuario acepta que se puede haber retrasoso en la entrega ocacionados por la empresa de paqueter&iacute;a contratada.
<p>
<h1 style="color: #cc6633; font-size: 14px; font-weight: bold;" >PARA EL DISTRITO FEDERAL Y &Aacute;REA METROPOLITANA</h1>
1.El costo ampara el empaquetado de la mercanc&iacute;a y traslado v&iacute;a terrestre hasta el domicili&oacute; solicitado.
<br>
2.Tambi&eacute;n podr&aacute;n venir por si pedido a nuestras sucursales sin costo alguno con los siguientes horarios.
<br>
Lunes a S&aacute;bado de 10:00am a 7:00pm
<br>
S&aacute;bado de 10:00am a 6:00pm.
<p>
<h1 style="color:#999999; font-size: 14px; font-weight: bold;" >Tiempos de entrega</h1>
1.El tiempo de entrega en el DF y &aacute;rea metropolitana es de 3 d&iacute;as h&aacute;biles.
<br>
2.El tiempo contar&aacute; a partir de la confirmaci&oacute;n del pago.
<br>
3.En caso de venir a nuestras sucursales por su ropa, deber&aacute; avisar previamente v&iacute;a e-mail
<br>
<a href="#" style="color:#cc6633;" >envios@trajeshidalgo.mx</a>, en el caso contrario no nos hacemos responsables de que no est&eacute; listo para la entrega.
<p>
<p>
<span style="color:#333333;"><strong>NOTA:</strong> Al comprar cualquier art&iacute;culo el usuario acepta los t&eacute;rminos y condiciones de estas pol&iacute;ticas. </span>
-->

    </div>

  </div>
  </div>



  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>