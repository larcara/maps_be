# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
Museum.create!([
                   {museo_id: "RMSMUS15", name: "Museo di mineralogia", city: "Roma", address: nil, telephone: nil, logo: nil, website: nil},
                   {museo_id: "RMSMUS06", name: "Museo del Vicino Oriente", city: "Roma", address: nil, telephone: nil, logo: nil, website: nil},
                   {museo_id: "RMSMUS09", name: "Museo delle Origini", city: "Roma", address: nil, telephone: nil, logo: nil, website: nil},
                   {museo_id: "RMSMUS12", name: "Erbario", city: "Roma", address: nil, telephone: nil, logo: nil, website: nil},
                   {museo_id: "RMSMUS14", name: "Museo di Storia della Medicina", city: "Roma", address: nil, telephone: nil, logo: nil, website: nil}
               ])


sezioni_campi='colori	Colore	colore	Colore
colori	Colore	coloreb	Colore B
colori	Colore	coloreg	Colore G
colori	Colore	colorer	Colore R
colori	Colore	fenomeni_ottici	Fenomeni ottici
conformit_scheda	Conformità Scheda	valida	Validità scheda
conformit_scheda	Conformità Scheda	visibile	Visibile
datazione	Datazione Reperto	ad_cristo	Avanti/Dopo Cristo
datazione	Datazione Reperto	cronologia_generica	Cronologia generica
datazione	Datazione Reperto	dt_a	A Data
datazione	Datazione Reperto	dt_assoluta	Data assoluta
datazione	Datazione Reperto	dt_da	Da Data
datazione	Datazione Reperto	epoca	Epoca
datazione	Datazione Reperto	fascia_cronologia_rif	Fascia cronologica riferimento
datazione	Datazione Reperto	secolo	Secolo
dati_bibliografici	Bibliografia	bibliografia	Bibliografia
dati_descrittivi	Dati Descrittivi	altra_categoria	Altra categoria
dati_foto	Bibliografia Foto	biblio_foto	Bibliografia Foto
dati_acquisizione	Acquisizione Reperto	dt_acquisizione	Data acquisizione
dati_acquisizione	Acquisizione Reperto	luogo_acquisizione	Luogo acquisizione
dati_acquisizione	Acquisizione Reperto	nome_acquisizione	Nome acquisizione
dati_acquisizione	Acquisizione Reperto	note_acquisizione	Note acquisizione
dati_acquisizione	Acquisizione Reperto	tipo_acquisizione	Tipo acquisizione
dati_descrittivi	Dati Descrittivi	altra_def_oggetto	Altra definizione oggetto
dati_descrittivi	Dati Descrittivi	altro_cod	Altro codice
dati_descrittivi	Dati Descrittivi	binomio1	Binomio 1
dati_descrittivi	Dati Descrittivi	binomio2	Binomio 2
dati_descrittivi	Dati Descrittivi	binomio3	Binomio 3
dati_descrittivi	Dati Descrittivi	binomio4	Binomio 4
dati_descrittivi	Dati Descrittivi	calco	Calco
dati_descrittivi	Dati Descrittivi	categoria_pricipale	Categoria principale
dati_descrittivi	Dati Descrittivi	classe	Classe
dati_descrittivi	Dati Descrittivi	collocazione_opera_finale	Collozione Opera finale
dati_descrittivi	Dati Descrittivi	costruttore	Costruttore
dati_descrittivi	Dati Descrittivi	cronologia_uso	Cronologia uso
dati_descrittivi	Dati Descrittivi	definizione	Definizione
dati_descrittivi	Dati Descrittivi	denominazione	Denominazione
dati_descrittivi	Dati Descrittivi	descrizione	Descrizione
dati_descrittivi	Dati Descrittivi	dest_prestito	Destinatario prestito
dati_descrittivi	Dati Descrittivi	disponibilita	Disponibilità reperto
dati_descrittivi	Dati Descrittivi	famiglia	Famiglia
dati_descrittivi	Dati Descrittivi	fluor	Fluorescente
dati_descrittivi	Dati Descrittivi	formula	Formula
dati_descrittivi	Dati Descrittivi	fornitore	Fornitore
dati_descrittivi	Dati Descrittivi	fosfo	Fosforescente
dati_descrittivi	Dati Descrittivi	funzione	Funzione
dati_descrittivi	Dati Descrittivi	geminato	Geminato
dati_descrittivi	Dati Descrittivi	genere	Genere
dati_descrittivi	Dati Descrittivi	gruppo	Gruppo
dati_descrittivi	Dati Descrittivi	id_num_inventario	Numero Inventario
dati_descrittivi	Dati Descrittivi	id_univoco_reperto	Numero Reperto
dati_anagrafici	Dati Anagrafici	id_codscheda	Codice Scheda
dati_anagrafici	Dati Anagrafici	museum_id	CodiceMuseo
dati_descrittivi	Dati Descrittivi	inprestito	Prestato
dati_descrittivi	Dati Descrittivi	magnetico	Magnetico
dati_descrittivi	Dati Descrittivi	materia_tecnica	Materia/Tecnica
dati_descrittivi	Dati Descrittivi	mod_conservazione	Modalità di conservazione
dati_descrittivi	Dati Descrittivi	mod_uso	Modalità uso
dati_descrittivi	Dati Descrittivi	note_generiche	Note generiche
dati_descrittivi	Dati Descrittivi	num_campione	Numero Campioni
dati_descrittivi	Dati Descrittivi	num_fogli	Numero Fogli
dati_descrittivi	Dati Descrittivi	oggetto	Oggetto
dati_descrittivi	Dati Descrittivi	opera_finale_originale	Opera finale originale
dati_descrittivi	Dati Descrittivi	pseudom	Pseudom
dati_descrittivi	Dati Descrittivi	radio	Radio
dati_descrittivi	Dati Descrittivi	restauri	Restauri
dati_descrittivi	Dati Descrittivi	screditato	Screditato
dati_descrittivi	Dati Descrittivi	sinonimi	Sinonimi
dati_descrittivi	Dati Descrittivi	sistema	Sistema
dati_descrittivi	Dati Descrittivi	sottoclasse	Sottoclasse
dati_descrittivi	Dati Descrittivi	specie	Specie
dati_descrittivi	Dati Descrittivi	specifiche_materiale	Specifiche materiale
geodati_reperto	Geodati Reperto	stato	Stato
dati_descrittivi	Dati Descrittivi	stato_conservazione	Stato conservazione
dati_descrittivi	Dati Descrittivi	stima	Valore economico
dati_descrittivi	Dati Descrittivi	studiato	Studiato
dati_descrittivi	Dati Descrittivi	studio	Studio
dati_descrittivi	Dati Descrittivi	tallone	Tallone
dati_descrittivi	Dati Descrittivi	tipo	Tipo
dati_descrittivi	Dati Descrittivi	txtitalia	Txt Italia
dati_descrittivi	Dati Descrittivi	txtspecie	Txt Specie
dati_descrittivi	Dati Descrittivi	varieta	Varietà
dati_descrittivi	Dati Descrittivi	zonato	Zonato
dati_restauro	Dati Restauro	desc_intervento	Descrizione Intervento
dati_restauro	Dati Restauro	dt_restauro	Data restauro
dati_restauro	Dati Restauro	ente_finanziatore_rest	Ente finanziatore restauro
dati_restauro	Dati Restauro	ente_responsabile_rest	Ente responsabile restauro
dati_scavo	Dati Scavi	cod_univoco_scavo_iccd	Codice univoco scavo
dati_scavo	Dati Scavi	contesto_ritrovamento	Contesto ritrovamento
dati_scavo	Dati Scavi	denominazione_scavo	Nome scavo
dati_scavo	Dati Scavi	dt_scavo	Data Scavo
dati_scavo	Dati Scavi	ente_responsabile_scavo	Ente responsabile scavo
dati_scavo	Dati Scavi	metodo_scavo	Metodo scavo
dati_scavo	Dati Scavi	motivo	Motivi scavo
dati_scavo	Dati Scavi	num_inventario_scavo	Numero inventario scavo
dati_scavo	Dati Scavi	resp_scientifico_scavo	Responsabile scientifico scavo
dati_scavo	Dati Scavi	specifiche_scavo	Specifiche scavo
dati_scavo	Dati Scavi	url_sito_scavo	Url sito scavo
dati_utente	Dati Utente	creato_da	Creato da
dati_utente	Dati Utente	dt_creazione	Data creazione
dati_utente	Dati Utente	dt_modifica	Data ultima modifica
dati_utente	Dati Utente	modificato_da	Modificato da
forma	Forma	abito	Abito
geodati_reperto	Geodati Reperto	continente	Continente
geodati_reperto	Geodati Reperto	coor_asse_x	Coordinate asse x
geodati_reperto	Geodati Reperto	coor_asse_Y	Coordinate asse y
geodati_reperto	Geodati Reperto	diocesi	Diocesi
geodati_reperto	Geodati Reperto	foglio_data	Data foglio
geodati_reperto	Geodati Reperto	loc_estera	Località estera
geodati_reperto	Geodati Reperto	localita	Località
geodati_reperto	Geodati Reperto	localita_antica	Località antica
geodati_reperto	Geodati Reperto	localizz_comune_catasto	Localizzazione comune catasto
geodati_reperto	Geodati Reperto	nazione	Nazione
geodati_reperto	Geodati Reperto	oldlocalita	Old Località
geodati_reperto	Geodati Reperto	oldregione	Old Regione
geodati_reperto	Geodati Reperto	oldstato	Old Stato
geodati_reperto	Geodati Reperto	paese_antico	Paese Antico
geodati_reperto	Geodati Reperto	particelle	Particelle
geodati_reperto	Geodati Reperto	provincia	Provincia
geodati_reperto	Geodati Reperto	quota	Quota
geodati_reperto	Geodati Reperto	regione	Regione
misure	Misure	altezza	Altezza
misure	Misure	capacita	Capacità
misure	Misure	circonferenza	Circonsferenza
misure	Misure	diametro	Diametro
misure	Misure	dimensione_base	Dimensione base
misure	Misure	dimensione_max	Dimensione max
misure	Misure	dimensionex	Dimensione x
misure	Misure	dimensioney	Dimensione y
misure	Misure	dimensionez	Dimensione z
misure	Misure	ingombro	Ingombro
misure	Misure	larghezza	Larghezza
misure	Misure	lunghezza	Lunghezza
misure	Misure	num_frammenti	Numero frammenti
misure	Misure	peso	Peso
misure	Misure	potenza	Potenza
misure	Misure	profondita	Profondità
misure	Misure	quantita	Quantità
misure	Misure	spessore	Spessore
misure	Misure	unita_misura	Unità di misura
ubicazione_reperto	Ubicazione Reperto	cassettiera	Cassettiera
ubicazione_reperto	Ubicazione Reperto	desc_collocazione	Descrizione collocazione
ubicazione_reperto	Ubicazione Reperto	espositore	Espositore
ubicazione_reperto	Ubicazione Reperto	pacco	Pacco
ubicazione_reperto	Ubicazione Reperto	piano	Piano
ubicazione_reperto	Ubicazione Reperto	posizione	Posizione
ubicazione_reperto	Ubicazione Reperto	ripiano	Ripiano
ubicazione_reperto	Ubicazione Reperto	sala	Sala'

sezioni_campi.each_line do |l|
  campi=l.split("\t")
  campi=campi.map{|x| x.strip}
  f=TemplateField.create(field_name: campi[2], field_label: campi[3], field_description: campi[3], field_data_type: "varchar", custom: false)
  CardTemplateField.create(section_name: campi[0], section_label: campi[1] , template_field_id:f.id , label:f.field_label,
                           enabled: true, hidden: false, position: 1, mobile: true, open_data: true, mandatory: false, options: "", option_key: nil, custom: false)
end
15.times do |i|
  TemplateField.create(field_name: "custom_#{i}", field_label: "label_custom_#{i}", field_description: "description_custom_#{i}", field_data_type: "varchar",  custom: true)
end

User.create(email: "larcara+m1@gmail.com", password: "password", museum_id:1, role: "amministratore")
User.create(email: "larcara+m2@gmail.com", password: "password", museum_id:2, role: "amministratore")
Museum.find(1).initMuseum
Museum.find(2).initMuseum

load 'db/card.rb'
load 'db/images.rb'
