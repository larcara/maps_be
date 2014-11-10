#!/bin/bash

curl -s http://127.0.0.1:3000/open_data/RMSMUS06.xml

read -e -p "################## PRESS ENTER KEY TO START ######################"
curl -s http://127.0.0.1:3000/api/users/sign_in -H "Content-Type: application/json" -X POST -d '{"user_login":{"email":"larcara+m1@gmail.com", "password":"password"}}'

read -e -p "Copy auth_token to contnue: " -i "tyZRctcTg82bAXeHHLGF" auth_token


echo;echo;echo "Start saveImage - image ##############################"
curl -s http://127.0.0.1:3000/api/museums/saveImage?auth_token=$auth_token -H "Content-Type: multipart/form-data" -X POST -F card_id=14726 -F image_data[label]="immagine allegata" -F image_file=@img1.png
echo;echo;echo "Start saveImage - image2 ##############################"
curl -s http://127.0.0.1:3000/api/museums/saveImage?auth_token=$auth_token -H "Content-Type: multipart/form-data" -X POST -F card_id=14726 -F image_data[label]="immagine allegata" -F image_file=@img2.gif

exit





curl -s http://127.0.0.1:3000/api/living_museum_users/sign_in.json -H "Content-Type: application/json" -X POST -d '{"user_login":{"email":"larcara+l1@gmail.com", "password":"newpassword2"}}'
echo
read -e -p "Copy token to contnue: " -i "NCziBro_SvJ-4QqfenHw" confirm_token
#echo;echo;echo "Start search for roma  max 5 cards  ##############################"
#curl -s http://127.0.0.1:3000/api/living_museum/searchCards.json?auth_token=$confirm_token -H "Content-Type: application/json" -X GET -d '{"q":"vaso", "limit":5}'
echo;echo;echo "export XML Lido ##############################"
curl -s http://127.0.0.1:3000/api/living_museum/exportCards.xml?auth_token=$confirm_token -H "Content-Type: application/json" -X GET -d '{"card_ids":[100,200,300]}'
#curl -s http://127.0.0.1:3000/api/living_museum/searchCards.json?auth_token=$confirm_token -H "Content-Type: application/json" -X GET -d '{"q":"vaso", "limit":5}'
echo;echo;echo "download  XML Lido ##############################"
curl -s http://127.0.0.1:3000/api/living_museum/downloadLidoXml.xml?auth_token=$confirm_token -H "Content-Type: application/json" -X GET -d '{"card_ids":[100,200,300]}'
echo
exit


echo;echo;echo "Start list searches ##############################"
curl -s http://127.0.0.1:3000/api/living_museum/listSearch.json?auth_token=$confirm_token -H "Content-Type: application/json" -X GET -d '{"public_search_limit":10}'
echo
echo;echo;echo "Start search for roma and epoca = Neolitico or Eneolitico and regione= Umbria or  Abbruzzo max 5 cards  ##############################"
curl -s http://127.0.0.1:3000/api/living_museum/searchCards.json?auth_token=$confirm_token -H "Content-Type: application/json" -X GET -d '{"q":"vaso", "epoca":["Neolitico","Eneolitico"], "regione":["Umbria","Abruzzo"], "limit":5}'
exit
echo
echo;echo;echo "Start save search for roma max 5 cards  ##############################"
curl -s http://127.0.0.1:3000/api/living_museum/saveSearch.json?auth_token=$confirm_token -H "Content-Type: application/json" -X POST -d '{"q":"vaso", "limit":5, "is_public":"0"}'
echo
exit
echo;echo;echo "Start getCard for id 1##############################"
curl -s http://127.0.0.1:3000/api/living_museum/getCard.json?auth_token=$confirm_token -H "Content-Type: application/json" -X GET -d '{"id":"1"}'

exit


clear
read -e -p "################## PRESS ENTER KEY TO START ######################"
curl -s http://127.0.0.1:3000/api/users/sign_in -H "Content-Type: application/json" -X POST -d '{"user_login":{"email":"larcara+m1@gmail.com", "password":"password"}}'
echo
read -e -p "Copy auth_token to contnue: " -i "tyZRctcTg82bAXeHHLGF" auth_token

echo "##### MUSEUM API - START Museum:"
echo
echo;echo;echo  "##### Start import excel file  ##############################";echo
curl  -s http://127.0.0.1:3000/api/museums/import?auth_token=$auth_token -H "Content-Type: multipart/form-data" -X POST -F excel_file=@import.xls

exit


#if [ false ]
#then
#    curl -s http://127.0.0.1:3000/api/living_museum/reset.json -X DELETE
#    echo;echo;echo "Start Create User ##############################"
#    curl -s http://127.0.0.1:3000/api/living_museum/createUser.json -H "Content-Type: application/json" -X POST -d '{"email":"larcara+l1@gmail.com", "first_name":"nome", "last_name":"cognome", "password":"password"}'
#    echo;echo;echo "Start Sign In User ##############################"
#    curl -s http://127.0.0.1:3000/api/living_museum_users/sign_in.json -H "Content-Type: application/json" -X POST -d '{"user_login":{"email":"larcara+l1@gmail.com", "password":"password"}}'
#    echo;echo;echo "Start Request Change Password ##############################"
#    curl -s http://127.0.0.1:3000/api/living_museum/requestResetPassword.json -H "Content-Type: application/json" -X POST -d '{"email":"larcara+l1@gmail.com"}'
#    echo;echo;echo "Start Reset Password By Token ##############################"
#    curl -s http://127.0.0.1:3000/api/living_museum/resetPassword.json -H "Content-Type: application/json" -X POST -d '{"living_museum_user":{"new_password":"newpassword", "reset_password_token":"token1234"}}'
#    echo;echo;echo "Start Sign In User with new password ##############################"
#    curl -s http://127.0.0.1:3000/api/living_museum_users/sign_in.json -H "Content-Type: application/json" -X POST -d '{"user_login":{"email":"larcara+l1@gmail.com", "password":"newpassword"}}'
#    echo;
#    read -e -p "Copy token to contnue: " -i "fwzy9-iwWoRTaG8ojYw3" auth_token
#    echo;echo;echo "Start Change Password ##############################"
#    curl -s http://127.0.0.1:3000/api/living_museum/resetPassword.json?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{"living_museum_user":{"new_password":"newpassword2", "reset_password_token":"newpassword"}}'
#    echo;echo;echo "Start Sign In User with new password ##############################"
#    curl -s http://127.0.0.1:3000/api/living_museum_users/sign_in.json -H "Content-Type: application/json" -X POST -d '{"user_login":{"email":"larcara+l1@gmail.com", "password":"newpassword2"}}'
#    echo
#    echo
#    exit
#fi


curl -s http://127.0.0.1:3000/api/living_museum_users/sign_in.json -H "Content-Type: application/json" -X POST -d '{"user_login":{"email":"larcara+l1@gmail.com", "password":"newpassword2"}}'
echo
read -e -p "Copy token to contnue: " -i "NCziBro_SvJ-4QqfenHw" confirm_token
#echo;echo;echo "Start search for roma  max 5 cards  ##############################"
#curl -s http://127.0.0.1:3000/api/living_museum/searchCards.json?auth_token=$confirm_token -H "Content-Type: application/json" -X GET -d '{"q":"vaso", "limit":5}'
echo
echo;echo;echo "Start search for roma and epoca = Eneolitico max 5 cards  ##############################"
curl -s http://127.0.0.1:3000/api/living_museum/searchCards.json?auth_token=$confirm_token -H "Content-Type: application/json" -X GET -d '{"q":"vaso", "epoca":"Eneolitico", "limit":5}'
echo
echo;echo;echo "Start save search for roma max 5 cards  ##############################"
curl -s http://127.0.0.1:3000/api/living_museum/saveSearch.json?auth_token=$confirm_token -H "Content-Type: application/json" -X POST -d '{"q":"vaso", "limit":5, "is_public":"0"}'
echo
echo;echo;echo "Start update search for roma and epoca = Eneolitico max 5 cards  ##############################"
curl -s http://127.0.0.1:3000/api/living_museum/saveSearch.json?auth_token=$confirm_token -H "Content-Type: application/json" -X POST -d '{"search_id":1,"q":"vaso", "epoca":"Eneolitico", "limit":5 , "is_public":"0"}'
echo
echo;echo;echo "Start get search id 1 ##############################"
curl -s http://127.0.0.1:3000/api/living_museum/getSearch.json?auth_token=$confirm_token -H "Content-Type: application/json" -X GET -d '{"search_id":1}'
echo
echo;echo;echo "Start get search id 2 (other) ##############################"
curl -s http://127.0.0.1:3000/api/living_museum/getSearch.json?auth_token=$confirm_token -H "Content-Type: application/json" -X GET -d '{"search_id":2}'
echo

echo;echo;echo "Start get search id 1000 (not found) ##############################"
curl -s http://127.0.0.1:3000/api/living_museum/getSearch.json?auth_token=$confirm_token -H "Content-Type: application/json" -X GET -d '{"search_id":1000}'
echo
echo;echo;echo "Start list searches ##############################"
curl -s http://127.0.0.1:3000/api/living_museum/listSearch.json?auth_token=$confirm_token -H "Content-Type: application/json" -X GET -d ''
echo
echo;echo;echo "Start Delete search id 2 ##############################"
curl -s http://127.0.0.1:3000/api/living_museum/deleteSearch.json?auth_token=$confirm_token -H "Content-Type: application/json" -X POST -d '{"search_id":1}'
echo
echo;echo;echo "Start Delete search id 200 ##############################"
curl -s http://127.0.0.1:3000/api/living_museum/deleteSearch.json?auth_token=$confirm_token -H "Content-Type: application/json" -X POST -d '{"search_id":200}'
echo


clear



clear
read -e -p "################## PRESS ENTER KEY TO START ######################"
curl -s http://127.0.0.1:3000/api/users/sign_in -H "Content-Type: application/json" -X POST -d '{"user_login":{"email":"larcara+m1@gmail.com", "password":"password"}}' 
echo
read -e -p "Copy auth_token to contnue: " -i "tyZRctcTg82bAXeHHLGF" auth_token

echo "##### MUSEUM API - START Museum:"
echo
echo;echo;echo  "##### Start getMuseumData ##############################";echo
curl  -s http://127.0.0.1:3000/api/museums/getMuseumData?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{}'

echo;echo;echo  "#######Start setMuseumData - aggiornamento senza image ##############################";echo
curl -s http://127.0.0.1:3000/api/museums/setMuseumData?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{"museum": { "name":"nuovo nome", "city":"Frattocchie", "website":"http://xxxxx" ,"address":"address","telephone":"telephone","logo":"logo", "curatore":"curatore", "edificio":"edificio", "fax":"fax", "email":"email", "orario":"orario", "descrizione":"descrizionedescrizionedescrizione", "nome_direttore":"nome_direttore", "staff":"staffstaffstaffstaffstaffstaffstaff"}}'

exit


echo;echo;echo "Start deleteCard ##############################"
curl -s http://127.0.0.1:3000/api/museums/deleteImage?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "card_id":"569", "image_id":"1" }'
echo;echo;echo "Start deleteCard ##############################"
curl -s http://127.0.0.1:3000/api/museums/deleteImage?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "card_id":"5697", "image_id":"10" }'
echo;echo;echo "Start deleteCard ##############################"
curl -s http://127.0.0.1:3000/api/museums/deleteImage?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "card_id":"5697", "image_id":"1" }'
exit
echo;echo;echo "Start saveCard ##############################"
curl -s http://127.0.0.1:3000/api/museums/saveCard?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "id":"", "data":{"id_codscheda":"test_custom1", "custom_0":"valore0", "custom_1":"valore2", "custom_2":"valore2"} }'
echo;echo;echo  "Start getSectionDetail ALL FIELD ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{"catalog":"default", "section":"*"}'

echo;echo;echo  "Start getSectionDetail ALL FIELD for geodati_reperto ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{"catalog":"default", "section":"geodati_reperto"}'

echo;echo;echo  "Start getSectionDetail ALL FIELD for geodati_reperto ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{"catalog":"default", "section":"*", "filter":{"label_cont":"col"}}'

echo;echo;echo  "Start getSectionDetail per DEFAULT section ubicazione_reperto ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"default", "section":"ubicazione_reperto"}'
echo;echo;echo  "Start getSectionDetail per MOBILE section nuova_sezione ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"mobile", "section":"nuova_sezione"}'
echo;echo;echo  "Start getSectionDetail FILTERED ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"default","section":"geodati_reperto", "filter":{"hidden_eq":"false"}}'

exit
clear

curl -s "http://127.0.0.1:3000/api/museums/getCard?auth_token=${auth_token}&id_codscheda=${id_codscheda}" -H "Content-Type: application/json" -X GET -d '{ }'
echo;echo;echo "Start saveImage - link_only ##############################"
curl -s http://127.0.0.1:3000/api/museums/saveImage?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "card_id":"70904", "image_data":{"label":"test immagine", "link":"http://xxxxx", "tipologia":"tipologia di test"}}'
echo;echo;echo "Start saveImage - image ##############################"
curl -s http://127.0.0.1:3000/api/museums/saveImage?auth_token=$auth_token -H "Content-Type: multipart/form-data" -X POST -F card_id=70904 -F image_data[label]="immagine allegata" -F image_file=@img1.png
echo;echo;echo "Start saveImage - image2 ##############################"
curl -s http://127.0.0.1:3000/api/museums/saveImage?auth_token=$auth_token -H "Content-Type: multipart/form-data" -X POST -F card_id=70904 -F image_data[label]="immagine allegata" -F image_file=@img2.gif
echo;echo;echo "Start saveImage - update data ##############################"
curl -s http://127.0.0.1:3000/api/museums/saveImage?auth_token=$auth_token -H "Content-Type: multipart/form-data" -X POST -F card_id=70904 -F image_data[id]=1 image_data[label]="nuovo testo" -F image_file=@img1.gif
echo;echo;echo "Start getCard per id_codscheda ##############################"
curl -s http://127.0.0.1:3000/api/museums/getCard?auth_token=$auth_token&id=$card_id -H "Content-Type: application/json" -X GET -d '{ }'
exit
echo "##### CONFIG API:"
echo

echo;echo;echo "#### Start getSections  ##############################"
curl  -s http://127.0.0.1:3000/api/config/getSections?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{}'

echo;echo;echo "##### Start getSectionFieldDetail ############################## "
curl  -s http://127.0.0.1:3000/api/config/getSectionFieldDetail?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "section_name":"geodati_reperto"}'

echo;echo;read -e -p "################## PRESS ENTER KEY TO CONTINUE ######################"
clear

echo "##### MUSEUM API - START Museum:"
echo
echo;echo;echo  "##### Start getMuseumData ##############################";echo
curl  -s http://127.0.0.1:3000/api/museums/getMuseumData?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{}'

echo;echo;echo  "#######Start setMuseumData - aggiornamento senza image ##############################";echo
curl -s http://127.0.0.1:3000/api/museums/setMuseumData?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{"museum": { "name":"nuovo nome", "city":"Frattocchie", "website":"http://xxxxx" ,"address":"address","telephone":telephone,"logo":"logo", "curatore":"curatore", "edificio":"edificio", "fax":"fax", "email":"email", "orario":"orario", "descrizione":"descrizionedescrizionedescrizione", "nome_direttore":"nome_direttore", "staff":"staffstaffstaffstaffstaffstaffstaff"}}'

echo;echo;echo  "Start setMuseumData - aggiornamento con image ##############################"
curl -s http://127.0.0.1:3000/api/museums/setMuseumData?auth_token=$auth_token -H "Content-Type: multipart/form-data" -X POST -F museum[name]="altro nome" -F museum[address]="via roma" -F image=@img1.png

echo;echo;echo  "Start setMuseumData - cancellazione dell'immagine allegata  ##############################"
curl -s http://127.0.0.1:3000/api/museums/setMuseumData?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{"museum": { "name":"nuovo nome", "city":"Frattocchie", "website":"http://xxxxx" , "logo":"http://www.google.com"}, "delete_image":true}'

echo;echo;echo   "Start createUser ##############################"
curl  -s http://127.0.0.1:3000/api/museums/createUser?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "user":{"email":"test@nomail.com", "password":"password", "role":"operatore", "cognome":"arcara", "nome":"luca", "facolta":"facolta1", "nascita_data":"1976-10-16", "nascita_luogo":"Roma","residenza_citta":"Roma","residenza_indirizzo":"via roma","telefono":"06123456","titolo_di_studio":"diploma"}}'
echo;echo;echo  "Start updateUser ##############################"
curl  -s http://127.0.0.1:3000/api/museums/updateUser?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "user":{"id":"6", "email":"test@nomail.com" , "role":"amministratore" , "password":"", "role":"operatore", "cognome":"arcara", "nome":"luca", "facolta":"facolta1", "nascita_data":"1976-10-16", "nascita_luogo":"Roma","residenza_citta":"Roma","residenza_indirizzo":"via roma","telefono":"06123456","titolo_di_studio":"diploma"}}'
echo;echo;echo  "Start getUsers ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getUsers?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{}'
echo;echo;echo  "Start destroyUser ##############################"
curl  -s http://127.0.0.1:3000/api/museums/destroyUser?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "user":{"email":"stest@nomail.com", "confirm_email":"stest@nomail.com"}}'

echo; read -e -p "################## END MUSEUM - PRESS ANY KEY TO CONTINUE ######################"
clear


echo "##### MUSEUM API - START Catalog:"
echo

echo;echo;echo  "Start getCatalogs ##############################";echo
curl -s http://127.0.0.1:3000/api/museums/getCatalogs?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{}'
echo;echo;echo  "Start createCatalog ##############################"
curl  -s http://127.0.0.1:3000/api/museums/createCatalog?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile"}'
echo;echo;echo  "Start getCatalogs ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getCatalogs?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{}'
echo
read -e -p "################## END Catalog- PRESS ANY KEY TO CONTINUE ######################"
clear

echo "##### MUSEUM API - START Section:"; echo
echo;echo;echo  "Start getSections per DEFAULT##############################"
curl -s http://127.0.0.1:3000/api/museums/getSections?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"default"}'
echo;echo;echo  "Start getSections per MOBILE##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSections?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"mobile"}'
echo;echo;echo  "Start getSections Filtered per MOBILE##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSections?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"mobile", "filter": {"section_label_cont":"colo"}}'

echo;echo;echo  "Start createSection su Default##############################"
curl  -s http://127.0.0.1:3000/api/museums/createSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"default", "section":"nuova_sezione"}'
echo;echo;echo  "Start getSections per DEFAULT##############################"
curl -s http://127.0.0.1:3000/api/museums/getSections?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"default"}'
echo;echo;echo  "Start deleteSection - delete section standar - ERRORE ##############################"
curl  -s http://127.0.0.1:3000/api/museums/deleteSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"default", "section":"ubicazione_reperto"}'
echo;echo;echo  "Start deleteSection - delete section custom - OK ##############################"
curl  -s http://127.0.0.1:3000/api/museums/deleteSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"default", "section":"nuova_sezione"}'
echo;echo;echo  "Start createSection - catalog MOBILE ##############################"
curl -s http://127.0.0.1:3000/api/museums/createSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile", "section":"nuova_sezione"}'
echo;echo;echo  "Start getSections FILTERED per DEFAULT##############################"
curl -s http://127.0.0.1:3000/api/museums/getSections?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"default", "filter":{"section_name_cont":"dati", "section_label_cont":"dati", "custom_eq":"false", "visible_eq":"true"}}'


echo
read -e -p "################## END Section - PRESS ANY KEY TO CONTINUE ######################"
clear

echo "##### MUSEUM API - START SectionDetail & Field:"; echo

echo;echo;echo  "Start getSectionDetail ALL FIELD ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{"catalog":"default", "section":"*"}'

echo;echo;echo  "Start getSectionDetail ALL FIELD for geodati_reperto ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{"catalog":"default", "section":"geodati_reperto"}'

echo;echo;echo  "Start getSectionDetail ALL FIELD for geodati_reperto ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{"catalog":"default", "section":"*", "filter":{"label_cont":"col"}}'

echo;echo;echo  "Start getSectionDetail per DEFAULT section ubicazione_reperto ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"default", "section":"ubicazione_reperto"}'
echo;echo;echo  "Start getSectionDetail per MOBILE section nuova_sezione ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"mobile", "section":"nuova_sezione"}'
echo;echo;echo  "Start getSectionDetail FILTERED ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"default","section":"geodati_reperto", "filter":{"hidden_eq":"false"}}'


echo
read -e -p "################## PRESS ENTER KEY TO CONTINUE ######################"
echo;echo;echo  "Start getSectionDetail ALL FIELD FILTERED ##############################"
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{"catalog":"default", "section":"*", "filter":{"label_cont":"col"}}'
echo;echo;echo  "Start updateSection - modifica label  ##############################"
curl -s http://127.0.0.1:3000/api/museums/updateSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile", "section":"nuova_sezione", "data":{"section_label": "altro nome"}}'
echo;echo;echo  "Start updateSection - modifica visibilita ##############################"
curl -s http://127.0.0.1:3000/api/museums/updateSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile", "section":"geodati_reperto", "data":{"visible": "false"}}'
echo
read -e -p "################## PRESS ENTER KEY TO CONTINUE ######################"
echo;echo;echo  "Start getSections per MOBILE##############################"
curl -s http://127.0.0.1:3000/api/museums/getSections?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"mobile"}'
echo;echo;echo  "Start addFieldToSection ##############################"
curl -s http://127.0.0.1:3000/api/museums/addFieldToSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"default", "section":"geodati_reperto", "stampa_a":"2", stampa_b:"","position":"3", "options":"test_options", "option_key":"test_option_key", "field_label":"mio campo"}'
echo;echo;echo  "Start addFieldToSection ##############################"
curl -s http://127.0.0.1:3000/api/museums/addFieldToSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile", "section":"nuova_sezione", "position":"3", "options":"test_options", "option_key":"test_option_key", "field_label":"mio campo"}'
echo;echo;echo  "Start addFieldToSection ##############################"
curl -s http://127.0.0.1:3000/api/museums/addFieldToSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile", "section":"nuova_sezione", "position":"3", "options":"test_options", "option_key":"test_option_key", "field_label":"mio campo"}'
echo;echo;echo  "Start addFieldToSection whit STAMPA##############################"
curl -s http://127.0.0.1:3000/api/museums/addFieldToSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"default", "section":"geodati_reperto", "stampa_a":"2", "stampa_b":"","position":"3", "options":"test_options", "option_key":"test_option_key", "field_label":"mio campo"}'
echo
read -e -p "################## PRESS ENTER KEY TO CONTINUE ######################"
echo;echo;echo  "Start getSectionDetail ALL FIELD FILTERED ##############################"
curl http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{"catalog":"mobile", "section":"*", "filter":{"custom_eq":"true"}}'
echo;echo;echo  "Start removeFieldFromSection - remove  from nuova_sezione ##############################"
read -e -p "Insert field_id: " -i "1" field_id
curl -s "http://127.0.0.1:3000/api/museums/removeFieldFromSection?auth_token=${auth_token}&field_id=${field_id}" -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile", "section":"nuova_sezione"}'
echo;echo;echo  "Start setFieldDetails ##############################"
read -e -p "Insert field_id: " -i "1" field_id
curl -s "http://127.0.0.1:3000/api/museums/setFieldDetails?auth_token=${auth_token}&field_id=${field_id}"  -H "Content-Type: application/json" -X POST -d '{ "catalog":"default", "section":"geodati_reperto" , "data":{"stampa_b":"","mobile":"true", "open_data":"false", "mandatory":"true","options":"opzioni varie"} }'
echo
read -e -p "################## END SectionDetail & Field- PRESS ANY KEY TO CONTINUE ######################"
clear

echo "##### MUSEUM API - START Card:"; echo

echo;echo;echo "Start saveCard - Errore campi sbagliati##############################"
curl -s http://127.0.0.1:3000/api/museums/saveCard?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "id":"", "data":{"c1":"val1", "2":"val2"} }'
echo;echo;echo "Start saveCard ##############################"
curl -s http://127.0.0.1:3000/api/museums/saveCard?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "id":"", "data":{"id_codscheda":"acb1000", "luogo_acquisizione":"Roma"} }'
echo;echo;echo  "Start saveCard ##############################"
curl -s http://127.0.0.1:3000/api/museums/saveCard?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "id":"", "data":{"id_codscheda":"acb1001", "luogo_acquisizione":"Napoli"} }'
echo;echo;echo "Start getCard per ID##############################"
read -e -p "Insert card_id: " -i "1" card_id
curl -s "http://127.0.0.1:3000/api/museums/getCard?auth_token=${auth_token}&id=${card_id}"  -H "Content-Type: application/json" -X GET -d '{ }'
echo;echo;echo "Start getCard per id_codscheda ##############################"
read -e -p "Insert card_id: " -i "acb1000" id_codscheda
curl -s "http://127.0.0.1:3000/api/museums/getCard?auth_token=${auth_token}&id_codscheda=${id_codscheda}" -H "Content-Type: application/json" -X GET -d '{ }'
echo;echo;echo "Start saveImage - link_only ##############################"
curl -s http://127.0.0.1:3000/api/museums/saveImage?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "card_id":"$card_id", "image_data":{"label":"test immagine", "link":"http://xxxxx", "tipologia":"tipologia di test"}}'
echo;echo;echo "Start saveImage - image ##############################"
curl -s http://127.0.0.1:3000/api/museums/saveImage?auth_token=$auth_token -H "Content-Type: multipart/form-data" -X POST -F card_id=$card_id -F image_data[label]="immagine allegata" -F image_file=@img1.png
echo;echo;echo "Start saveImage - image2 ##############################"
curl -s http://127.0.0.1:3000/api/museums/saveImage?auth_token=$auth_token -H "Content-Type: multipart/form-data" -X POST -F card_id=$card_id -F image_data[label]="immagine allegata" -F image_file=@img2.gif
echo;echo;echo "Start saveImage - update data ##############################"
curl -s http://127.0.0.1:3000/api/museums/saveImage?auth_token=$auth_token -H "Content-Type: multipart/form-data" -X POST -F card_id=$card_id -F image_data[id]=1 image_data[label]="nuovo testo" -F image_file=@img1.gif
echo;echo;echo "Start getCard per id_codscheda ##############################"
curl -s http://127.0.0.1:3000/api/museums/getCard?auth_token=$auth_token&id=$card_id -H "Content-Type: application/json" -X GET -d '{ }'
echo "Start deleteCard ##############################"
curl -s "http://127.0.0.1:3000/api/museums/deleteCard?auth_token=${auth_token}&id=${card_id}" -H "Content-Type: application/json" -X POST -d '{ }'
echo "Start findCard ##############################"
curl -s "http://127.0.0.1:3000/api/museums/findCard?auth_token=${auth_token}&id=${card_id}" -H "Content-Type: application/json" -X POST -d '{"filter":{
"regione_eq":"Siberia", "magnetico_false":"1" , "fornitore_eq":"Spada", "note_generiche_cont":"compatto"}}'


echo
read -e -p "################## END Card- PRESS ANY KEY TO CONTINUE ######################"
clear

echo "##### OPTIONS API - START Card:"; echo

echo;echo;echo "Start list all options - ##############################"
curl -s http://127.0.0.1:3000/api/options?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{"filter":{"name_present":1}  }'
echo;echo;echo "Start list all province  - ##############################"
curl -s http://127.0.0.1:3000/api/options?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{"filter":{"name_eq":"provincie"} }'
echo;echo;echo "Start inser new option - ##############################"
curl -s http://127.0.0.1:3000/api/options?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{"option":{"name":"nuova_lista", "key":"l1", "value":"value1"} }'
echo;echo;echo "Start inser new option - ##############################"
curl -s http://127.0.0.1:3000/api/options?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{"option":{"name":"nuova_lista", "key":"l2", "value":"value2"} }'
echo;echo;echo "Start list all nuova_lista  - ##############################"
curl -s http://127.0.0.1:3000/api/options?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{"filter":{"name_eq":"nuova_lista"} }'
echo;echo;echo "Start update option - ##############################"
curl -s http://127.0.0.1:3000/api/options/10?auth_token=$auth_token -H "Content-Type: application/json" -X PUT -d '{"option":{"name":"update", "key":"l2", "value":"value2"} }'
echo;echo;echo "Start delete option - ##############################"
curl -s http://127.0.0.1:3000/api/options/10?auth_token=$auth_token -H "Content-Type: application/json" -X DELETE -d '{}'

echo
read -e -p "################## END Card- PRESS ANY KEY TO CONTINUE ######################"
clear


exit



echo
echo "########## FINE TEST ###########"