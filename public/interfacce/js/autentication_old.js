/*** Created by rails on 12/05/2014. ***/

if(document.URL.indexOf("login.html") === -1) {
    var checKey = new RegExp('[\\?&]' + 'key' + '=([^&#]*)').exec(window.location.href);

//alert(!checKey);
    if (!checKey) {
        //alert("il parametro key non esiste")
        alert("Devi effettuare il login per accedere al portale M.A.p.S.");
        redirect("login.html");
    } else {
        //alert("parametro key esistente! proseguo nella esecuzione della pagina");
        role();
        nomeMuseo();
    }
}


function urlParams(name){
    var results = new RegExp('[\\?&]' + name + '=([^&#]*)').exec(window.location.href);
    if (!results) {
        return 0;
    }
    return results[1] || 0;
};

function role(){
    //alert("start role");
    $.ajax({
        type: "GET",
        url: json_url + "museums/getUsers",
        data:{ auth_token: urlParams('key')},
        dataType: "json",
        success: function(data){
            //alert(JSON.stringify(data));

            $.each(data.data,
                function (i, object) {
                    //check auth_token
                    var chiave = object.authentication_token;

                    if(chiave==urlParams('key')){
                        //alert(object.nome);
                        //alert(object.cognome);
                       // alert(object.role);
                        var role= object.role;
                        var f='<strong><label class="testol">'+object.nome+" "+object.cognome+'</label></strong>';
                        $('#nomeLogin').html(f);
                        Permission(role);
                    }else{
                       // alert("Authorization failed!");
                    }
                }
            );
        },
        error: function()
        {
            alert("Devi effettuare il login per accedere al portale M.A.p.S.");
            redirect("login.html");
        }
    });
}

var nome;

function nomeMuseo(){
    //alert("start nome museo");
    $.ajax({
        type: "GET",
        url: json_url + "museums/getMuseumData",
        data:{ auth_token: urlParams('key')},
        dataType: "json",
        success: function(data){
            //alert(JSON.stringify(data));
            nome = data.data.name;
            scrivi();
        },
        error: function(){
            //alert("Chiamata fallita, si prega di riprovare...");
            }
    });
    scrivi();
};

function scrivi(){
    //alert($(location).attr('pathname'));
    //alert(document.URL.indexOf("home.html"));
    var f;
    /* Check home.html in url address */
    if(document.URL.indexOf("home.html") === -1) {
        //tutte le altre pagine
        f='<strong><label class="testol">'+nome+'</label></strong>';
        $('#nomeMuseo').html(f);
    } else {
        //home.html
        f='<strong><label style="font-size:25px; color:#781C27; font-family: Arial Black, Gadget, sans-serif">'+nome+'</label></strong>';
        $('#mus').html(f);
    }
};

function redirect (url) {
    //alert ("inizio redirect");
    var ua = navigator.userAgent.toLowerCase(),
        isIE = ua.indexOf('msie') !== -1,
        version = parseInt(ua.substr(4, 2), 10);

    // IE8 and lower
    if (isIE && version < 9) {
        var link = document.createElement('a');
        link.href = url;
        document.body.appendChild(link);
        link.click();
    }

    // All other browsers
    else { window.location.href = url; }
}

function Permission(role){

    if (role == "amministratore"){
        //alert(role);
        var fields = ' <ul class="nav nav-pills nav-stacked" style="text-align:center;" > ' +
            '<li class="active"><a href=museo.html?key=' + urlParams('key') + '>MUSEO</a></li>' +
            '</ul>' +
            '<div style="line-height:5px">' +
            '&nbsp;' +
            '</div>' +
            '<ul class="nav nav-pills nav-stacked" style="text-align:center;">' +
            '<li class="active"><a href=utente.html?key=' + urlParams('key') + '>GESTIONE UTENTI</a></li>' +
            '</ul>' +
            '<div style="line-height:5px">' +
            '&nbsp;' +
            '</div>' +
            '<ul class="nav nav-pills nav-stacked" style="text-align:center;">' +
            '<li class="active"><a href=stampa.html?key=' + urlParams('key') +'>CONFIGURAZIONE STAMPE</a></li>' +
            '</ul>' +
            '<div style="line-height:5px">' +
            '&nbsp;' +
            '</div>' +
            '<ul class="nav nav-pills nav-stacked" style="text-align:center;">' +
            '<li class="active"><a href=reperti.html?key=' + urlParams('key') +'>GESTIONE REPERTI</a></li>' +
            '</ul>'
    }else if (role == "operatore"){
        var fields = '<ul class="nav nav-pills nav-stacked" style="text-align:center;">' +
            '<li class="active"><a href=reperti.html?key=' + urlParams('key') +'>GESTIONE REPERTI</a></li>' +
            '</ul>'
    }else if (role == "operatore_base"){
        var fields = '<ul class="nav nav-pills nav-stacked" style="text-align:center;">' +
            '<li class="active"><a href=reperti.html?key=' + urlParams('key') +'>GESTIONE REPERTI</a></li>' +
            '</ul>'

    }else{
        // redirect("login.html");
    }
    $('#menu').html(fields);

}