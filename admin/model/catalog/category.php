<?php
class ModelCatalogCategory extends Model {

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

	public function addCategory($data) {


		$this->db->query("INSERT INTO " . DB_PREFIX . "category SET parent_id = '" . (int)$data['parent_id'] . "', `top` = '" . (isset($data['top']) ? (int)$data['top'] : 0) . "', `column` = '" . (int)$data['column'] . "', sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', date_modified = NOW(), date_added = NOW()");
	
		$category_id = $this->db->getLastId();
		
		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "category SET image = '" . $this->db->escape($data['image']) . "' WHERE category_id = '" . (int)$category_id . "'");
		}


		foreach ($data['category_description'] as $language_id => $value) {

			$this->db->query("INSERT INTO " . DB_PREFIX . "category_description SET
                                          category_id = '" . (int)$category_id . "',
                                          language_id = '" . (int)$language_id . "',
                                          name = '" . $this->db->escape($value['name']) . "',
                                          meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "',
                                          meta_description = '" . $this->db->escape($value['meta_description']) . "',
                                          description = '" . $this->db->escape($value['description']) . "'");
		}

                   /* Agregar campos adicionales */
                   $precio = '';
                   $descuento = '';
		   $imagen_estilo = '';
                   if ( is_numeric( $data['precio'] ) ) { $precio = $data['precio']; }
                   if ( is_numeric( $data['descuento'] ) ) { $descuento = $data['descuento']; }

                   //Imagenes adicionales
                   $arrCompleto = array();
                   if ( isset( $data['image_cat'] ) ) {
                   foreach( $data['image_cat'] as $rs_cmp ) {
                       if ( $rs_cmp !="" ) {
                            $arrCompleto[] = $rs_cmp;
                       }
                   }
                   }
                   if( count( $arrCompleto ) > 0 ) { $imagen_estilo = serialize( $arrCompleto ); }

                   //Caracteristicas
                   $arrCaract = array();
                   $crt = '';
                   if ( isset( $data['caract'] ) ) {
                   foreach( $data['caract'] as $rs_caract ) {
                            if( $rs_caract !="" ) {
                                $arrCaract[] = $rs_caract;
                            }
                   }
                   }
                   if( count( $arrCaract ) > 0 ) { $crt = serialize( $arrCaract ); }

                   // Bloque Columna Izquierda
                   $arrExtraLeft = array();
                   $extra_left = '';
                   if ( isset( $data['colizq'] ) ) {
                   foreach( $data['colizq'] as $rs_ext ) {
                       if ( $rs_ext !="" ) {
                            $arrExtraLeft[] = $rs_ext;
                       }
                   }
                   }
                    if( count( $arrExtraLeft ) > 0 ) { $extra_left = serialize( $arrExtraLeft ); }

                   $this->db->query("UPDATE " . DB_PREFIX . "category_description SET
                        precio = '" . $precio . "',
                        composicion = '" .$this->db->escape($data['composicion']). "',
                        cuidado = '" .$this->db->escape($data['cuidado']). "',
                        corte = '" .$this->db->escape($data['cuidado']). "',
                                            caracteristica = '" . $crt . "',
                                            descuento = '" . $this->db->escape( $descuento ) . "',
                                            imagen_estilo = '" . $imagen_estilo . "',
                                            left_extra_module = '" .$extra_left. "'

                       WHERE category_id = '" . (int)$category_id . "'");

                   

		if (isset($data['category_store'])) {
			foreach ($data['category_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_to_store SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		if (isset($data['category_layout'])) {
			foreach ($data['category_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "category_to_layout SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}
						
		if ($data['keyword']) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'category_id=" . (int)$category_id . "', keyword = '" . $this->cleanURL( $data['keyword'] ) . "'");
		}
		
		$this->cache->delete('category');
	}
	
	public function editCategory($category_id, $data) {

		$this->db->query("UPDATE " . DB_PREFIX . "category SET parent_id = '" . (int)$data['parent_id'] . "',
                                        `top` = '" . (isset($data['top']) ? (int)$data['top'] : 0) . "',
                                        `column` = '" . (int)$data['column'] . "',
                                         sort_order = '" . (int)$data['sort_order'] . "',
                                         status = '" . (int)$data['status'] . "',
                                         date_modified = NOW() WHERE category_id = '" . (int)$category_id . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "category SET image = '" . $this->db->escape($data['image']) . "' WHERE category_id = '" . (int)$category_id . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int)$category_id . "'");

                $nombre = '';
		foreach ($data['category_description'] as $language_id => $value) {
                   $precio = '';
                   $descuento = '';
		   $imagen_estilo = '';
                   if ( is_numeric( $data['precio'] ) ) { $precio = $data['precio']; }
                   if ( is_numeric( $data['descuento'] ) ) { $descuento = $data['descuento']; }
                   
                   /* Imagenes adicionales */
                   $arrCompleto = array();
                   if ( isset( $data['image_cat'] ) ) {
                   foreach( $data['image_cat'] as $rs_cmp ) {
                       if ( $rs_cmp !="" ) {
                            $arrCompleto[] = $rs_cmp;
                       }
                   }
                   }
                   if( count( $arrCompleto ) > 0 ) { $imagen_estilo = serialize( $arrCompleto ); }
                   
                   /*Caracteristicas*/
                   $arrCaract = array();
                   $crt = '';
                   if ( isset( $data['caract'] ) ) {
                   foreach( $data['caract'] as $rs_caract ) {
                            if( $rs_caract !="" ) {
                                $arrCaract[] = $rs_caract;
                            }
                   }
                   }
                   if( count( $arrCaract ) > 0 ) { $crt = serialize( $arrCaract ); }
                   
                   /* Columna Izquierda */
                   $arrExtraLeft = array();
                   $extra_left = '';
                   if ( isset( $data['colizq'] ) ) {
                   foreach( $data['colizq'] as $rs_ext ) {
                       if ( $rs_ext !="" ) {
                            $arrExtraLeft[] = $rs_ext;
                       }
                   }
                   }

                   $nombre = $value['name'];

                   if( count( $arrExtraLeft ) > 0 ) { $extra_left = serialize( $arrExtraLeft ); }

			$this->db->query("INSERT INTO " . DB_PREFIX . "category_description SET category_id = '" . (int)$category_id . "', 
                                            language_id = '" . (int)$language_id . "',
                                            name = '" . $this->db->escape($value['name']) . "',
                                            meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "',
                                            meta_description = '" . $this->db->escape($value['meta_description']) . "',
                                            description = '" . $this->db->escape($value['description']) . "',
                                            precio = '" . $this->db->escape( $precio ) . "',
                                            composicion = '" . $this->db->escape($data['composicion']) . "',
                                            cuidado = '" . $this->db->escape($data['cuidado']) . "',
                                            corte = '" . $this->db->escape($data['corte']) . "',
                                            caracteristica = '" . $crt . "',
                                            descuento = '" . $this->db->escape( $descuento ) . "',
                                            imagen_estilo = '" . $imagen_estilo . "',
                                            left_extra_module = '" .$extra_left. "'
                                         ");
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_to_store WHERE category_id = '" . (int)$category_id . "'");
		
		if (isset($data['category_store'])) {		
			foreach ($data['category_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_to_store SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int)$category_id . "'");

		if (isset($data['category_layout'])) {
			foreach ($data['category_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "category_to_layout SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}
						
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'category_id=" . (int)$category_id. "'");
		
		if ($nombre) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'category_id=" . (int)$category_id . "', keyword = '" . $this->cleanURL( $nombre ) . "'");
		}
		
		$this->cache->delete('category');
	}
	
	public function deleteCategory($category_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "category WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_to_store WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'category_id=" . (int)$category_id . "'");
		
		$query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "category WHERE parent_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$this->deleteCategory($result['category_id']);
		}
		
		$this->cache->delete('category');
	} 

	public function getCategory($category_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'category_id=" . (int)$category_id . "') AS keyword FROM " . DB_PREFIX . "category WHERE category_id = '" . (int)$category_id . "'");
		
		return $query->row;
	} 
	
	public function getCategories($parent_id) {
		$category_data = $this->cache->get('category.' . $this->config->get('config_language_id') . '.' . $parent_id);
	
		if (!$category_data) {
			$category_data = array();
		
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) WHERE c.parent_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name ASC");
		
			foreach ($query->rows as $result) {
				$category_data[] = array(
					'category_id' => $result['category_id'],
					'name'        => $this->getPath($result['category_id'], $this->config->get('config_language_id')),
					'status'  	  => $result['status'],
					'sort_order'  => $result['sort_order']
				);
			
				$category_data = array_merge($category_data, $this->getCategories($result['category_id']));
			}	
	
			$this->cache->set('category.' . $this->config->get('config_language_id') . '.' . $parent_id, $category_data);
		}
		
		return $category_data;
	}
	
	public function getPath($category_id) {
		$query = $this->db->query("SELECT name, parent_id FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) WHERE c.category_id = '" . (int)$category_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name ASC");
		
		$category_info = $query->row;
		
		if ($category_info['parent_id']) {
			return $this->getPath($category_info['parent_id'], $this->config->get('config_language_id')) . $this->language->get('text_separator') . $category_info['name'];
		} else {
			return $category_info['name'];
		}
	}
	
	public function getCategoryDescriptions($category_id) {
		$category_description_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int)$category_id . "'");
		
		foreach ($query->rows as $result) {
			$category_description_data[$result['language_id']] = array(
				'name'             => $result['name'],
				'meta_keyword'     => $result['meta_keyword'],
				'meta_description' => $result['meta_description'],
				'description'      => $result['description'],
                                'precio'           => $result['precio'],
                                'composicion'      => $result['composicion'],
                                'cuidado'          => $result['cuidado'],
                                'corte'            => $result['corte'],
                                'caracteristica'   => $result['caracteristica'],
                                'descuento'        => $result['descuento'],
                                'imagen_estilo'    => $result['imagen_estilo'],
                                'left_extra_module'=> $result['left_extra_module']
			);
		}
		
		return $category_description_data;
	}

        /* Extra Module */
        public function getExtraLeftModule(){
                $q_left_extra = $this->db->query( 'SELECT * FROM left_extra_module' );
                if ( $q_left_extra->num_rows > 0 ) {
                    return $q_left_extra->rows;
                } else {
                    return false;
                }
        }
	
	public function getCategoryStores($category_id) {
		$category_store_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_store WHERE category_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$category_store_data[] = $result['store_id'];
		}
		
		return $category_store_data;
	}

	public function getCategoryLayouts($category_id) {
		$category_layout_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int)$category_id . "'");
		
		foreach ($query->rows as $result) {
			$category_layout_data[$result['store_id']] = $result['layout_id'];
		}
		
		return $category_layout_data;
	}
		
	public function getTotalCategories() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category");
		
		return $query->row['total'];
	}	
		
	public function getTotalCategoriesByImageId($image_id) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category WHERE image_id = '" . (int)$image_id . "'");
		
		return $query->row['total'];
	}

	public function getTotalCategoriesByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}		
}
?>