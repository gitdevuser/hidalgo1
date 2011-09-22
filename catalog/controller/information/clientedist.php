<?php 
class ControllerInformationClientedist extends Controller {
	private $error = array(); 

        public function htmlMailCD( $cliente_dist ){

              $html = '<style>
                  #tabla-mail {
                    border:1px solid #CCCCCC;
                    font-family: Arial;
                    line-height: normal;
                    width: 500px;
                    color: #666666;
                  }
                  #tabla-mail .ttl,
                  #tabla-mail th
                  {
                    text-align: left;
                    font-weight: bold;
                    padding: 5px;
                    color: #000;
                  }
                  #tabla-mail .ttl {
                    width: 100px;
                  }
                  #tabla-mail th {
                    background-color: #CC6633;
                    color: #fff;
                    text-transform: uppercase;
                  }
              </style>';
            $html .= '<table id="tabla-mail" class="ExternalClass" >';
            $html .= '<tr><th colspan="2">Nuevo Cliente distinguido</th></tr>';
            foreach ( $cliente_dist as $key=>$val ) {
            $key = ucwords($key);
            $titulo = '';
            switch( $key ) {
              case 'Cp':
                $titulo = 'C&oacute;digo Postal';
              break;
              case 'Direccion':
                $titulo = 'Direcci&oacute;n';
              break;
              case 'Delegacion':
                $titulo = 'Delegaci&oacute;n';
              break;
              case 'Telefono':
                $titulo = 'Tel&eacute;fono';
              break;
              default :
                $titulo = $key;
              break;
            }
            if ( $key == 'cp' ){ $titulo = 'C&oacute;digo postal'; }
             $html .= ' <tr>
                         <td class="ttl" >'.$titulo.':</td>
                         <td align="left">'.$val.'</td>
                        </tr>';
              
            }
            $html .= '</table>';
            return $html;

        }

  	public function index() {

            $this->language->load('account/register');

            $desc = $this->db->query( "SELECT * FROM information_description WHERE information_id = '11'" );

            $this->document->setTitle( $desc->row['title'] );
            $this->data['heading_title'] = strtoupper( $desc->row['title'] );
            $this->data['desc'] = html_entity_decode($desc->row['description'], ENT_QUOTES, 'UTF-8');

            if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

                       $info_dist = array(  'nombre'     => $this->request->post['firstname'],
                                            'apellido'   => $this->request->post['lastname'],
                                            'cp'         => $this->request->post['postcode'],
                                            'direccion'  => $this->request->post['address_1'],
                                            'colonia'    => $this->request->post['colonia'],
                                            'delegacion' => $this->request->post['deleg'],
                                            'ciudad'     => $this->request->post['city'],
                                            'telefono'   => $this->request->post['telephone_ini'].' '.$this->request->post['telephone'],
                                            'celular'    => $this->request->post['cell_ini'].' '.$this->request->post['cell'],
                                            'email'      => $this->request->post['email']
                                          );

			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->hostname = $this->config->get('config_smtp_host');
			$mail->username = $this->config->get('config_smtp_username');
			$mail->password = $this->config->get('config_smtp_password');
			$mail->port = $this->config->get('config_smtp_port');
			$mail->timeout = $this->config->get('config_smtp_timeout');
			$mail->setTo($this->config->get('config_email'));
	  		$mail->setFrom($this->request->post['email']);
	  		$mail->setSender('NUEVO CLIENTE DISINGUIDO');
	  		$mail->setSubject(sprintf('cliente distinguido', $this->request->post['firstname']));
	  		$mail->setHtml($this->htmlMailCD($info_dist));
                        $mail->send();

                        $this->redirect($this->url->link('information/clientesuccess'));
            }

            $this->data['text_yes'] = $this->language->get('text_yes');
            $this->data['text_no'] = $this->language->get('text_no');
            $this->data['text_select'] = $this->language->get('text_select');
            $this->data['text_account_already'] = sprintf($this->language->get('text_account_already'), $this->url->link('account/login', '', 'SSL'));
            $this->data['text_your_details'] = $this->language->get('text_your_details');
            $this->data['text_your_address'] = $this->language->get('text_your_address');
            $this->data['text_your_password'] = $this->language->get('text_your_password');
            $this->data['text_newsletter'] = $this->language->get('text_newsletter');

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
            $this->data['entry_newsletter'] = $this->language->get('entry_newsletter');
            $this->data['entry_password'] = $this->language->get('entry_password');
            $this->data['entry_confirm'] = $this->language->get('entry_confirm');

		$this->data['button_continue'] = $this->language->get('button_continue');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['firstname'])) {
			$this->data['error_firstname'] = $this->error['firstname'];
		} else {
			$this->data['error_firstname'] = '';
		}

		if (isset($this->error['lastname'])) {
			$this->data['error_lastname'] = $this->error['lastname'];
		} else {
			$this->data['error_lastname'] = '';
		}

		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
		}

		if (isset($this->error['telephone_ini'])) {
			$this->data['error_telephone_ini'] = $this->error['telephone_ini'];
		} else {
			$this->data['error_telephone_ini'] = '';
		}

		if (isset($this->error['telephone'])) {
			$this->data['error_telephone'] = $this->error['telephone'];
		} else {
			$this->data['error_telephone'] = '';
		}

		if (isset($this->error['cell_ini'])) {
			$this->data['error_cell_ini'] = $this->error['cell_ini'];
		} else {
			$this->data['error_cell_ini'] = '';
		}

		if (isset($this->error['cell'])) {
			$this->data['error_cell'] = $this->error['cell'];
		} else {
			$this->data['error_cell'] = '';
		}

		if (isset($this->error['password'])) {
			$this->data['error_password'] = $this->error['password'];
		} else {
			$this->data['error_password'] = '';
		}

 		if (isset($this->error['confirm'])) {
			$this->data['error_confirm'] = $this->error['confirm'];
		} else {
			$this->data['error_confirm'] = '';
		}

  		if (isset($this->error['address_1'])) {
			$this->data['error_address_1'] = $this->error['address_1'];
		} else {
			$this->data['error_address_1'] = '';
		}

		if (isset($this->error['city'])) {
			$this->data['error_city'] = $this->error['city'];
		} else {
			$this->data['error_city'] = '';
		}

		if (isset($this->error['postcode'])) {
			$this->data['error_postcode'] = $this->error['postcode'];
		} else {
			$this->data['error_postcode'] = '';
		}

		if (isset($this->error['country'])) {
			$this->data['error_country'] = $this->error['country'];
		} else {
			$this->data['error_country'] = '';
		}

		if (isset($this->error['deleg'])) {
			$this->data['error_deleg'] = $this->error['deleg'];
		} else {
			$this->data['error_deleg'] = '';
		}

		if (isset($this->error['colonia'])) {
			$this->data['error_colonia'] = $this->error['colonia'];
		} else {
			$this->data['error_colonia'] = '';
		}

                $this->data['action'] = $this->url->link('information/clientedist', '', 'SSL');

		if (isset($this->request->post['firstname'])) {
    		$this->data['firstname'] = $this->request->post['firstname'];
		} else {
			$this->data['firstname'] = '';
		}

		if (isset($this->request->post['lastname'])) {
    		$this->data['lastname'] = $this->request->post['lastname'];
		} else {
			$this->data['lastname'] = '';
		}

		if (isset($this->request->post['email'])) {
    		$this->data['email'] = $this->request->post['email'];
		} else {
			$this->data['email'] = '';
		}

		if (isset($this->request->post['telephone_ini'])) {
    		$this->data['telephone_ini'] = $this->request->post['telephone_ini'];
		} else {
			$this->data['telephone_ini'] = '';
		}

		if (isset($this->request->post['telephone'])) {
    		$this->data['telephone'] = $this->request->post['telephone'];
		} else {
			$this->data['telephone'] = '';
		}

		if (isset($this->request->post['cell_ini'])) {
    		$this->data['cell_ini'] = $this->request->post['cell_ini'];
		} else {
			$this->data['cell_ini'] = '';
		}

		if (isset($this->request->post['cell'])) {
    		$this->data['cell'] = $this->request->post['cell'];
		} else {
			$this->data['cell'] = '';
		}

		if (isset($this->request->post['fax'])) {
    		$this->data['fax'] = $this->request->post['fax'];
		} else {
			$this->data['fax'] = '';
		}

		if (isset($this->request->post['company'])) {
    		$this->data['company'] = $this->request->post['company'];
		} else {
			$this->data['company'] = '';
		}

		if (isset($this->request->post['address_1'])) {
    		$this->data['address_1'] = $this->request->post['address_1'];
		} else {
			$this->data['address_1'] = '';
		}

		if (isset($this->request->post['address_2'])) {
    		$this->data['address_2'] = $this->request->post['address_2'];
		} else {
			$this->data['address_2'] = '';
		}

		if (isset($this->request->post['postcode'])) {
    		$this->data['postcode'] = $this->request->post['postcode'];
		} else {
			$this->data['postcode'] = '';
		}

		if (isset($this->request->post['city'])) {
    		$this->data['city'] = $this->request->post['city'];
		} else {
			$this->data['city'] = '';
		}

    	if (isset($this->request->post['country_id'])) {
      		$this->data['country_id'] = $this->request->post['country_id'];
		} else {
      		$this->data['country_id'] = $this->config->get('config_country_id');
    	}

    	if (isset($this->request->post['deleg'])) {
      		$this->data['deleg'] = $this->request->post['deleg'];
		} else {
      		$this->data['deleg'] = '';
    	}

    	if (isset($this->request->post['colonia'])) {
      		$this->data['colonia'] = $this->request->post['colonia'];
		} else {
      		$this->data['colonia'] = '';
    	}


		$this->load->model('localisation/country');

                $this->data['countries'] = $this->model_localisation_country->getCountries();

		if (isset($this->request->post['password'])) {
    		$this->data['password'] = $this->request->post['password'];
		} else {
			$this->data['password'] = '';
		}

		if (isset($this->request->post['confirm'])) {
    		$this->data['confirm'] = $this->request->post['confirm'];
		} else {
			$this->data['confirm'] = '';
		}

		if (isset($this->request->post['newsletter'])) {
    		$this->data['newsletter'] = $this->request->post['newsletter'];
		} else {
			$this->data['newsletter'] = '';
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/clientedistinguido.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/clientedistinguido.tpl';
		} else {
			$this->template = 'default/template/information/clientedistinguido.tpl';
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


  	private function validate() {

        $this->load->model('account/customer');
        
    	if ((strlen(utf8_decode($this->request->post['firstname'])) < 1) || (strlen(utf8_decode($this->request->post['firstname'])) > 32)) {
      		$this->error['firstname'] = $this->language->get('error_firstname');
    	}

    	if ((strlen(utf8_decode($this->request->post['lastname'])) < 1) || (strlen(utf8_decode($this->request->post['lastname'])) > 32)) {
      		$this->error['lastname'] = $this->language->get('error_lastname');
    	}

    	if ((strlen(utf8_decode($this->request->post['email'])) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
      		$this->error['email'] = $this->language->get('error_email');
    	}

    	if ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
      		$this->error['warning'] = $this->language->get('error_exists');
    	}

    	if ((strlen(utf8_decode($this->request->post['telephone_ini'])) < 3) || (strlen(utf8_decode($this->request->post['telephone_ini'])) > 5)) {
      		$this->error['telephone_ini'] = 'CAMPO LADA REQUERIDO';
    	}

    	if ((strlen(utf8_decode($this->request->post['telephone'])) < 3) || (strlen(utf8_decode($this->request->post['telephone'])) > 32)) {
      		$this->error['telephone'] = $this->language->get('error_telephone');
    	}

    	if ((strlen(utf8_decode($this->request->post['cell_ini'])) < 3) || (strlen(utf8_decode($this->request->post['cell_ini'])) > 5)) {
      		$this->error['cell_ini'] = 'CAMPO CELULAR';
    	}

    	if ((strlen(utf8_decode($this->request->post['cell'])) < 3) || (strlen(utf8_decode($this->request->post['cell'])) > 32)) {
      		$this->error['cell'] = 'CAMPO CELULAR REQUERIDO';
    	}

    	if ((strlen(utf8_decode($this->request->post['deleg'])) < 3) || (strlen(utf8_decode($this->request->post['deleg'])) > 32)) {
      		$this->error['deleg'] = 'CAMPO DELEG/MUNICIPIO REQUERIDO';
    	}
    	if ((strlen(utf8_decode($this->request->post['colonia'])) < 3) || (strlen(utf8_decode($this->request->post['colonia'])) > 32)) {
      		$this->error['colonia'] = 'CAMPO COLONIA REQUERIDO';
    	}

    	if ((strlen(utf8_decode($this->request->post['address_1'])) < 3) || (strlen(utf8_decode($this->request->post['address_1'])) > 128)) {
      		$this->error['address_1'] = $this->language->get('error_address_1');
    	}

    	if ((strlen(utf8_decode($this->request->post['city'])) < 2) || (strlen(utf8_decode($this->request->post['city'])) > 128)) {
      		$this->error['city'] = $this->language->get('error_city');
    	}

		$this->load->model('localisation/country');

		$country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);

		if ($country_info && $country_info['postcode_required'] && (strlen(utf8_decode($this->request->post['postcode'])) < 2) || (strlen(utf8_decode($this->request->post['postcode'])) > 10)) {
			$this->error['postcode'] = $this->language->get('error_postcode');
		}

    	if ($this->request->post['country_id'] == '') {
      		$this->error['country'] = $this->language->get('error_country');
    	}

    	/*if ($this->request->post['zone_id'] == '') {
      		$this->error['zone'] = $this->language->get('error_zone');
    	}*/

    	/*if ((strlen(utf8_decode($this->request->post['password'])) < 4) || (strlen(utf8_decode($this->request->post['password'])) > 20)) {
      		$this->error['password'] = $this->language->get('error_password');
    	}*/

    	if ($this->request->post['confirm'] != $this->request->post['password']) {
      		$this->error['confirm'] = $this->language->get('error_confirm');
    	}

		if ($this->config->get('config_account_id')) {
			$this->load->model('catalog/information');

			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));

			/*if ($information_info && !isset($this->request->post['agree'])) {
      			$this->error['warning'] = sprintf($this->language->get('error_agree'), $information_info['title']);
			}*/
		}

    	if (!$this->error) {
      		return true;
    	} else {
      		return false;
    	}
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
