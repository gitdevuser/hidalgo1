<!--RNC-->
<div class="left">
  <h2><?php echo $text_your_details; ?></h2>

  <div id="info-inputList">
   <span class="required">*</span> <?php echo $entry_firstname; ?><br />
   <input type="text" name="firstname" value="" class="large-field" />
   <br>
  </div>

  <div id="info-inputList">
  <span class="required">*</span> <?php echo $entry_lastname; ?><br />
  <input type="text" name="lastname" value="" class="large-field" />
  <br />
  </div>

  <div id="info-inputList">
  <span class="required">*</span> <?php echo $entry_email; ?><br />
  <input type="text" name="email" value="" class="large-field" />
  <br />
  </div>

  <div id="info-inputList">
  <span class="required">*</span> <?php echo $entry_telephone; ?><br />
  <input type="text" name="telephone" value="" class="large-field" />
  <br />
  </div>

  <div id="info-inputList" style="display: none;">
  <?php echo $entry_fax; ?><br />
  <input type="text" name="fax" value="" class="large-field" />
  <br />
  </div>

  <div id="info-inputList">
  <h2><?php echo $text_your_password; ?></h2>
  <span class="required">*</span> <?php echo $entry_password; ?><br />
  <input type="password" name="password" value="" class="large-field" />
  <br />
  </div>

  <div id="info-inputList">
  <span class="required">*</span> <?php echo $entry_confirm; ?> <br />
  <input type="password" name="confirm" value="" class="large-field" />
  <br />
  </div>

</div>
<div class="right">
  <h2><?php echo $text_your_address; ?></h2>
  
  <div id="info-inputList" style="display:none;">
  <?php echo $entry_company; ?><br />
  <input type="text" name="company" value="" class="large-field" />
  <br />
  </div>

  <div id="info-inputList">
  <span class="required">*</span> <?php echo $entry_address_1; ?><br />
  <input type="text" name="address_1" value="" class="large-field" />
  <br />
  </div>
  <!--<br />
  <?php echo $entry_address_2; ?><br />
  <input type="text" name="address_2" value="" class="large-field" />
  <br />-->
  <br />

  <div id="info-inputList">
  <span class="required">*</span> <?php echo $entry_city; ?><br />
  <input type="text" name="city" value="" class="large-field" />
  <br />
  </div>

  <div id="info-inputList">
  <span class="required">*</span> <?php echo $entry_postcode; ?><br />
  <input type="text" name="postcode" value="" class="large-field" />
  <br />
  </div>

  <div id="info-inputList" style="display:none;">
  <span class="required">*</span> <?php echo $entry_country; ?><br />
  <select name="country_id" class="large-field" onchange="$('#payment-address select[name=\'zone_id\']').load('index.php?route=checkout/address/zone&country_id=' + this.value);">
    <option value=""><?php echo $text_select; ?></option>
    <?php foreach ($countries as $country) { ?>
    <?php if ($country['country_id'] == 138 ) { ?>
    <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
    <?php } else { ?>
    <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
    <?php } ?>
    <?php } ?>
  </select>
  <br />
  </div>

  <div id="info-inputList">
  <span class="required">*</span>ESTADO<br />
  <select name="zone_id" class="large-field">
  </select>
  <br />
  </div>
  
  <br />
</div>
<div style="clear: both; padding-top: 15px; border-top: 1px solid #EEEEEE;" id="direccion-compra" >
  <input type="checkbox" name="newsletter" value="1" id="newsletter" style="display:none;" />
  <label for="newsletter"><?php echo $entry_newsletter; ?></label>
  <br />
  <?php if ($shipping_required) { ?>
  <input type="checkbox" name="shipping_address" value="1" id="shipping" checked="checked" />
  <label for="shipping"><?php echo $entry_shipping; ?></label>
  <br />
  <?php } ?>
  <br />
  <br />
</div>

<!-- Campos Composturas -->
<style>
#compostura {
    border: 1px solid #DBDEE1;
    overflow: hidden;
    padding: 10px;
}
#compostura ul li input {
    width: 300px;
}
#compostura ul li,
#compostura h2
{
    clear: both;
}
#compostura .leyenda1 {
    text-align: left;
    text-transform: inherit;
}
#compostura .comps1 {
    width: 10px;
    height: 10px;
}
#compostura ul li  {
    list-style: none;
}
</style>

<div class="buttons" id="direccion-compra" style="background:#F8F8F8; color:#555555; ">
  <div class="right">
    <input type="checkbox" name="si_comp" id="agree" > <b>Mis productos requieren de compostura.</b><br>
        Acepto que las composturas solicitadas se realizar&aacute;n bajo mi responsabilidad y de acuerdo a mis indicaciones.
  </div>
</div>

<div id="compostura" >
  <h2>COMPOSTURAS</h2><br>
  <?php
  if ( isset($compostura) ) {

  foreach ( $compostura as $rs_comp ) {

      if ( $rs_comp['compostura_padre'] == 0 ) {
          echo '<h2>'.$rs_comp['nombre'].'</h2>';
          echo "<ul>";
          foreach ( $compostura as $rs_1 ) {
            if ( $rs_1['compostura_padre'] == $rs_comp['compostura_id'] ) {
                echo '<li><div style="display:block; float:left; width:80px;" >'.$rs_1['nombre'].'</div><div style="display:block; " ><input type="text" name="'.$rs_1['nombre'].'" value="" ></div></li>';
            }
          }
          echo "</ul>";
      }

  }
  
  }

  ?>
</div>

<p>&nbsp;</p>
<p>&nbsp;</p>

<?php if ($text_agree) { ?>
<div class="buttons" id="direccion-compra">
  <div class="right"><?php echo $text_agree; ?>
    <input type="checkbox" name="agree" value="1" id="agree" />
    <a id="button-register" class="button"><?php echo $button_continue; ?></a>
  </div>
</div>
<?php } else { ?>
<div class="buttons">
  <div class="right"><a id="button-register" class="button"><span><?php echo $button_continue; ?></span></a></div>
</div>
<?php } ?>




<script type="text/javascript"><!--
$('#payment-address select[name=\'zone_id\']').load('index.php?route=checkout/address/zone&country_id=<?php echo $country_id; ?>');
//--></script>
<script type="text/javascript"><!--
$('.fancybox').fancybox({
	width: 560,
	height: 560,
	autoDimensions: false
});
$( 'input[name="si_comp"]' ).change(function(){
alert( 'dfgdf' );
    
});

//--></script>  