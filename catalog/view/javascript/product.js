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
            var thumb_id = $( this ).index();
            $( '.image' ).removeClass( 'selected' );
            $( '.thumb-image'+thumb_id ).addClass( 'selected' );
            return false;
        });
        /* Zoom a imagenes */
	$('.jqzoom').jqzoom({
            zoomType: 'standard',
            zoomWidth: 465,
            zoomHeight: 231,
            lens:true,
            preloadImages: false,
            alwaysOn:false,
            title: true
        });
        $( '.zoomWindow' ).css( 'left','255px' );

        /** Tabla de Tallas */
        $( '.btn-tablatallas' ).click(function(){
            $( '.talla-tabla' ).fadeIn( 250 );
            $('html, body').animate({scrollTop: 0}, 'slow');
            return false;
        });

        $( '.close-atribute.talla-tabla' ).click(function(){
            $( '.talla-tabla' ).fadeOut( 250 );
            return false;
        });
		
		/*
                 * Seleccionables 
                 **/
		$( 'input[name="color"]' ).val( $( '.choose-color.selected' ).attr( 'name' ) );
		$( 'input[name="talla"]' ).val( $( '.medida-talla.selected' ).attr( 'name' ) );
		$( 'input[name="subtalla"]' ).val( $( '.medida-subs.selected' ).attr( 'name' ) );
		
		$.fn.selecionado = function( element ){
			$( element ).removeClass( 'selected' );
			$( this ).addClass( 'selected' );
		};
                $.fn.STaction = function( id_selected ,ms ) {
                    if ( $( this ).attr( 'name' ) != id_selected  ) {
                         $( '#button-cart' ).css('border', 'solid 1px red');
                         $( '#no-disponible' ).fadeIn( 250 ).html( '<span>'+ms+'</span>' );
                    }
                }
                /*Seleccionar Colores*/
                $( 'input[name="btn-incio"]' ).val( '' );

                function nombreColorSelect() {
                $( '.color-text' ).removeClass('selected');
                $( '.color-text' ).each(function(){
                    if ( $( '.choose-color.selected' ).attr('name') == $(this).attr('name') ) {
                        $( this ).addClass( 'selected' );
                    }
                });
                $( '.image' ).each(function(){
                    if ( $( '.choose-color.selected' ).attr('name') == $(this).attr('name') ) {
                        $( this ).addClass( 'selected' );
                    }
                });

                }

                function recorreLista( sl_index, inicio ) {

                    $( '.medida-talla, .medida-subs' ).removeClass( 'even' );

                //Imagen
                $( '.image' ).removeClass('selected');
                $( '.image' ).each(function(){
                    if ( $( this ).attr( 'name' ) == sl_index ) {
                        $( this ).addClass( 'selected' );
                    }
                });
                
                //selecciona imagenes de Inicio
                if( inicio !=null) {
                    if ( $( '.estilo-img' ).length > 0 ) {
                         $( '.image' ).removeClass('selected');
                         $( '.estilo-img' ).eq(0).addClass('selected');
                    }
                }

                    for(var i in ProdbyCat) {
                        
                          if ( ProdbyCat[i]['nombre'] == sl_index ) {
                             //Talla
                             $( '.medida-talla' ).each(function(){
                                if ( $( this ).attr( 'name' ) == ProdbyCat[i]['talla'] ) {
                                     $( this ).addClass( 'even' );
                                }
                             });
                             //Subtalla
                             $( '.medida-subs' ).each(function(){
                                if ( $( this ).attr( 'name' ) == ProdbyCat[i]['subtalla'] ) {
                                     $( this ).addClass( 'even' );
                                }
                             });
                          }


                    }
                }

                function recorreListaHover( sl_index ) {
                    
                    $( '.medida-talla, .medida-subs' ).removeClass( 'even-hover' ).removeClass( 'even-hover-selected' );
                    $( '.medida-talla, .medida-subs' ).addClass( 'even-hover-none' );
                    for(var i in ProdbyCat) {

                          if ( ProdbyCat[i]['nombre'] == sl_index ) {
                             //Talla
                             
                             $( '.medida-talla' ).each(function(){
                                if ( $( this ).attr( 'name' ) == ProdbyCat[i]['talla'] ) {
                                     $( this ).addClass( 'even-hover' ).removeClass( 'even-hover-none' );
                                }
                             });
                             //Subtalla
                             $( '.medida-subs' ).each(function(){
                                if ( $( this ).attr( 'name' ) == ProdbyCat[i]['subtalla'] ) {
                                     $( this ).addClass( 'even-hover' ).removeClass( 'even-hover-none' );
                                }
                             });
                          }

                    }

                }

                function comprobarExist( tipo ) {
                    
                    var color = $( '.choose-color.selected' ).attr( 'name' );
                    var talla = $( '.medida-talla.selected' ).attr( 'name' );
                    var subtalla = '';
                    $( '.medida-subs, .medida-talla, .choose-color' ).removeClass( 'talla-incorrecta' ).removeClass( 'talla-incorrecta-hover' );
                    $( '#button-cart' ).removeClass( 'hide-buttonCart' ).removeClass( 'show-buttonCart' );
                    $( '#no-stock' ).removeClass('show-noStock').removeClass('hide-noStock');

                    if ( $( '.medida-subs' ).hasClass( 'selected' )  ) {
                        subtalla = $( '.medida-subs.selected' ).attr( 'name' );
                    }

                     if( !$( '.medida-subs' ).hasClass('selected') ) {
                          $( '.medida-subs' ).removeClass( 'talla-incorrecta' );
                     }

                    var e = 0;
                    var id_prod = '';
                    var precio1 = '';
                    var cat_precio = $( '.precio_cat' ).val();
                    var nw_precio = '';
                    for(var i in ProdbyCat) {
                        if (  ( ProdbyCat[i]['nombre'] == color ) && ( ProdbyCat[i]['talla'] == talla ) && ( ProdbyCat[i]['subtalla'] == subtalla )  ) {
                               e++;
                               id_prod = ProdbyCat[i]['product_id'];
                               precio1 = ProdbyCat[i]['precio'];
                         }
                    }
                    
                    //Precios
                    nw_precio = cat_precio;
                    if ( ( precio1 !="" ) && ( precio1 != cat_precio ) ) {
                        nw_precio = precio1;
                    }
                    //$( '#price-cart' ).html( nw_precio );


                    if( e == 0 ) {
                        $( '.medida-subs.selected, .medida-talla.selected, .choose-color.selected' ).addClass( 'talla-incorrecta' );
                        if( $( '.medida-talla' ).hasClass( 'selected' ) ) {
                            nombreColorSelect();
                            $( 'input[name="btn-incio"]' ).val( 'false' );
                        }
                    } else {
                        $( 'input[name="product_id"]' ).val( id_prod );
                        $( 'input[name="btn-incio"]' ).val( 'true' );
                        
                    }

                     if ( !$( '.medida-talla' ).hasClass( 'selected' ) ) {
                           $( '.medida-talla.selected, .choose-color.selected' ).removeClass( 'talla-incorrecta' );
                     }


                }


                function ocultarBtnCompra() {
                         $( '#button-cart' ).addClass('no-prod-hover');
                         $( '#no-stock' ).addClass('no-prod-hover');
                }
                function mostrarBtnCompra() {
                         $( '#button-cart' ).removeClass('no-prod-hover');
                         $( '#no-stock' ).removeClass('no-prod-hover');
                         $( '#no-disponible' ).removeClass( 'hover' );
                }

                function mostrarLeyendaDisp() {
                    var html = '';
                    if( $( '.choose-color' ).hasClass( 'selected' ) ) {
                        html += '<span>Color seleccionado no disponible</span><br>';
                    }
                    if( $( '.medida-talla' ).hasClass( 'selected' ) ) {
                        html += '<span>Talla seleccionada no disponible</span><br>';
                    } else if( $( '.medida-talla' ).hasClass( 'incorrecta' ) ) {
                        html += '<span>Talla seleccionada no disponible</span><br>';
                    }
                    if( $( '.medida-subs' ).hasClass( 'selected' ) ) {
                        html += '<span>Subtalla seleccionada no disponible</span><br>';
                    } else if( $( '.medida-subs' ).hasClass( 'incorrecta' ) ) {
                        html += '<span>Subtalla seleccionada no disponible</span><br>';
                    }
                    $( '#no-disponible' ).addClass( 'hover' );
                    $( '#no-disponible' ).html( html );

                }

                function mostrarSelectVal() {
                     if ( $( 'input[name="btn-incio"]' ).val() == 'false' ) {
                          $( '#button-cart, #no-stock' ).addClass( 'no-prod-hover' );
                          mostrarLeyendaDisp();
                     }
                }

                function comprobarExistHover( tipo, curr_id ) {
                    var color = '';
                    var talla = '';
                    var subtalla = '';
                    var ms_html = '';
                    $( '.choose-color, .medida-talla, .medida-subs' ).removeClass( 'incorrecta' ).removeClass('talla-correcta');

                    if ( tipo == 'color' ) {
                         color = curr_id;
                         talla = $( '.medida-talla.selected' ).attr( 'name' );
                         if( $( '.medida-subs' ).hasClass( 'selected' ) ){
                             subtalla = $( '.medida-subs' ).attr( 'name' );
                         }
                    }

                    if ( tipo == 'talla' ) {
                         color = $( '.choose-color.selected' ).attr( 'name' );
                         talla = curr_id;
                         if( $( '.medida-subs' ).hasClass( 'selected' ) ){
                             subtalla = $( '.medida-subs' ).attr( 'name' );
                         }
                    }

                    if ( tipo == 'subtalla' ) {
                         color = $( '.choose-color.selected' ).attr( 'name' );
                         talla = $( '.medida-talla.selected' ).attr( 'name' );
                         subtalla = curr_id;
                    }

                    var e = 0;
                    var id_prod = '';
                    var id_talla = '';
                    var id_subtalla = '';
                    for(var i in ProdbyCat) {
                       if (  ( ProdbyCat[i]['nombre'] == color ) && ( ProdbyCat[i]['talla'] == talla ) && ( ProdbyCat[i]['subtalla'] == subtalla )  ) {
                               e++;
                               id_prod = ProdbyCat[i]['product_id'];
                               id_talla = ProdbyCat[i]['talla'];
                               id_subtalla = ProdbyCat[i]['subtalla'];
                         }
                    }

                    //Color
                    if( tipo == 'color' ) {
                        if($( '.medida-talla' ).hasClass( 'selected' )) {
                           if( e == 0 ) {
                               $( '.choose-color' ).each(function(){
                                 if ( $(this).attr( 'name' ) == curr_id ) {
                                     $( this ).addClass('incorrecta');
                                 }
                               });
                              ocultarBtnCompra();
                              mostrarLeyendaDisp();

                           } else {
                            $( '.medida-talla' ).each(function(){
                                if ( $(this).attr( 'name' ) == id_talla ) {
                                     $( this ).addClass('talla-correcta');
                                }
                            });
                            $( '.medida-subs' ).each(function(){
                                if ( $(this).attr( 'name' ) == id_subtalla ) {
                                     $( this ).addClass('talla-correcta').removeClass( 'incorrecta' );
                                }
                            });
                            mostrarBtnCompra();

                           }
                        }
                    }

                    //Tallas
                    if ( tipo == 'talla' ) {
                        if( e == 0 ) {
                            $( '.choose-color.selected' ).addClass( 'incorrecta' );
                            $( '.medida-talla' ).each(function(){
                                if ( $(this).attr( 'name' ) == curr_id ) {
                                     $( this ).addClass('incorrecta');
                                }
                            });
                            ocultarBtnCompra();
                            mostrarLeyendaDisp();
                        } else {
                            $( '.medida-talla' ).each(function(){
                                if ( $(this).attr( 'name' ) == curr_id ) {
                                     $( this ).addClass('talla-correcta');
                                }
                            });
                            $( '.medida-subs' ).each(function(){
                                if ( $(this).attr( 'name' ) == id_subtalla ) {
                                     $( this ).addClass('talla-correcta').removeClass( 'incorrecta' );
                                }
                            });
                            mostrarBtnCompra();
                            
                        }
                    }

                    //Subtalla
                    if ( tipo == 'subtalla' ) {
                         if( e == 0 ) {
                             $( '.choose-color.selected, .medida-talla.selected' ).addClass( 'incorrecta' );
                             $( '.medida-subs' ).each(function(){
                                if ( $(this).attr( 'name' ) == curr_id ) {
                                     $( this ).addClass('incorrecta');
                                }
                             });
                             ocultarBtnCompra();
                             mostrarLeyendaDisp();
                         } else {

                            $( '.medida-talla' ).each(function(){
                                if ( $(this).attr( 'name' ) == id_talla ) {
                                     $( this ).addClass('talla-correcta');
                                }
                            });
                            $( '.medida-subs' ).each(function(){
                                if ( $(this).attr( 'name' ) == curr_id ) {
                                     $( this ).addClass('talla-correcta').removeClass( 'incorrecta' );
                                }
                            });
                            mostrarBtnCompra();

                         }
                    }

                }

		$( '.choose-color' ).click(function(){
                    $( '.choose-color' ).removeClass( 'selected' );
                    $( this ).addClass( 'selected' );
                    nombreColorSelect();
                    comprobarExist( 'color' );
                    recorreLista( $( '.choose-color.selected' ).attr( 'name' ) );
                    
		}).mouseenter(function(){
                    // Cambiar Nombre del color
                    var curr_id = $( this ).attr( 'name' );
                    $( this ).addClass( 'selected-hover' );
                    $( '.color-text' ).addClass( 'name-hide' );
                    $( '.color-text' ).each(function(){
                        if ( $( this ).attr( 'name' ) == curr_id ) {
                            $( this ).addClass( 'name-show' ).removeClass( 'name-hide' );
                        }
                    });
                    //Cambia nombre Color
                    recorreListaHover( curr_id );
                    comprobarExistHover( 'color', curr_id );
                    
                }).mouseout(function(){
                    $( this ).removeClass( 'selected-hover' );
                    $( '.choose-color, .medida-talla, .medida-subs' ).removeClass( 'incorrecta' ).removeClass('talla-correcta');
                    $( '.medida-talla, .medida-subs' ).removeClass( 'even-hover' ).removeClass( 'even-hover-none' );
                    $( '.color-text' ).removeClass( 'name-hide' ).removeClass( 'name-show' );
                    mostrarBtnCompra();
                    if( $( '.medida-talla' ).hasClass( 'selected' ) ) {
                        mostrarSelectVal();
                    }
                    
                });

                
                /*TALLAS*/
		$( '.medida-talla' ).click(function(){
                    
                      $( '.medida-talla' ).removeClass( 'selected' );
                      $( this ).addClass( 'selected' );
                      $( '.medida-talla.selected, .choose-color.selected' ).removeClass( 'talla-incorrecta' );
                      comprobarExist( 'talla' );

		}).mouseenter(function(){
                    var curr_id = $( this ).attr( 'name' );
                    comprobarExistHover( 'talla', curr_id );
                }).mouseout(function(){
                    mostrarBtnCompra();
                    $( '.choose-color, .medida-talla, .medida-subs' ).removeClass( 'incorrecta' ).removeClass('talla-correcta');
                    mostrarSelectVal();
                });


                /*SUBTALLAS*/
                $( '.medida-subs' ).toggle(function(){
                      $( '.medida-subs' ).removeClass( 'selected' );
                      $( this ).addClass( 'selected' );
                      $( '.medida-talla.selected, .choose-color.selected' ).removeClass( 'talla-incorrecta' );
                      comprobarExist( 'talla' );
                }, function(){
                      $( '.medida-subs' ).removeClass( 'selected' );
                      $( '.medida-talla.selected, .choose-color.selected' ).removeClass( 'talla-incorrecta' );
                      comprobarExist( 'talla' );
                }).mouseenter(function(){
                     var curr_id = $( this ).attr( "name" );
                     comprobarExistHover( 'subtalla', curr_id );
                }).mouseout(function(){
                     mostrarBtnCompra();
                     $( '.choose-color, .medida-talla, .medida-subs' ).removeClass( 'incorrecta' ).removeClass('talla-correcta');
                     mostrarSelectVal();

                });

                //Valores inciales
                recorreLista( $( '.choose-color.selected' ).attr( 'name' ), 1 );
                

});