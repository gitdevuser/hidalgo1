$().ready(function(){
    /* Tabs */
    $( '.tab' ).click(function(){
        $( '.tab' ).removeClass( 'selected' );
        $( this ).addClass( 'selected' );
        var current = $( '.tab' ).index( this );
        $( '.sizechart-container' ).each(function( index ){
            $( '.sizechart-container' ).eq( index ).hide();
            if ( index == current  ) {
                 $( this ).fadeIn( 250 );
            }
        });
        return false;
    });
    menu_select(8);
});