//
//  PopUpListViewController.swift
//  hurtaud_tableview
//
//  Created by HURTAUD Cesar on 10/01/2019.
//  Copyright © 2019 HURTAUD Cesar. All rights reserved.
//

import UIKit

class PopUpListViewController: UIViewController {
    
    let ultraMarineBlue = UIColor(red: 0x00, green: 0x2A, blue: 0x32 )
    let dbh = DataBaseHelper.shared
    
    @IBOutlet weak var nomListeET: UITextField!
    
    @IBAction func closePopUpList(_ sender: Any) {
        
        
        
        self.removeAnimate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = ultraMarineBlue
        
        self.showAnimate()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 0.0
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: {(finished : Bool) in
            if (finished) {
                self.view.removeFromSuperview()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nom : String = nomListeET.text!
        
        let destinationVC = segue.destination as! TDLViewController
        destinationVC.name = nom
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
