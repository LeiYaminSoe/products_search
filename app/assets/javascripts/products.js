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
  
  $('#sort_by').on('change', function() {
    var sortBy = this.value;
    var product = gon.products;
    $.ajax({
      url: 'products/product_sorting',
      type: 'POST',
      scriptCharset: 'utf-8',
      data: {
        sortBy: sortBy,
        products: product,
      },
      dataType:'json',
      success: function(ret) {
        console.log(ret);
        //$("#updated_by_ajax").html('<%= j render "product_list", products: ret) %>');
        //jQuery("#updated_by_ajax").html(ret);
        //$("#updated_by_ajax").append(ret);
        //$('#updated_by_ajax').html("<%= j render(:partial => 'products/list') %>");
        //console.log($('#updated_by_ajax').html());
        // console.log($('#updated_by_ajax').data());
        //jQuery("#updated_by_ajax").html(ret);
        //$('#updated_by_ajax').load();
        //$('#updated_by_ajax').html("<%= j (render partial: 'list', locals: { :products => @products }) %>")
        
       /*  $('#request_ajax_update')
    .on 'ajax:complete', (event) ->
      response = event.detail[0].response
      $('#updated_by_ajax').html(response)
      
      
      
        $('#updated_by_ajax').data("@products", ret); */
       // $( "body" ).data( "bar", { isManual: true } );
        //$( "body" ).data( "bar", { isManual: true } );
        //$('#updated_by_ajax').data(ret); 
        //$('#updated_by_ajax').html(ret);
        //Rails.$(".random-number")[0].innerHTML = ret.html; 
        //location.reload();
       //if(ret.success == true){ // if true (1)
      //setTimeout(function(){// wait for 5 secs(2)
        //   location.reload(); // then reload the page.(3)
      //}, 5000); 
  // }
      },
      error: function(data) {
        //showErrorMessage();
      }
    });
    //$("#sort_form").submit();
    //return false
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