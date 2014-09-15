# == Schema Information
#
# Table name: cards
#
#  id                        :integer          not null, primary key
#  museum_id                 :integer          not null
#  colore                    :string(50)
#  descrizione               :text
#  oggetto                   :string(255)
#  id_codscheda              :string(50)       not null
#  abito                     :string(255)
#  ad_cristo                 :string(50)
#  altezza                   :float
#  altra_categoria           :string(255)
#  altra_def_oggetto         :string(255)
#  altro_cod                 :string(50)
#  biblio_foto               :string(50)
#  binomio1                  :string(255)
#  binomio2                  :string(255)
#  binomio3                  :string(255)
#  binomio4                  :string(255)
#  capacita                  :string(50)
#  cassettiera               :string(50)
#  categoria_pricipale       :string(255)
#  circonferenza             :string(50)
#  classe                    :string(255)
#  cod_univoco_scavo_iccd    :string(50)
#  id_univoco_reperto        :string(50)
#  id_num_inventario         :string(50)
#  collocazione_opera_finale :string(255)
#  coloreb                   :string(5)
#  coloreg                   :string(5)
#  colorer                   :string(5)
#  contesto_ritrovamento     :string(255)
#  continente                :string(255)
#  coor_asse_x               :string(50)
#  coor_asse_y               :string(50)
#  costruttore               :string(255)
#  creato_da                 :string(255)
#  cronologia_generica       :string(255)
#  cronologia_uso            :string(255)
#  definizione               :string(255)
#  denominazione             :text
#  denominazione_scavo       :text
#  desc_collocazione         :text
#  desc_intervento           :text
#  dest_prestito             :string(255)
#  diametro                  :float
#  dimensione_base           :float
#  dimensione_max            :float
#  dimensionex               :float
#  dimensioney               :float
#  dimensionez               :float
#  diocesi                   :string(50)
#  disponibilita             :string(255)
#  dt_a                      :string(20)
#  dt_acquisizione           :string(20)
#  dt_assoluta               :string(20)
#  dt_creazione              :string(20)
#  dt_da                     :string(20)
#  dt_esatta_acquisizione    :string(20)
#  dt_modifica               :string(20)
#  dt_restauro               :string(20)
#  dt_scavo                  :string(20)
#  ente_finanziatore_rest    :string(255)
#  ente_responsabile_rest    :string(255)
#  ente_responsabile_scavo   :string(255)
#  epoca                     :string(255)
#  espositore                :string(255)
#  famiglia                  :string(255)
#  fascia_cronologia_rif     :string(255)
#  fenomeni_ottici           :string(255)
#  fluor                     :boolean
#  foglio_data               :string(255)
#  fornitore                 :string(255)
#  fosfo                     :boolean
#  funzione                  :string(255)
#  geminato                  :boolean
#  genere                    :string(255)
#  gruppo                    :string(255)
#  ingombro                  :string(50)
#  inprestito                :string(255)
#  larghezza                 :string(255)
#  loc_estera                :string(255)
#  localita                  :string(255)
#  localita_antica           :string(255)
#  localizz_comune_catasto   :string(255)
#  lunghezza                 :string(50)
#  luogo_acquisizione        :string(255)
#  magnetico                 :boolean
#  materia_tecnica           :string(255)
#  metodo_scavo              :string(50)
#  mod_conservazione         :string(50)
#  mod_uso                   :string(255)
#  modificato_da             :string(50)
#  motivo                    :string(255)
#  nazione                   :string(50)
#  nome_acquisizione         :text
#  note_acquisizione         :text
#  note_generiche            :text
#  num_campione              :integer
#  num_fogli                 :integer
#  num_frammenti             :integer
#  num_inventario_scavo      :string(255)
#  oldlocalita               :string(255)
#  oldregione                :string(255)
#  oldstato                  :string(255)
#  opera_finale_originale    :string(255)
#  pacco                     :string(255)
#  paese_antico              :string(50)
#  particelle                :string(50)
#  peso                      :float
#  piano                     :string(255)
#  posizione                 :string(50)
#  potenza                   :string(255)
#  profondita                :string(255)
#  provincia                 :string(50)
#  pseudom                   :boolean
#  quantita                  :string(50)
#  quota                     :string(255)
#  radio                     :boolean
#  regione                   :string(50)
#  resp_scientifico_scavo    :string(255)
#  restauri                  :string(255)
#  ripiano                   :string(255)
#  sala                      :string(50)
#  secolo                    :string(50)
#  sistema                   :string(255)
#  sottoclasse               :string(255)
#  specie                    :string(255)
#  specifiche_materiale      :string(255)
#  specifiche_scavo          :string(255)
#  spessore                  :string(50)
#  stato_conservazione       :string(50)
#  stima                     :string(50)
#  tipo                      :string(50)
#  tipo_acquisizione         :string(255)
#  unita_misura              :string(50)
#  url_sito_scavo            :string(255)
#  valida                    :string(50)
#  visibile                  :string(50)
#  zonato                    :string(50)
#  stato                     :string(50)
#  studiato                  :boolean
#  txtspecie                 :string(255)
#  txtitalia                 :string(255)
#  sinonimi                  :string(255)
#  varieta                   :string(255)
#  screditato                :string(255)
#  formula                   :string(255)
#  lt                        :string(255)
#  tallone                   :string(255)
#  calco                     :boolean
#  primasegnalazione         :string(255)
#  collezione                :string(255)
#  erboserie                 :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  bibliografia              :text
#  studio                    :text
#

class Card < ActiveRecord::Base
  include PgSearch
  validates_presence_of :id_codscheda
  validates_uniqueness_of :id_codscheda, scope: :museum_id
  belongs_to :museum
  has_many :museum_images, dependent: :destroy

  scope :valide, -> {where(valida: true)}
  pg_search_scope :search_by_full_text,
                      :against => [:colore, :oggetto, :id_codscheda, :abito, :ad_cristo, :altra_categoria, :altra_def_oggetto, :altro_cod, :biblio_foto, :binomio1, :binomio2, :binomio3, :binomio4, :capacita, :cassettiera, :categoria_pricipale, :circonferenza, :classe, :cod_univoco_scavo_iccd, :id_univoco_reperto, :id_num_inventario, :collocazione_opera_finale, :coloreb, :coloreg, :colorer, :contesto_ritrovamento, :continente, :coor_asse_x, :coor_asse_y, :costruttore, :creato_da, :cronologia_generica, :cronologia_uso, :definizione, :dest_prestito, :diocesi, :disponibilita, :dt_a, :dt_acquisizione, :dt_creazione, :dt_da, :dt_esatta_acquisizione, :dt_modifica, :dt_restauro, :dt_scavo, :ente_finanziatore_rest, :ente_responsabile_rest, :ente_responsabile_scavo, :epoca, :espositore, :famiglia, :fascia_cronologia_rif, :fenomeni_ottici, :foglio_data, :fornitore, :funzione, :genere, :gruppo, :ingombro, :inprestito, :larghezza, :loc_estera, :localita, :localita_antica, :localizz_comune_catasto, :lunghezza, :luogo_acquisizione, :materia_tecnica, :metodo_scavo, :mod_conservazione, :mod_uso, :modificato_da, :motivo, :nazione, :num_inventario_scavo, :oldlocalita, :oldregione, :oldstato, :opera_finale_originale, :pacco, :paese_antico, :particelle, :piano, :posizione, :potenza, :profondita, :provincia, :quantita, :quota, :regione, :resp_scientifico_scavo, :restauri, :ripiano, :sala, :secolo, :sistema, :sottoclasse, :specie, :specifiche_materiale, :specifiche_scavo, :spessore, :stima, :tipo, :tipo_acquisizione, :unita_misura, :url_sito_scavo, :visibile, :zonato, :stato, :txtspecie, :txtitalia, :sinonimi, :varieta, :screditato, :formula, :lt, :tallone, :primasegnalazione, :collezione, :erboserie, :associazione, :legit, :custom_1, :custom_2, :custom_3, :custom_4, :custom_5, :custom_6, :custom_7, :custom_8, :custom_9, :custom_10, :custom_11, :custom_12, :custom_13, :custom_14, :custom_15, :custom_0],
                      :using => {:tsearch => {:prefix => true}}

end
