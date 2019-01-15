//
//  Item.swift
//  maPetiteListe
//
//  Created by DE RIVALS-MAZERES Malo on 08/01/2019.
//  Copyright © 2019 CesaLo. All rights reserved.
//

import Foundation

class Item {
    private var id_item: Int
    private var list: Int
    private var description: String
    private var quantity: Int
    private var unit: String
    private var checked: Bool
    
    init(id: Int, list: Int, description: String, quantity: Int, unit: String, checked: Bool){
        self.id_item = id
        self.list = list
        self.description = description
        self.quantity = quantity
        self.unit = unit
        self.checked = checked
    }
    
    init(id: Int, list: Int, description: String, quantity: Int, unit: String, checked: Int){
        self.id_item = id
        self.list = list
        self.description = description
        self.quantity = quantity
        self.unit = unit
        self.checked = (checked == 1) ? true : false
    }
    
    init(id: Int, list: Int){
        self.id_item = id
        self.list = list
        self.description = ""
        self.quantity = 1
        self.unit = ""
        self.checked = false
    }
    
    /*----------------------------- GETTERS & SETTERS -------------------------------------------------------------*/
    func getId_item() -> Int{
        return self.id_item
    }
    
    func setId_item(id: Int){
        self.id_item = id
    }
    
    func getList() -> Int{
        return self.list
    }
    
    func setList(list: Int){
        self.list = list
    }
    
    func getDescription() -> String {
        return self.description
    }
    
    func setDescription(desc:String){
        self.description = desc
    }
    
    func getQuantity() -> Int{
        return self.quantity
    }
    
    func setQuantity(quantity: Int){
        self.quantity = quantity
    }
    
    func getUnit() -> String{
        return self.unit
    }
    
    func setUnit(unit: String){
        self.unit = unit
    }
    
    //For the database
    func getChecked() -> Int{
        var check: Int = 0
        if (self.checked){
            check = 1
        }
        return check
    }
    
    func isChecked() -> Bool{
        return self.checked
    }
    
    func setChecked(check: Bool){
        self.checked = check
    }
    
    func affiche() ->String{
        return("id_item: \(self.id_item) \n list: \(self.list) \n description: \(self.description) \n quantity: \(self.quantity) \n unit: \(self.unit) \n checked: \(self.checked)")
    }
}
