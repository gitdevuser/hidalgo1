<?php
class ControllerCommonFooter extends Controller {   
	protected function index() {
		$this->load->language('common/footer');
		
		$this->data['text_footer'] = '<a href="http://bitlab.com.mx">Bitlab e-comerce '.date('Y').'</a>';
		
		$this->template = 'common/footer.tpl';
	
    	$this->render();
  	}
}
?>