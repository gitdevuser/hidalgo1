<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<script>
$().ready(function(){
    menu_select(2);
});
</script>
<!--<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>--->


<div id="content">
<div class="top-shadow" >&nbsp;</div>
<?php echo $content_top; ?>
  
  <div id="suc-cont" >
    <div class="suc-title" >
       <h1><?php echo $heading_title; ?></h1>
    </div>

    <div class="suc-info matriz" >
       <h1>Matriz</h1>
       <ul>
         <li>Av. 5 de Mayo #31</li>
         <li>Colonia Centro de la Ciudad de M&eacute;xico &Aacute;rea 1</li>
         <li>Delegaci&oacute;n Cuahut&eacute;moc</li>
         <li>C.P. 06000, M&eacute;xico, D.F.</li>
         <li>Tel&eacute;fono (55)5130-0320</li>
       </ul>
       <div class="mapPhoto-cont" >
         <a href="#" class="maps map-selected" >Mapa [+]</a> |
         <a href="http://localhost/opencart/image/cache/data/macbook_1-80x80.jpg" class="photo">Foto [+]</a>
       </div>
    </div><!--Matriz-->
    
    <div class="suc-info" >
       <h1>Sucursal Galer&iacute;as Coapa</h1>
       <ul>
         <li>Calzada del Hueso #519 Nivel 2 Local 335</li>
         <li>Colonia Acoxpan</li>
         <li>Delegaci&oacute;n Tlalpan</li>
         <li>C.P. 14300, M&eacute;xico, D.F.</li>
         <li>Tel&eacute;fono (55)5627-8225</li>
       </ul>
       <div class="mapPhoto-cont" >
         <a href="#" class="maps">Mapa [+]</a> |
         <a href="http://localhost/opencart/image/cache/data/macbook_1-80x80.jpg" class="photo" >Foto [+]</a>
       </div>
    </div><!--Gallerias Coapa -->

    <div class="suc-info suc-last" >
       <h1>Sucursal Las Flores</h1>
       <ul>
         <li>V&iacute;a Jose Lopez Portillo #105</li>
         <li>Local 75</li>
         <li>Colonia Zacuatitla</li>
         <li>Municipio Coacalco de Berriozaba</li>
         <li>C.P. 57000, Estado de M&eacute;xico</li>
         <li>Tel&eacute;fono (55)1039-2955</li>
       </ul>
       <div class="mapPhoto-cont" >
         <a href="#" class="maps">Mapa [+]</a> |
         <a href="http://localhost/opencart/image/cache/data/macbook_1-80x80.jpg" class="photo">Foto [+]</a>
       </div>
    </div><!--Las Flores -->


    <div id="map_canvas"></div>
    <div id="map_photo" ></div>

  </div>


  <?php echo $content_bottom; ?></div>

<script type="text/javascript" src="http://www.google.com/jsapi?key=ABQIAAAAZBe7uHI90ESk2XAmWRL3RxR6u04U0tImA3bfwZ3-HKdEno7z2xRk2YE6OkudtBX5qy0vLrgbf1DUCg"></script>
<script type="text/javascript">
	google.load("maps", "2.x");
</script>
<script src="catalog/view/javascript/sucursales.js" type="text/javascript"></script>


<?php echo $footer; ?>
