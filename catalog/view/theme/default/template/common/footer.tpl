<div id="footer">
  <div class="column">
     <div class="title"><?php echo $text_information; ?></div>
    <ul>
      <?php if ( $liga_faq ) { ?>
      <li><a href="<?php echo $liga_faq; ?>">Preguntas Frecuentes</a></li>
      <?php } ?>
      <?php if ( $liga_contact ) { ?>
      <li><a href="<?php echo $liga_contact; ?>">Cont&aacute;ctanos</a></li>
      <?php } ?>
      <?php if($liga_sucursales){ ?>
      <li><a href="<?php echo $liga_sucursales; ?>">Sucursales</a></li>
      <?php } ?>
    </ul>
  </div>
  <div class="column">
    <div class="title"><?php echo $text_service; ?></div>
    <ul>
      <?php if($liga_priv){ ?>
       <li><a href="<?php echo $liga_priv; ?>" >Aviso de Privacidad</a></li>
      <?php } ?>
      <?php if($liga_polVenta){ ?>
      <li><a href="<?php echo $liga_polVenta; ?>">Pol&iacute;tica de venta y devoluciones</a></li>
      <?php } ?>
      <?php if($liga_polEnvio){ ?>
      <li><a href="<?php echo $liga_polEnvio; ?>">Pol&iacute;tica de env&iacute;o</a></li>
      <?php } ?>
    </ul>
  </div>
  <div class="column">
    <div class="title"><?php echo $text_extra; ?></div>
    <ul>
      <?php if ( $cliente_dist ) { ?>
      <li><a href="<?php echo $cliente_dist; ?>">Cliente Distinguido</a></li>
      <?php } ?>
      <?php if($liga_formaPago) { ?>
      <li><a href="<?php echo $liga_formaPago; ?>">Formas de pago y seguridad</a></li>
      <?php } ?>
      <li><a href="<?php echo $liga_sizechart; ?>">Tabla de medidas (Tallas)</a></li>
    </ul>
  </div>
</div>
<div id="powered">
   <div class="hidalgo" > Copyrigth &copy; <?php  echo date( 'Y' ); ?> Hidalgo </div>
   <?php echo $powered; ?>
</div>
</div>
</body></html>