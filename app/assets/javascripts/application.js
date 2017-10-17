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
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function (){
    $( "#rental_period_slider" ).slider({
        range: true,
        values: [getRentalPeriodStart(),getRentalPeriodEnd()],
        min: getRentalPeriodMin(),
        max: getRentalPeriodMax(),
        slide: function( event, ui ) {
            $( "#scenario_rental_start" ).val(ui.values[ 0 ]);
            $( "#scenario_rental_end" ).val(ui.values[ 1 ]);
        }
    });
});

//clear the flash messages
function clearMsg() {
    $('#error-msg').html('');
    $('#notice-msg').html('');
}

function getRentalPeriodMin() {
    return Number($('#scenario_rental_period_min').val())
};

function getRentalPeriodMax() {
    return Number($('#scenario_rental_period_max').val())
};

function getRentalPeriodStart() {
    return Number($('#scenario_rental_start').val())
};

function getRentalPeriodEnd() {
    return Number($('#scenario_rental_end').val())
};