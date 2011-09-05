<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
<div class="top-shadow" >&nbsp;</div>
<?php echo $content_top; ?>

 <div id="pages-container"  >
  <div class="page-title" >
     <h1 style="width:300px" ><?php echo $heading_title; ?></h1>
  </div>
  <div class="pages-content" style="margin-bottom: 23px;" >
  
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="forgotten">
    <p><?php echo $text_email; ?></p>
    <h2><?php echo $text_your_email; ?></h2>
    <div class="content">
      <table class="form">
        <tr>
          <td><?php echo $entry_email; ?></td>
          <td><input type="text" name="email" value="" /></td>
        </tr>
      </table>
    </div>
    <div class="buttons">
      <div class="left"><a href="<?php echo $back; ?>" class="button"><?php echo $button_back; ?></a></div>
      <div class="right"><a onclick="$('#forgotten').submit();" class="button"><?php echo $button_continue; ?></a></div>
    </div>
  </form>

  </div>
</div>
  
  
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>