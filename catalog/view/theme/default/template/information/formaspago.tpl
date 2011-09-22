<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<script>
$().ready(function(){
    menu_select(7);
});
</script>
<div id="content">
<div class="top-shadow" >&nbsp;</div>
<?php echo $content_top; ?>

 <div id="pages-container"  >
  <div class="page-title" >
     <h1 style=" width: 300px;" ><?php echo $heading_title; ?></h1>
  </div>
  <div class="pages-content" style="margin-bottom: 23px;" >
    <div style="font-size: 14px;">
<?php if( isset($desc) ) { echo $desc; } ?>
<!--Ponemos a disposic&oacute;n de nuestros clientes varias formas de pago para facilitarle la compra de
nuestros productos. Todos nuestros m&eacute;todos de pago son seguros y respaldados por compa&ntilde;ias como American Express, Visa, Master Card y PayPal.
<p>
<h1 style="color: #cc6633; font-size: 14px; font-weight: bolder;" >1.Pago mediante tarjeta de cr&eacute;dito:</h1>
El cliente puede elegir el pago mediante tarjeta de cr&eacute;dito, realiz&aacute;ndose la operaci&oacute;n en el momento de realizaci&oacute;n del pedido. So&oacute;lo se aceptan tajetas
<span style="color: #cc6633;" >Visa, Mastercard y American Express.</span>
<p>
<h1 style="color: #cc6633; font-size: 14px; font-weight: bolder;">2.Pago mediante PayPal</h1>
Si escoges esta forma de pago, una vez que decida la opci&oacute;n de 
<span style="color: #cc6633;" >"Realizar Pago"</span> ser&aacute; redirigido a la p&aacute;gina de PayPal donde usted tiene 2 opciones: Una es registrarse como cliente de PayPal (Nuestra Recomendaci&oacuten) y la segunda opci&oacute;n es capturar sus datos SIN registrarse, al terminar su pago en PayPal y haya sido aprobado, ser&aacute; redirigido nuevamente a nuestra p&aacute;gina.PayPal acepta todas las tarjetas de cr&eacute;dito como
<span style="color: #cc6633;" >VISA, Mastercard y American Express.</span>
<p>
<h1 style="color: #cc6633; font-size: 14px; font-weight: bolder;" >3.Pago mediante Banco</h1>
Si escoges esta forma de pago, una vez que decida la opci&oacute;n de <span style="color: #cc6633;" >"Realizar Pago"</span> ser&aacute; redirigido a la p&aacute;gina del Banco y debe seguir kas instrucciones del mismo. Una vez aprobado, ser&aacute; redirigido nuevamente a nuestra p&aacute;gina. El Banco recibe las Tajetas
<span style="color: #cc6633;" >VISA y Mastercard.</span>
<p><p>
Una vez realizado el pago correctamente, tu pedido estar&aacute; finalizado y se enviar&aacute; un correo electr&oacute;nico con el resumen de tu compra. Pulsando el bot&oacute;n <span style="color: #cc6633;" >"Volver a la Web / www.trajeshidalgo.mx"</span>, regresar&aacute;s a la web para ver el pedido y poder imprimirlo.
<p>
En Hidalgo nos preocupamos por la seguridad de nuestros clientes y de nuestro sitio. Para conseguir mejorar la seguridad de nuestro sitio y de las transacciones de nuestros clientes en nuestro sitio <span style="color: #cc6633;" >NO SE ALMACENAN DATOS SOBRE SUS TARJETAS DE CR&Eacute;DITO NI CUENTAS BANCARIAS</span>, los pagos siempre son re direccionados a la p&aacute;gina de segura de la entidad bancaria.-->
    </div>
  </div>
  </div>
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>