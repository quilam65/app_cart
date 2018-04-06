// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require bootstrap-sprockets
function goBack() {
    window.history.back();
}
$(window).ready(function(){
  $('.quanltiy').on('change',function(){
    id = $(this).parent().attr('name');
    quanlity = $(this).val()
    if ((quanlity)>0) {
      $.ajax({
      url: '/orders/' + id,
      type: 'PUT',
      data: {
        'order[quanlity]': quanlity
      }
    }).done(setTimeout(function() { location.reload() }, 1000));
  }
    // console.log($(this).val());
    // price = parseInt($(this).parent().parent().find('.price').text());
    // quanlity = parseInt($(this).val());
    // $(this).parent().parent().find('.quanlity-price').text(price*quanlity);
  })
})
