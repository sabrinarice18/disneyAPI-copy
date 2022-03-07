//
//  affirmVC.swift
//  disneyAPI
//
//  Created by Sabrina Rice  on 3/1/22.
//

import UIKit
import SDWebImage

class affirmVC: UIViewController {

   // affirmation label
    @IBOutlet weak var myLabe: UILabel!
    
    // fox and affirmation button
    @IBOutlet weak var buttonONe: UIButton!
    
  // fox image
    @IBOutlet weak var imageVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        
        buttonONe.tintColor = UIColor.white
        buttonONe.titleLabel!.font = UIFont(name: "Avenir", size: 23)
        
    }
    
    
    
    
    
    

    
    
    // affirmation json
    @IBAction func button(_ sender: UIButton)
    {
        let urlString = "https://www.affirmations.dev"

        if let url = URL(string: urlString)
        {
           let task = URLSession.shared.dataTask(with: url) {
              (data, response, error) in
                 if let err = error {
                    print(err)
                    return
                 }

                 do {
                     let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any]
                            print(json!)


    let affirm = json!["affirmation"] as? String ?? " "

                     DispatchQueue.main.async {
                         self.myLabe.text = "\(affirm)"

                     }


                    print(json!)
                 } catch let jsonError {
                    print(jsonError)
                 }

             }
             task.resume()
          }

        
    
        // fox image json
        let urlStringTwo = "https://randomfox.ca/floof/"
          
        if let url = URL(string: urlStringTwo)
        {
           let task = URLSession.shared.dataTask(with: url) {
              (data, response, error) in
                 if let err = error {
                    print(err)
                    return
                 }
         
                 do {
                     let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as?
                     [String: Any];                           print(json!)
         
                   
let image = json!["image"] as? String ?? " "
                     
                     
             
                     DispatchQueue.main.async {
                         self.imageVIew.sd_setImage(with: URL(string: image), completed: nil)
                     }
                     
                     
                     
                     
                     
                     
      
                     
                     
                     
                     
                     
                    print(json!)
                 } catch let jsonError {
                    print(jsonError)
                 }
                        
             }
             task.resume()
          }

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    

}
