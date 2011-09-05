<?php 
class ControllerInformationPrivacidad extends Controller {
	private $error = array(); 
	    
  	public function index() {
                $this->document->setTitle( 'Aviso de Privacidad' );
                $this->data['heading_title'] = 'Aviso de Privacidad';

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
