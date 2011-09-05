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
    <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
    <div class="buttons"><a class="button salvar"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table id="module" class="list" style="width:500px; ">
        <thead>
          <tr>
            <td class="left">Titulo</td>
            <td class="left">Posici&oacute;n</td>
            <td class="left">Visible</td>
            <td colspan="5"></td>
          </tr>
        </thead>
        
            <?php
            $e = 0;
            $y = 0;
            if ( isset( $extraLeft ) ) {
                foreach ( $extraLeft as $rs_md ) {
                $y = $e++;
                $selected = '';
                if ( $rs_md['visible'] ) { $selected = 'checked="checked"'; }
            ?>
            <tbody class="module-info module-row<?php echo $y; ?>">
                <tr><td><input type="text" name="titulo[]" value="<?php echo $rs_md['extra_nom']; ?>"></td>
                <td><input type="text" name="posicion[]" value="<?php echo $rs_md['weight']; ?>"></td>
                <td><input type="checkbox" name="visible[<?php echo $y; ?>]" <?php echo $selected; ?> ></td>
                <td><a class="button" onClick="eliminar(<?php echo $y; ?>);" ><span>Eliminar</span></a></td>
                </tr>
            </tbody>
            <?php
                    
                }
            } 
            ?>
        <tfoot>
          <tr>
            <td colspan="5" class="left" >
                <a class="button" id="anadir-modulo"><span>A&ntilde;adir modulo</span></a>
            </td>
          </tr>
        </tfoot>
      </table>
    </form>
  </div>
</div>
<script type="text/javascript"><!--
$('input[name=\'product\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>',
			type: 'POST',
			dataType: 'json',
			data: 'filter_name=' +  encodeURIComponent(request.term),
			success: function(data) {		
				response($.map(data, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
		
	}, 
	select: function(event, ui) {
		$('#featured-product' + ui.item.value).remove();
		
		$('#featured-product').append('<div id="featured-product' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" value="' + ui.item.value + '" /></div>');

		$('#featured-product div:odd').attr('class', 'odd');
		$('#featured-product div:even').attr('class', 'even');
		
		data = $.map($('#featured-product input'), function(element){
			return $(element).attr('value');
		});
						
		$('input[name=\'featured_product\']').attr('value', data.join());
					
		return false;
	}
});

$('#featured-product div img').live('click', function() {
	$(this).parent().remove();
	
	$('#featured-product div:odd').attr('class', 'odd');
	$('#featured-product div:even').attr('class', 'even');

	data = $.map($('#featured-product input'), function(element){
		return $(element).attr('value');
	});
					
	$('input[name=\'featured_product\']').attr('value', data.join());	
});
//--></script>
<script type="text/javascript"><!--
function eliminar( e ) {
   $( '.module-row'+e ).remove();
}
$(function(){

$( '#anadir-modulo' ).click(function(){
    if ( $( '.module-info' ).length == 0 ) {
      lg = 0;
    } else {
      lg = ( $( '.module-info' ).length++ );
    }
    var row_val = lg;
    html_modulo = '<tbody class="module-info module-row'+row_val+'">\n\
                    <tr><td><input type="text" name="titulo[]" value="" ></td>\n\
                        <td><input type="text" name="posicion[]" value="" ></td>\n\
                        <td><input type="checkbox" name="visible['+row_val+']" ></td>\n\
                        <td><a class="button" onClick="eliminar('+row_val+');" name="'+row_val+'" ><span>Eliminar</span></td>\n\
                        </tr></tbody>';
    $('#module tfoot').before(html_modulo);
   return false;
});

$( '.salvar' ).click(function(){
   var e = new Array();
   var m = 0;
   $( 'input[name="posicion[]"]' ).each(function(){
       var t = $( this ).val();
       if(/^[0-9]+$/.test( t )) {} else {
           m++;
       }
   });
   if ( m == 0 ) {
       $( '#form' ).submit();
   } else {
       alert( 'Campo posicion debe ser numero' );
   }
});
});

//--></script>

<script type="text/javascript"><!--
/*var module_row = <?php echo $module_row; ?>;

function addModule() {	
        
	$('#module tfoot').before(html);
	
	module_row++;
}*/
//--></script> 
<?php echo $footer; ?>