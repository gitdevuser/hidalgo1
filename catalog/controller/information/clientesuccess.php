<?php 
class ControllerInformationClientesuccess extends Controller {
	private $error = array(); 
	    
  	public function index() {

                $this->document->setTitle( 'Cliente Distinguido' );
                $this->data['heading_title'] = strtoupper( 'CLIENTE DISTINGUIDO' );
                $this->data['text_message'] = '<p>En poco tiempo recibirá usted su "Tarjeta de Cliente Distinguido".</p><br><br>';

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/success.tpl';
		} else {
			$this->template = 'default/template/common/success.tpl';
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
