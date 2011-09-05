$().ready(function() {

        /* Detalle del producto  */
        $( '.detail-product-link' ).click(function(){
            $( '#banner-detail' ).fadeIn( 250 );
            return false;
        });
        $( '.close-atribute' ).click(function(){
            $( '#banner-detail' ).fadeOut( 250 );
            return false;
        });
        /* Imagenes seleccionadas */
        $( '.thumb-image' ).click(function(){
            var link = $( this ).attr( 'href' );
            $( '.image #image, .jqzoom img' ).attr( 'src', link );
            $( '.zoom .fancybox, .image .jqzoom' ).attr( 'href', link );
            return false;
        });
        /* Zoom a imagenes */
	$('.jqzoom').jqzoom({
            zoomType: 'standard',
            zoomWidth: 464,
            zoomHeight: 231,
            lens:true,
            preloadImages: false,
            alwaysOn:false,
            title: true
        });
        /** Tabla de Tallas */
        $( '.btn-tablatallas' ).click(function(){
            $( '.talla-tabla' ).fadeIn( 250 );
            $('html, body').animate({ scrollTop: 0 }, 'slow');
            return false;
        });

        $( '.close-atribute.talla-tabla' ).click(function(){
            $( '.talla-tabla' ).fadeOut( 250 );
            return false;
        });
		
		/* Seleccionables */
		$( '.choose-color:eq(0),.medida-talla:eq(0)' ).addClass( 'selected' );
		$( 'input[name="color"]' ).val( $( '.choose-color.selected' ).attr( 'name' ) );
		$( 'input[name="talla"]' ).val( $( '.medida-talla.selected' ).attr( 'name' ) );
		$( 'input[name="subtalla"]' ).val( $( '.medida-subs.selected' ).attr( 'name' ) );
		
		$.fn.selecionado = function( element, intup_val ){
			$( element ).removeClass( 'selected' );
			$( this ).addClass( 'selected' );
			$( intup_val ).val( $( this ).attr( 'name' ) );
		}
		$( '.choose-color' ).click(function(){
			$( this ).selecionado( '.choose-color', 'input[name="color"]' );
		});
		$( '.medida-talla' ).click(function(){
			$( this ).selecionado( '.medida-talla', 'input[name="talla"]' );
		});
		$( '.medida-subs' ).click(function(){
			$( this ).selecionado( '.medida-subs', 'input[name="subtalla"]' );
		});
		$( '.medida-subs' ).dblclick(function(){
			$( this ).removeClass( 'selected' );
			$( 'input[name="subtalla"]' ).val('');
		});
		

});