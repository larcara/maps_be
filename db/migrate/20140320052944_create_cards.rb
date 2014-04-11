class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :museum_id,  null: false
      t.string :colore
      t.string :descrizione
      t.string :oggetto
      t.string :id_codscheda,  null: false
      t.string :abito
      t.string :ad_cristo
      t.float  :altezza
      t.string :altra_categoria
      t.string :altra_def_oggetto
      t.string :altro_cod
      t.string :biblio_foto
      t.string :bibliografia
      t.string :binomio1
      t.string :binomio2
      t.string :binomio3
      t.string :binomio4
      t.string :capacita
      t.string :cassettiera
      t.string :categoria_pricipale
      t.string :circonferenza
      t.string :classe
      t.string :cod_univoco_scavo_iccd
      t.string :id_univoco_reperto
      t.string :id_num_inventario
      t.string :collocazione_opera_finale
      t.string :colore
      t.string :coloreb
      t.string :coloreg
      t.string :colorer
      t.string :contesto_ritrovamento
      t.string :continente
      t.string :coor_asse_x
      t.string :coor_asse_y
      t.string :costruttore
      t.string :creato_da
      t.string :cronologia_generica
      t.string :cronologia_uso
      t.string :definizione
      t.string :denominazione
      t.string :denominazione_scavo
      t.string :desc_collocazione
      t.string :desc_intervento
      t.string :descrizione
      t.string :dest_prestito
      t.float :diametro
      t.float :dimensione_base
      t.float :dimensione_max
      t.float :dimensionex
      t.float :dimensioney
      t.float :dimensionez
      t.string :diocesi
      t.string :disponibilita
      t.string :dt_a
      t.string :dt_acquisizione
      t.string :dt_assoluta
      t.string :dt_creazione
      t.string :dt_da
      t.string :dt_esatta_acquisizione
      t.string :dt_modifica
      t.string :dt_restauro
      t.string :dt_scavo
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
      t.string :ingombro
      t.string :inprestito
      t.string :larghezza
      t.string :loc_estera
      t.string :localita
      t.string :localita_antica
      t.string :localizz_comune_catasto
      t.string :lunghezza
      t.string :luogo_acquisizione
      t.boolean :magnetico
      t.string :materia_tecnica
      t.string :metodo_scavo
      t.string :mod_conservazione
      t.string :mod_uso
      t.string :modificato_da
      t.string :motivo
      t.string :nazione
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
      t.string :paese_antico
      t.string :particelle
      t.float :peso
      t.string :piano
      t.string :posizione
      t.string :potenza
      t.string :profondita
      t.string :provincia
      t.boolean :pseudom
      t.string :quantita
      t.string :quota
      t.boolean :radio
      t.string :regione
      t.string :resp_scientifico_scavo
      t.string :restauri
      t.string :ripiano
      t.string :sala
      t.string :secolo
      t.string :sistema
      t.string :sottoclasse
      t.string :specie
      t.string :specifiche_materiale
      t.string :specifiche_scavo
      t.string :spessore
      t.string :stato_conservazione
      t.string :stima
      t.string :tipo
      t.string :tipo_acquisizione
      t.string :unita_misura
      t.string :url_sito_scavo
      t.string :valida
      t.string :visibile
      t.string :zonato
      t.string :stato
      t.boolean :studiato
      t.string :studio
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
