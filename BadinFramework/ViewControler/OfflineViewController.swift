//
//  OfflineViewController.swift
//  genericappios
//
//  Created by DC on 09/10/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit
import QRCode
import Firebase
import Crashlytics

class OfflineViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        let card = KeychainWrapper.standard.string(forKey: "cardNumber")
        
        
        if let _:String = card {

            loadQrCard(card: card!)
            carNumber.text = card
            setExit()
            
        } else {
            
          //  CLSLog("Variable card value is: " + card!)
            
        }

    }

    
    func loadQrCard(card:String){
        let qrCode=QRCode(card)
        barCode.image=qrCode?.image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var carNumber: UILabel!
    @IBOutlet weak var barCode: UIImageView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
