$(function(){
  var priceCompare = $('#price_compare :selected').val();
  displayPrice(priceCompare);
  
  $('#price_compare').on('change', function() {
    var priceCompare = this.value;
    displayPrice(priceCompare);    
  });
  
  $('.pagination a').click(function() {    
    var priceCompare = $('#price_compare :selected').val();
    displayPrice(priceCompare);    
  }); 
  
  $('#sort_by').on('change', function() {
    var sortBy = this.value;
    var product = gon.products;
    var proTitle = $('#q_g_0_title_cont').val();
    $.ajax({
      url: 'products/product_sorting',
      type: 'POST',
      data: {
        sortBy: sortBy,
        products: product,
        product_title: proTitle
      },
      success: function(ret) {
      },
      error: function(data) {
      }
    });
    return false
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
      $('#q_price_gt').removeClass( "d-none" ).addClass( "d-block" );
      
    }
}