<div id="Logincheckout-container" >
<div class="left">
  <h2>Nuevo Cliente</h2>
  <p><b>Registrar nueva cuenta<?php //echo $text_checkout; ?></b></p>
  <label for="register">
    <?php if ($account == 'register') { ?>
    <input type="radio" name="account" value="register" id="register" checked="checked" />
    <?php } else { ?>
    <input type="radio" name="account" value="register" id="register" />
    <?php } ?>
    <!--<b><?php echo $text_register; ?></b>-->
  </label>
  <br />
  <?php if ($guest_checkout) { ?>
  <label for="guest">
    <?php /*if ($account == 'guest') { ?>
    <input type="radio" name="account" value="guest" id="guest" checked="checked" />
    <?php } else { ?>
    <input type="radio" name="account" value="guest" id="guest" />
    <?php }*/ ?>
    <!--<b><?php echo $text_guest; ?></b>-->
    </label>
  <br />
  <?php } ?>
  <br />
  <!--<p><?php echo $text_register_account; ?></p>-->
  <a id="button-account" class="button"><?php echo $button_continue; ?></a><br />
  <br />
</div>

<div id="login" class="right">
  <h2>Ingresar<?php //echo $text_returning_customer; ?></h2>
  <p><?php //echo $text_i_am_returning_customer; ?></p>
  <b>Direcci&oacute;n de Email<?php //echo $entry_email; ?></b><br />
  <input type="text" name="email" value="" />
  <br />
  <br />
  <b><?php echo $entry_password; ?></b><br />
  <input type="password" name="password" value="" />
  <br />
  <a href="<?php echo $forgotten; ?>">¿Olvidaste tu password?<?php //echo $text_forgotten; ?></a><br />
  <br />
  <a id="button-login" class="button"><?php echo $button_login; ?></a><br />
  <br />
</div>
</div>