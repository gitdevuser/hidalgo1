<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($shipping_methods) { ?>
<p><?php echo $text_shipping_method; ?></p>
<table class="form">
  <?php foreach ($shipping_methods as $shipping_method) { ?>
  <tr>
    <td colspan="3" align="left" style="text-align: left;" ><b><?php echo $shipping_method['title']; ?></b></td>
  </tr>
  <?php if (!$shipping_method['error']) { ?>
  <?php foreach ($shipping_method['quote'] as $quote) { ?>
  <tr>
    <td style="width: 1px; text-align: left; "><?php if ($quote['code'] == $code || !$code) { ?>
      <?php $code = $quote['code']; ?>
      <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" 
             id="<?php echo $quote['code']; ?>" checked="checked" style="width: 15px; height: 15px;"  />
      <?php } else { ?>
      <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" 
             id="<?php echo $quote['code']; ?>" style="width: 15px; height: 15px;" />
      <?php } ?></td>
    <td align="left" style="text-align: left;" >
        <label for="<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?></label></td>
    <td style="text-align: left;"><label for="<?php echo $quote['code']; ?>"><?php echo $quote['text']; ?></label></td>
  </tr>
  <?php } ?>
  <?php } else { ?>
  <tr>
    <td colspan="3" ><div class="error"><?php echo $shipping_method['error']; ?></div></td>
  </tr>
  <?php } ?>
  <?php } ?>
</table>
<?php } ?>
<b><?php echo $text_comments; ?></b><p>
<textarea name="comment" rows="8" style="width: 300px; height: 168px;"><?php echo $comment; ?></textarea>
<br />
<br />
<div class="buttons">
  <div class="right"><a id="button-shipping" class="button"><?php echo $button_continue; ?></a></div>
</div>
