//var json_url = 'http://127.0.0.1:3000/api/'
//var img_url = 'http://127.0.0.1:3000'
var json_url = '/api/'
var img_url = 'http://digilab4.let.uniroma1.it:8080'


function unique(list) {
  var result = [];
  $.each(list, function(i, e) {
    if ($.inArray(e, result) == -1) result.push(e);
  });
  return result;
}

function logout(list) {
  redirect("login.html");
}