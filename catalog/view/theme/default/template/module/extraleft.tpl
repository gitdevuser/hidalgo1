<?php if ( isset( $arrayList ) ) {  ?>
<?php foreach ( $arrayList as $rs_key=>$rs_list ) { ?>
<div class="box">
  <div class="box-heading"><?php echo $rs_list['nombre']; ?></div>
  <div class="box-content">
    <div class="box-category">
      <ul>
        <?php
        if( $rs_list['info_cat'] !="" ) {
            foreach ( $rs_list['info_cat'] as $rs ) {
        ?>
         <li><a href="<?php echo $rs['href']; ?>" ><?php echo $rs['name']; ?></a></li>
        <?php
            }
        ?>
        <?php } ?>
      </ul>
    </div>
  </div>
</div>
<?php } ?>
<?php } ?>