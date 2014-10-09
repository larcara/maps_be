# == Schema Information
#
# Table name: cards
#
#  id                        :integer          not null, primary key
#  museum_id                 :integer          not null
#  colore                    :string(255)
#  oggetto                   :string(255)
#  id_codscheda              :string(255)      not null
#  abito                     :string(255)
#  ad_cristo                 :string(255)
#  altezza                   :float
#  altra_categoria           :string(255)
#  altra_def_oggetto         :string(255)
#  altro_cod                 :string(255)
#  biblio_foto               :string(255)
#  binomio1                  :string(255)
#  binomio2                  :string(255)
#  binomio3                  :string(255)
#  binomio4                  :string(255)
#  capacita                  :string(255)
#  cassettiera               :string(255)
#  categoria_pricipale       :string(255)
#  circonferenza             :string(255)
#  classe                    :string(255)
#  cod_univoco_scavo_iccd    :string(255)
#  id_univoco_reperto        :string(255)
#  id_num_inventario         :string(255)
#  collocazione_opera_finale :string(255)
#  coloreb                   :string(255)
#  coloreg                   :string(255)
#  colorer                   :string(255)
#  contesto_ritrovamento     :string(255)
#  continente                :string(255)
#  coor_asse_x               :string(255)
#  coor_asse_y               :string(255)
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
#  diocesi                   :string(255)
#  disponibilita             :string(255)
#  dt_a                      :string(255)
#  dt_acquisizione           :string(255)
#  dt_creazione              :string(255)
#  dt_da                     :string(255)
#  dt_esatta_acquisizione    :string(255)
#  dt_modifica               :string(255)
#  dt_restauro               :string(255)
#  dt_scavo                  :string(255)
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
#  ingombro                  :string(255)
#  inprestito                :string(255)
#  larghezza                 :string(255)
#  loc_estera                :string(255)
#  localita                  :string(255)
#  localita_antica           :string(255)
#  localizz_comune_catasto   :string(255)
#  lunghezza                 :string(255)
#  luogo_acquisizione        :string(255)
#  magnetico                 :boolean
#  materia_tecnica           :string(255)
#  metodo_scavo              :string(255)
#  mod_conservazione         :string(255)
#  mod_uso                   :string(255)
#  modificato_da             :string(255)
#  motivo                    :string(255)
#  nazione                   :string(255)
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
#  paese_antico              :string(255)
#  particelle                :string(255)
#  peso                      :float
#  piano                     :string(255)
#  posizione                 :string(255)
#  potenza                   :string(255)
#  profondita                :string(255)
#  provincia                 :string(255)
#  pseudom                   :boolean
#  quantita                  :string(255)
#  quota                     :string(255)
#  radio                     :boolean
#  regione                   :string(255)
#  resp_scientifico_scavo    :string(255)
#  restauri                  :string(255)
#  ripiano                   :string(255)
#  sala                      :string(255)
#  secolo                    :string(255)
#  sistema                   :string(255)
#  sottoclasse               :string(255)
#  specie                    :string(255)
#  specifiche_materiale      :string(255)
#  specifiche_scavo          :string(255)
#  spessore                  :string(255)
#  stima                     :string(255)
#  tipo                      :string(255)
#  tipo_acquisizione         :string(255)
#  unita_misura              :string(255)
#  url_sito_scavo            :string(255)
#  visibile                  :string(255)
#  zonato                    :string(255)
#  stato                     :string(255)
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
#  associazione              :string(255)
#  legit                     :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  bibliografia              :text
#  studio                    :text
#  stato_conservazione       :text
#  descrizione               :text
#  custom_1                  :string(255)
#  custom_2                  :string(255)
#  custom_3                  :string(255)
#  custom_4                  :string(255)
#  custom_5                  :string(255)
#  custom_6                  :string(255)
#  custom_7                  :string(255)
#  custom_8                  :string(255)
#  custom_9                  :string(255)
#  custom_10                 :string(255)
#  custom_11                 :string(255)
#  custom_12                 :string(255)
#  custom_13                 :string(255)
#  custom_14                 :string(255)
#  custom_15                 :string(255)
#  custom_0                  :string(255)
#  dt_assoluta               :date
#  valida                    :boolean
#

class Card < ActiveRecord::Base
  include PgSearch
  validates_presence_of :id_codscheda
  validates_uniqueness_of :id_codscheda, scope: :museum_id
  belongs_to :museum
  has_many :museum_images, dependent: :destroy

  scope :valide, -> {where(valida: true)}
  pg_search_scope :search_by_full_text,
                      :against => [:colore, :oggetto,
                                   :abito, :ad_cristo,
                                   :altra_def_oggetto, :altro_cod, :biblio_foto, :binomio1, :binomio2,

                                   :capacita, :classe,:id_univoco_reperto, :id_num_inventario,
                                   :coloreb, :coloreg, :colorer,
                                   :contesto_ritrovamento,:continente,:costruttore,:cronologia_generica, :cronologia_uso,
                                   :definizione, :diocesi,:dt_acquisizione, :dt_creazione,:dt_assoluta,:dt_scavo,:epoca,:famiglia, :fascia_cronologia_rif, :genere, :gruppo,
                                   :localita, :localita_antica, :materia_tecnica,:nazione,:oldlocalita, :oldregione, :oldstato,
                                   :paese_antico,:provincia,:regione,:resp_scientifico_scavo,:secolo, :sistema, :sottoclasse, :specie,
                                   :specifiche_scavo,  :tipo,:stato,:txtspecie,:txtitalia, :sinonimi,  :varieta, :screditato, :formula,
                                   :tallone, :collezione, :erboserie, :legit, :stato_conservazione, :associazione,
                                   :denominazione, :denominazione_scavo, :note_generiche, :bibliografia, :studio, :stato_conservazione, #TEXT
                                   :custom_0,:custom_1, :custom_2, :custom_3, :custom_4, :custom_5, :custom_6, :custom_7, :custom_8, :custom_9, :custom_10, :custom_11, :custom_12, :custom_13, :custom_14, :custom_15
                                   # NON RICERCATI
                                   # :id_codscheda, :altra_categoria,:binomio3,:binomio4
                                   # :cassettiera, :categoria_pricipale, :circonferenza, :cod_univoco_scavo_iccd,  :collocazione_opera_finale,
                                   # :coor_asse_x, :coor_asse_y,  :creato_da,  :dest_prestito, :disponibilita, :dt_a,  :dt_da, :dt_esatta_acquisizione,
                                   # :dt_modifica, :dt_restauro,  :ente_finanziatore_rest, :ente_responsabile_rest,
                                   # :ente_responsabile_scavo,  :espositore,   :fenomeni_ottici,
                                   # :foglio_data, :fornitore, :funzione,:ingombro, :inprestito, :larghezza, :loc_estera,
                                   # :localizz_comune_catasto, :lunghezza, :luogo_acquisizione,
                                   # :metodo_scavo, :mod_conservazione, :mod_uso, :modificato_da, :motivo,  :num_inventario_scavo,
                                   # :opera_finale_originale, :pacco,  :particelle, :piano,
                                   # :posizione, :potenza, :profondita,  :quantita, :quota,   :restauri,
                                   # :ripiano, :sala, :specifiche_materiale, :spessore,
                                   # :stima,  :tipo_acquisizione, :unita_misura, :url_sito_scavo, :visibile, :zonato,  :lt, :primasegnalazione,
                                   ],






  :using => {:tsearch => {:prefix => true}}

  def image_link
    return "" if museum_images.blank?
    museum_images.first.link
  end
end
