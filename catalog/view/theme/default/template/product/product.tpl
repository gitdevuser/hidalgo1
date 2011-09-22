<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<script src="catalog/view/javascript/jqzoom_ev-2.3/js/jquery.jqzoom-core.js" type="text/javascript"></script>
<link rel="stylesheet" href="catalog/view/javascript/jqzoom_ev-2.3/css/jquery.jqzoom.css" type="text/css">
<script src="catalog/view/javascript/product.js" type="text/javascript"></script>
<div id="content">
<div class="top-shadow" >&nbsp;</div>
<?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>

  <div class="product-info">

    <div class="left">

    <div id="no-disponible" >
      <span>No disponible</span>
    </div>

    <?php if ( count( $Arrimagen ) > 0 ) { ?>

      <?php if ( count( $Arrimagen ) > 0 ) { ?>
      <?php foreach( $Arrimagen as $img_val ) { ?>
      <?php
      if ( $img_val['imagen_princ'] =="" ) { $img_val['imagen_princ'] = 'catalog/view/theme/default/image/sin.jpg'; }
      $jZoom = 'onClick="return false;" class="no-jzoom" ';
      $jRollOver = '#';
      if ( $img_val['image_rollover'] !="" ){ $jZoom = 'class="jqzoom"'; $jRollOver = 'image/'.$img_val['image_rollover']; }
      ?>

      <div class="image" name="<?php echo $img_val['nombre']; ?>" >
        <div class="zoom" >
          <?php if ( $img_val['imagen_zoom'] !="" ) { ?>
          <a href="<?php echo $img_val['imagen_zoom']; ?>" title="<?php echo $heading_title; ?>" class="fancybox" rel="fancybox">
           Zoom
          </a>
          <?php } ?>
        </div>

        <div class="clearfix">
          <a href="<?php echo $jRollOver; ?>" <?php echo $jZoom; ?> title="" >
            <img src="<?php echo $img_val['imagen_princ']; ?>" title="" class="imagen_princ" >
          </a>
        </div>
      </div>
      <?php } ?>
      <?php } ?>
      <?php
      $x1 = 0;
      if ( $imagen_estilo ) {
           $arrImgEst = unserialize( $imagen_estilo );
           $popup_adt = '';
           $thumb_adt = '';
           foreach ( $arrImgEst as $rs_imgEst ) {
 
           //Popup
           $popup_adt = $this->model_tool_image->resize($rs_imgEst['img_nom'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
           //Thumb
           $thumb_adt = $this->model_tool_image->resize($rs_imgEst['img_nom'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'));

      ?>
      <div class="image estilo-img thumb-image<?php  echo $x1++; ?>" >
        <div class="zoom" >
          <a href="<?php echo $popup_adt; ?>" title="<?php echo $heading_title; ?>" class="fancybox" rel="fancybox">
           Zoom
          </a>
        </div>

        <div class="clearfix">
          <a href="image/<?php echo $rs_imgEst['img_nom']; ?>" class="jqzoom" title="" >
            <img src="<?php echo $popup_adt; ?>" title="" class="imagen_princ" >
          </a>
        </div>
      </div>
      <?php
           }

      }

      ?>

      <div class="image-additional">
      <?php
      //Imagenes adicionales
      if ( $imagen_estilo ) {
      $arrImgEst = unserialize( $imagen_estilo );
      $popup_adt = '';
      $thumb_adt = '';
      foreach ( $arrImgEst as $rs_imgEst ) {
         if ( $rs_imgEst['img_nom'] !=""  )  {
       //Popup
	$popup_adt = $this->model_tool_image->resize($rs_imgEst['img_nom'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
       //Thumb
	$thumb_adt = $this->model_tool_image->resize($rs_imgEst['img_nom'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'));
        echo '<a href="'.$popup_adt.'" class="thumb-image" ><img src="'.$thumb_adt.'" /></a>';
         }
      ?>
      <?php
      } } 
      ?>
      </div>
    
    <?php } else { ?>
        
      <div class="image" style="display:block;" >
        <div class="zoom" ></div>
        <img src="catalog/view/theme/default/image/sin.jpg" title="">
      </div>
	
    <?php } ?>
	
	</div>
	
    <div class="right" >

        
        <div id="banner-detail" >
        <table class="attribute">
            <thead>
             <tr>
                <td colspan="2" class="atr-detailProd-title" >
                    Detalle de producto
                    <img src="catalog/view/theme/default/image/close-atribute.png" class="close-atribute" >
                </td>
             </tr>
            </thead>

            <thead>
             <tr>
                <td colspan="2">Composici&oacute;n</td>
             </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="2" class="atr-space"></td>
            </tr>
            <tr>
                <td class="atr-name" >
                Composici&oacute;n :&nbsp; <?php  echo $composicion;  ?>
                </td>
            </tr>
            <tr>
                <td class="atr-name" >
                Cuidado :&nbsp; <?php echo $cuidado;  ?>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="atr-space"></td>
            </tr>
            </tbody><!-- Composicion y cuidado -->

            <?php if ( $caract ) { ?>
            <thead>
             <tr>
                <td colspan="2">Descripci&oacute;n General</td>
             </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="2" class="atr-space"></td>
            </tr>
            <?php
            $caractInfo = unserialize($caract);
            $i = 0;
            foreach( $caractInfo as $caract_item ) {
                echo '<tr><td class="atr-name" >'.$caract_item.'</td></tr>';
            }
            ?>
            <?php } ?>

            <tr>
                <td colspan="2" class="atr-space"></td>
            </tr>
            </tbody><!-- Descripcion General -->
            <?php if ( $corte ) { ?>
            <thead>
             <tr>
                <td colspan="2">Tipo de corte</td>
             </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="2" class="atr-space"></td>
            </tr>
            <tr>
                <td class="atr-name" >
                <?php echo $corte; ?>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="atr-space"></td>
            </tr>
            </tbody>
            <?php } ?><!-- Tipo de corte -->

        </table>
        </div><!-- Detalle del producto -->

        <?php include( '_tallatabla.tpl' );  ?>


      <div class="description" >
        <span class="stock" >Hay en existencia</span>
        <span class="code"><?php echo $text_model; ?><?php echo $model; ?></span>
      </div>
      <div id="product-title" ><?php echo $heading_title; ?></div>
      <div id="desc-product" >
        <div class="desc-title" >Descripci&oacute;n</div>
        <?php if ( (isset($desc1)) && ($desc1 !="") ) { echo $desc1; } ?>
      </div>
      <a href="#" class="detail-product-link" ><?php echo $produc_detail_link; ?></a>
      
      <!-- Detalle del producto -->

      <div class="product-color">
         <?php echo $text_color; ?>
         <?php
            if ( count( $ArrnomColor ) > 0 ) {
               $i = 0;
                foreach ( $ArrnomColor as $ncolor_val  ) {
                $slc = "";
                if( $i++ == 0 ) {
                   $slc = "selected";
                }
                    echo '<span class="color-text '.$slc.'"
                        name="'.$ncolor_val['c_nombre'].'" >'.$ncolor_val['c_nombre'].'</span>';
                }
            }
         ?>
         <ul>
          <?php
          if ( count( $ArrnomColor ) > 0 ) {
             $i = 0;

             foreach ( $ArrnomColor as $colorItem ) {
               $slc = "";
               if( $i++ == 0 ) {
                   $slc = "selected";
               }
               echo '<li style="background: #fff url('.$colorItem['c_textura'].');" name="'.$colorItem['c_nombre'].'"
                   class="choose-color '.$slc.'">
                    <span id="hoverColor-container" >
                      <span class="hover-color" style="background: #fff url('.$colorItem['c_textura'].');"  ></span>
                      </span>
                    </span>
                    </li>';
             }
          }
          ?>
        </ul>
      </div>
      

      <?php if ( $ArrTallas ) {  ?>
      <div id="talla">
        <?php echo $text_talla; ?>
        <ul>
        <?php
        foreach ( $ArrTallas as $talla_val ) {
            echo '<li class="medida-talla "
                        name="'.$talla_val['talla_id'].'" >'.$talla_val['talla_nombre'].'</li>';
        }
        ?>
        </ul>
        <a href="<?php echo $link_sizechart; ?>"><?php echo $text_comosaver; ?></a>
      </div>
      <?php } ?>

      <?php if ( $ArrSubTallas ) { ?>
      <div id="talla">
        <?php echo $text_subtalla; ?>
        <ul>
        <?php
        foreach ( $ArrSubTallas as $subtalla_val ) {
            echo '<li class="medida-subs"
                      name="'.$subtalla_val['talla_id'].'" >'.$subtalla_val['talla_nombre'].'</li>';
        }
        ?>
        </ul>
        <a href="#" class="btn-tablatallas"><?php echo $text_tablatallas; ?></a>
      </div>
      <?php } ?>

      <div class="cart">

        <div class="buy-container">
          <span class="buy" ><?php echo $text_qty; ?></span>
          <input type="text" name="quantity" size="2" value="1" />
          <p>
          <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
          <p>
          <input type="hidden" name="btn-incio" value="" />
          <input type="hidden" name=precio_cat" class="precio_cat"  value="<?php echo $price; ?>" />
        </div>
        <div id="price-cart-content">
            <div id="price-cart">
                <?php if ($price) { ?>
                    <?php echo $price; ?>
                <?php } ?>
            </div>
            <a id="button-cart" class="button"></a>
            <a id="no-stock" class="button"> Producto no disponible </a>
        </div>

      </div><!-- Cart -->

    </div>
  </div>

  <?php
  if (isset( $product_related ) && ( count($product_related) > 0 ) ) { ?>

  <div id="tab-related" class="tab-content">
    <div id="related-product-title" ><?php echo $related_title;  ?></div>
    <div class="box-product">
      <?php foreach ($product_related as $product) { ?>
      <div>
        <?php if ($product['thumb']) { ?>
            <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } else { ?>
            <div class="image"><a href="<?php echo $product['href']; ?>"><img src="catalog/view/theme/default/image/sin.jpg" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        </div>
      <?php } ?>
    </div>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript">
    window.ProdbyCat = new Array();
    <?php echo $Jscript; ?>
</script>
<script type="text/javascript">
$('.fancybox').fancybox({cyclic: false,
                         overlayOpacity: 0.3,
                         overlayColor: '#000',
                         width:'500',
                         height:'750',
                         onStart:function(){
                            $( '#fancybox-content' ).width( '500px' ).height( '750px' );
                         },autoDimensions: false,
                         onComplete:function(){
                             $( '#fancybox-right, #fancybox-left' ).hide();
                             $( '#fancybox-content' ).width( '500px' ).height( '750px' );
                             $( '#fancybox-title' ).css({ 'left': '25px' });
                         },
                    'transitionIn'      : 'elastic',
                    'transitionOut'     : 'elastic'

                        });
</script>
<script type="text/javascript"><!--
$('#button-cart').bind('click', function() {
        
        if( $( '.medida-talla' ).length > 0 ) {

            if ( $( '.medida-talla' ).hasClass( 'selected' ) ) {

            //Definir el id del producto
            var def_color = $( '.choose-color.selected' ).attr( 'name' );
            var def_talla = $( '.medida-talla.selected' ).attr( 'name' );
            var def_subtalla = '';
            var def_e = 0;
            var def_id_prod = '';

            if ( $( '.medida-subs' ).hasClass( 'selected' ) ) {
                def_subtalla = $( '.medida-subs.selected' ).attr( 'name' );
            }

            for(var x in ProdbyCat) {

                if (  ( ProdbyCat[x]['nombre'] == def_color ) && ( ProdbyCat[x]['talla'] == def_talla ) && ( ProdbyCat[x]['subtalla'] == def_subtalla )  ) {
                        def_id_prod = ProdbyCat[x]['product_id'];
                }

             }

             $( 'input[name="product_id"]' ).val( def_id_prod );

	$.ajax({
		url: 'index.php?route=checkout/cart/update',
		type: 'post',
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();

			if (json['error']) {
				if (json['error']['warning']) {
					$('#notification').html('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

					$('.warning').fadeIn('slow');
				}

				for (i in json['error']) {
					$('#option-' + i).after('<span class="error">' + json['error'][i] + '</span>');
				}
			}

			if (json['success']) {
				$('#notification').html('<div class="attention" style="display: block;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				$('.attention').fadeIn('slow');
				$('#cart_total').html(json['total']);
				$('html, body').animate({ scrollTop: 0 }, 'slow');
                                setTimeout(function() {
                                    $('.attention').fadeOut( 500 );
                                }, 2500);
                                clearTimeout();

			}
                        

		}
	});


            } else {
                alert( 'Seleccione una talla' );
            }
        }

});
//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
	action: 'index.php?route=product/product/upload',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" id="loading" style="padding-left: 5px;" />');
	},
	onComplete: function(file, json) {
		$('.error').remove();
		
		if (json.success) {
			alert(json.success);
			
			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json.file);
		}
		
		if (json.error) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json.error + '</span>');
		}
		
		$('#loading').remove();	
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').slideUp('slow');
		
	$('#review').load(this.href);
	
	$('#review').slideDown('slow');
	
	return false;
});			

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
	$.ajax({
		type: 'POST',
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data.error) {
				$('#review-title').after('<div class="warning">' + data.error + '</div>');
			}
			
			if (data.success) {
				$('#review-title').after('<div class="success">' + data.success + '</div>');
								
				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
if ($.browser.msie && $.browser.version == 6) {
	$('.date, .datetime, .time').bgIframe();
}
$('.date').datepicker({dateFormat: 'yy-mm-dd'});
$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'h:m'
});
$('.time').timepicker({timeFormat: 'h:m'});
//--></script> 
<?php echo $footer; ?>