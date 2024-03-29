<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
<div class="top-shadow" >&nbsp;</div>
<?php echo $content_top; ?>

  <div id="pages-container" class="my-account"  >
    <div class="page-title" >
    <h1 style="width: 250px;" ><?php echo $heading_title; ?></h1>
    </div>

    <div class="pages-content" >

  <p><?php echo $text_total; ?><b> <?php echo $total; ?></b>.</p>
  <table class="list">
    <thead>
      <tr>
        <td class="left"><?php echo $column_date_added; ?></td>
        <td class="left"><?php echo $column_description; ?></td>
        <td class="right"><?php echo $column_amount; ?></td>
      </tr>
    </thead>
    <tbody>
      <?php if ($transactions) { ?>
      <?php foreach ($transactions  as $transaction) { ?>
      <tr>
        <td class="left"><?php echo $transaction['date_added']; ?></td>
        <td class="left"><?php echo $transaction['description']; ?></td>
        <td class="right"><?php echo $transaction['amount']; ?></td>
      </tr>
      <?php } ?>
      <?php } else { ?>
      <tr>
        <td class="center" colspan="5"><?php echo $text_empty; ?></td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
  <div class="pagination"><?php echo $pagination; ?></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>

    </div>
  </div>
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>