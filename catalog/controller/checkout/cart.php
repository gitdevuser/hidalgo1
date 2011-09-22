<?php
class ControllerCheckoutCart extends Controller {
	public function index() {
		$this->language->load('checkout/cart');

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
      		if (isset($this->request->post['quantity'])) {
				if (!is_array($this->request->post['quantity'])) {
					if (isset($this->request->post['option'])) {
						$option = $this->request->post['option'];
					} else {
						$option = array();
					}

      				$this->cart->add($this->request->post['product_id'], $this->request->post['quantity'], $option);
				} else {
					foreach ($this->request->post['quantity'] as $key => $value) {
	      				$this->cart->update($key, $value);
					}
				}
      		}

      		if (isset($this->request->post['remove'])) {
	    		foreach ($this->request->post['remove'] as $key) {
          			$this->cart->remove($key);
				}
      		}

      		if (isset($this->request->post['voucher']) && $this->request->post['voucher']) {
	    		foreach ($this->request->post['voucher'] as $key) {
          			if (isset($this->session->data['vouchers'][$key])) {
						unset($this->session->data['vouchers'][$key]);
					}
				}
      		}

			if (isset($this->request->post['redirect'])) {
				$this->session->data['redirect'] = $this->request->post['redirect'];
			}

			if (isset($this->request->post['quantity']) || isset($this->request->post['remove']) || isset($this->request->post['voucher'])) {
				unset($this->session->data['shipping_methods']);
				unset($this->session->data['shipping_method']);
				unset($this->session->data['payment_methods']);
				unset($this->session->data['payment_method']);
				unset($this->session->data['reward']);

				$this->redirect($this->url->link('checkout/cart'));
			}
    	}
        
   
    	$this->document->setTitle($this->language->get('heading_title'));

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'href'      => $this->url->link('common/home'),
        	'text'      => $this->language->get('text_home'),
        	'separator' => false
      	);

      	$this->data['breadcrumbs'][] = array(
        	'href'      => $this->url->link('checkout/cart'),
        	'text'      => $this->language->get('heading_title'),
        	'separator' => $this->language->get('text_separator')
      	);

    	if ($this->cart->hasProducts() || (isset($this->session->data['vouchers']) && $this->session->data['vouchers'])) {
      		$this->data['heading_title'] = $this->language->get('heading_title');

			$this->data['text_select'] = $this->language->get('text_select');
			$this->data['text_weight'] = $this->language->get('text_weight');

     		$this->data['column_remove'] = $this->language->get('column_remove');
      		$this->data['column_image'] = $this->language->get('column_image');
      		$this->data['column_name'] = $this->language->get('column_name');
      		$this->data['column_model'] = $this->language->get('column_model');
      		$this->data['column_quantity'] = $this->language->get('column_quantity');
			$this->data['column_price'] = $this->language->get('column_price');
      		$this->data['column_total'] = $this->language->get('column_total');

      		$this->data['button_update'] = $this->language->get('button_update');
      		$this->data['button_shopping'] = $this->language->get('button_shopping');
      		$this->data['button_checkout'] = $this->language->get('button_checkout');

			if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
				$this->data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
			} else {
				$this->data['attention'] = '';
			}

			if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
      			$this->data['error_warning'] = $this->language->get('error_stock');
			} elseif (isset($this->session->data['error'])) {
				$this->data['error_warning'] = $this->session->data['error'];

				unset($this->session->data['error']);
			} else {
				$this->data['error_warning'] = '';
			}

			if (isset($this->session->data['success'])) {
				$this->data['success'] = $this->session->data['success'];

				unset($this->session->data['success']);
			} else {
				$this->data['success'] = '';
			}

			$this->data['action'] = $this->url->link('checkout/cart');

			if ($this->config->get('config_cart_weight')) {
				$this->data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
			} else {
				$this->data['weight'] = false;
			}

			$this->load->model('tool/image');
                        $this->load->model('catalog/product');

      		$this->data['products'] = array();
                
      		foreach ($this->cart->getProducts() as $result) {

				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_cart_width'), $this->config->get('config_image_cart_height'));
				} else {
					$image = '';
				}

				$option_data = array();

        		foreach ($result['option'] as $option) {
					if ($option['type'] != 'file') {
						$option_data[] = array(
							'name'  => $option['name'],
							'value' => (strlen($option['option_value']) > 20 ? substr($option['option_value'], 0, 20) . '..' : $option['option_value'])
						);
					} else {
						$this->load->library('encryption');

						$encryption = new Encryption($this->config->get('config_encryption'));

						$file = substr($encryption->decrypt($option['option_value']), 0, strrpos($encryption->decrypt($option['option_value']), '.'));

						$option_data[] = array(
							'name'  => $option['name'],
							'value' => (strlen($file) > 20 ? substr($file, 0, 20) . '..' : $file)
						);
					}
        		}

                        //Obtener precio de producto por categoria
                        $catID = $this->model_catalog_product->getProductsStyleID($result['product_id']);
                        $catDesc = $this->model_catalog_product->getCatDescripcion($catID);
                        $resultsStyle = $this->model_catalog_product->getProdbyCat($catID);
                        $dec_precio = '';
                        $dec_nombre = '';
                        $talla = '';
                        $subtalla = '';
                        $color = '';

                        foreach( $catDesc as $desc_var=>$key ) {
                                 $dec_precio = $key['precio'];
                                 if ( isset( $key['descuento'] ) )  {
                                    $dec_precio = ( $key['precio'] - ( $key['precio'] * ( $key['descuento'] / 100 ) ) );
                                 }
                                 $dec_nombre = $key['name'];
                        }

                        foreach ( $resultsStyle as $rel_item ) {
                                  if ( $rel_item['product_id'] == $result['product_id'] ) {

                                 if ( $rel_item['talla'] ) {
                                        $talla = $this->model_catalog_product->getTallaSubtallaNombre( $rel_item['talla'], 'talla' );
                                 }
                                 if ( $rel_item['subtalla'] ) {
                                        $subtalla = $this->model_catalog_product->getTallaSubtallaNombre( $rel_item['subtalla'], 'subtalla' );
                                 }
                                 if($rel_item['color']) {
                                     $color = $this->model_tool_image->resize($rel_item['color'], 20, 20);
                                 }
                                 

                                  }
                        }

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					//$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                                        $price =  $this->currency->format($this->tax->calculate($dec_precio, $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$total = $this->currency->format($this->tax->calculate($result['total'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$total = false;
				}


                                $t = $this->db->query( "SELECT * FROM product_to_category as tabla1
                                                        LEFT JOIN category as tabla2
                                                        ON tabla1.category_id = tabla2.category_id
                                                        WHERE tabla1.product_id = '".$result['product_id']."'" );
                                if ( $t->num_rows > 0 ) {
                                     $parent_id = $t->row['parent_id'];
                                     $cat_id = $t->row['category_id'];
                                }

        		$this->data['products'][] = array(
          			'key'      => $result['key'],
          			'thumb'    => $image,
					'name'     => $dec_nombre,
          			'model'    => $result['model'],
          			'option'   => $option_data,
          			'quantity' => $result['quantity'],
          			'stock'    => $result['stock'],
					'points'   => ($result['points'] ? sprintf($this->language->get('text_points'), $result['points']) : ''),
					'price'    => $price,
					'total'    => $total,
					/*'href'     => $this->url->link('product/product', 'product_id=' . $result['product_id']),*/
                            'href'     => $this->url->link('product/category', '&path=' .$parent_id.'_'.$cat_id ),
                            'talla' => $talla,
                            'subtalla' => $subtalla,
                            'color' => $color
        		);
                        
      		}

			// Gift Voucher
			$this->data['vouchers'] = array();

			if (isset($this->session->data['vouchers']) && $this->session->data['vouchers']) {
				foreach ($this->session->data['vouchers'] as $key => $voucher) {
					$this->data['vouchers'][] = array(
						'key'         => $key,
						'description' => $voucher['description'],
						'amount'      => $this->currency->format($voucher['amount'])
					);
				}
			}

			$total_data = array();
			$total = 0;
			$taxes = $this->cart->getTaxes();

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$this->load->model('setting/extension');

				$sort_order = array();

				$results = $this->model_setting_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
					if ($this->config->get($result['code'] . '_status')) {
						$this->load->model('total/' . $result['code']);

						$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
					}
				}

				$sort_order = array();

				foreach ($total_data as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $total_data);
			}

			$this->data['totals'] = $total_data;

			// Modules
			$this->data['modules'] = array();

			if (isset($results)) {
				foreach ($results as $result) {
					if ($this->config->get($result['code'] . '_status') && file_exists(DIR_APPLICATION . 'controller/total/' . $result['code'] . '.php')) {
						$this->data['modules'][] = $this->getChild('total/' . $result['code']);
					}
				}
			}

			if (isset($this->session->data['redirect'])) {
      			$this->data['continue'] = $this->session->data['redirect'];

				unset($this->session->data['redirect']);
			} else {
				$this->data['continue'] = $this->url->link('common/home');
			}

			$this->data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/cart.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/checkout/cart.tpl';
			} else {
				$this->template = 'default/template/checkout/cart.tpl';
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
    	} else {
      		$this->data['heading_title'] = $this->language->get('heading_title');

      		$this->data['text_error'] = $this->language->get('text_empty');

      		$this->data['button_continue'] = $this->language->get('button_continue');

      		$this->data['continue'] = $this->url->link('common/home');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
			} else {
				$this->template = 'default/template/error/not_found.tpl';
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

	public function update() {
		$this->language->load('checkout/cart');
		$json = array();

		if (isset($this->request->post['product_id'])) {
			$this->load->model('catalog/product');

			$product_info = $this->model_catalog_product->getProduct($this->request->post['product_id']);

			if ($product_info) {
				// Minimum quantity validation
				if (isset($this->request->post['quantity'])) {
					$quantity = $this->request->post['quantity'];
				} else {
					$quantity = 1;
				}

				$product_total = 0;

				foreach ($this->session->data['cart'] as $key => $value) {
					$product = explode(':', $key);

					if ($product[0] == $this->request->post['product_id']) {
						$product_total += $value;
					}
				}

				if ($product_info['minimum'] > ($product_total + $quantity)) {
					$json['error']['warning'] = sprintf($this->language->get('error_minimum'), $product_info['name'], $product_info['minimum']);
				}

				// Option validation
				if (isset($this->request->post['option'])) {
					$option = array_filter($this->request->post['option']);
				} else {
					$option = array();
				}

				$product_options = $this->model_catalog_product->getProductOptions($this->request->post['product_id']);

				foreach ($product_options as $product_option) {
					if ($product_option['required'] && (!isset($this->request->post['option'][$product_option['product_option_id']]) || !$this->request->post['option'][$product_option['product_option_id']])) {
						$json['error'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
					}
				}
			}

			if (!isset($json['error'])) {
				$this->cart->add($this->request->post['product_id'], $quantity, $option);

				$json['success'] = sprintf($this->language->get('text_success'), $this->url->link('checkout/cart'), $product_info['name'], $this->url->link('checkout/cart'));

				unset($this->session->data['shipping_methods']);
				unset($this->session->data['shipping_method']);
				unset($this->session->data['payment_methods']);
				unset($this->session->data['payment_method']);
			} else {
				$json['redirect'] = str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']));
			}
		}

      	if (isset($this->request->post['remove'])) {
        	$this->cart->remove($this->request->post['remove']);
      	}

      	if (isset($this->request->post['voucher'])) {
			if ($this->session->data['vouchers'][$this->request->post['voucher']]) {
				unset($this->session->data['vouchers'][$this->request->post['voucher']]);
			}
		}

		$this->load->model('tool/image');

		$this->data['text_empty'] = $this->language->get('text_empty');

		$this->data['button_checkout'] = $this->language->get('button_checkout');
		$this->data['button_remove'] = $this->language->get('button_remove');

		$this->data['products'] = array();

		foreach ($this->cart->getProducts() as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], 40, 40);
			} else {
				$image = '';
			}

			$option_data = array();

			foreach ($result['option'] as $option) {
				if ($option['type'] != 'file') {
					$option_data[] = array(
						'name'  => $option['name'],
						'value' => (strlen($option['option_value']) > 20 ? substr($option['option_value'], 0, 20) . '..' : $option['option_value'])
					);
				} else {
					$this->load->library('encryption');

					$encryption = new Encryption($this->config->get('config_encryption'));

					$file = substr($encryption->decrypt($option['option_value']), 0, strrpos($encryption->decrypt($option['option_value']), '.'));

					$option_data[] = array(
						'name'  => $option['name'],
						'value' => (strlen($file) > 20 ? substr($file, 0, 20) . '..' : $file)
					);
				}
			}
                        
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$total = $this->currency->format($this->tax->calculate($result['total'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$total = false;
			}

			$this->data['products'][] = array(
				'key'      => $result['key'],
				'thumb'    => $image,
				'name'     => $result['name'],
				'model'    => $result['model'],
				'option'   => $option_data,
				'quantity' => $result['quantity'],
				'stock'    => $result['stock'],
				'price'    => $price,
				'total'    => $total,
				'href'     => $this->url->link('product/product', 'product_id=' . $result['product_id'])
			);
		}

		// Gift Voucher
		$this->data['vouchers'] = array();

		if (isset($this->session->data['vouchers']) && $this->session->data['vouchers']) {
			foreach ($this->session->data['vouchers'] as $key => $voucher) {
				$this->data['vouchers'][] = array(
					'key'         => $key,
					'description' => $voucher['description'],
					'amount'      => $this->currency->format($voucher['amount'])
				);
			}
		}

		// Calculate Totals
		$total_data = array();
		$total = 0;
		$taxes = $this->cart->getTaxes();

		if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
			$this->load->model('setting/extension');

			$sort_order = array();

			$results = $this->model_setting_extension->getExtensions('total');

			foreach ($results as $key => $value) {
				$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
			}

			array_multisort($sort_order, SORT_ASC, $results);

			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('total/' . $result['code']);

					$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
				}
			}

			$sort_order = array();

			foreach ($total_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}

			array_multisort($sort_order, SORT_ASC, $total_data);
		}

		$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));

		$this->data['totals'] = $total_data;

		$this->data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/cart.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/cart.tpl';
		} else {
			$this->template = 'default/template/common/cart.tpl';
		}

		$json['output'] = $this->render();

		$this->load->library('json');

		$this->response->setOutput(Json::encode($json));
	}
}
?>