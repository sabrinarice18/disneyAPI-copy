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
let films = json!["films"] as? [String] ?? ["None"]

            
               var filmsDisplay = ""
                     if films.count > 0 {
                         for item in films {
                             filmsDisplay += item + ", "
                         }
                     }
                     else {
                         filmsDisplay = "No Films"
                     }
                     
                     
                    var tvShowsDisplay = ""
                     if tvShow.count > 0 {
                         for item in tvShow
                         {
                             tvShowsDisplay += item + " "
                         }
                     }
                     else {
                         tvShowsDisplay = "No tvShows"
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
        
        let stringOne = myLabel.text
        
    
        
        
        
        

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
        } else{
            print("no")
            alertNO()
        }
        
        if count < 0 {
            alertTwo()
            print("gameOver")
        }
        
        
        
   
        // alert functions 
        func alertYES() {
            SPAlert.present(title: "Great Job!", message: "You are Correct!", preset: .custom(UIImage.init(named: "mickeyHappy")!))
        }
    
        func alertNO(){
            SPAlert.present(title: "Try Again", message: "The answer was \(myLabel.text ?? "None")", preset: .custom(UIImage.init(named: "sad")!))
        }
    

    
        func gameOver(){
            SPAlert.present(title: "Game Over", message: "Try Again Next Time", preset: .custom(UIImage.init(named: "sad")!))
        }

        func alertTwo(){
            let alert = UIAlertController(title: "Game Over!", message: "The correct answer was \(stringOne ?? "None"). Try again next time.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Ok.", style: .default, handler: nil))
               self.present(alert, animated: true)
           }
        
        
        
        
        
        
        
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}


