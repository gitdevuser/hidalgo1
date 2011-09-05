<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
<div class="top-shadow" >&nbsp;</div>
<?php echo $content_top; ?>

  <div id="pages-container" class="my-account"  >
    <div class="page-title" >
    <h1 style="width: 200px;" ><?php echo $heading_title; ?></h1>
    </div>
<div class="pages-content" >
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="password">
    <h2><?php echo $text_password; ?></h2>
    <div class="content">
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
      <div class="left"><a href="<?php echo $back; ?>" class="button"><?php echo $button_back; ?></a></div>
      <div class="right"><a onclick="$('#password').submit();" class="button"><?php echo $button_continue; ?></a></div>
    </div>
  </form>

    </div>
  </div>

  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>