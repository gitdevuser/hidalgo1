<?php 
class ControllerInformationSucursales extends Controller {
	private $error = array(); 
	    
  	public function index() {
			
                $this->language->load('information/sucursales');
                $this->document->setTitle( 'Sucursales' );
                $this->data['heading_title'] = $this->language->get('heading_title');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/sucursales.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/sucursales.tpl';
		} else {
			$this->template = 'default/template/information/sucursales.tpl';
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
