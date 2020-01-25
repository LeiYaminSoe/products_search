$(function(){
  var priceCompare = $('#price_compare :selected').val();
  displayPrice(priceCompare);
  
  $('#price_compare').on('change', function() {
    var priceCompare = this.value;
    displayPrice(priceCompare);    
  });
  
  $('.pagination span a').click(function() {
    var priceCompare = $('#price_compare :selected').val();
    displayPrice(priceCompare);
  });

});

function displayPrice(priceCompare)
{
  if(priceCompare == "Cheaper than"){
      $('#price_less').show();
      $('#price_exact').hide();
      $('#price_expensive').hide();
      $('#q_price_lt').removeClass( "d-none" ).addClass( "d-block" );
    }
    else if(priceCompare == "Exactly that"){
      $('#price_less').hide();
      $('#price_exact').show();
      $('#price_expensive').hide();
      $('#q_price_eq').removeClass( "d-none" ).addClass( "d-block" );
    }
    else{
      $('#price_less').hide();
      $('#price_exact').hide();
      $('#price_expensive').show();
      //$('#price_expensive').removeClass( "d-none" ).addClass( "d-block" );
      $('#q_price_gt').removeClass( "d-none" ).addClass( "d-block" );
      
    }
}