<?php 
class ControllerInformationPoliticasventa extends Controller {
	private $error = array(); 
	    
  	public function index() {
                
                $desc = $this->db->query( "SELECT * FROM information_description WHERE information_id = '8'" );
                
                $this->document->setTitle( $desc->row['title'] );
                $this->data['heading_title'] = strtoupper( $desc->row['title'] );
                $this->data['desc'] = html_entity_decode($desc->row['description'], ENT_QUOTES, 'UTF-8');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/politicasventa.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/politicasventa.tpl';
		} else {
			$this->template = 'default/template/information/politicasventa.tpl';
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
?>
