<?php 
class ControllerProductCategory extends Controller {  
	public function index() { 
		$this->language->load('product/category');
		$this->language->load('product/product');
		$this->load->model('catalog/category');
		
		$this->load->model('catalog/product');
		
		$this->load->model('tool/image'); 

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else { 
			$page = 1;
		}	
							
		if (isset($this->request->get['limit'])) {
			$limit = $this->request->get['limit'];
		} else {
			$limit = $this->config->get('config_catalog_limit');
		}
					
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
       		'separator' => false
   		);	

		if (isset($this->request->get['path'])) {
			$path = '';
		
			$parts = explode('_', (string)$this->request->get['path']);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);
				
				if ($category_info) {
	       			$this->data['breadcrumbs'][] = array(
   	    				'text'      => $category_info['name'],
						'href'      => $this->url->link('product/category', 'path=' . $path),
        				'separator' => $this->language->get('text_separator')
        			);
				}
			}		
		
			$category_id = array_pop($parts);
		} else {
			$category_id = 0;
		}


		$category_info = $this->model_catalog_category->getCategory($category_id);
	
		if ($category_info) {
	  		$this->document->setTitle($category_info['name']);
			$this->document->setDescription($category_info['meta_description']);
			$this->document->setKeywords($category_info['meta_keyword']);
			
			$this->data['text_refine'] = $this->language->get('text_refine');
			$this->data['text_empty'] = $this->language->get('text_empty');			
			$this->data['text_quantity'] = $this->language->get('text_quantity');
			$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$this->data['text_model'] = $this->language->get('text_model');
			$this->data['text_price'] = $this->language->get('text_price');
			$this->data['text_tax'] = $this->language->get('text_tax');
			$this->data['text_points'] = $this->language->get('text_points');
			$this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$this->data['text_display'] = $this->language->get('text_display');
			$this->data['text_list'] = $this->language->get('text_list');
			$this->data['text_grid'] = $this->language->get('text_grid');
			$this->data['text_sort'] = $this->language->get('text_sort');
			$this->data['text_limit'] = $this->language->get('text_limit');
					
			$this->data['button_cart'] = $this->language->get('button_cart');
                        $this->data['button_detalle'] = $this->language->get('button_detalle');
			$this->data['button_wishlist'] = $this->language->get('button_wishlist');
			$this->data['button_compare'] = $this->language->get('button_compare');
			$this->data['button_continue'] = $this->language->get('button_continue');
					
			if ($category_info['image']) {
				$this->data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
			} else {
				$this->data['thumb'] = '';
			}
									
			$this->data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
			$this->data['compare'] = $this->url->link('product/compare');
			
			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}	
			
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$this->data['categories'] = array();
			$results = $this->model_catalog_category->getCategories($category_id);

                        //si es modulo izquierdo
                        $results2 = array();
                        $leer_mod = explode( '/', $_SERVER['QUERY_STRING']);
                        $nom_mod = '';
                        if ( isset( $leer_mod[1] ) ) {
                            $Q_mod = $this->db->query("SELECT extra_left_id, extra_nom FROM left_extra_module WHERE LOWER(extra_nom) = '".$leer_mod[1]."'");
                            if ($Q_mod->num_rows > 0) {
                                foreach ( $results as $rt ) {
                                if ( (isset($rt['left_extra_module'])) && ($rt['left_extra_module']!="") ) {
                                    foreach ( unserialize($rt['left_extra_module']) as $rs_mod1 ) {
                                       if ( $rs_mod1 == $Q_mod->row['extra_left_id'] ) {
                                            $results2[] = $rt;
                                       }
                                    }
                                }
                            }

                           }

                            if ( count($results2) > 0 ) {
                                $results = $results2;
                                 $nom_mod = $Q_mod->row['extra_nom'].' / ';
                            }

                        }

                        $this->data['heading_title'] = $nom_mod.$category_info['name'];



			foreach ($results as $result) {
				$product_total = $this->model_catalog_product->getTotalProducts(array('filter_category_id' => $result['category_id']));
                                $img ='';
                                $img_select = '';
                                if ( $result['imagen_estilo'] ) {
                                    $img_cat = unserialize($result['imagen_estilo']);
                                    foreach ( $img_cat as $rs_img  ) {
                                        if ( $rs_img['selected'] ) { $img_select = $rs_img['img_nom']; }
                                    }
                                    $img = $this->model_tool_image->resize($img_select, $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
                                }

				$this->data['categories'][] = array(
					'name'  => $result['name'],
                                        'precio'=> $this->currency->format($this->tax->calculate($result['precio'], 0, $this->config->get('config_tax'))),
                                        'imagen' =>$img,
                                        'descuento' =>$result['descuento'],
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url)
				);
			}



                        //productos no usado
			$this->data['products'] = array();
			$data = array(
				'filter_category_id' => $category_id, 
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);
					
			$product_total = $this->model_catalog_product->getTotalProducts($data); 
			$results = $this->model_catalog_product->getProducts($data);

			foreach ($results as $result) {

				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				} else {
					$image = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}	
				
				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
				} else {
					$tax = false;
				}				
				
				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
                                        $price = false;
				}

                                $catID = $this->model_catalog_product->getProductsStyleID($result['product_id']);
                                $catDesc = $this->model_catalog_product->getCatDescripcion($catID);
                                $descuento = '';
                                if ( isset( $catDesc[0]['precio'] ) ) {
                                    $price = $catDesc[0]['precio'];
                                }
                                if ( isset( $catDesc[0]['descuento'] ) && ( $catDesc[0]['descuento'] !=0 )  ){
                                    $price = ( $price - ( $price * ( $catDesc[0]['descuento'] / 100 ) ) );
                                    $descuento = $catDesc[0]['descuento'];
                                }
                                $price = $this->currency->format($this->tax->calculate($price, $result['tax_class_id'], $this->config->get('config_tax')));


                                if( $result['model'] ) {
                                    //$name = $this->model_catalog_product->getCatProductName( $result['product_id'] );
                                    $name = $result['model'];
                                } else {
                                    $name = false;
                                }
                                
							
				$this->data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $name,
					'description' => substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'rating'      => $result['rating'],
					'descuento'      => $descuento,
					'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
					'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'])
				);
			}
                        

			$url = '';
	
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
							
			$this->data['sorts'] = array();
			
			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.sort_order&order=ASC' . $url)
			);
			
			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=ASC' . $url)
			);

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=DESC' . $url)
			);

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=ASC' . $url)
			); 

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=DESC' . $url)
			); 
			
			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_rating_desc'),
				'value' => 'rating-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=DESC' . $url)
			); 
			
			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_rating_asc'),
				'value' => 'rating-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=ASC' . $url)
			);
			
			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=ASC' . $url)
			);

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=DESC' . $url)
			);
			
			$url = '';
	
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
			
			$this->data['limits'] = array();
			
			$this->data['limits'][] = array(
				'text'  => $this->config->get('config_catalog_limit'),
				'value' => $this->config->get('config_catalog_limit'),
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=' . $this->config->get('config_catalog_limit'))
			);
						
			$this->data['limits'][] = array(
				'text'  => 25,
				'value' => 25,
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=25')
			);
			
			$this->data['limits'][] = array(
				'text'  => 50,
				'value' => 50,
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=50')
			);

			$this->data['limits'][] = array(
				'text'  => 75,
				'value' => 75,
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=75')
			);
			
			$this->data['limits'][] = array(
				'text'  => 100,
				'value' => 100,
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=100')
			);
						
			$url = '';
	
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
	
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
					
			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}');
		
			$this->data['pagination'] = $pagination->render();
		
			$this->data['sort'] = $sort;
			$this->data['order'] = $order;
			$this->data['limit'] = $limit;
		
			$this->data['continue'] = $this->url->link('common/home');

                        $load_product = '';
                        if ( $category_info['parent_id'] != 0 ) {
                             $category_info['parent_id'];
                             $q_prod = $this->db->query( "SELECT * FROM product_to_category WHERE category_id ='".$category_id."'" );
                             if ( $q_prod->num_rows > 0 ) {
                                    $load_product = $q_prod->row['product_id'];
                             }
                        }

                        if ( $load_product !="" ) {
                        //CARGAR PRODUCTOS

			$this->data['text_stock'] = $this->language->get('text_stock');
			$this->data['text_price'] = $this->language->get('text_price');
                        $this->data['related_title'] = $this->language->get('related_title');
                        $this->data['text_qty'] = $this->language->get('text_qty');
                        $this->data['text_subtalla'] = $this->language->get('text_subtalla');
                        $this->data['text_tablatallas'] = $this->language->get('text_tablatallas');
                        $this->data['text_color'] = $this->language->get('text_color');
                        $this->data['text_talla'] = $this->language->get('text_talla');
                        $this->data['text_comosaver'] = $this->language->get('text_comosaver');
                        $this->data['produc_detail_link'] = $this->language->get('produc_detail_link');
                        $this->data['tab_description'] = $this->language->get('tab_description');
                        $this->data['text_stock'] = $this->language->get('text_stock');
                        $this->data['link_sizechart'] = $this->url->link('information/sizechart');

                        $this->data['desc1'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');

                        $resultsStyle = '';
                        $talla_selected = '';
                        $Subtalla_selected = '';
                        $ItemsbyCat = array();
                        $Arrcolor = array();
                        $Arrdesc = array();
                        $Arrimagen = array();
                        $ArrnomColor = array();
                        $ArrTalla = array();
                        $Arrcolor = array();
                        $Arrdesc = array();
                        $ArrTalla = array();
                        $ArrSubTalla = array();
                        $Jscript = '';
                        $e = 0;

                        if ( $category_id ) {

                             $resultsStyle = $this->model_catalog_product->getProdbyCat($category_id);


                             if( $resultsStyle !="" ) {

                             $ColorsbyItems = array();
                             foreach ( $resultsStyle as $rel_item ) {

                                 $selected = '';
                                 if ( $rel_item['product_id'] == $load_product ) {
                                      $selected = 'selected';
                                 }

                                 $textura = '';
                                 if ( $rel_item['color'] ) {
                                      $textura = $this->model_tool_image->resize($rel_item['color'], 160, 180);
                                 }
                                 $talla = '';
                                 if ( $rel_item['talla'] ) {
                                        $talla = $rel_item['talla'];
                                 }
                                 $subtalla = '';
                                 if ( $rel_item['subtalla'] ) {
                                        $subtalla = $rel_item['subtalla'];
                                 }
                                 $img_prin = '';
                                 $img_zoom = '';
                                 $rollover = '';

                                 if ($rel_item['image']) {
                                      $img_prin = $this->model_tool_image->resize($rel_item['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
                                      $img_zoom = $this->model_tool_image->resize($rel_item['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
                                      $rollover = $rel_item['image'];
                                 }

                                $descripcion = html_entity_decode($rel_item['description'], ENT_QUOTES, 'UTF-8');

                                $ArrnomColor[] = array('nombre' => $rel_item['nombre_color'],
                                                       'selected' => $selected,
                                                       'product_id' => $rel_item['product_id'],
                                                       'color' => $textura
                                                  );
                                $Arrdesc[] = array(  'descripcion' => $descripcion,
                                                     'selected' => $selected,
                                                     'product_id' => $rel_item['product_id']
                                                  );
                                $Arrimagen[] = array('nombre' => $rel_item['nombre_color'],
                                                     'imagen_princ' => $img_prin,
                                                     'imagen_zoom' => $img_zoom,
                                                     'image_rollover' => $rollover,
                                                     'selected' => $selected,
                                                     'product_id' => $rel_item['product_id']
                                                  );
                                $ArrTalla[] = array( 'talla' => $talla,
                                                     'selected' => $selected,
                                                     'product_id' => $rel_item['product_id'] );
                                $ArrSubTalla[] = array( 'talla' => $subtalla,
                                                     'selected' => $selected,
                                                     'product_id' => $rel_item['product_id'] );

                                $Jscript .= "ProdbyCat[".$e++."] = { 'product_id':'".$rel_item['product_id']."',
                                                             'nombre':'".$rel_item['nombre_color']."',
                                                             'talla':'".$talla."',
                                                             'subtalla':'".$subtalla."',
                                                             'precio':'".$this->currency->format($this->tax->calculate($rel_item['price'], 0, $this->config->get('config_tax')))."'
                                                           };";
                             }

                           }
                           
                        }

                        //Color nombre unico
                        $color_nombre = array();
                        foreach ( $ArrnomColor as $itemColor ) {
                           $color_nombre[] = $itemColor['nombre'];
                        }

                        /* Colore Unicos anadirle atributos */
                        $uniqueColor = array_unique( $color_nombre );
                        $idProd = array();
                        $array_color_textura = array();
                        $array_imagen = array();
                        foreach ( $uniqueColor as $uColor ) {
                             $nombre = $uColor;
                             foreach ( $ArrnomColor as $itemColor ) {
                                 if ( $itemColor['nombre'] == $uColor ) {
                                    $color_textura = $itemColor['color'];
                                 }
                             }
                             foreach ( $Arrimagen as $itemImagen ) {
                                 if ( $itemImagen['nombre'] == $uColor ) {
                                      $i_nombre = $itemImagen['nombre'];
                                      $i_imagen_princ = $itemImagen['imagen_princ'];
                                      $i_imagen_zoom = $itemImagen['imagen_zoom'];
                                      $i_image_rollover = $itemImagen['image_rollover'];
                                 }

                             }

                             $array_imagen[] = array('nombre' => $i_nombre,
                                                     'imagen_princ' => $i_imagen_princ,
                                                     'imagen_zoom' => $i_imagen_zoom,
                                                     'image_rollover' => $i_image_rollover
                                                      );

                             $array_color_textura[] = array( 'c_nombre' => $nombre,
                                                             'c_textura' => $color_textura
                                                         );
                        }


                        /*Tallas*/
                        $nombreTallas = $this->model_catalog_product->getTallaSubtalla( $ArrTalla, 'talla' );
                        /*Subtallas*/
                        $nombreSubTallas = $this->model_catalog_product->getTallaSubTalla( $ArrSubTalla, 'subtalla' );


                        $this->data['Arrcolor'] = $Arrcolor;
                        $this->data['Arrdesc'] = $Arrdesc;
                        $this->data['Arrimagen'] = $array_imagen;
                        $this->data['ArrnomColor'] = $array_color_textura;
                        $this->data['ArrTallas'] = $nombreTallas;
                        $this->data['ArrSubTallas'] = $nombreSubTallas;
                        $this->data['Jscript'] = $Jscript;


                        /* Composicion, general, corte, caracteristicas ,descuento */
                        $catDesc = array();
                        $catDesc = $this->model_catalog_product->getCatDescripcion($category_id);
                        $nombre_cat = '';
                        $composicion = '';
                        $cuidado = '';
                        $corte = '';
                        $caract = '';
                        $descuento = '';
                        $precio = '';
                        $descuento = '';
                        $imagen_estilo = '';
                        foreach( $catDesc as $desc_var=>$key ) {
                            $nombre_cat = $key['name'];
                            $composicion = $key['composicion'];
                            $cuidado = $key['cuidado'];
                            $corte = $key['corte'];
                            $caract = $key['caracteristica'];
                            $descuento = $key['descuento'];
                            $precio = $key['precio'];
                            if ( $descuento !="" ){
                                 $precio = ( $key['precio'] - ( $key['precio'] * ( $descuento / 100 ) ) );
                            }
                            $imagen_estilo = $key['imagen_estilo'];
                        }

                        $this->data['composicion'] = $composicion;
                        $this->data['cuidado'] = $cuidado;
                        $this->data['corte'] = $corte;
                        $this->data['caract'] = $caract;
                        $this->data['descuento'] = $descuento;
                        $this->data['imagen_estilo'] = $imagen_estilo;

                        /* ID */
                        $this->data['model'] = $category_id;
                        /* Headding title */
                        $this->data['heading_title'] = $nombre_cat;
                        //Titulo
                        $this->document->setTitle($nombre_cat);

                        $this->data['price'] = $this->currency->format($this->tax->calculate($precio, 0, $this->config->get('config_tax')));

                        //Estilos relacionados
                        $this->data['product_related'] = array();
                        $q_rel = $this->db->query( "SELECT related_id FROM category_related
                                            WHERE category_id = '".$category_id."'" );
                        if ( $q_rel->num_rows > 0 ) {
                            foreach( $q_rel->rows as $related_info ) {
                                $name = '';
                                $q_name = $this->db->query( "SELECT name, imagen_estilo FROM category_description WHERE category_id ='".$related_info['related_id']."'" );
                                if( $q_name->num_rows > 0 ) {
                                    $name = $q_name->row['name'];
                                    $img = unserialize( $q_name->row['imagen_estilo'] );
                                    $nwImg = '';
                                    
                                    if ( $img ) {
                                        foreach ( $img as $rs_img ) {
                                           if ( $rs_img['selected'] == 'selected' ) {
                                                $nwImg = $this->model_tool_image->resize($rs_img['img_nom'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
                                           }
                                        }
                                    }
                                    
                                }

                                $q_parent = $this->db->query("SELECT parent_id FROM category WHERE category_id ='".$related_info['related_id']."'");
                                $parent_id = '';
                                if ( $q_parent->num_rows > 0 ) { $parent_id = $q_parent->row['parent_id'].'_';  }

                                $this->data['product_related'][] = array(
                                    'related_id' => $related_info['related_id'],
                                    'name'       => $name,
                                    'thumb'      => $nwImg,
                                    /*'href'       => $this->url->link('product/category',  $related_info['related_id'])*/
                                    'href'       => $this->url->link('product/category', '&path=' .$parent_id.$related_info['related_id'] )
                            );


                            }
                        }


			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/product.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/product/product.tpl';
			} else {
				$this->template = 'default/template/product/product.tpl';
			}

			$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);



                        } else {


                        //CARGAR CATEGORIAS
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/category.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/product/category.tpl';
			} else {
				$this->template = 'default/template/product/category.tpl';
			}

			$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);


                        }

			$this->response->setOutput($this->render());										
    	} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}
									
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
				
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
						
						
						
			$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('product/category', $url),
				'separator' => $this->language->get('text_separator')
			);
				
			$this->document->setTitle($this->language->get('text_error'));

      		$this->data['heading_title'] = $this->language->get('text_error');

      		$this->data['text_error'] = $this->language->get('text_error');

      		$this->data['button_continue'] = $this->language->get('button_continue');

      		$this->data['continue'] = $this->url->link('common/home');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
			} else {
				$this->template = 'default/template/error/not_found.tpl';
			}
			
			$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);
					
			$this->response->setOutput($this->render());
		}
  	}
}
?>