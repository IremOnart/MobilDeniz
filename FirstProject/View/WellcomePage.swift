//
//  WellcomePage.swift
//  FirstProject
//
//  Created by iremo on 3.02.2023.
//

import UIKit

class WellcomePage: UIViewController {

    
    @IBOutlet var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.getName(_:)), name: Notification.Name("notificationName"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.fromTheList(_:)), name: Notification.Name("tableViewNotification"), object: nil)
        if UserData1.shared.userName1 != nil {
            userName.text = UserData1.shared.userName1
        }
        else if UserData2.shared.userName2 != nil {
            userName.text = nil
            userName.text = UserData2.shared.userName2
        }
        
        
    }

    @objc func getName(_ notification : NSNotification) {
        if let theName = notification.userInfo?["userInfo"] as? String{
            userName.text = theName
           
        }
    }
    
    @objc func fromTheList(_ notification : NSNotification){
        if let thename = notification.userInfo?["userName"] as? String{
            userName.text = thename
           
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        view.window?.rootViewController?.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
