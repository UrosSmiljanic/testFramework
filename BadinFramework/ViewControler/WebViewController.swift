//
//  WebViewController.swift
//  genericappios
//
//  Created by DC on 06/05/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController, UIWebViewDelegate {
    
    
    var urlS:String! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        
        wevView.delegate = self
        if let url = URL(string: urlS) {
            let request = URLRequest(url: url)
            wevView.loadRequest(request)
           startProgress(dataToLoad: 1)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
  
    func webViewDidFinishLoad(_ webView: UIWebView){
        let js = "javascript:(function() { var head = document.getElementsByTagName('header')[0]; head.parentNode.removeChild(head); var bottom = document.getElementsByClassName('region region-bottom')[0];  bottom.parentNode.removeChild(bottom); var bottom = document.getElementsByClassName('rteright')[0];  bottom.parentNode.removeChild(bottom); var bottom = document.getElementsByClassName('rteright')[0];  bottom.parentNode.removeChild(bottom); })()"
        _ = wevView.stringByEvaluatingJavaScript(from: js)
        stopProgress()
    }
    @IBOutlet weak var wevView: UIWebView!

}
