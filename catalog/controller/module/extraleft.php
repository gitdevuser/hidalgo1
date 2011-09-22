<?php  
class ControllerModuleExtraleft extends Controller {
	protected function index() {
		$this->language->load('module/category');
		
                $this->data['heading_title'] = '';
							
		$this->load->model('catalog/category');
		$this->load->model('catalog/product');
                
                //Descripcion de categoria
                $q_catDesc = $this->db->query( 'SELECT * FROM category_description as tabla1 
                                                LEFT JOIN category as tabla2
                                                ON tabla2.category_id = tabla1.category_id
                                                WHERE tabla1.left_extra_module !="" AND tabla2.parent_id = 0' );
                $extra_info = '';
                $arrayCatInfo = array();
                if ( $q_catDesc->num_rows > 0 ) {
                   foreach ( $q_catDesc->rows as $rs_catdesc ) {
                          $extra_info = unserialize($rs_catdesc['left_extra_module']);
                          foreach ( $extra_info as $rs_ext ) {
                              $links = '';
                              if ( $rs_ext == 1 ) {
                                $links = $this->url->link('product/category', 'path=' . $rs_catdesc['category_id']);
                              } else {
                                $links = $this->url->link('product/category', 'path=' . $rs_catdesc['category_id'].'&modulo_izq='.$rs_ext);
                              }

                            $arrayCatInfo[][$rs_ext] = array(
                                'category_id' => $rs_catdesc['category_id'],
                                'name' => $rs_catdesc['name'],
                                'href' => $links
                            );
                          }
                   }
                }

                $arrayList = array();
                $arrayCatExt = array();
                $q_left_extra = $this->db->query( 'SELECT * FROM left_extra_module WHERE visible=1 ORDER BY weight' );
                if ( $q_left_extra->num_rows > 0 ) {
                     foreach ( $q_left_extra->rows as $rs_left ) {
                         foreach( $arrayCatInfo as $t=>$t_key ) {
                             foreach( $t_key as $rs_t=>$key_rs_t ) {
                                if ( $rs_t == $rs_left['extra_left_id']  ) {
                                     $arrayCatExt[$rs_t][] = array( 
                                                                    'category_id' => $key_rs_t['category_id'],
                                                                    'name' => $key_rs_t['name'],
                                                                    'href' => $key_rs_t['href']
                                                                 );
                                }
                             }
                         }
                         $arrayCat = '';
                         if ( array_key_exists( $rs_left['extra_left_id'] ,$arrayCatExt ) ) {
                              $arrayCat = $arrayCatExt[$rs_left['extra_left_id']];
                         }
                         $arrayList[] = array( 'nombre' => $rs_left['extra_nom'], 'info_cat' => $arrayCat );
                     }
                }

                $this->data['arrayList'] = $arrayList;
                
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/extraleft.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/extraleft.tpl';
		} else {
			$this->template = 'default/template/module/extraleft.tpl';
		}
		
		$this->render();
  	}
}
?>