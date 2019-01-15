//
//  DataBaseHelper.swift
//  maPetiteListe
//
//  Created by DE RIVALS-MAZERES Malo on 08/01/2019.
//  Copyright © 2019 CesaLo. All rights reserved.
//

import UIKit
import SQLite

class DataBaseHelper{
    var tableTDLExist = false // false la table tdls n'est encore pas créée
    var TDLinitiated = false
    var tableItemsExist = false // false la table items n'est encore pas créée
    var ItemsInitiated = false
    var initiated = false
    
    let tdl_table = Table("tdls")
    let tdl_list_id = Expression<Int>("id_list")
    let tdl_name = Expression<String>("name")
    let tdl_date = Expression<String>("date")
    
    let item_table = Table("items")
    let item_id = Expression<Int>("id_item")
    let list = Expression<Int>("list")
    let item_description = Expression<String>("description")
    let item_quantity = Expression<Int>("quantity")
    let item_unit = Expression<String>("unit")
    let item_checked = Expression<Int>("checked")
    
    var database: Connection!
    static let shared = DataBaseHelper()
    
    init(){
        if(self.initiated){}
        else{
            do{
                let documentDirectory = try
                    FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let fileUrl = documentDirectory.appendingPathComponent("tdl").appendingPathExtension("sqlite3")
                let base = try Connection(fileUrl.path)
                self.database = base
            } catch {
                print(error)
            }
            initData()
            self.initiated = true
        }
    }
    
    func getConnection() -> Connection{
        return self.database
    }
    
    func initData(){
        print("initData() start")
        // Objectif vérifier si les tables existent dans la bdd pour ne pas réinitialiser les examples pour rien.
        createTableTDL()
        createTableItems()
        if(!TDLinitiated || !ItemsInitiated){
            // Fill the Database
            let initData = InitData()
            let tdls = initData.getTDLs()
            let items = initData.getItems()
        
            print("insert data")
            for tdl in tdls{
                insertTDL(tdl: tdl)
                TDLinitiated = true
            }
            
            for item in items{
                insertItem(item: item)
                ItemsInitiated = true
            }
        }
        print("init end")
    }
    
    func createTableTDL() {
        print ("--> createTableTDL debut")
        if !self.tableTDLExist {
            self.tableTDLExist = true
            
            // Instruction pour faire un create de la table TDL
            let createTable = self.tdl_table.create { table in
                table.column(self.tdl_list_id, primaryKey: true)
                table.column(self.tdl_name)
                table.column(self.tdl_date)
            }
            
            do {
                // Exécution du drop et du create
                try self.database!.run(createTable)
                print ("Table TDL est créée")
            }
            catch {
                TDLinitiated = true
                print (error)
            }
        }
        print ("--> createTableTDL fin")
    }
    
    func createTableItems() {
        print ("--> createTableItems debut")
        if !self.tableItemsExist {
            self.tableItemsExist = true
            
            // Instruction pour faire un create de la table Items
            let createTable = self.item_table.create { table in
                table.column(self.item_id, primaryKey: true)
                table.column(self.list)
                table.column(self.item_description)
                table.column(self.item_quantity)
                table.column(self.item_unit)
                table.column(self.item_checked)
            }
            
            do {
                // Exécution du drop et du create
                try self.database!.run(createTable)
                print ("Table Items est créée")
            }
            catch {
                ItemsInitiated = true
                print (error)
            }
        }
        print ("--> createTableItems fin")
    }
    
    func insertTDL(tdl: TDL){
        print("insert tdl")
        let insert = self.tdl_table.insert(self.tdl_list_id <- tdl.getId_list(), self.tdl_name <- tdl.getName(), self.tdl_date <- tdl.getDate())
        do{try self.database.run(insert)
            print("Insert ok")
        }catch{
            print(error)
            print("Insert pas ok")
        }
    }
    
     func getTDL(id: Int) -> TDL {
        var tdl: TDL = TDL(id: 0, name: "Liste not loaded", date: "01/01/1900")
        do{
            let query = try self.database.prepare(self.tdl_table.where(self.tdl_list_id == id))
            for row in query {
                tdl = TDL(id: row[self.tdl_list_id], name: row[self.tdl_name], date: row[self.tdl_date])
            }
        }catch{
            print("TDL not found")
            print(error)
            }
        
        return tdl
     }
    
    
    func getTDLs() -> Array<TDL>{
        print("------> getTDLs() debut")
        var tdls: Array<TDL> = Array()
        do {
            //let fetchTDL = try self.database.prepare("SELECT * FROM " + tdl_table)
            let fetchTDL = try self.database.prepare(self.tdl_table)
            
            for tdl in fetchTDL {
                print("TDL: \(tdl[self.tdl_list_id]), \(tdl[self.tdl_name]), \(tdl[self.tdl_date])")
                tdls.append(TDL(id: tdl[self.tdl_list_id], name: tdl[self.tdl_name], date: tdl[self.tdl_date]))
            }
        } catch {
            print(error)
        }
        return tdls
    }
    
    func delTDL(id: Int){
        print("start deleting tdl \(id)")
        do{
            let query = self.tdl_table.filter(self.tdl_list_id == id)
            try self.database.run(query.delete())
            print("TDL deleted")
        } catch{
            print("tdl not deleted")
            print(error)
        }
    }
    
    func highestIdTDL() -> Int{
        var id_tdl: Int = 0
        do{
            let query = self.tdl_table.select(self.tdl_list_id.max)
            let max = try self.database.prepare(query)
            //let query = try self.database.prepare(self.tdl_table.where(self.tdl_list_id.max))
            print("cherchons le max")
            for row in max {
                //print("\(String(describing: row[self.tdl_list_id.max]))")
                id_tdl = row[self.tdl_list_id.max]!
                //let tdl = TDL(id: row[self.tdl_list_id], name: row[self.tdl_name], date: row[self.tdl_date])
                //id_tdl = tdl.getId_list()
            }
        } catch{
            print("error")
        }
        return id_tdl
    }
    
    func countTDLs() -> Int{
        let total = self.getTDLs().count
        return total
    }
    
    func insertItem(item: Item){
        print("insert Item \(item.getId_item()), \(item.getDescription())")
        let insert = self.item_table.insert(self.item_id <- item.getId_item(), self.list <- item.getList(), self.item_description <- item.getDescription(), self.item_quantity <- item.getQuantity(), self.item_unit <- item.getUnit(), self.item_checked <- item.getChecked())
        do{try self.database.run(insert)
            print("Insert ok")
        }catch{
            print(error)
            print("Insert pas ok")
        }
    }
    
    func delItem(id: Int){
        print("start deleting item \(id)")
        do{
            let query = self.item_table.filter(self.item_id == id)
            try self.database.run(query.delete())
            print("item deleted")
        } catch{
            print("item not deleted")
            print(error)
        }
    }
    
    func getListItems(id_list:Int) -> Array<Item>{
        print("------> getItems() debut")
        var items: Array<Item> = Array()
        do {
            let fetchItems = try self.database.prepare(self.item_table.where(self.list == id_list))
            for item in fetchItems {
                let temp = Item(id: item[self.item_id], list: item[self.list], description: item[self.item_description], quantity: item[self.item_quantity], unit: item[self.item_unit], checked: item[self.item_checked])
                print("\(temp.affiche())")
                items.append(temp)
            }
        } catch {
            print("fail to cath the items")
            print(error)
        }
        return items
    }
    
    func highestIdItem() -> Int{
        var id_item: Int = 0
        do{
            let query = self.item_table.select(self.item_id.max)
            let max = try self.database.prepare(query)
            for row in max {
                //print("\(String(describing: row[self.tdl_list_id.max]))")
                id_item = row[self.item_id.max]!
                //let tdl = TDL(id: row[self.tdl_list_id], name: row[self.tdl_name], date: row[self.tdl_date])
                //id_tdl = tdl.getId_list()
            }
        } catch{
            print("error")
        }
        return id_item
    }
}
