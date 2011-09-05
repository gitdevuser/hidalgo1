<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<script>
$().ready(function(){
    menu_select(6);
});
</script>
<div id="content">
<div class="top-shadow" >&nbsp;</div>
<?php echo $content_top; ?>
<div id="pages-container" >
  <div class="page-title" >
    <h1><?php echo $heading_title; ?></h1>
  </div>
  <div class="pages-content" >

  <div id="clienteDisting-cont" >
      <img src="catalog/view/theme/default/image/cliente-distinguido.jpg">
<label>
Si desea recibir promociones y descuentos permanentes en nuestras sucursales, llene el formato.
Cuando desee hacer una compra en nuestras sucursales, &uacute;nicamente pres&eacute;ntela antes de que le elaboren su nota para que le apliquen su descuento.
<br><br>
Esta tarjeta se divide en 3 parte que debe usted desprender, una es para su cartera y dos m&aacute;s peque&ntilde;s para adherirla a sus llaveros y as&iacute; nunca la olvide. Con una de ellas que presente es suficiente.
<br>
Los beneficios inmediatos que recibi&aacute; son del 10% de descuento si su pago es en efectivo, 8% con tarjeta de d&eacute;bito y 5% con tarjeta de cr&eacute;dito.
<br>
Estos descuentos NO son acumulables con otras promociones, no aplica a Meses Sin Intereses, NO aplica en la Tienda de Internet.
</label>
  </div>

  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div id="register-container" >
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="register">
    <h2><?php echo $text_your_details; ?></h2>
    <div class="content">
      <table class="form">
        <tr>
          <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
          <td><input type="text" name="firstname" value="<?php echo $firstname; ?>" />
            <?php if ($error_firstname) { ?>
            <span class="error"><?php echo $error_firstname; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
          <td><input type="text" name="lastname" value="<?php echo $lastname; ?>" />
            <?php if ($error_lastname) { ?>
            <span class="error"><?php echo $error_lastname; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_postcode; ?></td>
          <td><input type="text" name="postcode" value="<?php echo $postcode; ?>" />
            <?php if ($error_postcode) { ?>
            <span class="error"><?php echo $error_postcode; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_address_1; ?></td>
          <td><input type="text" name="address_1" value="<?php echo $address_1; ?>" />
            <?php if ($error_address_1) { ?>
            <span class="error"><?php echo $error_address_1; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td>Colonia</td>
          <td><input type="text" name="colonia" value="" /></td>
        </tr>
        <tr style="display: none;" >
          <td><span class="required">*</span> <?php echo $entry_country; ?></td>
          <td><select name="country_id" onchange="$('select[name=\'zone_id\']').load('index.php?route=account/register/zone&country_id=' + this.value + '&zone_id=<?php echo $zone_id; ?>');">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country) { ?>
              <?php if ($country['country_id'] == 138 ) { ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
            <?php if ($error_country) { ?>
            <span class="error"><?php echo $error_country; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_zone; ?></td>
          <td class="selectbox"><select name="zone_id">
            </select>
            <?php if ($error_zone) { ?>
            <span class="error"><?php echo $error_zone; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_city; ?></td>
          <td><input type="text" name="city" value="<?php echo $city; ?>" />
            <?php if ($error_city) { ?>
            <span class="error"><?php echo $error_city; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
          <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" />
            <?php if ($error_telephone) { ?>
            <span class="error"><?php echo $error_telephone; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_email; ?></td>
          <td><input type="text" name="email" value="<?php echo $email; ?>" />
            <?php if ($error_email) { ?>
            <span class="error"><?php echo $error_email; ?></span>
            <?php } ?></td>
        </tr>
      </table>
    </div>
    <div class="content">
      <h2><?php echo $text_your_address; ?> </h2>
      <table class="form">
        <!--<tr>
          <td><?php echo $entry_company; ?></td>
          <td><input type="text" name="company" value="<?php echo $company; ?>" /></td>
        </tr>-->
      </table>
    </div>
    <div class="content">
      <h2><?php echo $text_your_password; ?></h2>
      <table class="form">
        <tr>
          <td><span class="required">*</span> <?php echo $entry_password; ?></td>
          <td><input type="password" name="password" value="<?php echo $password; ?>" />
            <?php if ($error_password) { ?>
            <span class="error"><?php echo $error_password; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_confirm; ?></td>
          <td><input type="password" name="confirm" value="<?php echo $confirm; ?>" />
            <?php if ($error_confirm) { ?>
            <span class="error"><?php echo $error_confirm; ?></span>
            <?php } ?></td>
        </tr>
      </table>
    </div>
    <!--<h2><?php echo $text_newsletter; ?></h2>
    <div class="content">
      <table class="form">
        <tr>
          <td><?php echo $entry_newsletter; ?></td>
          <td><?php if ($newsletter == 1) { ?>
            <input type="radio" name="newsletter" value="1" checked="checked" />
            <?php echo $text_yes; ?>
            <input type="radio" name="newsletter" value="0" />
            <?php echo $text_no; ?>
            <?php } else { ?>
            <input type="radio" name="newsletter" value="1" />
            <?php echo $text_yes; ?>
            <input type="radio" name="newsletter" value="0" checked="checked" />
            <?php echo $text_no; ?>
            <?php } ?></td>
        </tr>
      </table>
    </div>-->
    <?php if ($text_agree) { ?>
    <div class="buttons">
      <div class="right"><?php echo $text_agree; ?>
        <?php if ($agree) { ?>
        <input type="checkbox" name="agree" value="1" checked="checked" />
        <?php } else { ?>
        <input type="checkbox" name="agree" value="1" />
        <?php } ?>
        <a onclick="$('#register').submit();" class="button"><?php echo $button_continue; ?></a></div>
    </div>
    <?php } else { ?>
    <div class="buttons">
      <div class="right">
        <a onclick="$('#register').submit();" class="button">Enviar</a>
        <a class="button clear">Borrar</a>
      </div>
    </div>
    <?php } ?>
  </form>
  </div>

  <?php echo $content_bottom; ?>
</div>
</div>
</div>
<script type="text/javascript"><!--
$('select[name=\'zone_id\']').load('index.php?route=account/register/zone&country_id=<?php echo $country_id; ?>&zone_id=<?php echo $zone_id; ?>');
//--></script> 
<script type="text/javascript"><!--
$('.fancybox').fancybox({
	width: 560,
	height: 560,
	autoDimensions: false
});
//--></script>  
<?php echo $footer; ?>