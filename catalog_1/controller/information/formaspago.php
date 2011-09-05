<?php 
class ControllerInformationFormaspago extends Controller {
	private $error = array(); 
	    
  	public function index() {
		$this->document->setTitle( 'Formas de Pago y seguridad' );
                $this->data['heading_title'] = 'FORMAS DE PAGO Y SEGURIDAD';

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/formaspago.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/formaspago.tpl';
		} else {
			$this->template = 'default/template/information/formaspago.tpl';
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
