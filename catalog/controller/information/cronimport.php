<?php 
class ControllerInformationCronimport extends Controller {
	private $error = array(); 
	    
  	public function index() {

                $this->document->setTitle( '' );
                $this->data['heading_title'] = '';

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/cronimport.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/cronimport.tpl';
		} else {
			$this->template = 'default/template/information/cronimport.tpl';
		}


                echo "-+";
                echo "<br>";

                /*$this->db->query( "UPDATE `product` SET `quantity` = '7',
                                          `price` = '7' WHERE `product_id` ='7'" );*/

                /**
                 * Importando
                 **/
                /*ini_set ('auto_detect_line_endings','1');
                $fp = fopen("http://bitlab.com.mx/clientes/hidalgo/csv/ActQtyPrice.csv","r");

                while ($data = fgetcsv ($fp, 1000, "|")) {

                       $items_id = $data[0];
                       $cantidad = $data[1];
                       $precio = $data[2];
                       $query = $this->db->query( "SELECT * FROM `product` WHERE product_id ='".$items_id."'" );
                       if ( count( $query->num_rows ) > 0  ) {
                              $this->db->query( "UPDATE `product` SET `quantity` = '".$cantidad."',
                                                        `price` = '".$precio."' WHERE `product_id` =".$items_id.";" );
                       }



                }*/
  	}
}
?>
