//
//  AboutViewController.swift
//  genericappios
//
//  Created by DC on 13/09/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    @IBOutlet weak var versionNo: UILabel!
    @IBOutlet weak var buildDate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        versionNo.text = "1." + (Bundle.main.infoDictionary?["CFBundleVersion"] as! String)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.string(from: buildDates)
        buildDate.text = date
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    var buildDates:Date
    {
        if let infoPath = Bundle.main.path(forResource: "Info.plist", ofType: nil),
            let infoAttr = try? FileManager.default.attributesOfItem(atPath: infoPath),
            let infoDate = infoAttr[FileAttributeKey.creationDate] as? Date
        { return infoDate }
        return NSDate() as Date
    }
}
