//
//  TDL.swift
//  maPetiteListe
//
//  Created by DE RIVALS-MAZERES Malo on 08/01/2019.
//  Copyright © 2019 CesaLo. All rights reserved.
//

import Foundation

class TDL {
    private var id_list: Int
    private var name: String
    private var date: String
    
    init(id: Int){
        self.id_list = id
        self.name = ""
        self.date = ""
    }
    
    init(id: Int, name: String, date: String){
        self.id_list = id
        self.name = name
        self.date = date
    }
    
    /*----------------------------- GETTERS & SETTERS -------------------------------------------------------------*/
    func getId_list() -> Int{
        return self.id_list
    }
    
    func setId_list(id: Int){
        self.id_list = id
    }
    
    func getName() -> String {
        return self.name
    }
    
    func setName(name:String){
        self.name = name
    }
    
    func getDate() -> String{
        return self.date
    }
    
    func setDate(date: String){
        self.date = date
    }
    
    func affiche() ->String{
        return("id_list: \(self.id_list) \n name: \(self.name)\n date: \(self.date)")
    }
}
