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

ActiveRecord::Schema.define(version: 20140428195526) do

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
  end

  create_table "cards", force: true do |t|
    t.integer  "museum_id",                            null: false
    t.string   "colore",                    limit: 50
    t.text     "descrizione"
    t.string   "oggetto"
    t.string   "id_codscheda",              limit: 50, null: false
    t.string   "abito"
    t.string   "ad_cristo",                 limit: 50
    t.float    "altezza"
    t.string   "altra_categoria"
    t.string   "altra_def_oggetto"
    t.string   "altro_cod",                 limit: 50
    t.string   "biblio_foto",               limit: 50
    t.string   "binomio1"
    t.string   "binomio2"
    t.string   "binomio3"
    t.string   "binomio4"
    t.string   "capacita",                  limit: 50
    t.string   "cassettiera",               limit: 50
    t.string   "categoria_pricipale"
    t.string   "circonferenza",             limit: 50
    t.string   "classe"
    t.string   "cod_univoco_scavo_iccd",    limit: 50
    t.string   "id_univoco_reperto",        limit: 50
    t.string   "id_num_inventario",         limit: 50
    t.string   "collocazione_opera_finale"
    t.string   "coloreb",                   limit: 5
    t.string   "coloreg",                   limit: 5
    t.string   "colorer",                   limit: 5
    t.string   "contesto_ritrovamento"
    t.string   "continente"
    t.string   "coor_asse_x",               limit: 50
    t.string   "coor_asse_y",               limit: 50
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
    t.string   "diocesi",                   limit: 50
    t.string   "disponibilita"
    t.string   "dt_a",                      limit: 20
    t.string   "dt_acquisizione",           limit: 20
    t.string   "dt_assoluta",               limit: 20
    t.string   "dt_creazione",              limit: 20
    t.string   "dt_da",                     limit: 20
    t.string   "dt_esatta_acquisizione",    limit: 20
    t.string   "dt_modifica",               limit: 20
    t.string   "dt_restauro",               limit: 20
    t.string   "dt_scavo",                  limit: 20
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
    t.string   "ingombro",                  limit: 50
    t.string   "inprestito"
    t.string   "larghezza"
    t.string   "loc_estera"
    t.string   "localita"
    t.string   "localita_antica"
    t.string   "localizz_comune_catasto"
    t.string   "lunghezza",                 limit: 50
    t.string   "luogo_acquisizione"
    t.boolean  "magnetico"
    t.string   "materia_tecnica"
    t.string   "metodo_scavo",              limit: 50
    t.string   "mod_conservazione",         limit: 50
    t.string   "mod_uso"
    t.string   "modificato_da",             limit: 50
    t.string   "motivo"
    t.string   "nazione",                   limit: 50
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
    t.string   "paese_antico",              limit: 50
    t.string   "particelle",                limit: 50
    t.float    "peso"
    t.string   "piano"
    t.string   "posizione",                 limit: 50
    t.string   "potenza"
    t.string   "profondita"
    t.string   "provincia",                 limit: 50
    t.boolean  "pseudom"
    t.string   "quantita",                  limit: 50
    t.string   "quota"
    t.boolean  "radio"
    t.string   "regione",                   limit: 50
    t.string   "resp_scientifico_scavo"
    t.string   "restauri"
    t.string   "ripiano"
    t.string   "sala",                      limit: 50
    t.string   "secolo",                    limit: 50
    t.string   "sistema"
    t.string   "sottoclasse"
    t.string   "specie"
    t.string   "specifiche_materiale"
    t.string   "specifiche_scavo"
    t.string   "spessore",                  limit: 50
    t.string   "stato_conservazione",       limit: 50
    t.string   "stima",                     limit: 50
    t.string   "tipo",                      limit: 50
    t.string   "tipo_acquisizione"
    t.string   "unita_misura",              limit: 50
    t.string   "url_sito_scavo"
    t.string   "valida",                    limit: 50
    t.string   "visibile",                  limit: 50
    t.string   "zonato",                    limit: 50
    t.string   "stato",                     limit: 50
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bibliografia"
    t.text     "studio"
  end

  add_index "cards", ["id_codscheda", "museum_id"], name: "cards_index_1", unique: true, using: :btree

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
    t.string   "options"
    t.string   "option_key"
    t.string   "field_type"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  create_table "options", force: true do |t|
    t.integer  "museum_id"
    t.string   "name"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
