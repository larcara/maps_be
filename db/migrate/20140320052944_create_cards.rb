class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :museum_id,  null: false
      t.string :colore, limit: 50
      t.text :descrizione
      t.text :oggetto
      t.string :id_codscheda,  null: false, limit: 50
      t.string :abito
      t.string :ad_cristo, limit: 50
      t.float  :altezza, limit: 50
      t.string :altra_categoria
      t.string :altra_def_oggetto
      t.string :altro_cod, limit: 50
      t.string :biblio_foto, limit: 50
      t.string :bibliografia
      t.string :binomio1
      t.string :binomio2
      t.string :binomio3
      t.string :binomio4
      t.string :capacita, limit: 50
      t.string :cassettiera, limit: 50
      t.string :categoria_pricipale
      t.string :circonferenza, limit: 50
      t.string :classe
      t.string :cod_univoco_scavo_iccd, limit: 50
      t.string :id_univoco_reperto, limit: 50
      t.string :id_num_inventario, limit: 50
      t.string :collocazione_opera_finale
      t.string :coloreb, limit: 5
      t.string :coloreg, limit: 5
      t.string :colorer, limit: 5
      t.string :contesto_ritrovamento
      t.string :continente
      t.string :coor_asse_x, limit: 50
      t.string :coor_asse_y, limit: 50
      t.string :costruttore
      t.string :creato_da
      t.string :cronologia_generica
      t.string :cronologia_uso
      t.string :definizione
      t.text :denominazione
      t.text :denominazione_scavo
      t.text :desc_collocazione
      t.text :desc_intervento
      t.text :descrizione
      t.string :dest_prestito
      t.float :diametro
      t.float :dimensione_base
      t.float :dimensione_max
      t.float :dimensionex
      t.float :dimensioney
      t.float :dimensionez
      t.string :diocesi, limit: 50
      t.string :disponibilita
      t.string :dt_a, limit: 20
      t.string :dt_acquisizione, limit: 20
      t.string :dt_assoluta, limit: 20
      t.string :dt_creazione, limit: 20
      t.string :dt_da, limit: 20
      t.string :dt_esatta_acquisizione, limit: 20
      t.string :dt_modifica, limit: 20
      t.string :dt_restauro, limit: 20
      t.string :dt_scavo, limit: 20
      t.string :ente_finanziatore_rest
      t.string :ente_responsabile_rest
      t.string :ente_responsabile_scavo
      t.string :epoca
      t.string :espositore
      t.string :famiglia
      t.string :fascia_cronologia_rif
      t.string :fenomeni_ottici
      t.boolean :fluor
      t.string :foglio_data
      t.string :fornitore
      t.boolean :fosfo
      t.string :funzione
      t.boolean :geminato
      t.string :genere
      t.string :gruppo
      t.string :ingombro, limit: 50
      t.string :inprestito
      t.string :larghezza
      t.string :loc_estera
      t.string :localita
      t.string :localita_antica
      t.string :localizz_comune_catasto
      t.string :lunghezza, limit: 50
      t.string :luogo_acquisizione
      t.boolean :magnetico
      t.string :materia_tecnica
      t.string :metodo_scavo, limit: 50
      t.string :mod_conservazione, limit: 50
      t.string :mod_uso
      t.string :modificato_da, limit: 50
      t.string :motivo
      t.string :nazione, limit: 50
      t.text   :nome_acquisizione
      t.text   :note_acquisizione
      t.text   :note_generiche
      t.integer :num_campione
      t.integer :num_fogli
      t.integer :num_frammenti
      t.string :num_inventario_scavo
      t.string :oldlocalita
      t.string :oldregione
      t.string :oldstato
      t.string :opera_finale_originale
      t.string :pacco
      t.string :paese_antico, limit: 50
      t.string :particelle, limit: 50
      t.float :peso
      t.string :piano
      t.string :posizione, limit: 50
      t.string :potenza
      t.string :profondita
      t.string :provincia, limit: 50
      t.boolean :pseudom
      t.string :quantita, limit: 50
      t.string :quota
      t.boolean :radio
      t.string :regione, limit: 50
      t.string :resp_scientifico_scavo
      t.string :restauri
      t.string :ripiano
      t.string :sala, limit: 50
      t.string :secolo, limit: 50
      t.string :sistema
      t.string :sottoclasse
      t.string :specie
      t.string :specifiche_materiale
      t.string :specifiche_scavo
      t.string :spessore, limit: 50
      t.string :stato_conservazione, limit: 50
      t.string :stima, limit: 50
      t.string :tipo, limit: 50
      t.string :tipo_acquisizione
      t.string :unita_misura, limit: 50
      t.string :url_sito_scavo
      t.string :valida, limit: 50
      t.string :visibile, limit: 50
      t.string :zonato, limit: 50
      t.string :stato, limit: 50
      t.boolean :studiato
      t.string :studio, limit: 50
      t.string :txtspecie
      t.string :txtitalia
      t.string :sinonimi
      t.string :varieta
      t.string :screditato
      t.string :formula
      t.string :lt
      t.string :tallone
      t.string :oggetto
      t.boolean :calco
      t.string :primasegnalazione
      t.string :collezione
      t.string :erboserie


      t.timestamps
    end
    add_index :cards, [:id_codscheda, :museum_id], unique: true, name: :cards_index_1
  end
end
