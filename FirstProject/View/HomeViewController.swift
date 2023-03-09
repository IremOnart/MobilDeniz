//
//  ViewController.swift
//  FirstProject
//
//  Created by iremo on 15.01.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var bireysel : UILabel!
    @IBOutlet var kurumsalLabel: UILabel!
    @IBOutlet var topNavigation: UIImageView!
    @IBOutlet var chat: UIImageView!
    @IBOutlet var mail: UIImageView!
    @IBOutlet var wellcome: UILabel!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var userChanged: UIButton!
    @IBOutlet var name: UILabel!
    
    


    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(_:)), name: Notification.Name("notificationName"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.fromTheList(_:)), name: Notification.Name("tableViewNotification"), object: nil)
       
        
        
     /*loginButton.addAction(for: .touchUpInside) {
                
        }*/
    
        
    }
    


    
    @objc func showSpinningWheel(_ notification : NSNotification) {
        if let theName = notification.userInfo?["userInfo"] as? String{
            name.text = theName
           
        }
    }
    
    @objc func fromTheList(_ notification : NSNotification){
        if let thename = notification.userInfo?["userName"] as? String{
            name.text = thename
           
        }
    }
    
    
    
    
    
    @IBAction func loginClicked(_ sender: Any) {
        //name.text = notification.userInfo?["userInfo"] as? String
        //self.present(LoginVC(nibName: "LoginVC", bundle: nil), animated: true)
        // self.navigationController?.pushViewController(LoginVC(nibName: "LoginVC", bundle: nil), animated: true)
        //self.performSegue(withIdentifier: "LoginVC", sender: nil)
        let login = WellcomePage(nibName: "WellcomePage", bundle: nil)
        login.modalPresentationStyle = .fullScreen
        self.present(login, animated: true)
        //self.present(WellcomePage(nibName: "WellcomePage", bundle: nil), animated: true)
    
        
    }

   
    
    @IBAction func userChangeClicked(_ sender: Any) {
        //self.navigationController?.pushViewController(LoginVC(nibName: "LoginVC", bundle: nil), animated: true)
        /*let login = LoginVC(nibName: "LoginVC", bundle: nil)
        //login.modalPresentationStyle = .fullScreen
        self.present(login, animated: true)*/
        self.present(LoginVC(nibName: "LoginVC", bundle: nil), animated: true)
        //navigationController?.pushViewController(login, animated: true)
        
    }
    
    
    func toAlert(title : String , message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert , animated: true)
    }


}

