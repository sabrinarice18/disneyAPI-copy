//
//  searchVC.swift
//  disneyAPI
//
//  Created by Sabrina Rice  on 3/4/22.
//

import UIKit

class searchVC: UIViewController {

   
    @IBOutlet weak var myText: UITextField!
    
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myImage: UIImageView!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()



        // Do any additional setup after loading the view.
    }
    

  
    
    @IBAction func buttonTapped(_ sender: UIButton)
    {
    
        let urlString = "https://api.disneyapi.dev/characters"
          
        if let url = URL(string: urlString)
        {
            let task = URLSession.shared.dataTask(with: url) { [self]
              (data, response, error) in
                 if let err = error {
                    print(err)
                    return
                 }
         
                 do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any]
                            print(json!)
                   
                     let name = json!["name"] as? String ?? "none"
                     let films = json!["films"] as? [String] ?? ["none"]
                     let tvSHows = json!["tvShows"] as? [String] ?? ["none"]
                     let parkAttractions = json!["parkAttractions"] as? [String] ?? ["none"]
                     let videoGames = json!["videoGames"] as? [String] ?? ["none"]
                     let imageLink = json!["imageUrl"] as? String ?? " "
                     let shortFilms = json!["shortFilms"] as? [String] ?? ["none"]
                     
                     
                     
                     var filmsDisplay = ""
                     if films.count > 0 {
                         for item in films
                         {
                             filmsDisplay += item + ", "
                         }
                     }
                     else {
                         filmsDisplay = "None"
                     }
                     
                     var tvShowsDisplay = ""
                     if tvSHows.count > 0 {
                         for item in tvSHows
                         {
                             tvShowsDisplay += item + ", "
                         }
                     }
                     else {
                         tvShowsDisplay = "None"
                     }
                     
                     var parkAttractionDisplays = ""
                     if parkAttractions.count > 0 {
                         for item in parkAttractions {
                             parkAttractionDisplays += item + ", "
                         }
                     }
                     else{
                         parkAttractionDisplays = "None"
                     }
                     
                     var videoGamesDisplay = ""
                     if videoGames.count > 0 {
                         for item in videoGames {
                             videoGamesDisplay += item + ", "
                         }
                     }
                     else{
                         videoGamesDisplay = "None"
                     }
                     
                     var shortFilmsDisplays = ""
                     if shortFilms.count > 0 {
                         for item in shortFilms{
                             shortFilmsDisplays += item + ", "
                         }
                     }
                     else {
                         shortFilmsDisplays = "None"
                     }
                     
                     
                     
                     if ((myText.text?.range(of: name)) != nil){
                         
                         DispatchQueue.main.async {
                             self.myLabel.text = "Name: \(name)\nFilms: \(filmsDisplay)\nTv Shows: \(tvShowsDisplay)\nPark Attractions: \(parkAttractionDisplays)\nVideo Games: \(videoGamesDisplay)\nShort Films: \(shortFilmsDisplays)"
    
                             self.myImage.sd_setImage(with: URL(string: imageLink), completed: nil)
                             }
                     }
                     
                       
                 
                     
                     
                     
                     
                     
             
                     
                     
            
                     
                    
                     
                    
                     
                     
                     
                     
                     
                     
                    
                     
                     
                     
                     
                     
                     
//                     DispatchQueue.main.async {
//                         self.myLabel.text = "Name: \(name)\nFilms: \(filmsDisplay)\nTv Shows: \(tvShowsDisplay)\nPark Attractions: \(parkAttractionDisplays)\nVideo Games: \(videoGamesDisplay)\nShort Films: \(shortFilmsDisplays)"
//
//                         self.myImage.sd_setImage(with: URL(string: imageLink), completed: nil)
//                         }
                    print(json!)
                 } catch let jsonError {
                    print(jsonError)
                 }
                        
             }
             task.resume()
          }

        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
