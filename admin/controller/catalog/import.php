<?php
class ControllerCatalogImport extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/information');
		$this->document->setTitle($this->language->get('heading_title'));
		//$this->load->model('catalog/import');
                $this->data['action'] = $this->url->link('catalog/import/importacion', 'token=' . $this->session->data['token'], 'SSL');
		$this->template = 'catalog/import_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		$this->response->setOutput($this->render());

	}

	public function cleanURL($str) {

            $delimiter='-';
            if( !empty($replace) ) {
                $str = str_replace((array)$replace, ' ', $str );
            }
            $clean = iconv('UTF-8', 'ASCII//TRANSLIT', $str);
            $clean = preg_replace("/[^a-zA-Z0-9\/_|+ -]/", '', $clean);
            $clean = strtolower(trim($clean, '-'));
            $clean = preg_replace("/[\/_|+ -]+/", $delimiter, $clean);

            //Eliminar keyword iguales
            $q_key = $this->db->query("SELECT * FROM url_alias WHERE keyword = '".$clean."'");
            if ( $q_key->num_rows > 0  ) {
                 $clean = $clean.'-'.( $q_key->num_rows + 1 );
            }

            return $clean;

        }

        public function validaExiste( $tabla, $nombre_id, $id ) {
            $q_e = $this->db->query( "SELECT * FROM ".$tabla." WHERE ".$nombre_id." = '".$id."'" );
            if ( $q_e->num_rows > 0 ) {
                 return true;
            } else {
                return false;
            }
        }

        public function validaNombreCat( $tabla, $nombre_id, $id ) {
            $q_e = $this->db->query( "SELECT * FROM ".$tabla." WHERE ".$nombre_id." = '".$id."'" );
            if ( $q_e->num_rows > 0 ) { 
                return $q_e->row['name'];
            } else {
                return false;
            }

        }


        public function desglosaCaract( $cadena ) {
                          if( $cadena !="" ) {
                              $nwTag = array();
                              $tags = explode(',', $cadena);
                              foreach ($tags as $tag) { $nwTag[] = $tag; }
                              return serialize($nwTag);
                          }
        }

        public function desglosaID( $cadena, $ident ) {
                          if( $cadena !="" ) {
                              $nwTag = array();
                              $tags = explode( $ident, $cadena);
                              foreach ($tags as $tag) { $nwTag[] = $tag; }
                              return $nwTag;
                          }
        }

        /*
        * Mueve archivos de un directorio a otro directorio.
        * Move files from one directory to another directory.
         */
        public function rename_win($oldfile,$newfile){
            if(!rename($oldfile,$newfile)){
                if(copy($oldfile,$newfile)){
                    //unlink($oldfile);
                    return TRUE;
                }
                return FALSE;
            }
            return TRUE;
        }




        public function importacion() {

         $errorMS = array();

         /*Importacion de estilos*/
         if (isset($this->request->files['estilos'])) {
             
             if (@move_uploaded_file($this->request->files['estilos']['tmp_name'], DIR_CVS. basename($this->request->files['estilos']['name']))) {
               ini_set ('auto_detect_line_endings','1');
               $fp = fopen(DIR_CVS.$this->request->files['estilos']['name'],"r");
               $error_data = '';
               while ($data = fgetcsv ($fp, 1000, "|")) {

                  if ( count($data) == 10 ) {

                  if ( $this->validaExiste( 'category', 'category_id', $data[0] ) =="" ) {
                      
                    //Anadir a tabla category
                    $q_category = $this->db->query( "INSERT INTO `category` (`category_id`, `image`, `parent_id`, `top`, `column`, `sort_order`, `status`, `date_added`, `date_modified`)
                                                        VALUES (".$data[0].", NULL, '0', '0', '1', '0', '1', '".date( 'Y-m-d H:m:s' )."', '".date( 'Y-m-d H:m:s' )."');" );

                    //fabricantes
                    $manufacturer = $this->db->query( "SELECT * FROM manufacturer WHERE name = '".$data[4]."'" );
                    $mnf_id = '';
                    if ( $manufacturer->num_rows > 0 ) {
                         $mnf_id = $manufacturer->row['manufacturer_id'];
                    } else {
                        if ( (isset($data[4])) && ($data[4]!="") ) {
                            $this->db->query( "INSERT INTO `manufacturer` (`name`,`sort_order`) VALUES ('".$data[4]."', '1')" );
                            $last_mnf = $this->db->query( "SELECT manufacturer_id FROM `manufacturer` ORDER BY `manufacturer_id` DESC LIMIT 1 " );
                            if ( $last_mnf->num_rows > 0 ) {
                                 $this->db->query( "INSERT INTO `manufacturer_to_store` (`manufacturer_id`, `store_id`) VALUES ('".$last_mnf->row['manufacturer_id']."', '0')" );
                                 $mnf_id = $last_mnf->row['manufacturer_id'];
                            }
                        }
                    }

                    //Anadir a tabla category_description
                    $q_category_desc = $this->db->query("INSERT INTO `category_description` (`category_id`,
                                                            `language_id`,
                                                            `name`,
                                                            `description`,
                                                            `meta_description`,
                                                            `meta_keyword`,
                                                            `precio`,
                                                            `composicion`,
                                                            `cuidado`,
                                                            `corte`,
                                                            `caracteristica`,
                                                            `manufacturer_id`
                                                            )
                                                            VALUES (
                                                            ".$data[0].",
                                                            '1',
                                                            '".$data[9]."',
                                                            '".$data[3]."',
                                                            '".$data[9]."',
                                                            '".$data[9]."',
                                                            '".str_replace('$', '', $data[1])."',
                                                            '".$data[5]."',
                                                            '".$data[8]."',
                                                            '".$data[7]."',
                                                            '".$this->desglosaCaract( $data[6] )."',
                                                            '".$mnf_id."'
                                                             );" );

                      //Anadir a category_to_store
                      $q_category_to_st = $this->db->query( "INSERT INTO `category_to_store` (`category_id`, `store_id`) VALUES (".$data[0].", 0)" );
                      
                      //Anadir a url_alias
                      $q_url = $this->db->query( "SELECT * FROM url_alias WHERE query = 'category_id=".$data[0]."'" );
                      if ( $q_url->num_rows <=0 ) {  
                           $this->db->query("INSERT INTO `url_alias` (`query`, `keyword`) VALUES ('category_id=".$data[0]."', '".$this->cleanURL($data[9])."')" );
                      }
   
                  } else {

                    if ( $this->validaExiste( 'category', 'category_id', $data[0] ) !="" ) {


                    //fabricantes
                    $manufacturer = $this->db->query( "SELECT * FROM manufacturer WHERE name = '".$data[4]."'" );
                    $mnf_id = '';
                    if ( $manufacturer->num_rows > 0 ) {
                         $mnf_id = $manufacturer->row['manufacturer_id'];
                    } else {
                        if ( (isset($data[4])) && ($data[4]!="") ) {
                            $this->db->query( "INSERT INTO `manufacturer` (`name`,`sort_order`) VALUES ('".$data[4]."', '1')" );
                            $last_mnf = $this->db->query( "SELECT manufacturer_id FROM `manufacturer` ORDER BY `manufacturer_id` DESC LIMIT 1 " );
                            if ( $last_mnf->num_rows > 0 ) {
                                 $this->db->query( "INSERT INTO `manufacturer_to_store` (`manufacturer_id`, `store_id`) VALUES ('".$last_mnf->row['manufacturer_id']."', '0')" );
                                 $mnf_id = $last_mnf->row['manufacturer_id'];
                            }
                        }
                    }

                        //ACTUALIZAR tabla category_description
                        $q_category_desc = $this->db->query("UPDATE `category_description` SET
                                                            `name` = '".$data[9]."' ,
                                                            `description` = '".$data[3]."',
                                                            `meta_description` = '".$data[9]."',
                                                            `meta_keyword` = '".$data[9]."',
                                                            `precio`=".str_replace('$', '', $data[1]).",
                                                            `composicion` ='".$data[5]."',
                                                            `cuidado` = '".$data[8]."',
                                                            `corte` = '".$data[7]."',
                                                            `caracteristica` = '".$this->desglosaCaract( $data[6] )."',
                                                            `manufacturer_id` = '".$mnf_id."'
                                                             WHERE category_id ='".$data[0]."'" );

                        $this->db->query( "UPDATE `url_alias` SET `keyword` = '".$this->cleanURL($data[9])."' WHERE `query` ='category_id=".$data[0]."'" );


                    } else {
                      $errorMS['estilos'][] =  "no se puede actualizar este estilo <b>item_id(".$data[0]." )</b>, estilo_id inexistente ";
                    }

                  }

                } else {//count data
                    $error_data = 1;
                } // fin count data

               }
               fclose($fp);
               if ( $error_data !="" ) { $errorMS['estilos'][] = "Error al importar estilos, el contenido del archivo <b><i>".$this->request->files['estilos']['name']."</i></b> es incorrecto. "; }

           }

        }
        
        /*Importacion de items(productos)*/
        if (isset($this->request->files['items'])) {
          if (@move_uploaded_file($this->request->files['items']['tmp_name'], DIR_CVS. basename($this->request->files['items']['name']))) {
               ini_set ('auto_detect_line_endings','1');
               $fp = fopen(DIR_CVS.$this->request->files['items']['name'],"r");

               $error_data = '';
               while ($data = fgetcsv ($fp, 1000, "|")) {

                 //Validar tallas
                 $talla = '';
                 if ( isset($data[2]) ) {
                  if ( $this->validaExiste( 'tallas', 'sizes_id', $data[2] ) !="" ) {
                      $talla = $data[2];
                  }
                 }

                 //Validar subtallas
                 $subtalla = '';
                 if ( isset( $data[3] ) ) {
                    if ( $this->validaExiste( 'subtalla', 'secsizes_id ', $data[3] ) !="" ) {
                      $subtalla = $data[3];
                    }
                 }


                if( count( $data ) == 6 ) {

                //Agregar
                if ( isset( $data[0] ) && isset( $data[1] ) ) { //+1

                if ( $this->validaExiste( 'product', 'product_id', $data[0] ) =="" ) {
                 if ( $this->validaExiste( 'category', 'category_id', $data[1] ) !="" ) {

                       $modelo = '';
                       $modelo = $this->validaNombreCat( 'category_description', 'category_id ', $data[1] );

                       //Fabricantes
                       $t = '';
                       $mnf = $this->db->query( "SELECT manufacturer_id, name FROM category_description WHERE category_id = '".$data[1]."'" );
                       if ( $mnf->num_rows > 0 ) {
                            $t = $mnf->row['manufacturer_id'];
                            $this->db->query( "INSERT INTO `product_tag` ( `product_id`, `language_id`,`tag`)
                                                      VALUES ( '".$data[0]."', '1','".$mnf->row['name']."' )" );
                       }

                      //product
                      $this->db->query( "INSERT INTO `product` (`product_id`,
						`model`, 
						`stock_status_id`, 
						`manufacturer_id`,
						`tax_class_id`, 
						`date_available`, 
						`minimum`, 
						`status`, 
						`date_added`, 
						`date_modified`, 
						`talla`, 
						`subtalla`,
						`nombre_color`) 
						VALUES (
						'".$data[0]."',
						'".$modelo."',
						'5', 
						'".$t."',
						'0', 
						'".date( 'Y-m-d H:m:s' )."', 
						'1',
						'1',
						'".date( 'Y-m-d H:m:s' )."', 
						'".date( 'Y-m-d H:m:s' )."', 
						'".$talla."',
						'".$subtalla."',
						'".$data[4]."'
						);" );

                      
                      //product_description
                      $this->db->query( "INSERT INTO `product_description` (`product_id`,
						`language_id`,
						`name`,
						`description`,
						`meta_description`,
						`meta_keyword`)
						VALUES ( 
                                                '".$data[0]."',
                                                '1',
                                                '".$data[5]."',
                                                '".$data[5]."',
                                                '".$data[5]."',
                                                '".$data[5]."'
                                                )" );
                      //product_tag
                      $nom_cat = $this->db->query( "SELECT name FROM category_description WHERE category_id ='".$data[1]."'" );
                      $this->db->query( "INSERT INTO `product_tag` ( `product_id`, `language_id`,`tag`)
                                                        VALUES ( '".$data[0]."', '1','".$nom_cat->row['name']."' )" );
                      
                      $this->db->query( "INSERT INTO `product_tag` ( `product_id`, `language_id`,`tag`)
                                                        VALUES ( '".$data[0]."', '1','".$modelo."' )" );
                      
                      //product_to_category
                      $this->db->query( "INSERT INTO `product_to_category` ( `product_id`, `category_id`)
                                                        VALUES ( '".$data[0]."','".$data[1]."' )" );
                      //product_to_store
                      $this->db->query( "INSERT INTO `product_to_store` ( `product_id`, `store_id`)
                                                        VALUES ( '".$data[0]."','0' )" );


                 } else {
                   $errorMS['items'][] =  "no existe categor&iacute;a (".$data[1]."), no se puede agregar este item_id (".$data[0].")";
                 }
                 
                     

                //Actualizar
                } else {
                
                 //Validar si existe categoria
                 if ( $this->validaExiste( 'category', 'category_id', $data[1] ) !="" ) {

                       $modelo = '';
                       $modelo = $this->validaNombreCat( 'category_description', 'category_id ', $data[1] );

                       //Fabricantes
                       $t = '';
                       $mnf = $this->db->query( "SELECT manufacturer_id FROM category_description WHERE category_id = '".$data[1]."'" );
                       if ( $mnf->num_rows > 0 ) { $t = $mnf->row['manufacturer_id']; }


                      $this->db->query( "UPDATE `product` SET 
                                                `model` ='".$modelo."',
                                                `manufacturer_id` ='".$t."',
						`talla` = '".$talla."',
                                                `subtalla` ='".$subtalla."',
						`nombre_color` = '".$data[4]."'
                                                 WHERE `product_id` = '".$data[0]."' LIMIT 1" );
                      
                      $this->db->query( "UPDATE `product_description` SET
						`name` = '".$data[5]."',
						`description` = '".$data[5]."',
						`meta_description` = '".$data[5]."',
						`meta_keyword` = '".$data[5]."'
                                                WHERE `product_id` = '".$data[0]."' LIMIT 1" );

                      //product_to_category
                      if ( $this->validaExiste( 'product_to_category', 'category_id', $data[1] ) =="" ) {
                           $this->db->query( "INSERT INTO `product_to_category` ( `product_id`, `category_id`)
                                                        VALUES ( '".$data[0]."','".$data[1]."' )" );
                      }

                      //product_tag
                      $this->db->query( "DELETE FROM `product_tag` WHERE `product_id` = '".$data[0]."'" );
                      $prod_cat = $this->db->query( "SELECT tabla2.name FROM `product_to_category` as tabla1
                                                     LEFT JOIN `category_description` as tabla2
                                                     ON tabla2.category_id = tabla1.category_id
                                                     WHERE tabla1.product_id ='".$data[0]."'" );
                      if ( $prod_cat->num_rows > 0 ) {
                           foreach( $prod_cat->rows as $nameProdCat ) {
                             $this->db->query( "INSERT INTO `product_tag` ( `product_id`, `language_id`,`tag`)
                                                            VALUES ( '".$data[0]."', '1','".$nameProdCat['name']."' )" );
                           }
                      }
                      $this->db->query( "INSERT INTO `product_tag` ( `product_id`, `language_id`,`tag`)
                                                        VALUES ( '".$data[0]."', '1','".$modelo."' )" );
                                                        
                      

                 } else {
                   $errorMS['items'][] = "No existe <b><i>categor&oacute;a (".$data[1].")</i></b>, no se puede agregar/actualizar el <b><i>item_id (".$data[0].")</i></b>";
                 }

                } //Fin actualizar

               }//+1

               } else {//Fin Count data
                   $error_data = 1;
               }//Fin Count data

               } //Fin while
               fclose($fp);
               if ( $error_data !="" ) { $errorMS['items'][] = "Error al importar estilos, el contenido del archivo <b><i>".$this->request->files['items']['name']."</i></b> es incorrecto. "; }

           }

        }

        /*
         * SINCRONIZAR IMAGENES
         * CONVENCION DE COLORES
         *
         * Para estilos:
         * I-ID_ESTILO-NUMERO DE FOTO.jpg
         * (ejemplo: I-123454-1.jpg)
         * El número de foto 1 es para la imagen principal, las secundarias serían 2,3 y 4
         *
         * Colores (muestra del cuadrito):
         *C-ID_ITEM_1-ID_ITEM_2-ID_ITEM_3-.....-ID_ITEM_N.jpg
         * (ejemplo: C-34234-435345-345345.jpg)
         *
         * Color (foto de la prenda del color elegido):
         * P-ID_ITEM_1-ID_ITEM_2-ID_ITEM_3-.....-ID_ITEM_N.jpg
         * (ejemplo: P-34234-435345-345345.jpg)
         * 
         */
        if (isset($this->request->post['sinc'])) {
            
            $gd = '';
            $allow = array( 'JPG', 'jpg', 'png', 'PNG', 'gif', 'GIF' );
            $archivo = '';
            $ID_ESTILO = array();
            $count_img = 0;
            if (is_dir(DIR_SINC)) {
                if ($gd = opendir(DIR_SINC)) {

                while ($archivo = readdir($gd)) {
                  
                  $ext = explode( '.', $archivo );
                  if (in_array( $ext[1], $allow ) ) {
                      $count_img++;
                      
                      $tipo = strtolower( $archivo[0] );
                      switch($tipo) {
                        //Estilo
                        case 'i':
                          $id_estilo = $this->desglosaID( $archivo, '-' );
                          if ( $this->validaExiste( 'product_to_category', 'category_id', $id_estilo[1] ) !="" ) {
                               $ID_ESTILO[] = $id_estilo[1];
                               $selected = '';
                               if ( $id_estilo[2] == 1 ) { $selected = 'selected'; }
                               $img_estilo[$id_estilo[1]][] = array( 'img_nom' =>$archivo, 'selected'=>$selected );
                          } else {
                              $errorMS['sinc']['estilo'][] = " No se puede agregar imagen (".$archivo."), <br><b>estilo_id (".$id_estilo[1].")</b> no existente.<p>";
                          }
                          if (!file_exists(DIR_PROD.'/'.$archivo)){
                              $this->rename_win(DIR_SINC.'/'.$archivo, DIR_PROD.'/'.$archivo);
                          }
                           
                        break;
                        //Color
                        case 'c':
                          $id_color = $this->desglosaID( $ext[0], '-' );
                          foreach ( $id_color as $rs_color ) {
                             if ( strtolower($rs_color) != $tipo ) {
                                if ( $this->validaExiste( 'product', 'product_id', $rs_color ) !="" ) {
                                    
                                    $this->db->query("UPDATE `product` SET `color` = 'data/colores/".$archivo."'
                                                        WHERE `product_id` =".$rs_color." LIMIT 1");
                                    
                                } else {
                                    $errorMS['sinc'][] = " No se puede agregar el la imagen/color (".$archivo."), <br><b>item_id (".$rs_color.")</b> no existente.<p>";
                                }
                                
                             }
                          }
                          if (!file_exists(DIR_COLOR.'/'.$archivo)){
                              $this->rename_win(DIR_SINC.'/'.$archivo, DIR_COLOR.'/'.$archivo);
                          }
                        break;
                        //Producto
                        case 'p':
                          $id_color = $this->desglosaID( $ext[0], '-' );
                          foreach ( $id_color as $rs_color ) {
                            if ( strtolower($rs_color) != $tipo ) {
                                if ( $this->validaExiste( 'product', 'product_id', $rs_color ) !="" ) {
                                    $this->db->query("UPDATE `product` SET `image` = 'data/producto/".$archivo."'
                                                        WHERE `product_id` =".$rs_color." LIMIT 1");
                                } else {
                                    $errorMS['sinc'][] = " No se puede agregar el la imagen (".$archivo."), <br><b>item_id (".$rs_color.")</b> no existente.<p>";
                                }
                            }
                          }
                          if (!file_exists(DIR_PROD.'/'.$archivo)){
                              $this->rename_win(DIR_SINC.'/'.$archivo, DIR_PROD.'/'.$archivo);
                          }
                          
                        break;

                      }


                  }
                    
                }
                closedir($gd);
                }

            } else { //Fin leer directorio
                $errorMS['directorio'][] = 'Directorio de imagenes no encotrado.';
            }
            //Actualizar imagenes para estilo
            if ( count( $ID_ESTILO ) > 0 ) {
                 $nw_id = array_unique($ID_ESTILO);
                 foreach ( $nw_id as $rs_id ) {
                    $enc = array();
                    foreach( $img_estilo[$rs_id] as $rs ) {
                        $enc[] = array( 'img_nom' => 'data/producto/'.$rs['img_nom'], 'selected' => $rs['selected'] );
                    }
                    $this->db->query("UPDATE `category_description` SET `imagen_estilo` = '".serialize($enc)."'
                                        WHERE `category_id` =".$rs_id." LIMIT 1");
                }
            }

            if ( $count_img <= 0 ) {
                $errorMS['directorio'][] = 'No hay imagenes disponibles en el directorio.';
            }

        }


                $this->cache->delete('product');
		$this->cache->delete('category');

                $this->data['errorMS'] = $errorMS;
		$this->load->language('catalog/information');
		$this->document->setTitle($this->language->get('heading_title'));
                $this->data['action'] = $this->url->link('catalog/import/importacion', 'token=' . $this->session->data['token'], 'SSL');
		$this->template = 'catalog/import_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		$this->response->setOutput($this->render());

        }

	private function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'id.title';
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
		
		$url = '';
			
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/information', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
							
		$this->data['insert'] = $this->url->link('catalog/information/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('catalog/information/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	

		$this->data['informations'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
		
		$information_total = $this->model_catalog_information->getTotalInformations();
	
		$results = $this->model_catalog_information->getInformations($data);
 
    	foreach ($results as $result) {
			$action = array();
						
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('catalog/information/update', 'token=' . $this->session->data['token'] . '&information_id=' . $result['information_id'] . $url, 'SSL')
			);
						
			$this->data['informations'][] = array(
				'information_id' => $result['information_id'],
				'title'          => $result['title'],
				'sort_order'     => $result['sort_order'],
				'selected'       => isset($this->request->post['selected']) && in_array($result['information_id'], $this->request->post['selected']),
				'action'         => $action
			);
		}	
	
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_title'] = $this->language->get('column_title');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
		$this->data['column_action'] = $this->language->get('column_action');		
		
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
 
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_title'] = $this->url->link('catalog/information', 'token=' . $this->session->data['token'] . '&sort=id.title' . $url, 'SSL');
		$this->data['sort_sort_order'] = $this->url->link('catalog/information', 'token=' . $this->session->data['token'] . '&sort=i.sort_order' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $information_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('catalog/information', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'catalog/information_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
				
		$this->response->setOutput($this->render());
	}

	private function getForm() {
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
    	$this->data['text_disabled'] = $this->language->get('text_disabled');
		
		$this->data['entry_title'] = $this->language->get('entry_title');
		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_keyword'] = $this->language->get('entry_keyword');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
    	
		$this->data['tab_general'] = $this->language->get('tab_general');
    	$this->data['tab_data'] = $this->language->get('tab_data');
		$this->data['tab_design'] = $this->language->get('tab_design');
		
		$this->data['token'] = $this->session->data['token'];

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

 		if (isset($this->error['title'])) {
			$this->data['error_title'] = $this->error['title'];
		} else {
			$this->data['error_title'] = array();
		}
		
	 	if (isset($this->error['description'])) {
			$this->data['error_description'] = $this->error['description'];
		} else {
			$this->data['error_description'] = array();
		}
		
		$url = '';
			
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),     		
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/information', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
							
		if (!isset($this->request->get['information_id'])) {
			$this->data['action'] = $this->url->link('catalog/information/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('catalog/information/update', 'token=' . $this->session->data['token'] . '&information_id=' . $this->request->get['information_id'] . $url, 'SSL');
		}
		
		$this->data['cancel'] = $this->url->link('catalog/information', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['information_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$information_info = $this->model_catalog_information->getInformation($this->request->get['information_id']);
		}
		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		
		if (isset($this->request->post['information_description'])) {
			$this->data['information_description'] = $this->request->post['information_description'];
		} elseif (isset($this->request->get['information_id'])) {
			$this->data['information_description'] = $this->model_catalog_information->getInformationDescriptions($this->request->get['information_id']);
		} else {
			$this->data['information_description'] = array();
		}

		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (isset($information_info)) {
			$this->data['status'] = $information_info['status'];
		} else {
			$this->data['status'] = 1;
		}
		
		$this->load->model('setting/store');
		
		$this->data['stores'] = $this->model_setting_store->getStores();
		
		if (isset($this->request->post['information_store'])) {
			$this->data['information_store'] = $this->request->post['information_store'];
		} elseif (isset($information_info)) {
			$this->data['information_store'] = $this->model_catalog_information->getInformationStores($this->request->get['information_id']);
		} else {
			$this->data['information_store'] = array(0);
		}		
		
		if (isset($this->request->post['keyword'])) {
			$this->data['keyword'] = $this->request->post['keyword'];
		} elseif (isset($information_info)) {
			$this->data['keyword'] = $information_info['keyword'];
		} else {
			$this->data['keyword'] = '';
		}
		
		if (isset($this->request->post['sort_order'])) {
			$this->data['sort_order'] = $this->request->post['sort_order'];
		} elseif (isset($information_info)) {
			$this->data['sort_order'] = $information_info['sort_order'];
		} else {
			$this->data['sort_order'] = '';
		}
		
		if (isset($this->request->post['information_layout'])) {
			$this->data['information_layout'] = $this->request->post['information_layout'];
		} elseif (isset($information_info)) {
			$this->data['information_layout'] = $this->model_catalog_information->getInformationLayouts($this->request->get['information_id']);
		} else {
			$this->data['information_layout'] = array();
		}

		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
				
		$this->template = 'catalog/information_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
				
		$this->response->setOutput($this->render());
	}

	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/information')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['information_description'] as $language_id => $value) {
			if ((strlen(utf8_decode($value['title'])) < 3) || (strlen(utf8_decode($value['title'])) > 64)) {
				$this->error['title'][$language_id] = $this->language->get('error_title');
			}
		
			if (strlen(utf8_decode($value['description'])) < 3) {
				$this->error['description'][$language_id] = $this->language->get('error_description');
			}
		}
		
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
			
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/information')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		$this->load->model('setting/store');
		
		foreach ($this->request->post['selected'] as $information_id) {
			if ($this->config->get('config_account_id') == $information_id) {
				$this->error['warning'] = $this->language->get('error_account');
			}
			
			if ($this->config->get('config_checkout_id') == $information_id) {
				$this->error['warning'] = $this->language->get('error_checkout');
			}
			
			if ($this->config->get('config_affiliate_id') == $information_id) {
				$this->error['warning'] = $this->language->get('error_affiliate');
			}
						
			$store_total = $this->model_setting_store->getTotalStoresByInformationId($information_id);

			if ($store_total) {
				$this->error['warning'] = sprintf($this->language->get('error_store'), $store_total);
			}
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>