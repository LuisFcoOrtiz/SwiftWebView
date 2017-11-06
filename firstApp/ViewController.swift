//
//  ViewController.swift
//  firstApp
//
//  Created by aleluis burguerMan on 16/10/17.
//  Copyright © 2017 aleluis burguerMan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseCore

class ViewController: UIViewController, UIWebViewDelegate{

    @IBOutlet weak var etiqueta: UILabel!
    @IBOutlet weak var urlText: UITextField!
    @IBOutlet weak var etiquetaWeb: UILabel!
    @IBOutlet weak var botonBuscar: UIButton!
    
    
    @IBOutlet weak var webViewLabel: UIWebView!
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        urlText.text="http://"
        ref = Database.database().reference()
        // Do any additional setup after loading the view, typically from a nib.
        botonBuscar.backgroundColor = UIColor.white
    }
    
    @IBAction func buttonEvent(_ sender: Any) {
        //var urlToGo = urlText.text

        if (urlText.text != ""){
            webViewLabel.loadRequest(URLRequest(url: URL(string: urlText.text!)!))
            
            etiquetaWeb.text = urlText.text
            addToDatabase(url: urlText.text!)
        } else{
            etiquetaWeb.text="La busqueda debe contener elementos"
        }
    }//event for button
    
    @IBAction func buttonGoBack(_ sender: Any) {
        webViewLabel.goBack()
    }//event button go back
    
    @IBAction func butonGoAhead(_ sender: Any) {
        webViewLabel.goForward()
    }
    
    func addToDatabase(url: String){
        ref.childByAutoId().setValue(url)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidFinishLoad(_ webView: UIWebView) { if let text = webViewLabel.request?.url?.absoluteString{ etiquetaWeb.text = text } }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        let txt = webViewLabel.request?.description
        etiquetaWeb.text = txt
        urlText.text = txt
        addToDatabase(url: txt!)
    }
    
}//End class
