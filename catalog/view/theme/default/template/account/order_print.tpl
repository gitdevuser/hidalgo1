<html>
 <head>
    <link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/print.css" media="all" />
    <script>window.print();</script>
 </head>
 <body>

<div id="content">

<?php echo $content_top; ?>


  <div id="pages-container" class="my-account"  >
    <div class="page-title" >
    <h1><?php echo $heading_title; ?></h1>
    </div>

    <div class="pages-content" >

  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>

  <table class="list">
    <thead>
      <tr>
        <td class="left" colspan="2"><?php echo $text_order_detail; ?></td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="left" style="width: 50%;"><?php if ($invoice_no) { ?>
          <b><?php echo $text_invoice_no; ?></b> <?php echo $invoice_no; ?><br />
          <?php } ?>
          <b><?php echo $text_order_id; ?></b> #<?php echo $order_id; ?><br />
          <b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?></td>
        <td class="left"><b><?php echo $text_payment_method; ?></b> <?php echo $payment_method; ?><br />
          <?php if ($shipping_method) { ?>
          <b><?php echo $text_shipping_method; ?></b> <?php echo $shipping_method; ?>
          <?php } ?></td>
      </tr>
    </tbody>
  </table>
  <p></p>
  <table class="list" width="300">
    <thead>
      <tr>
        <td class="left"><b><?php echo $text_payment_address; ?></b></td>
        <?php if ($shipping_address) { ?>
        <td class="left"><b><?php echo $text_shipping_address; ?></b></td>
        <?php } ?>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="left"><?php echo $payment_address; ?></td>
        <?php if ($shipping_address) { ?>
        <td class="left"><?php echo $shipping_address; ?></td>
        <?php } ?>
      </tr>
    </tbody>
  </table>
  <p></p>
  
    <table class="list">
      <thead>
        <tr>
          <td width="1" style="text-align: center; display: none;">
           <input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" style="width:10px; height:10px;" />
          </td>
          <td class="left"><b><?php echo $column_name; ?></b></td>
          <td class="left"><b><?php echo $column_model; ?></b></td>
          <td class="center"><b><?php echo $column_quantity; ?></b></td>
          <td class="right"><b><?php echo $column_price; ?></b></td>
          <td class="right"><b><?php echo $column_total; ?></b></td>
        </tr>
        <tr>
          <td colspan="6"></td>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td colspan="6"></td>
        </tr>
        <?php foreach ($products as $product) { ?>
        <tr>
          <td style="text-align: center; vertical-align: middle; display: none;">
            <?php if ($product['selected']) { ?>
            <input type="checkbox" name="selected[]" value="<?php echo $product['order_product_id']; ?>" checked="checked" style="width:10px; height:10px;" />
            <?php } else { ?>
            <input type="checkbox" name="selected[]" value="<?php echo $product['order_product_id']; ?>" style="width:10px; height:10px;" />
            <?php } ?>
          </td>
          <td class="left">
            <?php echo $product['name']; ?>
            <?php foreach ($product['option'] as $option) { ?>
            <br />
            &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
            <?php } ?>
          </td>
          <td class="left"><?php echo $product['model']; ?></td>
          <td class="right"><?php echo $product['quantity']; ?></td>
          <td class="right"><?php echo $product['price']; ?></td>
          <td class="right"><?php echo $product['total']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      <tfoot>
        <?php foreach ($totals as $total) { ?>
        <tr>
          <td colspan="3"></td>
          <td class="right"><b><?php echo $total['title']; ?>:</b></td>
          <td class="right"><?php echo $total['text']; ?></td>
        </tr>
        <?php } ?>
      </tfoot>
    </table>
 
  <?php if ($comment) { ?>
  <p></p><p></p>
  <table class="list">
    <thead>
      <tr>
        <td class="left"><?php echo $text_comment; ?></td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="left"><?php echo $comment; ?></td>
      </tr>
    </tbody>
  </table>
  <?php } ?>
  <?php if ($histories) { ?>
  <p></p><p></p>
  <h2><?php echo $text_history; ?></h2>
  <table class="list">
    <thead>
      <tr>
        <td class="left"><?php echo $column_date_added; ?></td>
        <td class="left"><?php echo $column_status; ?></td>
        <td class="left"><?php echo $column_comment; ?></td>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($histories as $history) { ?>
      <tr>
        <td class="left"><?php echo $history['date_added']; ?></td>
        <td class="left"><?php echo $history['status']; ?></td>
        <td class="left"><?php echo $history['comment']; ?></td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
  <?php } ?>

    </div>
  </div>

</div>

    </body>
</html>
