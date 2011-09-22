<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<script>
$().ready(function(){
    menu_select(3);
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
    <!--<span style="color: #000; font-size: 14px;" >
En cumplimiento con la Ley Federal de Protecci&oacute;n de Datos Personales en posesi&oacute;n de los Particulares y con el fin de Asegurar la protecci&oacute;n y privacidad de los datos personales, as&iacute; como
regular el acceso, rectificaci&oacute;n, cancelaci&oacute; y oposici&oacute;n de los mismos HIDALGO, S.A. DE C.V. propietario de Tienda de ropa HIDALGO&copy; establece el siguente:
    </span>
<p>
<p>
<span style="color:#625151; font-size: 14px; text-align: justify; " >
<h1 style="text-align: center; color:#cc6633; font-size: 13px; font-weight: bold; " >AVISO DE PRIVACIDAD</h1>

<p>
<span style="color:#cc6633;" >HIDALGO S.A. DE CV</span>; con domicilio en Av. 5 de Mayo #31 Piso1-1 Col. Centro, C.P. 06000 Delegaci&oacute;n Cuauht&eacute;moc, en M&eacute;xico D.F., es responsable de recabar sus datos personales, del uso que se le d&eacute; a los mismos y de su protecci&oacute;n, seg&uacute;n sea el caso, mismos que se utilizar&aacute;n  para la identificaci&oacute;n, operaci&oacute;n admnistraci&oacute;n y an&aacute;logos que sean necesarios para la prestaci&oacute;n de los servicios de compra por internet y solicitud de Cliente Distinguido.
<p>
Usted tiene derecho de acceder, rectificar, cancelar sus datos personales, as&iacute; como de oponerse al tratamiento de los mismos o revocar el consentimiento que para tal fin nos haya otorgado, por lo que respecta sus datos personales seg&uacute;n sea el caso, se puede poner en contacto con niestro departamento de Tecnolog&iacute;as de Informaci&oacute;n con el Sr. Juan HidalgoMart&iacute;n en el correo electr&oacute;nico <a href="#" style="color:#cc6633;;" >juanhidalgo@trajeshidalgo.mx</a> y al tel&eacute;fono <span style="color:#cc6633" >51 30 03 20</span> o visitar nuestra
p&aacute;gina de internet <a href="#" style="color:#cc6633;" >www.trajeshidalgo.mx</a>
<p>
Si usted como cliente proporcionan los datos personales significa que ha le&icute;do, entendido y aceptado los t&eacute;rminos antes expiestos y no manifiesta su opocisi&oacute;n para que sus datos personales sean transferidos, se entender&aacute; que ha otorgado su consentimiento para ello.
<p>
As&iacute; mismo le informamos que sus datos personales NO pueden ser transferidos y tratados dentro y fuera del pa&iacute;s, por personas distintas a HIDALGO, S.A. DE C.V. excepto la compa&ntilde;a de trasnportes qie har&aacute; la entraga de sus productos.
<p>
</span>
<span style="color:#cc6633; text-align: left; font-size: 14px;" >
  La pol&iacute;tica de Privacidad y los cambios en el presente aviso se publicar&aacute;n en nuestra p&aacute;gina <a href="#" style="color:#cc6633;" >www.trajeshidalgo.mx</a></span>-->

    </div>


  </div>
  </div>
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>