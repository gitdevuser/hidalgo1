<?php 
class ControllerInformationPrivacidad extends Controller {
	private $error = array(); 
	    
  	public function index() {

                $this->load->model('catalog/information');
                $information_info = $this->model_catalog_information->getInformation(5);

                $this->document->setTitle( $information_info['title'] );
                $this->data['heading_title'] = strtoupper( $information_info['title'] );
                $this->data['desc'] = html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');


		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/privacidad.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/privacidad.tpl';
		} else {
			$this->template = 'default/template/information/privacidad.tpl';
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
