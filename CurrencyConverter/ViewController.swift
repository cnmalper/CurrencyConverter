//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Alper Canımoğlu on 16.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func convertButtonClicked(_ sender: Any) {
        
        // 1) Request & Session,
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        let session = URLSession.shared
        
        // Closure
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else {
                
                // 2) Response & Data
                if data != nil {
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        // Bunu bir dict olarak cast etmeliyiz çünkü bize bir any object döndürüyor. Browser'daki veri ise "String : Any" (Any : String/Int/Boolean olabilir.)
                        
                        // ASYNC
                        // 3) JSON & Serialization
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String: Any] {
//                                print(rates)
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "1€ = \(cad) CAD"
                                }
                                
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "1€ = \(chf) CHF"
                                }
                                
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "1€ = \(gbp) GBP"
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "1€ = \(jpy) JPY"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "1€ = \(usd) USD"
                                }
                                
                                if let tl = rates["TRY"] as? Double {
                                    self.tryLabel.text = "1€ = \(tl) TRY"
                                }
                                
                            }
                        }
                        
                    } catch {
                        print("Error!")
                    }
                    
                }
                
            }
        }
        
        task.resume()
        
    }
    
}

