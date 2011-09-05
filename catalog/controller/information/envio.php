<?php 
class ControllerInformationEnvio extends Controller {
	private $error = array(); 
	    
  	public function index() {

                $this->document->setTitle( 'Pol&iacute;tica de env&iacute;o' );
                $this->data['heading_title'] = 'Envio';

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/envio.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/envio.tpl';
		} else {
			$this->template = 'default/template/information/envio.tpl';
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
