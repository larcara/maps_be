#!/bin/bash
TOT=41
c=0

curl -s http://127.0.0.1:3000/api/users/sign_in -H "Content-Type: application/json" -X POST -d '{"user_login":{"email":"larcara+m1@gmail.com", "password":"password"}}' 
echo
#auth_token=${auth_token:-s_cYHdKeX7-Cyyj7Gs3R}
read -e -p "Copy auth_token to contnue: " -i "s_cYHdKeX7-Cyyj7Gs3R" auth_token



echo $auth_token
c=$(($c + 1))
echo -n "$c/$TOT Start getSections ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/config/getSections?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start saveImage - link_only ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/saveImage?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "card_id":"1", "label":"test immagine", "link":"http://xxxxx"}'


echo
c=$(($c + 1))
echo -n "$c/$TOT Start saveImage - image ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/saveImage?auth_token=$auth_token -H "Content-Type: multipart/form-data" -X POST -F card_id=1 -F label="immagine allegata" -F image=@img1.png

echo
c=$(($c + 1))
echo -n "$c/$TOT Start saveImage - image2 ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/saveImage?auth_token=$auth_token -H "Content-Type: multipart/form-data" -X POST -F card_id=1 -F label="immagine allegata" -F image=@img2.gif

echo
c=$(($c + 1))
echo -n "$c/$TOT Start setMuseumData - senza image ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/setMuseumData?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{"museum": { "name":"nuovo nome", "city":"Frattocchie", "website":"http://xxxxx"}}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start setMuseumData - con image ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/setMuseumData?auth_token=$auth_token -H "Content-Type: multipart/form-data" -X POST -F museum[name]="altro nome" -F museum[address]="via roma" -F image=@img1.png

echo
c=$(($c + 1))
echo -n "$c/$TOT Start setMuseumData - delete image ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/setMuseumData?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{"museum": { "name":"nuovo nome", "city":"Frattocchie", "website":"http://xxxxx" , "logo":"http://www.google.com"}, "delete_image":true}'


echo
c=$(($c + 1))
echo -n "$c/$TOT Start getSectionFieldDetail ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/config/getSectionFieldDetail?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "section_name":"geodati_reperto"}'


echo
c=$(($c + 1))
echo -n "$c/$TOT Start getMuseumData ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/getMuseumData?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start getCatalogs ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/getCatalogs?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start getSections ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/getSections?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"default"}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start getSections ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/getSections?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"mobile"}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start getSectionDetail ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"default", "section":"ubicazione_reperto"}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start getSectionDetail FILTERED ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"default","section":"geodati_reperto", "filter":{"label_cont":"col"}}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start getSectionDetail ALL FIELD FILTERED ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{"catalog":"default", "section":"*", "filter":{"label_cont":"col"}}'



echo
c=$(($c + 1))
echo -n "$c/$TOT Start deleteSection ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/deleteSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"default", "section":"ubicazione_reperto"}'


echo
c=$(($c + 1))
echo -n "$c/$TOT Start getSectionDetail ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"non_esiste", "section":"ubicazione_reperto"}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start createCatalog ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/createCatalog?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"non_esiste"}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start createCatalog ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/createCatalog?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile"}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start getCatalogs ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/getCatalogs?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start createUser ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/createUser?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "user":{"email":"test@nomail.com", "password":"password", "role":"operatore"}}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start destroyUser ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/destroyUser?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "user":{"email":"test@nomail.com", "confirm_email":"test@nomail.com"}}'

echo "#################################"

echo
c=$(($c + 1))
echo -n "$c/$TOT Start createUser ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/createUser?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "user":{"email":"test@nomail.com", "password":"password", "role":"operatore"}}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start updateUser ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/updateUser?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "user":{"email":"test@nomail.com" , "role":"amministratore"}}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start getUsers ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/getUsers?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start createSection ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/createSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"default", "section":"nuova_sezione"}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start deleteSection ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/deleteSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"default", "section":"nuova_sezione"}'


echo
c=$(($c + 1))
echo -n "$c/$TOT Start createSection ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/createSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile", "section":"nuova_sezione"}'


echo
c=$(($c + 1))
echo -n "$c/$TOT Start addFieldToSection ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/addFieldToSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile", "section":"nuova_sezione", "position":"3", "options":"test_options", "option_key":"test_option_key", "field_label":"mio campo"}'	

echo
c=$(($c + 1))
echo -n "$c/$TOT Start removeFieldFromSection ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/removeFieldFromSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile", "section":"nuova_sezione", "field_id":"500"}'	

echo
c=$(($c + 1))
echo -n "$c/$TOT Start removeFieldFromSection ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/removeFieldFromSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile", "section":"nuova_sezione", "field_id":"499"}'	


echo
c=$(($c + 1))
echo -n "$c/$TOT Start addFieldToSection ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/addFieldToSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile", "section":"nuova_sezione", "position":"3", "options":"test_options", "option_key":"test_option_key", "field_label":"mio campo"}'	

echo
c=$(($c + 1))
echo -n "$c/$TOT Start deleteSection ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/deleteSection?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile", "section":"nuova_sezione"}'



echo
c=$(($c + 1))
echo -n "$c/$TOT Start getSectionDetail ############################## Press any key to start: "
read -n 1 key
curl  -s http://127.0.0.1:3000/api/museums/getSectionDetail?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "catalog":"mobile", "section":"nuova_sezione"}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start setFieldDetails ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/setFieldDetails?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile", "section":"nuova_sezione", "field_id": "150" , "data":{"position":20,"mobile":"true", "open_data":"false", "mandatory":"true","options":"opzioni varie"} }'


echo
c=$(($c + 1))
echo -n "$c/$TOT Start setSectionName ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/setSectionName?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "catalog":"mobile", "section":"nuova_sezione", "new_label": "altro nome" }'




echo
c=$(($c + 1))
echo -n "$c/$TOT Start saveCard ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/saveCard?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "id":"", "data":{"c1":"val1", "2":"val2"} }'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start saveCard ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/saveCard?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "id":"", "data":{"id_codscheda":"val2", "luogo_acquisizione":"val2"} }'


echo
c=$(($c + 1))
echo -n "$c/$TOT Start getCard ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/getCard?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "id":"1120"}'

echo
c=$(($c + 1))
echo -n "$c/$TOT Start getCard ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/getCard?auth_token=$auth_token -H "Content-Type: application/json" -X GET -d '{ "id":"1"}'


echo
c=$(($c + 1))
echo -n "$c/$TOT Start deleteCard ############################## Press any key to start: "
read -n 1 key
curl -s http://127.0.0.1:3000/api/museums/deleteCard?auth_token=$auth_token -H "Content-Type: application/json" -X POST -d '{ "id":"1000"}'

echo
echo "########## FINE TEST ###########"