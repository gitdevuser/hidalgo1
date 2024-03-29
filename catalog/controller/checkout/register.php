<?php 
class ControllerCheckoutRegister extends Controller {
  	public function index() {
		$this->language->load('checkout/checkout');
		
		$this->load->model('account/customer');
		
		$json = array();
		
		if ($this->customer->isLogged()) {
			$json['redirect'] = $this->url->link('checkout/checkout', '', 'SSL');			
		}
		
		if ((!$this->cart->hasProducts() && (!isset($this->session->data['vouchers']) || !$this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$json['redirect'] = $this->url->link('checkout/cart');				
		}
					
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if (!$json) {			
				if ((strlen(utf8_decode($this->request->post['firstname'])) < 1) || (strlen(utf8_decode($this->request->post['firstname'])) > 32)) {
					$json['error']['firstname'] = $this->language->get('error_firstname');
				}
		
				if ((strlen(utf8_decode($this->request->post['lastname'])) < 1) || (strlen(utf8_decode($this->request->post['lastname'])) > 32)) {
					$json['error']['lastname'] = $this->language->get('error_lastname');
				}
		
				if ((strlen(utf8_decode($this->request->post['email'])) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
					$json['error']['email'] = $this->language->get('error_email');
				}
		
				if ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
					$json['error']['warning'] = $this->language->get('error_exists');
				}
				
				if ((strlen(utf8_decode($this->request->post['telephone'])) < 3) || (strlen(utf8_decode($this->request->post['telephone'])) > 32)) {
					$json['error']['telephone'] = $this->language->get('error_telephone');
				}
		
				if ((strlen(utf8_decode($this->request->post['address_1'])) < 3) || (strlen(utf8_decode($this->request->post['address_1'])) > 128)) {
					$json['error']['address_1'] = $this->language->get('error_address_1');
				}
		
				if ((strlen(utf8_decode($this->request->post['city'])) < 2) || (strlen(utf8_decode($this->request->post['city'])) > 128)) {
					$json['error']['city'] = $this->language->get('error_city');
				}
		
				$this->load->model('localisation/country');
				
				$country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);
				
				if ($country_info && $country_info['postcode_required'] && (strlen(utf8_decode($this->request->post['postcode'])) < 2) || (strlen(utf8_decode($this->request->post['postcode'])) > 10)) {
					$json['error']['postcode'] = $this->language->get('error_postcode');
				}
		
				if ($this->request->post['country_id'] == '') {
					$json['error']['country'] = $this->language->get('error_country');
				}
				
				if ($this->request->post['zone_id'] == '') {
					$json['error']['zone'] = $this->language->get('error_zone');
				}
		
				if ((strlen(utf8_decode($this->request->post['password'])) < 4) || (strlen(utf8_decode($this->request->post['password'])) > 20)) {
					$json['error']['password'] = $this->language->get('error_password');
				}
		
				if ($this->request->post['confirm'] != $this->request->post['password']) {
					$json['error']['confirm'] = $this->language->get('error_confirm');
				}

                                /*Composturas*/
				if ($this->request->post['si_comp'] != '') {
                                    $q_compostura = $this->db->query( 'SELECT * FROM compostura' );
                                    if ( $q_compostura->num_rows > 0 ) {
                                        if ( $q_compostura->num_rows > 0 ) {
                                            $this->data['compostura'] = $q_compostura->rows;
                                        }
                                    }

				}

				if ($this->config->get('config_account_id')) {
					$this->load->model('catalog/information');
					
					$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));
					
					if ($information_info && !isset($this->request->post['agree'])) {
						$json['error']['warning'] = sprintf($this->language->get('error_agree'), $information_info['title']);
					}
				}
			}
			
			if (!$json) {
				$this->model_account_customer->addCustomer($this->request->post);
				
				$this->customer->login($this->request->post['email'], $this->request->post['password']);
				
				$this->session->data['payment_address_id'] = $this->customer->getAddressId();
				
				if (isset($this->request->post['shipping_address']) && $this->request->post['shipping_address']) {
					$this->session->data['shipping_address_id'] = $this->customer->getAddressId();
				}
				
				$this->tax->setZone($this->request->post['country_id'], $this->request->post['zone_id']);	
					
				unset($this->session->data['guest']);
				unset($this->session->data['shipping_methods']);
				unset($this->session->data['shipping_method']);
				unset($this->session->data['payment_methods']);
				unset($this->session->data['payment_method']);							
			}
		} else {
			$this->data['text_select'] = $this->language->get('text_select');
			$this->data['text_your_details'] = $this->language->get('text_your_details');
			$this->data['text_your_address'] = $this->language->get('text_your_address');
			$this->data['text_your_password'] = $this->language->get('text_your_password');
					
			$this->data['entry_firstname'] = $this->language->get('entry_firstname');
			$this->data['entry_lastname'] = $this->language->get('entry_lastname');
			$this->data['entry_email'] = $this->language->get('entry_email');
			$this->data['entry_telephone'] = $this->language->get('entry_telephone');
			$this->data['entry_fax'] = $this->language->get('entry_fax');
			$this->data['entry_company'] = $this->language->get('entry_company');
			$this->data['entry_address_1'] = $this->language->get('entry_address_1');
			$this->data['entry_address_2'] = $this->language->get('entry_address_2');
			$this->data['entry_postcode'] = $this->language->get('entry_postcode');
			$this->data['entry_city'] = $this->language->get('entry_city');
			$this->data['entry_country'] = $this->language->get('entry_country');
			$this->data['entry_zone'] = $this->language->get('entry_zone');
			$this->data['entry_newsletter'] = sprintf($this->language->get('entry_newsletter'), $this->config->get('config_name'));
			$this->data['entry_password'] = $this->language->get('entry_password');
			$this->data['entry_confirm'] = $this->language->get('entry_confirm');
			$this->data['entry_shipping'] = $this->language->get('entry_shipping');
	
			$this->data['button_continue'] = $this->language->get('button_continue');
	
			$this->data['country_id'] = $this->config->get('config_country_id');

                        $this->data['compostura'] = '';
                        $q_compostura = $this->db->query( 'SELECT * FROM compostura' );
                        if ( $q_compostura->num_rows > 0 ) {
                             $this->data['compostura'] = $q_compostura->rows;
                        }

			$this->load->model('localisation/country');
			
			$this->data['countries'] = $this->model_localisation_country->getCountries();
	
			if ($this->config->get('config_account_id')) {
				$this->load->model('catalog/information');
				
				$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));
				
				if ($information_info) {
					$this->data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/info', 'information_id=' . $this->config->get('config_account_id'), 'SSL'), $information_info['title'], $information_info['title']);
				} else {
					$this->data['text_agree'] = '';
				}
			} else {
				$this->data['text_agree'] = '';
			}
			
			$this->data['shipping_required'] = $this->cart->hasShipping();
			
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/register.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/checkout/register.tpl';
			} else {
				$this->template = 'default/template/checkout/register.tpl';
			}
					
			$json['output'] = $this->render();		
		}
		
		$this->load->library('json');
		
		$this->response->setOutput(Json::encode($json));			
  	}
	
  	public function zone() {
		$output = '<option value="">' . $this->language->get('text_select') . '</option>';
		
		$this->load->model('localisation/zone');

    	$results = $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']);
        
      	foreach ($results as $result) {
        	$output .= '<option value="' . $result['zone_id'] . '"';
	
	    	if (isset($this->request->get['zone_id']) && ($this->request->get['zone_id'] == $result['zone_id'])) {
	      		$output .= ' selected="selected"';
	    	}
	
	    	$output .= '>' . $result['name'] . '</option>';
    	} 
		
		if (!$results) {
		  	$output .= '<option value="0">' . $this->language->get('text_none') . '</option>';
		}
	
		$this->response->setOutput($output);
  	}	
}
?>