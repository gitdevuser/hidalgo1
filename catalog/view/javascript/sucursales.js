    $().ready(function(){

				var map = new GMap2($("#map").get(0));
				var burnsvilleMN = new GLatLng(19.433818,-99.135321);
				map.setCenter(burnsvilleMN, 16);
                                map.disableDragging();
                                var Icon = new GIcon(G_DEFAULT_ICON);
                                Icon.image = "catalog/view/theme/default/image/icono.png";
                                Icon.iconSize = new GSize(18, 18);
                                Icon.shadow = '';
                                markerOptions = { icon:Icon };
				var markers = [];
				for (var i = 0; i < 3; i++) {
                                        var point = new GLatLng(maps1[i]['lat'], maps1[i]['long']);
					marker = new GMarker(point, markerOptions);
					map.addOverlay(marker);
					markers[i] = marker;
				}

                                $( '.maps' ).click(function(){
                                    var index_var =  $( '.mapPhoto-cont a.maps' ).index( this );
                                    displayPoint(markers[index_var], index_var );
                                    return false;
                                });

				function displayPoint(marker, index){

					var moveEnd = GEvent.addListener(map, "moveend", function(){
						var markerOffset = map.fromLatLngToDivPixel(marker.getLatLng());
						$("#message")
							.fadeIn()
							.css({top:markerOffset.y, left:markerOffset.x});

						GEvent.removeListener(moveEnd);
					});
					map.panTo(marker.getLatLng());
				}


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





    });