<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
<div class="top-shadow" >&nbsp;</div>
<?php echo $content_top; ?>

  <div id="pages-container" class="my-account"  >
    <div class="page-title" >
    <h1 style="width: 200px;" ><?php echo $heading_title; ?></h1>
    </div>

<div class="pages-content" >
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <h2><?php echo $text_address_book; ?></h2>
  <?php foreach ($addresses as $result) { ?>
  <div class="content">
    <table style="width: 100%;">
      <tr>
        <td><?php echo $result['address']; ?></td>
        <td class="buttons">
            <a href="<?php echo $result['update']; ?>" class="button"><?php echo $button_edit; ?></a> &nbsp;
            <a href="<?php echo $result['delete']; ?>" class="button"><?php echo $button_delete; ?></a>
        </td>
      </tr>
    </table>
  </div>
  <?php } ?>
  <div class="buttons">
    <div class="left"><a href="<?php echo $back; ?>" class="button"><?php echo $button_back; ?></a></div>
    <div class="right"><a href="<?php echo $insert; ?>" class="button new-address"><?php echo $button_new_address; ?></a></div>
  </div>
</div>
</div>

  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>