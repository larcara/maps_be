/*** Created by rails on 12/05/2014. ***/


///// DA CONTROLLARE
$agent = 'd';
function setAgent(agent){
	$agent = agent;
	
}
///////


if(document.URL.indexOf("login.html") === -1 && document.URL.indexOf("login_m.html") === -1) {
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

var email;
var password
var idUser

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
                        email = object.email;
                        password = object.password;
                        idUser=object.id
                        //alert(idUser);

                        var role= object.role;
                        //var f='<strong><label class="testol">'+object.nome+" "+object.cognome+'</label></strong>';
                        //alert($(window).width());
                        if (($(window).width()>=1200)) {
                        var f='<span class="glyphicon glyphicon-user"></span>&nbsp;<label class="testol">'+object.nome+" "+object.cognome+'</label>';
                        } else {
                        var f='<span class="glyphicon glyphicon-user"></span>&nbsp;<label class="testol">'+object.cognome+'</label>';
                        }
                        $('#nomeLogin').html(f);
                        Permission(role,$agent);
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
var idMuseo;

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
            idMuseo = data.data.id;
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
        f='<label class="testol">Museo di&nbsp;'+nome+'</label>';
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

function Permission(role, agent){
$agent = agent;	
    if (role == "amministratore"){
        
        if(agent=='d'){    
            var fields = ' <ul class="nav nav-pills nav-stacked visible-lg" style="text-align:center;" > ' +
            '<li class="active"><a href=museo.html?key=' + urlParams('key') + '>MUSEO</a></li>' +
            '</ul>' +
            '<div style="line-height:5px">' +
            '&nbsp;' +
            '</div>' +
            '<ul class="nav nav-pills nav-stacked visible-lg" style="text-align:center;">' +
            '<li class="active"><a href=utente.html?key=' + urlParams('key') + '>GESTIONE UTENTI</a></li>' +
            '</ul>' +
            '<div style="line-height:5px">' +
            '&nbsp;' +
            '</div>' +

            //'<ul class="nav nav-pills nav-stacked" style="text-align:center;">' +
            //'<li class="active"><a href=stampa.html?key=' + urlParams('key') +'>CONFIGURAZIONE STAMPE</a></li>' +
            //'</ul>' +
            //'<div style="line-height:5px">' +
            //'&nbsp;' +
            //'</div>' +

            '<ul class="nav nav-pills nav-stacked" style="text-align:center;">' +
            '<li class="active"><a href=reperti.html?key=' + urlParams('key') +'>GESTIONE REPERTI</a></li>' +
            '</ul>'
	}
	else{
		var fields = '<ul class="nav nav-pills nav-stacked" style="text-align:center;">' +
            '<li class="active"><a href=reperti.html?key=' + urlParams('key') +'>GESTIONE REPERTI</a></li>' +
            '</ul>';
	}
    }else if (role == "operatore"){
        var fields = '<ul class="nav nav-pills nav-stacked" style="text-align:center;">' +
            '<li class="active"><a href=reperti.html?key=' + urlParams('key') +'>GESTIONE REPERTI</a></li>' +
            '</ul>';
    }else if (role == "operatore_base"){
        var fields = '<ul class="nav nav-pills nav-stacked" style="text-align:center;">' +
            '<li class="active"><a href=reperti.html?key=' + urlParams('key') +'>GESTIONE REPERTI</a></li>' +
            '</ul>'

    }else{
        // redirect("login.html");
    }
    $('#menu').html(fields);

}

    function emptyValue(value) {
        //alert(value);
        if (value == null){
            value = "";
        } else {
            value = value;
        }
        return value;
    }



function changePassword(){
    $.ajax({
        type: "POST",
        url: json_url +  "users/sign_in",
        data:{ user_login:{email:email, password: $("#id_old_password").val() }},
        dataType: "json",
        success: function(data)
        {
       // alert(idUser);
            //cambio password
            if ($("#id_new_password").val() == $("#id_check_password").val() ) {
                $.ajax({
                    type: "POST",
                    url: json_url + "museums/updateUser",
                    data:{auth_token:urlParams('key'),user:{id: idUser, password:$("#id_new_password").val()}},
                    dataType: "json",
                    success: function(data){
                        alert("La password è stata modificata");

                    },
                    error: function(data){
                       // alert(JSON.stringify(data));
                        alert("Chiamata fallita, si prega di riprovare...");
                    }
                });

            }else{
                alert("Controllare che il conferma password sia corretto");
            }
            //fine cambio password


        },
        error: function(data)
        {
           // alert(JSON.stringify(data));
            alert("Immettere dati corretti");
        }
    });

}