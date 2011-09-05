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
    <?php if ($thumb || $images) { ?>
    
      <?php if ($thumb) { ?>
      <div class="image">
        <div class="zoom" >
          <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="fancybox" rel="fancybox">
           Zoom
          </a>
        </div>
        <div class="clearfix">
          <a href="image/<?php echo $rollover_image; ?>" class="jqzoom" title="" >
            <img src="<?php echo $thumb; ?>" title="">
          </a>
        </div>

      </div>
      <?php } ?>

      <?php  $i = 0; if ($images) {  ?>
      <div class="image-additional">
        <?php foreach ($images as $image) { ?>
        <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="thumb-image" ><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
        <?php } ?>
      </div>
      <?php } ?>
        

    
    <?php } else { ?>
	
      <div class="image">
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
                    <a href="#" class="close-atribute" ></a>
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



        <div id="banner-detail" class="talla-tabla" >
        <table class="attribute">
            <thead>
             <tr>
                <td colspan="2" class="atr-detailProd-title" >
                    <?php echo 'Tabla de Trajes y Sacos';  ?>
                    <a href="#" class="close-atribute talla-tabla" ></a>
                </td>
             </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="2" class="atr-space">
                    <div class="talla-traje-cont">
         <table>
           <tr>
             <th colspan="13"></th>
           </tr>
           <tr>
             <td class="even" >Talla</td>
             <td></td>
             <td>36</td>
             <td>37</td>
             <td>38</td>
             <td>39</td>
             <td>40</td>
             <td>42</td>
             <td>44</td>
             <td>46</td>
             <td>48</td>
             <td>50</td>
             <td>52</td>
           </tr>
           <tr>
             <td colspan="13" class="space" ></td>
           </tr>
           <tr>
             <td class="even" >Largos</td>
             <td>C</td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
             <td></td>
             <td></td>
             <td></td>
             <td></td>
           </tr>
           <tr>
             <td class="even"></td>
             <td>R</td>
             <td></td>
             <td></td>
             <td></td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
           </tr>
           <tr>
             <td class="even"></td>
             <td>L</td>
             <td></td>
             <td></td>
             <td></td>
             <td></td>
             <td></td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
             <td>X</td>
           </tr>
         </table>


                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="atr-space"></td>
            </tr>
            </tbody>
        </table>
        </div>

      <div class="description" >
        <?php /*if ($manufacturer) { ?>
        <span><?php echo $text_manufacturer; ?></span><a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
        <?php }*/ ?>
        <span class="stock" ><?php echo $text_stock; ?><?php echo $stock; ?></span>
        <span class="code"><?php echo $text_model; ?><?php echo $model; ?></span>
        <!--<span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />-->
      </div>
      <div id="product-title" ><?php echo $heading_title; ?></div>
      <div id="desc-product" >
        <div class="desc-title" ><?php echo $tab_description; ?></div>
        <?php echo $description; ?>
      </div>


      <a href="#" class="detail-product-link" ><?php echo $produc_detail_link; ?></a>

      <?php if ($attribute_groups) { ?>
      <?php } ?><!-- Detalle del producto -->


      <div class="product-color">

	<?php  ?>
         <?php echo $text_color; ?>
          <ul>
          <?php
          if ( $color ) {
               $colorProd = unserialize($color);
               $i = 0;
                foreach( $colorProd as $color_var ) {
                    echo '<li class="choose-color" name="'.$color_var.'" style="background:#'.$color_var.';" ></li>';
                }
         }

         if (  ){
             
         }

         ?>
         </ul>
      </div>

      

      <?php if ( $talla ) { ?>
      <div id="talla">
        <?php echo $text_talla; ?>
        <ul>
        <?php
          $tallas = unserialize($talla);
          $i = 0;
          foreach( $tallas as $talla ) {
              $even = '';
              if( ( $i++%2 ) == 1 ) { $even = 'even'; }
              echo '<li class="medida-talla '.$even.'" name="'.$talla.'" >'.$talla.'</li>';
          }
        ?>
        </ul>
        <a href="<?php echo $link_sizechart; ?>"><?php echo $text_comosaver; ?></a>
      </div>
      <?php } ?>

      <?php if ( $subtalla ) {  ?>
      <div id="talla">
        <?php echo $text_subtalla; ?>
        <ul>
        <?php
          $subtallas = unserialize($subtalla);
          $i = 0;
          foreach( $subtallas as $subtalla ) {
              $even = '';
              if( ( $i++%2 ) == 1 ) { $even = 'even'; }
              echo '<li class="medida-subs '.$even.'" name="'.$subtalla.'" >'.$subtalla.'</li>';
          }
        ?>
        </ul>
        <a href="#" class="btn-tablatallas"><?php echo $text_tablatallas; ?></a>
      </div>
      <?php } ?>


      <?php /*if ($options) { ?>
      <div class="options">
        <h2><?php echo $text_option; ?></h2>
        <br />
        <?php foreach ($options as $option) { ?>
        <?php if ($option['type'] == 'select') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <select name="option[<?php echo $option['product_option_id']; ?>]">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($option['option_value'] as $option_value) { ?>
            <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
            </option>
            <?php } ?>
          </select>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'radio') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <?php foreach ($option['option_value'] as $option_value) { ?>
          <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
          </label>
          <br />
          <?php } ?>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'checkbox') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <?php foreach ($option['option_value'] as $option_value) { ?>
          <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"> <?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
          </label>
          <br />
          <?php } ?>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'text') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'textarea') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'file') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <a id="button-option-<?php echo $option['product_option_id']; ?>" class="button"><span><?php echo $button_upload; ?></span></a>
          <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'date') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'datetime') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'time') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
        </div>
        <br />
        <?php } ?>
        <?php } ?>
      </div>
      <?php }*/ ?><!-- Options -->


      <div class="cart">

        <div class="buy-container">
          <span class="buy" ><?php echo $text_qty; ?></span>
		  <input type="text" name="talla" value="" />
		  <input type="hidden" name="subtalla" value="" />
		  <input type="hidden" name="color" value="" />
          <input type="hidden" name="quantity" size="2" value="<?php echo $minimum; ?>" />
          <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
        </div>
        <div id="price-cart-content">
            <div id="price-cart">
                <?php if ($price) { ?>
                    <?php if (!$special) { ?>
                    <?php echo $price; ?>
                    <?php } else { ?>
                    <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
                    <?php } ?>
                <?php } ?>
            </div>
            <a id="button-cart" class="button"></a>
        </div>

        <?php if ($minimum > 1) { ?>
        <div class="minimum"><?php echo $text_minimum; ?></div>
        <?php } ?>
        
      </div><!-- Cart -->

      <?php /*if ($price) { ?>
      <div class="price">
        <?php if (!$special) { ?>
        <?php echo $price; ?>
        <?php } else { ?>
        <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
        <?php } ?>
        <br />
        <?php if ($tax) { ?>
        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
        <?php } ?>
        <?php if ($points) { ?>
        <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span> <br />
        <?php } ?>

        <?php if ($discounts) { ?>
        <br />
        <div class="discount">
          <?php foreach ($discounts as $discount) { ?>
          <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
          <?php } ?>
        </div>
        <?php } ?>
      </div>
      <?php } */ ?><!-- Price -->



      <?php /*if ($review_status) { ?>
      <div class="review">
        <div><img src="catalog/view/theme/default/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a></div>
        <div class="share"><!-- AddThis Button BEGIN -->
          <div class="addthis_default_style"><a class="addthis_button_compact"><?php echo $text_share; ?></a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a></div>
          <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js"></script> 
          <!-- AddThis Button END --> 
        </div>
      </div>
      <?php }*/ ?>
    </div>
  </div>
  <!--<div id="tabs" class="htabs"><a href="#tab-description"><?php echo $tab_description; ?></a>
    <?php if ($attribute_groups) { ?>
    <a href="#tab-attribute"><?php echo $tab_attribute; ?>d</a>
    <?php } ?>
    <?php if ($review_status) { ?>
    <a href="#tab-review"><?php echo $tab_review; ?></a>
    <?php } ?>
    <?php if ($products) { ?>
    <a href="#tab-related"><?php echo $tab_related; ?> (<?php echo count($products); ?>)</a>
    <?php } ?>
  </div>-->
  <!--<div id="tab-description" class="tab-content"><?php echo $description; ?></div>-->
  <?php if ($attribute_groups) { ?>
  <!--<div id="tab-attribute" class="tab-content">
    <table class="attribute">
      <?php foreach ($attribute_groups as $attribute_group) { ?>
      <thead>
        <tr>
          <td colspan="2"><?php echo $attribute_group['name']; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
        <tr>
          <td><?php echo $attribute['name']; ?></td>
          <td><?php echo $attribute['text']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      <?php } ?>
    </table>
  </div>-->
  <?php } ?>
  <?php if ($review_status) { ?>
  <!--<div id="tab-review" class="tab-content">
    <div id="review"></div>
    <h2 id="review-title"><?php echo $text_write; ?></h2>
    <b><?php echo $entry_name; ?></b><br />
    <input type="text" name="name" value="" />
    <br />
    <br />
    <b><?php echo $entry_review; ?></b>
    <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
    <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
    <br />
    <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
    <input type="radio" name="rating" value="1" />
    &nbsp;
    <input type="radio" name="rating" value="2" />
    &nbsp;
    <input type="radio" name="rating" value="3" />
    &nbsp;
    <input type="radio" name="rating" value="4" />
    &nbsp;
    <input type="radio" name="rating" value="5" />
    &nbsp; <span><?php echo $entry_good; ?></span><br />
    <br />
    <b><?php echo $entry_captcha; ?></b><br />
    <input type="text" name="captcha" value="" />
    <br />
    <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
    <br />
    <div class="buttons">
      <div class="right"><a id="button-review" class="button"><span><?php echo $button_continue; ?></span></a></div>
    </div>
  </div>-->
  <?php } ?>
  <?php if ($products) { ?>
  <div id="tab-related" class="tab-content">
    <div id="related-product-title" ><?php echo $related_title;  ?></div>
    <div class="box-product">
      <?php foreach ($products as $product) { ?>
      <div>
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
        <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><span><?php echo $button_cart; ?></span></a></div>
      <?php } ?>
    </div>
  </div>
  <?php } ?>
  <?php /*if ($tags) { ?>
  <div class="tags"><b><?php echo $text_tags; ?></b>
    <?php foreach ($tags as $tag) { ?>
    <a href="<?php echo $tag['href']; ?>"><?php echo $tag['tag']; ?></a>,
    <?php } ?>
  </div>
  <?php }*/ ?>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript">
$('.fancybox').fancybox({cyclic: false,
                         overlayOpacity: 0.3,
                         overlayColor: '#000',
                         width:'500',
                         height:'750',
                         onStart:function(){
                            $( '#fancybox-content' ).width( '500px' ).height( '750px' );
                         },
                         onComplete:function(){
                             $( '#fancybox-right, #fancybox-left' ).hide();
                             $( '#fancybox-content' ).width( '500px' ).height( '750px' );
                             $( '#fancybox-title' ).css({ 'left': '25px' });
                         }
                        });
</script>
<script type="text/javascript"><!--
$('#button-cart').bind('click', function() {
	
	$.ajax({
		url: 'index.php?route=checkout/cart/update',
		type: 'post',
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea, input[name="color"], input[name="talla"], input[name="subtalla"]'),
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
				$('#notification').html('<div class="attention" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
				$('.attention').fadeIn('slow');
					
				$('#cart_total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
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