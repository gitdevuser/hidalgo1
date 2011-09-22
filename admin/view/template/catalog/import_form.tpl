<?php echo $header; ?>
<div id="content">
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/information.png" alt="" /> Importar</h1>
      <div class="buttons">
        <a class="button" id="salvar"><span>Salvar</span></a>
        <a onclick="location = '<?php echo $cancel; ?>';" class="button"><span>Cancelar</span></a>
      </div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">

        <table id="option-value" class="list" style="width: 500px;">
          <thead>
            <tr>
              <td class="left">Formatos</td>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="left">

                <div class="formatos">
                  <a href="#" class="cerrar" >mostrar informaci&oacute;n [+]</a>
                  <div class="info-formatos" >
                  Para crear archivos ".csv", seguir los siguentes pasos <a href="http://youtu.be/eLH9v7Zsc4c" target="_blank">click aqu&iacute;</a>.
                  <br>
                  <b>Nota:</b> Los campos deber&aacute;n estar separados por pipes ( <b>|</b> ).
                  <br>
                  <p>
                  <b>FORMATO IMPORTACI&Oacute;N ESTILOS</b><p>
                  Orden de los campos para importar estilos:
                  <ul>
                    <li>Estilo ID</li>
                    <li>Precio</li>
                    <li>Modelo</li>
                    <li>Descripci&oacute;n</li>
                    <li>Marca</li>
                    <li>Composici&oacute;n</li>
                    <li>Caracter&iacute;sticas ( separado por comas ) </li>
                    <li>Corte</li>
                    <li>Cuidado</li>
                    <li>Nombre del estilo</li>
                  </ul>
                  
                  Ejemplos de como deber&aacute; quedar el archivo ".csv":
                  <br>
                  <a href="../import/ejemplo/estilos_prueba.csv" target="_blank" >Formato Importaci&oacute;n <b>estilos</b></a>
                  <p>&nbsp;</p>
                  <b>FORMATO IMPORTACI&Oacute;N ITEMS</b><p>
                  Orden de los campos para importar items:
                  <ul>
                    <li>Items ID</li>
                    <li>Estilo ID</li>
                    <li>Talla ID</li>
                    <li>Subtalla ID</li>
                    <li>Color</li>
                    <li>Nombre item</li>
                  </ul>
                  Ejemplos de como deber&aacute; quedar el archivo ".csv":
                  <br>
                  <a href="../import/ejemplo/items_prueba.csv" target="_blank" >Formato Importaci&oacute;n <b>items</b></a>

                  </div>
                  <p>
                </div>

              </td>
            </tr>
          </tbody>
        </table><!--Informacion-->

        <table id="option-value" class="list" style="width: 500px;">
          <thead>
            <tr>
              <td class="left">Importar Estilos</td>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="left">
                <input type="file" name="estilos">
              </td>
            </tr>
          </tbody>
        </table><!--Importando estilos-->

        <table id="option-value" class="list" style="width: 500px;">
          <thead>
            <tr>
              <td class="left">Importar Items</td>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="left">
                <input type="file" name="items">
              </td>
            </tr>
          </tbody>
        </table><!--Importando items(productos)-->


        <table id="option-value" class="list" style="width: 500px;">
          <thead>
            <tr>
              <td class="left">Sincronizar Imagenes</td>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="left">
                 <input type="checkbox" name="sinc" >
              </td>
            </tr>
          </tbody>
        </table><!--Importando items(productos)-->

        <?php if( ( isset($errorMS) ) && ( count( $errorMS ) > 0 ) ) {  ?>
        <table id="option-value" class="list" style="width: 700px;">
          <thead>
            <tr>
              <td class="left">Resumen de actualizaci&oacute;n</td>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="left">
                <div style="overflow-y: scroll; height: 200px; ">
                   <?php
                   function htmlMS( $arr ){
                       $html = '';
                       $html .= "<ul>";
                       foreach ( $arr as $rs_ia ) {
                         if( !is_array($rs_ia) ) {
                             $html .= "<li>".$rs_ia."</li>";
                         }  
                       }
                       $html .= "</ul></br>";
                       return $html;
                   }

                   if ( isset( $errorMS['estilos'] ) ) {
                        echo  "<h3>IMPORTACI&Oacute;N ESTILOS</h3>";
                        echo htmlMS( $errorMS['estilos'] );
                   }

                   //Items
                   if ( isset( $errorMS['items'] ) ) {
                        echo  "<h3>IMPORTACI&Oacute;N ITEMS</h3>";
                        echo htmlMS( $errorMS['items'] );
                   }

                   //Sinc Imagenes
                   if ( isset( $errorMS['directorio'] ) ) {
                        echo htmlMS( $errorMS['directorio'] );
                   }
                   //Sinc Imagenes
                   if ( isset( $errorMS['sinc'] ) ) {
                    echo  "<h3>SINCRONIZAR IMAGENES</h3>";
                        echo htmlMS( $errorMS['sinc'] );
                   }

                   ?>
                </div>
              </td>
            </tr>
          </tbody>
        </table><!--listado err-->
        <?php } ?>


      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--

    $( '.cerrar' ).toggle(
    function(){ $( '.info-formatos' ).fadeIn(250); $(this).html( 'cerrar [-]' );  },
    function(){ $( '.info-formatos' ).fadeOut(250); $(this).html( 'mostrar informaci&oacute;n [+]' ); });

    
    function fl_extension( archivo ) {

        extension = ( archivo.substring( archivo.lastIndexOf("."))).toLowerCase();
        if ( extension == ".csv" ) {
             return true;
        } else {
            return false;
        }

    }

$('#salvar').click(function(){
    var estilo = $('input[name="estilos"]').val();
    var items = $('input[name="items"]').val();
    var e = 0;
    //Estilos
    if ( estilo !="" ) {
       if ( !fl_extension( $('input[name="estilos"]').val() ) ) {
          alert( 'Formato no valido para estilos, el archivo debe ser ".csv" ' );
          e = 1;
       }
    }
    //Items
    if ( items !="" ) {
       if ( !fl_extension( $('input[name="items"]').val() ) ) {
          alert( 'Formato no valido para items, el archivo debe ser ".csv" ' );
          e = 1;
       }
    }
    if(  e <= 0 ) {
        $('#form').submit();
    }

    return false;
});
//--></script> 
<?php echo $footer; ?>