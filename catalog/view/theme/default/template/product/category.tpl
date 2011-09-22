<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
<div class="top-shadow" >&nbsp;</div>
<?php echo $content_top; ?>

  <div id="list-header" style="background: url(<?php echo $thumb; ?>) no-repeat;" ><?php echo $heading_title; ?></div>

  <?php if ($categories) { ?>
  <div class="category-list" style="display: block;" ><!-- !Important, subategorias de Categoria-->

<div class="product-list">
   <?php foreach ($categories as $category) {  ?>
   
    <div>
      <?php if ( $category['descuento'] ) { ?>
       <div class="descuentos" name="<?php echo $category['href']; ?>" >-<?php echo $category['descuento']; ?>%</div>
      <?php } ?>
       
      <div class="image">
        <?php if ( $category['imagen'] ) { ?>
          <a href="<?php echo $category['href']; ?>"><img src="<?php echo $category['imagen']; ?>" title="<?php echo $category['name']; ?>" alt="<?php echo $category['name']; ?>" /></a>
        <?php } else { ?>
          <a href="<?php echo $category['href']; ?>"><img src="catalog/view/theme/default/image/sin.jpg" title="#" alt="#" /></a>
        <?php } ?>
      </div>

      <div class="name">
        <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
      </div>
       
      <div class="description"></div>
      <div class="cart">
       <a href="<?php echo $category['href']; ?>" class="button detalle"><span>Detalle</span></a>
         <div class="price">
             <?php echo $category['precio']; ?>
         </div>
      </div>
    </div>
  
  <?php } ?>
</div>
<?php } ?>

  </div>
  


  <?php if (!$categories && !$products) { ?>
  
  <div class="content" style="border:none;">
  
 <div id="pages-container"  >
  <div class="page-title" >
     <h1 style="width:300px" ><?php echo $heading_title; ?></h1>
  </div>
  <div class="pages-content" style="margin-bottom: 23px;" >
	<?php echo $text_empty; ?>
  </div>

 </div>
  
  </div>
  
  
  
  <?php } ?>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$( '.descuentos' ).click(function(){ document.location.href=$(this).attr( 'name' ); });
$( '.comprar' ).click(function(){ document.location.href='carrito-de-compra'; });

function display(view) {
	if (view == 'list') {
		$('.product-grid').attr('class', 'product-list');
		
		$('.product-list > div').each(function(index, element) {
			//html  = '<div class="right">';
			html += '  <div class="cart">' + $(element).find('.cart').html() + '</div>';
			html += '  <div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '  <div class="compare">' + $(element).find('.compare').html() + '</div>';
			//html += '</div>';
			
			//html += '<div class="left">';
			
			var image = $(element).find('.image').html();
			
			if (image != null) { 
				html += '<div class="image">' + image + '</div>';
			}
			
			var price = $(element).find('.price').html();
			
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
					
			html += '  <div class="name">' + $(element).find('.name').html() + '</div>';
			html += '  <div class="description">' + $(element).find('.description').html() + '</div>';
			
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
				
			//html += '</div>';

						
			$(element).html(html);
		});		
		
		$('.display').html('<b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display(\'grid\');"><?php echo $text_grid; ?></a>');
		
		$.cookie('display', 'list'); 
	} else {
		$('.product-list').attr('class', 'product-grid');
		
		$('.product-grid > div').each(function(index, element) {
			html = '';
			
			var image = $(element).find('.image').html();
			
			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}
			
			html += '<div class="name">' + $(element).find('.name').html() + '</div>';
			html += '<div class="description">' + $(element).find('.description').html() + '</div>';
			
			var price = $(element).find('.price').html();
			
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
			
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
						
			html += '<div class="cart">' + $(element).find('.cart').html() + '</div>';
			html += '<div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '<div class="compare">' + $(element).find('.compare').html() + '</div>';
			
			$(element).html(html);
		});	
					
		$('.display').html('<b><?php echo $text_display; ?></b> <a onclick="display(\'list\');"><?php echo $text_list; ?></a> <b>/</b> <?php echo $text_grid; ?>');
		
		$.cookie('display', 'grid');
	}
}

view = $.cookie('display');

if (view) {
	display(view);
} else {
	display('list');
}
//--></script> 
<?php echo $footer; ?>