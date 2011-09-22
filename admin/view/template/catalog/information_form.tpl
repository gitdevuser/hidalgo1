<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/information.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs">
          <a href="#tab-general"><?php echo $tab_general; ?></a>
          <a href="#tab-data"><?php echo $tab_data; ?></a>
          <?php
          if ( ( $id_info !="" ) && ( $id_info == 3 ) ) {
          ?>    
              <a href="#tab-suc">Mapa / Foto </a>
          <?php } ?>

          <!--<a href="#tab-design"><?php echo $tab_design; ?></a>-->
      </div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <!--<div id="languages" class="htabs">
            <?php foreach ($languages as $language) { ?>
            <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
            <?php } ?>
          </div>-->
          <?php foreach ($languages as $language) { ?>
          <div id="language<?php echo $language['language_id']; ?>">
            <table class="form">
              <tr>
                <td><span class="required">*</span> <?php echo $entry_title; ?></td>
                <td><input type="text" name="information_description[<?php echo $language['language_id']; ?>][title]" size="100" value="<?php echo isset($information_description[$language['language_id']]) ? $information_description[$language['language_id']]['title'] : ''; ?>" />
                  <?php if (isset($error_title[$language['language_id']])) { ?>
                  <span class="error"><?php echo $error_title[$language['language_id']]; ?></span>
                  <?php } ?></td>
              </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_description; ?></td>
                <td><textarea name="information_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>"><?php echo isset($information_description[$language['language_id']]) ? $information_description[$language['language_id']]['description'] : ''; ?></textarea>
                  <?php if (isset($error_description[$language['language_id']])) { ?>
                  <span class="error"><?php echo $error_description[$language['language_id']]; ?></span>
                  <?php } ?></td>
              </tr>
            </table>
          </div>
          <?php } ?>
        </div>
        <div id="tab-data">
          <table class="form">
            <tr style="display:none;">
              <td><?php echo $entry_store; ?></td>
              <td><div class="scrollbox">
                  <?php $class = 'even'; ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array(0, $information_store)) { ?>
                    <input type="checkbox" name="information_store[]" value="0" checked="checked" />
                    <?php echo $text_default; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="information_store[]" value="0" />
                    <?php echo $text_default; ?>
                    <?php } ?>
                  </div>
                  <?php foreach ($stores as $store) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($store['store_id'], $information_store)) { ?>
                    <input type="checkbox" name="information_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                    <?php echo $store['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="information_store[]" value="<?php echo $store['store_id']; ?>" />
                    <?php echo $store['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div></td>
            </tr>
            <tr style="display:none;">
              <td><?php echo $entry_keyword; ?></td>
              <td><input type="text" name="keyword" value="<?php echo $keyword; ?>" /></td>
            </tr>

            <?php if ( ( $id_info !="" ) && ( $id_info != 12 ) ) { ?>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="status">
                  <?php if ($status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr><!--estatus-->
            <?php } ?>

            <?php if ( ( $id_info !="" ) && ( $id_info == 12 ) ) { ?>
            <?php $social = unserialize( $redes ); ?>
            <tr>
              <td>Facebook</td>
              <td><input type="text" name="facebook" value="<?php echo $social[0]; ?>"></td>
            </tr><!--Redes-->
            <tr>
              <td>Twitter</td>
              <td><input type="text" name="twitter" value="<?php echo $social[1]; ?>"></td>
            </tr><!--Redes-->
            <?php } ?>


            <tr style="display:none;">
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="1" /></td>
            </tr>
          </table>
        </div>
        <div id="tab-design" style="display:none;" >
          <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_store; ?></td>
                <td class="left"><?php echo $entry_layout; ?></td>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td class="left"><?php echo $text_default; ?></td>
                <td class="left"><select name="information_layout[0][layout_id]">
                    <option value=""></option>
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if (isset($information_layout[0]) && $information_layout[0] == $layout['layout_id']) { ?>
                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
            </tbody>
            <?php foreach ($stores as $store) { ?>
            <tbody>
              <tr>
                <td class="left"><?php echo $store['name']; ?></td>
                <td class="left"><select name="information_layout[<?php echo $store['store_id']; ?>][layout_id]">
                    <option value=""></option>
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if (isset($information_layout[$store['store_id']]) && $information_layout[$store['store_id']] == $layout['layout_id']) { ?>
                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
            </tbody>
            <?php } ?>
          </table>
        </div>


    <?php if ( ( $id_info !="" ) && ( $id_info == 3 ) ) {
              if ( isset( $sucursales_info ) && ( $sucursales_info !="" ) ) {
                   $suc = unserialize( $sucursales_info );
                   $suc_nom = array( 0 => 'Matriz', 1 => 'Sucursal Galer&iacute;as Coapa', 2 => 'Sucursal Las Flores'  );

    ?>
        <div id="tab-suc" >
          <?php foreach ( $suc as $key=>$rs ) { ?>
          <?php
          $this->load->model('tool/image');
          $img_1 = $this->model_tool_image->resize($rs['foto'], 200, 200);
          ?>
          <table class="list">
              
            <thead>
              <tr>
                <td class="left"><?php echo $suc_nom[$key]; ?></td>
              </tr>
            </thead>
            
            <tbody>
              <tr>
                <td class="left">
                 
                 <table style="border: none;" >
                   <tr>
                     <th>Mapa</th>
                     <th>&nbsp;</th>
                     <th>Foto</th>
                   </tr>
                   <tr>
                     <td>
                       <div class="mapa" ></div>
                     </td>
                     <td>&nbsp;</td>
                     <td valign="top">
               <img onclick="image_upload('image<?php echo $key; ?>', 'preview<?php echo $key; ?>');"
                        class="image<?php echo $key; ?>" id="preview<?php echo $key; ?>"
                        alt="" src="<?php echo $img_1; ?>">
                     </td>
                   </tr>

                   <tr>
                     <td>
                      <input type="hidden" name="long[<?php echo $key; ?>]" value="<?php echo $rs['mapa']['long']; ?>"  />
                      <input type="hidden" name="lat[<?php echo $key; ?>]" value="<?php echo $rs['mapa']['lat']; ?>"  />
                     </td>
                     <td>&nbsp;</td>
                     <td><input type="hidden" id="image<?php echo $key; ?>" name="foto[<?php echo $key; ?>]" value="<?php echo $rs['foto']; ?>" ></td>
                   </tr>
                 </table>

                </td>
              </tr>
            </tbody>

            
          </table>
          <?php } ?>
            
        </div>
        <?php } } ?>


      </form>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
//--></script>
<script type="text/javascript"><!--
function image_upload(field, preview) {
	$('#dialog').remove();

	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

	$('#dialog').dialog({
		title: 'Subir imagen sucursal',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>',
					type: 'POST',
					data: 'image=' + encodeURIComponent($('#' + field).val()),
					dataType: 'text',
					success: function(data) {
						$('#' + preview).replaceWith('<img src="' + data + '" alt="" id="' + preview + '" class="image" onclick="image_upload(\'' + field + '\', \'' + preview + '\');" />');
					}
				});
			}
		},
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script>
<script src="<?php echo GM_API; ?>"
	type="text/javascript"></script>
<script type="text/javascript" src="view/javascript/jquery.googlemaps1.01.js"></script>
<script type="text/javascript"><!--

        var map_a = new GMap2($(".mapa:eq(0)").get(0));
        var burnsvilleMN_a = new GLatLng($( 'input[name="lat[0]"]' ).val(), $( 'input[name="long[0]"]' ).val());
        map_a.setCenter(burnsvilleMN_a, 16);
        map_a.addControl(new GSmallMapControl());
        var Icon = new GIcon(G_DEFAULT_ICON);
        Icon.image = "../catalog/view/theme/default/image/icono.png";
        Icon.iconSize = new GSize(16, 16);
        Icon.shadow = '';
        markerOptions_a = { icon:Icon, draggable:true };
        var point_a = new GLatLng($( 'input[name="lat[0]"]' ).val(), $( 'input[name="long[0]"]' ).val());
        marker_a = new GMarker(point_a, markerOptions_a);
        map_a.addOverlay(marker_a);
       GEvent.addListener(marker_a, "dragend", function() {
         var point2_a = marker_a.getPoint();
         map_a.panTo(point2_a);
         $( 'input[name="lat[0]"]' ).val( point2_a.lat() );
         $( 'input[name="long[0]"]' ).val( point2_a.lng() );
       });


        var map_b = new GMap2($(".mapa:eq(1)").get(0));
        var burnsvilleMN_b = new GLatLng($( 'input[name="lat[1]"]' ).val(), $( 'input[name="long[1]"]' ).val());
        map_b.setCenter(burnsvilleMN_b, 16);
        map_b.addControl(new GSmallMapControl());
        var Icon = new GIcon(G_DEFAULT_ICON);
        Icon.image = "../catalog/view/theme/default/image/icono.png";
        Icon.iconSize = new GSize(16, 16);
        Icon.shadow = '';
        markerOptions_b = { icon:Icon, draggable:true };
        var point_b = new GLatLng($( 'input[name="lat[1]"]' ).val(), $( 'input[name="long[1]"]' ).val());
        marker_b = new GMarker(point_b, markerOptions_b);
        map_b.addOverlay(marker_b);
       GEvent.addListener(marker_b, "dragend", function() {
         var point2_b = marker_b.getPoint();
         map_b.panTo(point2_b);
         $( 'input[name="lat[1]"]' ).val( point2_b.lat() );
         $( 'input[name="long[1]"]' ).val( point2_b.lng() );
       });

        var map_c = new GMap2($(".mapa:eq(2)").get(0));
        var burnsvilleMN_c = new GLatLng($( 'input[name="lat[2]"]' ).val(), $( 'input[name="long[2]"]' ).val());
        map_c.setCenter(burnsvilleMN_c, 16);
        map_c.addControl(new GSmallMapControl());
        var Icon = new GIcon(G_DEFAULT_ICON);
        Icon.image = "../catalog/view/theme/default/image/icono.png";
        Icon.iconSize = new GSize(16, 16);
        Icon.shadow = '';
        markerOptions_c = { icon:Icon, draggable:true };
        var point_c = new GLatLng($( 'input[name="lat[2]"]' ).val(), $( 'input[name="long[2]"]' ).val());
        marker_c = new GMarker(point_c, markerOptions_c);
        map_c.addOverlay(marker_c);
       GEvent.addListener(marker_c, "dragend", function() {
         var point2_c = marker_c.getPoint();
         map_c.panTo(point2_c);
         $( 'input[name="lat[2]"]' ).val( point2_c.lat() );
         $( 'input[name="long[2]"]' ).val( point2_c.lng() );
       });
    

//--></script>
<script type="text/javascript"><!--
$('#tabs a').tabs(); 
$('#languages a').tabs();
//--></script> 
<?php echo $footer; ?>