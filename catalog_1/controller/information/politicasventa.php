<?php 
class ControllerInformationPoliticasventa extends Controller {
	private $error = array(); 
	    
  	public function index() {
		$this->document->setTitle( 'Pol&iacute;tica de venta y devoluciones' );
                $this->data['heading_title'] = 'POL&Iacute;TICAS DE VENTA Y DEVOLUCIONES';

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
