# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141104213720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "card_template_fields", force: true do |t|
    t.string  "section_name"
    t.string  "section_label"
    t.integer "template_field_id"
    t.string  "label"
    t.boolean "enabled"
    t.boolean "hidden"
    t.integer "position"
    t.integer "mobile"
    t.integer "open_data"
    t.boolean "mandatory"
    t.string  "options"
    t.string  "option_key"
    t.string  "field_type"
    t.boolean "custom"
    t.boolean "pubblico"
  end

  create_table "cards", force: true do |t|
    t.integer  "museum_id",                 null: false
    t.string   "colore"
    t.string   "oggetto"
    t.string   "id_codscheda",              null: false
    t.string   "abito"
    t.string   "ad_cristo"
    t.float    "altezza"
    t.string   "altra_categoria"
    t.string   "altra_def_oggetto"
    t.string   "altro_cod"
    t.string   "biblio_foto"
    t.string   "binomio1"
    t.string   "binomio2"
    t.string   "binomio3"
    t.string   "binomio4"
    t.string   "capacita"
    t.string   "cassettiera"
    t.string   "categoria_pricipale"
    t.string   "circonferenza"
    t.string   "classe"
    t.string   "cod_univoco_scavo_iccd"
    t.string   "id_univoco_reperto"
    t.string   "id_num_inventario"
    t.string   "collocazione_opera_finale"
    t.string   "coloreb"
    t.string   "coloreg"
    t.string   "colorer"
    t.string   "contesto_ritrovamento"
    t.string   "continente"
    t.string   "coor_asse_x"
    t.string   "coor_asse_y"
    t.string   "costruttore"
    t.string   "creato_da"
    t.string   "cronologia_generica"
    t.string   "cronologia_uso"
    t.string   "definizione"
    t.text     "denominazione"
    t.text     "denominazione_scavo"
    t.text     "desc_collocazione"
    t.text     "desc_intervento"
    t.string   "dest_prestito"
    t.float    "diametro"
    t.float    "dimensione_base"
    t.float    "dimensione_max"
    t.float    "dimensionex"
    t.float    "dimensioney"
    t.float    "dimensionez"
    t.string   "diocesi"
    t.string   "disponibilita"
    t.string   "dt_a"
    t.string   "dt_acquisizione"
    t.string   "dt_creazione"
    t.string   "dt_da"
    t.string   "dt_esatta_acquisizione"
    t.string   "dt_modifica"
    t.string   "dt_restauro"
    t.string   "dt_scavo"
    t.string   "ente_finanziatore_rest"
    t.string   "ente_responsabile_rest"
    t.string   "ente_responsabile_scavo"
    t.string   "epoca"
    t.string   "espositore"
    t.string   "famiglia"
    t.string   "fascia_cronologia_rif"
    t.string   "fenomeni_ottici"
    t.boolean  "fluor"
    t.string   "foglio_data"
    t.string   "fornitore"
    t.boolean  "fosfo"
    t.string   "funzione"
    t.boolean  "geminato"
    t.string   "genere"
    t.string   "gruppo"
    t.string   "ingombro"
    t.string   "inprestito"
    t.string   "larghezza"
    t.string   "loc_estera"
    t.string   "localita"
    t.string   "localita_antica"
    t.string   "localizz_comune_catasto"
    t.string   "lunghezza"
    t.string   "luogo_acquisizione"
    t.boolean  "magnetico"
    t.string   "materia_tecnica"
    t.string   "metodo_scavo"
    t.string   "mod_conservazione"
    t.string   "mod_uso"
    t.string   "modificato_da"
    t.string   "motivo"
    t.string   "nazione"
    t.text     "nome_acquisizione"
    t.text     "note_acquisizione"
    t.text     "note_generiche"
    t.integer  "num_campione"
    t.integer  "num_fogli"
    t.integer  "num_frammenti"
    t.string   "num_inventario_scavo"
    t.string   "oldlocalita"
    t.string   "oldregione"
    t.string   "oldstato"
    t.string   "opera_finale_originale"
    t.string   "pacco"
    t.string   "paese_antico"
    t.string   "particelle"
    t.float    "peso"
    t.string   "piano"
    t.string   "posizione"
    t.string   "potenza"
    t.string   "profondita"
    t.string   "provincia"
    t.boolean  "pseudom"
    t.string   "quantita"
    t.string   "quota"
    t.boolean  "radio"
    t.string   "regione"
    t.string   "resp_scientifico_scavo"
    t.string   "restauri"
    t.string   "ripiano"
    t.string   "sala"
    t.string   "secolo"
    t.string   "sistema"
    t.string   "sottoclasse"
    t.string   "specie"
    t.string   "specifiche_materiale"
    t.string   "specifiche_scavo"
    t.string   "spessore"
    t.string   "stima"
    t.string   "tipo"
    t.string   "tipo_acquisizione"
    t.string   "unita_misura"
    t.string   "url_sito_scavo"
    t.string   "visibile"
    t.string   "zonato"
    t.string   "stato"
    t.boolean  "studiato"
    t.string   "txtspecie"
    t.string   "txtitalia"
    t.string   "sinonimi"
    t.string   "varieta"
    t.string   "screditato"
    t.string   "formula"
    t.string   "lt"
    t.string   "tallone"
    t.boolean  "calco"
    t.string   "primasegnalazione"
    t.string   "collezione"
    t.string   "erboserie"
    t.string   "associazione"
    t.string   "legit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bibliografia"
    t.text     "studio"
    t.text     "stato_conservazione"
    t.text     "descrizione"
    t.string   "custom_1"
    t.string   "custom_2"
    t.string   "custom_3"
    t.string   "custom_4"
    t.string   "custom_5"
    t.string   "custom_6"
    t.string   "custom_7"
    t.string   "custom_8"
    t.string   "custom_9"
    t.string   "custom_10"
    t.string   "custom_11"
    t.string   "custom_12"
    t.string   "custom_13"
    t.string   "custom_14"
    t.string   "custom_15"
    t.string   "custom_0"
    t.date     "dt_assoluta"
    t.boolean  "valida"
  end

  add_index "cards", ["id_codscheda", "museum_id"], name: "cards_index_1", unique: true, using: :btree
  add_index "cards", ["nazione", "paese_antico", "provincia", "regione", "resp_scientifico_scavo", "secolo", "sistema", "sottoclasse", "specie", "specifiche_scavo", "tipo", "stato", "txtspecie", "txtitalia", "sinonimi", "varieta", "screditato", "formula", "tallone", "collezione", "erboserie", "legit", "stato_conservazione", "associazione", "denominazione", "denominazione_scavo", "note_generiche", "bibliografia", "studio", "stato_conservazione"], name: "for_fulltext_2", using: :btree
  add_index "cards", ["regione", "colore", "oggetto", "abito", "ad_cristo", "altra_def_oggetto", "binomio1", "binomio2", "capacita", "classe", "contesto_ritrovamento", "costruttore", "cronologia_generica", "cronologia_uso", "definizione", "diocesi", "epoca", "famiglia", "fascia_cronologia_rif", "genere", "gruppo", "localita", "localita_antica", "materia_tecnica"], name: "for_fulltext_1", using: :btree

  create_table "living_museum_user_searches", force: true do |t|
    t.integer  "living_museum_user_id"
    t.string   "q"
    t.integer  "limit"
    t.text     "filter"
    t.text     "sql"
    t.text     "card_ids"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "living_museum_users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_name"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "living_museum_users", ["email"], name: "index_living_museum_users_on_email", unique: true, using: :btree
  add_index "living_museum_users", ["reset_password_token"], name: "index_living_museum_users_on_reset_password_token", unique: true, using: :btree

  create_table "museum_fields", force: true do |t|
    t.integer  "museum_section_id"
    t.integer  "card_template_field_id"
    t.string   "template_field_id"
    t.string   "label"
    t.boolean  "enabled"
    t.boolean  "hidden"
    t.integer  "position"
    t.integer  "mobile"
    t.integer  "open_data"
    t.boolean  "mandatory"
    t.boolean  "custom"
    t.text     "options"
    t.string   "option_key"
    t.string   "field_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stampa_a"
    t.integer  "stampa_b"
    t.integer  "stampa_c"
    t.boolean  "pubblico"
  end

  create_table "museum_images", force: true do |t|
    t.integer  "card_id"
    t.string   "label"
    t.string   "link"
    t.integer  "num_prog"
    t.string   "tipologia"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "prog"
  end

  create_table "museum_sections", force: true do |t|
    t.integer  "museum_id"
    t.string   "form_name"
    t.string   "section_name"
    t.string   "section_label"
    t.boolean  "custom"
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "museums", force: true do |t|
    t.string   "museo_id"
    t.string   "name"
    t.string   "city"
    t.string   "address"
    t.string   "telephone"
    t.string   "logo"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "curatore"
    t.string   "edificio"
    t.string   "fax"
    t.string   "email"
    t.string   "orario"
    t.string   "descrizione"
    t.string   "nome_direttore"
    t.text     "staff"
  end

  create_table "options", force: true do |t|
    t.integer  "museum_id"
    t.string   "name"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "template_fields", force: true do |t|
    t.string   "field_name"
    t.string   "field_label"
    t.string   "field_description"
    t.string   "field_data_type"
    t.boolean  "custom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "template_fields", ["field_name"], name: "index_template_fields_on_field_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "role"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.integer  "museum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nome"
    t.string   "cognome"
    t.string   "titolo_di_studio"
    t.string   "facolta"
    t.date     "nascita_data"
    t.string   "nascita_luogo"
    t.string   "residenza_indirizzo"
    t.string   "residenza_citta"
    t.string   "telefono"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
