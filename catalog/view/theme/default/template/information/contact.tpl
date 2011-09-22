<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<script>
$().ready(function(){
    menu_select(1);
});
</script>
<div id="content">
<div class="top-shadow" >&nbsp;</div>
<?php echo $content_top; ?>

 <div id="pages-container" >
  <div class="page-title" >
     <h1><?php echo $heading_title; ?></h1>
  </div>
  <div class="pages-content" >

  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="contact">

    <div id="pages-description" >
    <?php if( isset($desc) ) { echo $desc; } ?>
    </div>

        <div class="contactInfo-container" >
            <div class="contact-info">
               <ul>

                 <li>
                   <h2><?php echo $horario_atencion;  ?></h2>
                   <?php echo $horario;  ?>
                 </li>
                 
                 <li>
                   <?php if ($telephone) { ?>
                   <h2><?php echo $text_telephone; ?></h2>
                   <?php echo $en_interior;  ?>
                   <?php echo $telephone; ?>
                   <?php echo $metropolitana; ?>
                   <?php echo $tel_metropolitana; ?>
                   <?php } ?>
                 </li>

                 <li>
                   <?php echo $email_info; ?>
                   <?php echo $email_contact; ?>
                 </li>

               </ul>

            </div>
        </div>

        <div class="content">
         <ul id="contact-fields">

           <li>
            <span><?php echo $entry_name; ?></span>
            <input type="text" name="name" value="<?php echo $name; ?>" />
            <?php if ($error_name) { ?>
              <span class="error"><?php echo $error_name; ?></span>
            <?php } ?>
           </li>

           <li>
            <span><?php echo $entry_email; ?></span>
            <input type="text" name="email" value="<?php echo $email; ?>" />
            <?php if ($error_email) { ?>
            <span class="error"><?php echo $error_email; ?></span>
            <?php } ?>
           </li>

           <li>
            <span><?php echo $entry_enquiry; ?></span>
            <textarea name="enquiry" cols="40" rows="10" ><?php echo $enquiry; ?></textarea>
            <?php if ($error_enquiry) { ?>
            <span class="error"><?php echo $error_enquiry; ?></span>
            <?php } ?>
           </li>
           
         </ul>

         <div id="buttons-contact" >
           <a onclick="$('#contact').submit();" >Enviar</a>
           <a href="#" >Borrar</a>
         </div>
    </div>


  </form>

  <div id="suc-contact" >
    <div class="suc-info matriz" >
       <h1>Matriz</h1>
       <ul>
         <li>Av. 5 de Mayo #31</li>
         <li>Colonia Centro de la Ciudad de M&eacute;xico &Aacute;rea 1</li>
         <li>Delegaci&oacute;n Cuahut&eacute;moc</li>
         <li>C.P. 06000, M&eacute;xico, D.F.</li>
         <li>Tel&eacute;fono (55)5130-0320</li>
       </ul>
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
    </div><!--Las Flores -->
   </div>

  </div>
  </div>
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>