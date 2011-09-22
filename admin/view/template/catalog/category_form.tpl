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
      <h1><img src="view/image/category.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons" id="salvar"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs">
          <a href="#tab-general"><?php echo $tab_general; ?></a>
          <a href="#tab-data"><?php echo $tab_data; ?></a>
          <!--<a href="#tab-design"><?php echo $tab_design; ?></a>-->
          <?php if ( $parent_id != 0 ) {  ?>
          <a href="#tab-detalle">Detalle del Producto</a>
          <a href="#tab-precio">Precio</a>
          <a href="#tab-img">Imagenes</a>
          <?php } ?>
          <?php if ( $parent_id == 0 ) { } ?>
          <a href="#tab-col-izq">Columna Izquierda</a>
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
                <td><span class="required">*</span> <?php echo $entry_name; ?></td>
                <td><input class="nombre-cat" type="text" name="category_description[<?php echo $language['language_id']; ?>][name]" size="100" value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['name'] : ''; ?>" />
                  <?php if (isset($error_name[$language['language_id']])) { ?>
                  <span class="error"><?php echo $error_name[$language['language_id']]; ?></span>
                  <?php } ?></td>
              </tr>
              <tr style="display:none;">
                <td><?php echo $entry_meta_description; ?></td>
                <td><textarea name="category_description[<?php echo $language['language_id']; ?>][meta_description]" cols="40" rows="5"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_description'] : ''; ?></textarea></td>
              </tr>
              <tr style="display:none;">
                <td><?php echo $entry_meta_keyword; ?></td>
                <td><textarea name="category_description[<?php echo $language['language_id']; ?>][meta_keyword]" cols="40" rows="5"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea></td>
              </tr>
              <tr>
                <td><?php echo $entry_description; ?></td>
                <td><textarea name="category_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>"><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['description'] : ''; ?></textarea></td>
              </tr>
            </table>
          </div>
          <?php } ?>
        </div>
        <div id="tab-data">
          <table class="form">
            <tr>
              <td><?php echo $entry_parent; ?></td>
              <td><select name="parent_id">
                  <option value="0"><?php echo $text_none; ?></option>
                  <?php foreach ($categories as $category) { ?>
                  <?php if ($category['category_id'] == $parent_id) { ?>
                  <option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr style="display: none;">
              <td><?php echo $entry_store; ?></td>
              <td><div class="scrollbox">
                  <?php $class = 'even'; ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array(0, $category_store)) { ?>
                    <input type="checkbox" name="category_store[]" value="0" checked="checked" />
                    <?php echo $text_default; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="category_store[]" value="0" />
                    <?php echo $text_default; ?>
                    <?php } ?>
                  </div>
                  <?php foreach ($stores as $store) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($store['store_id'], $category_store)) { ?>
                    <input type="checkbox" name="category_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                    <?php echo $store['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="category_store[]" value="<?php echo $store['store_id']; ?>" />
                    <?php echo $store['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div></td>
            </tr>
            <tr style="display: none;">
              <td><?php echo $entry_keyword; ?></td>
              <td><input type="hidden" name="keyword" value="<?php echo $keyword; ?>" /></td>
            </tr>
            <?php if ($parent_id == 0 ) { ?>
            <tr>
              <td><?php echo $entry_image; ?></td>
              <td valign="top"><input type="hidden" name="image" value="<?php echo $image; ?>" id="image" />
                <img src="<?php echo $preview; ?>" alt="" id="preview" class="image" onclick="image_upload('image', 'preview');" /></td>
            </tr>
            <?php } ?>
            <tr style="display: none;">
              <td><?php echo $entry_top; ?></td>
              <td><?php if ($top) { ?>
                <input type="checkbox" name="top" value="1" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="top" value="1" />
                <?php } ?></td>
            </tr>
            <tr style="display: none;">
              <td><?php echo $entry_column; ?></td>
              <td><input type="text" name="column" value="<?php echo $column; ?>" size="1" /></td>
            </tr>
            <tr style="display: none;">
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="1" /></td>
            </tr>
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
            </tr>

            <?php if ( $parent_id !=0 ) {  ?>
            <tr>
              <td valign="top">Productos relacionados</td>
              <td valign="top">
                  <div>
                   <input type="text" name="related" >
                  </div>
                  <br>
                  <div id="product-related" class="scrollbox">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($product_related as $product_related) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div id="product-related<?php echo $product_related['related_id']; ?>" class="<?php echo $class; ?>"> <?php echo $product_related['name']; ?><img src="view/image/delete.png" />
                    <input type="hidden" name="product_related[]" value="<?php echo $product_related['related_id']; ?>" />
                  </div>
                  <?php } ?>
                  </div>
              </td>
            </tr>
            <?php } ?>


          </table>
        </div>

          
        <div id="tab-design" style="display: none;" >
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
                <td class="left"><select name="category_layout[0][layout_id]">
                    <option value=""></option>
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if (isset($category_layout[0]) && $category_layout[0] == $layout['layout_id']) { ?>
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
                <td class="left"><select name="category_layout[<?php echo $store['store_id']; ?>][layout_id]">
                    <option value=""></option>
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if (isset($category_layout[$store['store_id']]) && $category_layout[$store['store_id']] == $layout['layout_id']) { ?>
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

        <?php if ( $parent_id !=0 ) {  ?>
        <div id="tab-detalle" >

          <table class="list">
            <thead>
              <tr>
                <td class="left">Composici&oacute;n</td>
              </tr>
            </thead>
            
            <tbody>
              <tr>
                <td class="left">
                  <table>
                    <tr>
                     <td>Composici&oacute;n</td>
                     <td>
                       <input type="text" name="composicion" value="<?php if(isset($composicion)){echo $composicion;} ?>" />
                     </td>
                    </tr>
                    <tr>
                     <td>Cuidado</td>
                     <td>
                       <input type="text" name="cuidado" value="<?php if(isset($cuid)){ echo $cuid; } ?>" />
                     </td>
                    </tr>
                  </table>
                </td>
              </tr>
           </tbody>
          </table><!-- Composicion y cuidado -->

          <table class="list">
            <thead>
              <tr>
                <td class="left">Corte</td>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td class="left">
                  <table>
                    <tr>
                     <td>Corte</td>
                     <td>
                       <textarea name="corte" ><?php if(isset($corte)){echo $corte;} ?></textarea>
                     </td>
                    </tr>
                  </table>
                </td>
              </tr>
           </tbody>
          </table><!-- Corte -->

          <table class="list">
            <thead>
              <tr>
                <td class="left">Descripci&oacute;n General</td>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td class="left">
                  <div id="caract" >
                    <?php
                    if( $caract ) {
                        $descGen = unserialize( $caract );
                        foreach ( $descGen as $desc_var ) {
                           echo '<input value="'.$desc_var.'" name="caract[]"><p>';
                        }
                    }
                    ?>
                    <a href="#" class="anadir_caract" >A&ntilde;adir caracter&iacute;stica</a>
                  </div>
                </td>
              </tr>
           </tbody>
          </table><!-- Corte -->

        </div>
       <?php } ?>

        <?php if ( $parent_id !=0 ) {  ?>
        <div id="tab-precio" >

          <table class="list">
            <thead>
              <tr>
                <td class="left">Precio</td>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td class="left"><input type="text" name="precio" value="<?php echo $precio; ?>"  ></td>
              </tr>
           </tbody>
          </table><!-- Precio -->

          <table class="list">
            <thead>
              <tr>
                <td class="left">Descuento</td>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td class="left"><input type="text" name="descuento" value="<?php echo $descuento; ?>" >%</td>
              </tr>
           </tbody>
          </table><!-- Precio -->

        </div><!--Precio-->
        <?php } ?>

        <?php if ( $parent_id !=0 ) {  ?>
        <div id="tab-img" >
          <table class="list" id="imagen01" style="width:800px;" >
            <thead>
              <tr>
                <td class="left" >Imagen</td>
                <td class="left" >Principal</td>
                <td class="left" colspan="2" ></td>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td class="left" colspan="4"></td>
              </tr>
           </tbody>


            <?php
            $e = 0;
            $y = 0;
            if ( $imagen_estilo ) {
            foreach ( unserialize( $imagen_estilo ) as $rs1 ) {
                    $y = $e++;
                    $resize_img = $this->model_tool_image->resize($rs1['img_nom'], 100, 100);
            ?>
            <tbody class="imagen-estilo<?php echo $y; ?>" >
                <tr>
                    <td>
               <img onclick="image_upload('image<?php echo $y; ?>', 'preview<?php echo $y; ?>');" 
                        class="image<?php echo $y; ?>" id="preview<?php echo $y; ?>"
                        alt="" src="<?php echo $resize_img; ?>">

               <input type="hidden" id="image<?php echo $y; ?>"
                              value="<?php echo $rs1['img_nom']; ?>" name="image_cat[]">
              </td>

              <td>
                <input type="radio" name="principal[]" value="<?php echo $y; ?>" <?php if ( $rs1['selected'] ) { echo "CHECKED"; } ?> >
              </td>

              <td>
               <a href="#" class="button eliminar-imagen<?php echo $y; ?>" onClick="eliminarImagen(<?php echo $y; ?>); return false;" >
                 <span>Eliminar Imagen</span>
               </a>
              </td>

              <td></td>
              
             </tr>
            </tbody>
            <?php } } ?>

            <tfoot>
              <tr>
                <td></td>
                <td></td>
                <td></td>
                <td class="left">
                    <a href="#" class="button anadir_imagen" >
                   <span>A&ntilde;adir Imagen</span>
                  </a>
                </td>
              </tr>
            </tfoot>

          </table><!-- imagenes -->
        </div>
        <?php } ?>


        <?php if ( $parent_id == 0 ) {  ?>
        <?php } ?>
        <div id="tab-col-izq" >
          <table class="list" >
            <thead>
              <tr>
                <td class="left" >Columna Izquierda</td>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td class="left">
                  <div class="scrollbox">
                  <table width="200">
                   <?php
                   $x2 = 0;
                   $color="";
                   if ( isset( $left_extra_module ) && ( $left_extra_module !="" ) ) {
                     foreach ( $left_extra_module as $rs_lem ) {
                     if( $x2++%2 == 1 ) { $color="#E4EEF7"; }else { $color="#fff"; }
                     $check = '';
                     if( isset( $extra_1 ) && ( $extra_1 !="" ) ) {
                         foreach ( $extra_1 as $rs_ex ) {
                           if ( $rs_ex == $rs_lem['extra_left_id'] ) { $check = 'checked="checked"'; }
                         }
                     }
                   ?>
                    <tr>
                      <td style="background: <?php echo $color; ?>;">
                       <input type="checkbox" name="colizq[]" <?php echo $check; ?> value="<?php echo $rs_lem['extra_left_id']; ?>" ><br>
                      </td>
                      <td style="background: <?php echo $color; ?>;">
                        <?php echo $rs_lem['extra_nom']; ?>
                      </td>
                    </tr>
                   <?php } } ?>
                   </table>
                   </div>
                </td>
              </tr>
           </tbody>

          </table><!-- left extra module -->
        </div>
        





      </form>
    </div>
  </div>
</div>


<script type="text/javascript"><!--
$('input[name=\'related\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/category/autocompleto&token=<?php echo $token; ?>',
			type: 'POST',
			dataType: 'json',
			data: 'filter_name=' +  encodeURIComponent(request.term),
			success: function(data) {
				response($.map(data, function(item) {
					return {
						label: item.name,
						value: item.category_id
					}
				}));
			}
		});

	},
	select: function(event, ui) {
		$('#product-related' + ui.item.value).remove();

		$('#product-related').append('<div id="product-related' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="product_related[]" value="' + ui.item.value + '" /></div>');

		$('#product-related div:odd').attr('class', 'odd');
		$('#product-related div:even').attr('class', 'even');

		return false;
	}
});

$('#product-related div img').live('click', function() {
	$(this).parent().remove();

	$('#product-related div:odd').attr('class', 'odd');
	$('#product-related div:even').attr('class', 'even');
});
//--></script>
<script type="text/javascript"><!--
var row_val = <?php echo $y+1; ?>;
$( '.anadir_imagen' ).click(function(){
    img1 = '<tbody class="imagen-estilo'+row_val+'" ><tr><td>\n\
               <img src="<?php echo $preview; ?>" alt="" id="preview'+row_val+'" class="image'+row_val+'" onclick="image_upload(\'image'+row_val+'\', \'preview'+row_val+'\');" />\n\
              <input type="hidden" name="image_cat[]" value="" id="image' + row_val + '" /></td>\n\
              <td><input type="radio" name="principal[]"></td>\n\
              <td><a href="#" class="button eliminar-imagen" onClick="eliminarImagen('+row_val+'); return false;" ><span>Eliminar Imagen</span></a></td>\n\
              <td></td></tr></tbody>';
      $('#imagen01 tfoot').before(img1);
   row_val++;
   return false;
});

function eliminarImagen( value ) {
    $( '.imagen-estilo'+value ).remove();
}

//--></script> 
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
<script type="text/javascript">
$(function(){
    $( '.anadir_caract' ).click(function(){
       html_var = '<input name="caract[]" value="" ><p>';
       $( this ).before( html_var );
       return false;
    });
    $( '.nombre-cat' ).change(function(){
        $( 'input=[name="keyword"]' ).val( $( this ).val() );
    });
    $( '#salvar' ).click(function(){
        $( 'input=[name="keyword"]' ).val( $( '.nombre-cat' ).val() );
        return false;
    });

});
</script>
<script type="text/javascript"><!--
function image_upload(field, preview) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
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
<script type="text/javascript"><!--
$('#tabs a').tabs(); 
$('#languages a').tabs();
//--></script> 
<?php echo $footer; ?>