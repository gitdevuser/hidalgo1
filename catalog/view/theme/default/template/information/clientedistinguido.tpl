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
      <div class="content-dist" ><?php if (isset($desc)) { echo $desc; }  ?></div>
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
          <td><input type="text" name="postcode" value="<?php echo $postcode; ?>" style="width: 150px;" />
            <?php if ($error_postcode) { ?>
            <span class="error"><?php echo $error_postcode; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> CALLE</td>
          <td><input type="text" name="address_1" value="<?php echo $address_1; ?>" />
            <?php if ($error_address_1) { ?>
            <span class="error"><?php echo $error_address_1; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span>COLONIA</td>
          <td><input type="text" name="colonia" value="<?php echo $colonia; ?>" />
            <?php if ($error_colonia) { ?>
            <span class="error"><?php echo $error_colonia; ?></span>
            <?php } ?>
          </td>
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
          <td class="selectbox">
            <input type="text" name="deleg" value="<?php echo $deleg; ?>" />
            <?php if ($error_deleg) { ?>
            <span class="error"><?php echo $error_deleg; ?></span>
            <?php } ?>
          </td>
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
          <td>
            <input type="text" name="telephone_ini" value="<?php echo $telephone_ini; ?>" style="width: 85px; margin-right: 15px; "  />
            <input type="text" name="telephone" value="<?php echo $telephone; ?>" style="width: 190px; " />
            <?php if ($error_telephone_ini) { ?>
            <span class="error"><?php echo $error_telephone_ini; ?></span>
            <?php } ?>
            <?php if ($error_telephone) { ?>
            <span class="error"><?php echo $error_telephone; ?></span>
            <?php } ?>
          </td>
        </tr>
        <tr>
          <td><span class="required">*</span> Celular</td>
          <td><input type="text" name="cell_ini" value="<?php echo $cell_ini; ?>" style="width: 85px; margin-right: 15px; " />
              <input type="text" name="cell" value="<?php echo $cell; ?>" style="width: 190px; " />
            <?php if ($error_cell_ini) { ?>
                <span class="error"><?php echo $error_cell_ini; ?></span>
            <?php } ?>  
            <?php if ($error_cell) { ?>
                <span class="error"><?php echo $error_cell; ?></span>
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
    <div class="content" style="display:none;" >
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
    <div class="buttons">
      <div class="right">
        <a onclick="$('#register').submit();" class="button">Enviar</a>
        <a class="button clear">Borrar</a>
      </div>
    </div>
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