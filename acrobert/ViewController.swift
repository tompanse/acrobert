//
//  ViewController.swift
//  acrobert
//
//  Created by Thomas Panas on 2/28/17.
//  Copyright © 2017 com.panasarts.acrobert. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    let session = URLSession.shared

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var errorMessage: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.spinner.hidesWhenStopped = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    @IBAction func searchButtonPressed(_ sender: UIButton){
        let inputStr: String = inputField.text!;
        if (inputStr.characters.count <= 0) {
            return
        }
        self.spinner.startAnimating()
        var theURL: URL {
            return URL(string: "https://www.nactem.ac.uk/software/acromine/dictionary.py?sf=\(inputStr)")!
        }
        NSLog(theURL.absoluteString)
       
        do {
            let data = try Data(contentsOf: theURL)
            let json = JSON(data: data)

            var resultData:String = ""
            if let names = json[0]["lfs"].array {
                for name in names {
                    if let title = name["lf"].string {
                        resultData.append(title+"\n")
                    }
                }
            }
            textView.text = resultData
            self.spinner.stopAnimating()
        } catch {
            errorMessage.text = "Error retrieving data"
        }
        
    }
    

}

