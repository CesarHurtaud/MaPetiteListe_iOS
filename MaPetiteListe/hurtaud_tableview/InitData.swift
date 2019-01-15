//
//  InitData.swift
//  maPetiteListe
//
//  Created by DE RIVALS-MAZERES Malo on 08/01/2019.
//  Copyright © 2019 CesaLo. All rights reserved.
//

import Foundation

class InitData {
    private var tdls: Array<TDL> = Array()
    private var items: Array<Item> = Array()
    
    init(){
        print("creating the examples")
        addTDL(tdl: TDL(id: 1, name: "Première liste", date: "01/01/2019"))
        addItem(item: Item(id: 1, list: 1, description: "oeufs", quantity: 6, unit: "", checked: false))
        addItem(item: Item(id: 2, list: 1, description: "farine", quantity: 500, unit: "g", checked: false))
        addItem(item: Item(id: 3, list: 1, description: "sucre", quantity: 1, unit: "kg", checked: false))
        addItem(item: Item(id: 4, list: 1, description: "lait", quantity: 6, unit: "l", checked: false))
        addItem(item: Item(id: 5, list: 1, description: "beurre", quantity: 250, unit: "g", checked: true))
        
        addTDL(tdl: TDL(id: 2, name: "Deuxième liste", date: "02/01/2019"))
        addItem(item: Item(id: 6, list: 2, description: "SAO", quantity: 1, unit: "", checked: false))
        addItem(item: Item(id: 7, list: 2, description: "Hunter x hunter", quantity: 1, unit: "", checked: false))
        addItem(item: Item(id: 8, list: 2, description: "FMA", quantity: 1, unit: "", checked: true))
        addItem(item: Item(id: 9, list: 2, description: "Code Geass", quantity: 1, unit: "", checked: true))
    }
    
    func addTDL(tdl: TDL){
        self.tdls.append(tdl)
    }
    
    func addItem(item: Item){
        self.items.append(item)
    }
    
    func getTDLs() -> Array<TDL>{
        return tdls
    }
    
    func getItems() -> Array<Item>{
        return items
    }
    
}
