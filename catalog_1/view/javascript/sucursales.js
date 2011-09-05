    $().ready(function(){

				var map = new GMap2($("#map_canvas").get(0));
				var burnsvilleMN = new GLatLng(19.433818,-99.135321);
				map.setCenter(burnsvilleMN, 16);
                                map.disableDragging();


                                var Icon = new GIcon(G_DEFAULT_ICON);
                                Icon.image = "http://localhost/opencart/catalog/view/theme/default/image/cross-desc.jpg";
                                Icon.shadow = "";
                                Icon.iconSize = new GSize(16, 16);
                                markerOptions = { icon:Icon };

                                var maps1 = new Array();
                                maps1[0] = {'lat': 19.433818, 'long': '-99.135321'};
                                maps1[1] = {'lat': 19.303548, 'long': '-99.124352'};
                                maps1[2] = {'lat': 19.621372, 'long': '-99.105322'};
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
                                    $( '.maps' ).removeClass('map-selected');
                                    $( this ).addClass('map-selected');
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

    });