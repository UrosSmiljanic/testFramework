//
//  HelpAboutViewController.swift
//  genericappios
//
//  Created by DC on 10/09/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

class HelpAboutViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.tnc.addGestureRecognizer(gesture)
       
        let gesture1 = UITapGestureRecognizer(target: self, action:  #selector (self.someAction1 (_:)))
        self.pp.addGestureRecognizer(gesture1)

        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector (self.someAction2 (_:)))
        self.faq.addGestureRecognizer(gesture2)

        let gesture3 = UITapGestureRecognizer(target: self, action:  #selector (self.someAction3 (_:)))
        self.about.addGestureRecognizer(gesture3)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var tnc: UIView!
    @IBOutlet weak var pp: UIView!
    @IBOutlet weak var faq: UIView!
    @IBOutlet weak var about: UIView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "webView") as! WebViewController
        nextViewController.urlS="https://m.columbuscoffee.co.nz/rewards/terms-and-conditions"
        self.navigationController?.pushViewController(nextViewController, animated:false )    }
    
    @objc func someAction1(_ sender:UITapGestureRecognizer){
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "webView") as! WebViewController
        nextViewController.urlS="https://m.columbuscoffee.co.nz/rewards/privacy-policy"
        self.navigationController?.pushViewController(nextViewController, animated:false )    }

    
    @objc func someAction2(_ sender:UITapGestureRecognizer){
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "webView") as! WebViewController
        nextViewController.urlS="https://m.columbuscoffee.co.nz/rewards/frequently-asked-questions"
        self.navigationController?.pushViewController(nextViewController, animated:false )    }

    
    @objc func someAction3(_ sender:UITapGestureRecognizer){
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "aboutApp") as! AboutViewController
        
        self.navigationController?.pushViewController(nextViewController, animated:false )    }


}
