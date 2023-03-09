//
//  LoginVC.swift
//  FirstProject
//
//  Created by iremo on 15.01.2023.
//

import UIKit

class LoginVC: UIViewController {

    
    @IBOutlet var nameText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
    var userPage = WellcomePage()
    
    var loginVM = LoginVCviewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //NotificationCenter.post(<#T##self: NotificationCenter##NotificationCenter#>)
        
    }
    
   
    @IBAction func registeredClicked(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("u are there")
        case 1:
            /*let toSecondPage = MainViewController(nibName: "MainViewController", bundle: nil)
            toSecondPage.modalPresentationStyle = .fullScreen
            self.present(toSecondPage, animated: true)*/
            self.present(MainViewController(nibName: "MainViewController", bundle: nil), animated: true)
            
            /*let vc = UserListVC()
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)*/
            
        default:
            break
        }
    }
    
    
    
    @IBAction func signInButton(_ sender: Any) {
        loginVM.signInClicked(nameText: nameText, passwordText: passwordText)
        let theName = loginVM.nameText2
        
        UserData1.shared.userName1 = theName
        
        
        
        let loginResponse = ["userInfo" : theName]
        NotificationCenter.default.post(name: NSNotification.Name("notificationName"), object: nil , userInfo: loginResponse)
        
        let login = WellcomePage(nibName: "WellcomePage", bundle: nil)
        login.modalPresentationStyle = .fullScreen
        self.present(login, animated: true)
        
        
        
        
        }
        
    
    @IBAction func signUpButton(_ sender: Any) {
        loginVM.signUpClicked(nameText: nameText, passwordText: passwordText)
    }
    

    @IBAction func toTheMainButton(_ sender: Any) {
        //self.navigationController?.pushViewController(HomeViewController(nibName: "HomeViewController", bundle: nil), animated: true)
        //self.present(HomeViewController(nibName: "HomeViewController", bundle: nil), animated: true)
        //navigationController?.popViewController(animated: true)
        view.window?.rootViewController?.dismiss(animated: true)
    }
    
    
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is HomeViewController {
        let vc = segue.destination as? HomeViewController
            vc?.name.text = nameText.text
    }
    }*/

    

}
