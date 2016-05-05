# thank you http://www.sketchup.com/intl/en/developer/index

require 'sketchup.rb'

def pass; end

UI.menu("Plugins").add_item("Creation Bac") {
    #UI.messagebox("Nous allons créer un bac!")

    SKETCHUP_CONSOLE.show
  
    prompts = [
               "Matière",
               "Ep. de la tôle ( mm )",
               "Longueur ( mm )",
               "Largeur  ( mm )" ,
               "Hauteur  ( mm )"
               ]
    defaults = [ "Inox brossé",1.5, 2000, 500, 40 ]
    list = ["Inox brossé|Inox brut|Alluminium|Acier","","","",""]
    input = UI.inputbox(prompts, defaults,list, "Dimmensions du bac.")    
    
    if input != false
        matiere   = input[0]
        # les mesures sont en pouces ( inch )
        # 1 pouce =  25.4 mm
        epaisseur = input[1].to_f / 25.4
        longueur  = input[2].to_f / 25.4
        largeur   = input[3].to_f / 25.4
        hauteur   = input[4].to_f / 25.4
        #puts "construction du bac en " + matiere
        #puts epaisseur.to_s + " x " + longueur.to_s + " x " + largeur.to_s + " x " + hauteur.to_s
        model      = Sketchup.active_model
        entities   = model.entities
        base       = []
        base[0]    = [0,0,0              ]
        base[1]    = [0,longueur,0       ]
        base[2]    = [largeur,longueur,0 ]
        base[3]    = [largeur, 0,0       ]
        bac        = entities.add_face base
        bac.reverse!
        #puts base.inspect
        bac.pushpull hauteur
        extrude    = []
        extrude[0] = [ epaisseur, epaisseur, hauteur                      ]
        extrude[1] = [ epaisseur, longueur - epaisseur, hauteur           ]
        extrude[2] = [ largeur - epaisseur, longueur - epaisseur, hauteur ]
        extrude[3] = [ largeur - epaisseur, epaisseur, hauteur            ]
        model      = Sketchup.active_model
        entities   = model.entities
        extrusion  = entities.add_face extrude
        extrusion.reverse!
        extrusion.pushpull hauteur - epaisseur
    end

    
}