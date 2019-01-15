//
//  ItemViewController.swift
//  hurtaud_tableview
//
//  Created by DE RIVALS-MAZERES Malo on 14/01/2019.
//  Copyright © 2019 HURTAUD Cesar. All rights reserved.
//

import UIKit

class TDLViewController: UITableViewController {
    
    private var roundButton = UIButton()
    var newTDL : TDL?
    
    var name: String?
    
    let dbh = DataBaseHelper.shared
    
    let ultraMarineBlue = UIColor(red: 0x00, green: 0x2a, blue: 0x32)
    public var allTDLs : Array<TDL> = Array()
    
    let cellSpacingHeight: CGFloat = 5
    
    let identifiantTDLCellule = "celluleTDL"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allTDLs = dbh.getTDLs()
        self.navigationItem.title = "MaPetiteListe"
        
        tableView.backgroundColor = ultraMarineBlue
        
        createFloatingButton()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func presentPopUpList() {
        /*
         let popUpListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpList") as! PopUpListViewController
         self.addChildViewController(popUpListVC)
         popUpListVC.view.frame = self.view.frame
         self.view.addSubview(popUpListVC.view)
         popUpListVC.didMove(toParentViewController: self)
         */
        self.name = "Liste des codes nucléaires"
        if self.name != nil {
            print("insérer liste")
            // créer TDL
            let id_list = self.dbh.highestIdTDL() + 1
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/YYYY"
            
            
            let tdl: TDL = TDL(id: id_list, name: self.name!, date: formatter.string(from: date))
            dbh.insertTDL(tdl: tdl)
            self.allTDLs.append(tdl)
            tableView.reloadData()
        }
    }
    
    func createFloatingButton() {
        roundButton = UIButton(type: .custom)
        roundButton.translatesAutoresizingMaskIntoConstraints = false
        roundButton.backgroundColor = .orange
        // Make sure you replace the name of the image:
        //roundButton.setImage(UIImage(named:"NAME OF YOUR IMAGE"), for: .normal)
        
        //Il faut créer un lien vers le popup
        roundButton.addTarget(self, action: #selector(presentPopUpList), for: UIControlEvents.touchUpInside)
        
        // We're manipulating the UI, must be on the main thread:
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addSubview(self.roundButton)
                NSLayoutConstraint.activate([
                    keyWindow.trailingAnchor.constraint(equalTo: self.roundButton.trailingAnchor, constant: 15),
                    keyWindow.bottomAnchor.constraint(equalTo: self.roundButton.bottomAnchor, constant: 15),
                    self.roundButton.widthAnchor.constraint(equalToConstant: 75),
                    self.roundButton.heightAnchor.constraint(equalToConstant: 75)])
            }
            // Make the button round:
            self.roundButton.layer.cornerRadius = 37.5
            // Add a black shadow:
            self.roundButton.layer.shadowColor = UIColor.black.cgColor
            self.roundButton.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
            self.roundButton.layer.masksToBounds = false
            self.roundButton.layer.shadowRadius = 2.0
            self.roundButton.layer.shadowOpacity = 0.5
            // Add a pulsing animation to draw attention to button:
            let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.duration = 0.4
            scaleAnimation.repeatCount = .greatestFiniteMagnitude
            scaleAnimation.autoreverses = true
            scaleAnimation.fromValue = 1.0;
            scaleAnimation.toValue = 1.05;
            self.roundButton.layer.add(scaleAnimation, forKey: "scale")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return allTDLs.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiantTDLCellule, for: indexPath)
        let tdl = allTDLs[indexPath.section ]
        
        let label = tdl.getName()
        cell.textLabel?.text = label
        
        let reste : String = "\(tdl.getDate())"
        cell.detailTextLabel?.text = reste
        
        cell.backgroundColor = UIColor.orange
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let tdl = allTDLs[indexPath.section]
            allTDLs.remove(at: indexPath.section)
            // delete the row from the tableView / pour l'instant, delete le premier row
            tableView.deleteSections([indexPath.section], with: .fade)
            dbh.delTDL(id: tdl.getId_list())
        } else if editingStyle == .insert {
            // Pas utilisé ici mais si on ajoute des nouveaux rows, c'est ici qu'on le ferait
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt IndexPath: IndexPath){
        self.performSegue(withIdentifier: "TDLtoItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TDLtoItem",
            let destination = segue.destination as? ItemViewController{
            let row = tableView.indexPathForSelectedRow?.section
            let tdl = self.allTDLs[row!]
            destination.list = tdl.getId_list()
        }
        
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    override func viewWillDisappear(_ animated: Bool) {
        if roundButton.superview != nil {
            roundButton.removeFromSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createFloatingButton()
    }
}
