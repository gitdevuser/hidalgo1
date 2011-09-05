<?php 
class ControllerInformationFaq extends Controller {
	private $error = array(); 
	    
  	public function index() {

                $this->document->setTitle( 'Preguntas Frecuentes' );
                $this->data['heading_title'] = 'PREGUNTAS FRECUENTES';

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/faq.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/faq.tpl';
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
