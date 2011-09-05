<?php 
class ControllerInformationSizechart extends Controller {
	private $error = array(); 
	    
  	public function index() {
                $this->document->setTitle( 'Tabla de medidas Tallas' );
                $this->data['heading_title'] = 'TABLA DE MEDIDAS <span style="color:#999999;" >(TALLAS)</span>';
                $this->data['sizechart_title1'] = 'Camisa de Vestir';
                $this->data['sizechart_title2'] = 'Polos, Sweaters y Chalecos / Chamarras y Abrigos';
                $this->data['sizechart_title3'] = 'Trajes y Sacos';

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/sizechart.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/sizechart.tpl';
		} else {
			$this->template = 'default/template/information/sizechart.tpl';
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
