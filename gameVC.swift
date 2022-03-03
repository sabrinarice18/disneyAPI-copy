//
//  gameVC.swift
//  disneyAPI
//
//  Created by Sabrina Rice  on 3/1/22.
//

import UIKit
import SDWebImage
import SPAlert


class gameVC: UIViewController, UITextFieldDelegate {

    
    // guess textfield
    @IBOutlet weak var myTextField: UITextField!
    
    // guess disney image
    @IBOutlet weak var myImage: UIImageView!
    
    // hidden label
    @IBOutlet weak var myLabel: UILabel!
    
    // image button
    @IBOutlet weak var buttonOne: UIButton!
    
    // score label
    @IBOutlet weak var scoreLable: UILabel!
    
    var films = [String]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    
   
        self.myTextField.delegate = self

    }
        // keyboard dismiss on return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return false
       }
    
    
    
    
    
    
        // image json
    @IBAction func imageButton(_ sender: UIButton)
    {
        let rand = Int.random(in: 1...7438)
    
        let urlString = "https://api.disneyapi.dev/characters/\(rand)"
          
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
    
let imageLink = json!["imageUrl"] as? String ?? " "
let tvShow = json!["tvShows"] as? [String] ?? ["None"]
self.films = json!["films"] as? [String] ?? ["None"]

            
               var filmsDisplay = ""
                     if self.films.count > 0 {
                         for item in self.films {
                             filmsDisplay += item + ", "
                         }
                     }
                     else {
                         filmsDisplay = "None"
                     }
                     
                     
                    var tvShowsDisplay = ""
                     if tvShow.count > 0 {
                         for item in tvShow
                         {
                             tvShowsDisplay += item + " "
                         }
                     }
                     else {
                         tvShowsDisplay = "None"
                     }
                     
                     
                     DispatchQueue.main.async {
                         self.myLabel.text = "\(tvShowsDisplay), \(filmsDisplay)"
                         self.myImage.sd_setImage(with: URL(string: imageLink), completed: nil)
                     }
                     
                     
                     
                    
                    print(json!)
                 } catch let jsonError {
                    print(jsonError)
                 }
                        
             }
             task.resume()
          }
    }
    
  
    
    @IBAction func guessButton(_ sender: UIButton)
    {
        
        
        
        // score
        
        let string = myLabel.text?.lowercased()

        if string?.range(of: (myTextField.text?.lowercased())! ) != nil {
            count = count+1
            scoreLable.text = "\(count)"
        } else {
            count = count-1
            scoreLable.text = "\(count)"
        }
        
    
        // input from textfield
        if string?.range(of: (myTextField.text?.lowercased())! ) != nil {
            print("yes")
            alertYES()
        } else {
            print("no")
            alertNO()
        }
        
        if count < 0 {
            gameOver()
            print("gameOver")
        }
        
        
        
   
        // alert functions 
        func alertYES() {
            SPAlert.present(title: "Great Job!", message: "You are Correct!", preset: .custom(UIImage.init(named: "mickeyHappy")!))
        }
    
        func alertNO(){
            SPAlert.present(title: "Try Again", message: "You are incorrect", preset: .custom(UIImage.init(named: "sad")!))
        }
    
    
        func gameOver(){
            SPAlert.present(title: "Game Over", message: "Try Again Next Time", preset: .custom(UIImage.init(named: "sad")!))
        }

        
        
        
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
