<div id="footer">
  <div class="column">
     <div class="title"><?php echo $text_information; ?></div>
    <ul>
      <?php /*foreach ($informations as $information) {*/ ?>
      <!--<li><a href="<?php //echo $information['href']; ?>"><?php //echo $information['title']; ?></a></li>-->
      <?php /*}*/ ?>
      <li><a href="<?php echo $liga_faq; ?>">Preguntas Frecuentes</a></li>
      <li><a href="<?php echo $liga_contact; ?>">Cont&aacute;ctanos</a></li>
      <li><a href="<?php echo $liga_sucursales; ?>">Sucursales</a></li>
    </ul>
  </div>
  <div class="column">
    <div class="title"><?php echo $text_service; ?></div>
    <ul>
      <li><a href="<?php echo $liga_priv; ?>" >Aviso de Privacidad</a></li>
      <li><a href="<?php echo $liga_polVenta; ?>">Pol&iacute;tica de venta y devoluciones</a></li>
      <li><a href="<?php echo $liga_polEnvio; ?>">Pol&iacute;tica de env&iacute;o</a></li>
    </ul>
  </div>
  <div class="column">
    <div class="title"><?php echo $text_extra; ?></div>
    <ul>
      <li><a href="<?php echo $cliente_dist; ?>">Cliente Distinguido</a></li>
      <li><a href="<?php echo $liga_formaPago; ?>">Formas de pago y seguridad</a></li>
      <li><a href="<?php echo $liga_sizechart; ?>">Tabla de medidas (Tallas)</a></li>
    </ul>
  </div>
</div>
<!-- 
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donatation.
Please donate via PayPal to donate@opencart.com
//-->
<div id="powered">
   <div class="hidalgo" > Copyrigth &copy; <?php  echo date( 'Y' ); ?> Hidalgo </div>
   <?php echo $powered; ?>
</div>
<!-- 
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donatation.
Please donate via PayPal to donate@opencart.com
//-->
</div>
</body></html>