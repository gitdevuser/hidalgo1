<?php  
class ControllerCommonFooter extends Controller {
	protected function index() {
		$this->language->load('common/footer');
		
		$this->data['text_information'] = $this->language->get('text_information');
		$this->data['text_service'] = $this->language->get('text_service');
		$this->data['text_extra'] = $this->language->get('text_extra');
		$this->data['text_account'] = $this->language->get('text_account');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['text_return'] = $this->language->get('text_return');
    	$this->data['text_sitemap'] = $this->language->get('text_sitemap');
		$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$this->data['text_voucher'] = $this->language->get('text_voucher');
		$this->data['text_affiliate'] = $this->language->get('text_affiliate');
		$this->data['text_special'] = $this->language->get('text_special');
		$this->data['text_account'] = $this->language->get('text_account');
		$this->data['text_order'] = $this->language->get('text_order');
		$this->data['text_wishlist'] = $this->language->get('text_wishlist');
		$this->data['text_newsletter'] = $this->language->get('text_newsletter');
		
		$this->load->model('catalog/information');
		
		$this->data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
      		$this->data['informations'][] = array(
        		'title' => $result['title'],
	    		'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
      		);
    	}

		$this->data['contact'] = $this->url->link('information/contact');
		$this->data['return'] = $this->url->link('account/return/insert', '', 'SSL');
                $this->data['sitemap'] = $this->url->link('information/sitemap');
		$this->data['manufacturer'] = $this->url->link('product/manufacturer', '', 'SSL');
		$this->data['voucher'] = $this->url->link('checkout/voucher', '', 'SSL');
		$this->data['affiliate'] = $this->url->link('affiliate/account', '', 'SSL');
		$this->data['special'] = $this->url->link('product/special');
		$this->data['account'] = $this->url->link('account/account', '', 'SSL');
		$this->data['order'] = $this->url->link('account/order', '', 'SSL');
		$this->data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$this->data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');

                /* Ligas */
                $this->data['liga_faq'] = '';
                $this->data['liga_contact'] = '';
                $this->data['liga_sucursales'] = '';
                $this->data['liga_priv'] = '';
                $this->data['liga_polVenta'] = '';
                $this->data['liga_polEnvio'] = '';
                $this->data['cliente_dist'] = '';
                $this->data['liga_formaPago'] = '';
                $q_ligas = $this->db->query('SELECT * FROM information ORDER BY `sort_order` ASC ');
                if( $q_ligas->num_rows > 0 ) {
                    foreach( $q_ligas->rows as $rs_ligas ) {
                      if( $rs_ligas['status'] != 0 ) {
                        if ( $rs_ligas['information_id'] == 3 ) {
                            $this->data['liga_sucursales'] = $this->url->link('information/sucursales');
                        }
                        if ( $rs_ligas['information_id'] == 6 ) {
                            $this->data['liga_contact'] = $this->url->link('information/contact');
                        }
                        if ( $rs_ligas['information_id'] == 4 ) {
                            $this->data['liga_faq'] = $this->url->link('information/faq');
                        }
                        if ( $rs_ligas['information_id'] == 5 ) {
                            $this->data['liga_priv'] = $this->url->link('information/privacidad');
                        }
                        if ( $rs_ligas['information_id'] == 8 ) {
                            $this->data['liga_polVenta'] = $this->url->link('information/politicasventa');
                        }
                        if ( $rs_ligas['information_id'] == 9 ) {
                            $this->data['liga_polEnvio'] = $this->url->link('information/envio');
                        }
                        if ( $rs_ligas['information_id'] == 11 ) {
                            $this->data['cliente_dist'] = $this->url->link('information/clientedist');
                        }
                        if ( $rs_ligas['information_id'] == 10 ) {
                            $this->data['liga_formaPago'] = $this->url->link('information/formaspago');
                        }

                      }
                    }
                }

                $this->data['liga_sizechart'] = $this->url->link('information/sizechart');


		$this->data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/footer.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/footer.tpl';
		} else {
			$this->template = 'default/template/common/footer.tpl';
		}
		
		$this->render();
	}
}
?>