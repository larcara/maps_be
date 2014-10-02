class AddIndexToCards < ActiveRecord::Migration
  def change
    add_index :cards, [
            :regione, :colore, :oggetto, :abito, :ad_cristo, :altra_def_oggetto,
            :binomio1, :binomio2, :capacita, :classe, :contesto_ritrovamento,:costruttore,
            :cronologia_generica, :cronologia_uso, :definizione, :diocesi,:epoca,:famiglia,
            :fascia_cronologia_rif, :genere, :gruppo, :localita, :localita_antica, :materia_tecnica], name: :for_fulltext_1

    add_index :cards, [:nazione, :paese_antico,:provincia,:regione,:resp_scientifico_scavo,:secolo, :sistema, :sottoclasse, :specie,
            :specifiche_scavo,  :tipo,:stato,:txtspecie,:txtitalia, :sinonimi,  :varieta, :screditato, :formula,
            :tallone, :collezione, :erboserie, :legit, :stato_conservazione, :associazione,
            :denominazione, :denominazione_scavo, :note_generiche, :bibliografia, :studio, :stato_conservazione], name: :for_fulltext_2

    # ,
    #
    # ,:id_univoco_reperto, :id_num_inventario,
    # :coloreb, :coloreg, :colorer,
    #
    #
    #
    #

     #TEXT
    # :custom_0,:custom_1, :custom_2, :custom_3, :custom_4, :custom_5, :custom_6, :custom_7, :custom_8, :custom_9, :custom_10, :custom_11, :custom_12, :custom_13, :custom_14, :custom_15
  end
end
