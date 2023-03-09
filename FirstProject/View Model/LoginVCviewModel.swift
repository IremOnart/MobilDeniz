//
//  LoginVCviewModel.swift
//  FirstProject
//
//  Created by iremo on 26.01.2023.
//

import Foundation
import CoreData
import UIKit

struct LoginVCviewModel{
    var nameArray = [String]()
    var passwordArray = [String]()
    var nameIndex : Int = 0
    var nameText2 : String = ""
    var passwordText2 : String = ""
    var idArray = [UUID]()
    
    mutating func signInClicked(nameText : UITextField , passwordText : UITextField) {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if results.count > 0{
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String{
                        nameArray.append(name)
                        
                    }
                    if let password = result.value(forKey: "password") as? String{
                        passwordArray.append(password)
                    }
                    if let id = result.value(forKey: "id") as? UUID{
                        idArray.append(id)
                    }
                }
            }
        } catch  {
            print("error")
        }
        
        if nameArray.contains(nameText.text!){
            nameIndex = nameArray.firstIndex(where: {$0 == nameText.text})!
            if passwordArray[nameIndex] == passwordText.text{
                
                print("u are in")
                
                 /*let alert = UIAlertController(title: "Success", message: "giriş yapıldı", preferredStyle: UIAlertController.Style.alert)
                 let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                 alert.addAction(okButton)
                 self.present(alert , animated: true)*/
                
                nameText2 = nameArray[nameIndex]
                passwordText2 = passwordArray[nameIndex]
                
                print(nameText2)
                print(passwordText2)
                
            }
        }
        else{
            print("kayıt Bulunamadı")
            /*let alert = UIAlertController(title: " ", message: "Kayıt Bulunamadı", preferredStyle: UIAlertController.Style.alert)
             let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
             alert.addAction(okButton)
             self.present(alert , animated: true)*/
        }
        
    }
    
    func getName() -> String {
        return (nameText2)
    }
    
    
    
    func signUpClicked(nameText : UITextField , passwordText : UITextField) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: context)
        
        if ((nameText.text?.isEmpty) == true){
            print("error")
        }
        else{
            newUser.setValue(nameText.text!, forKey: "name")
            newUser.setValue(passwordText.text!, forKey: "password")
            newUser.setValue(UUID(), forKey: "id")
        
            do {
                try context.save()
                /*let alert = UIAlertController(title: "Success", message: "Kayıt Başarılı", preferredStyle: UIAlertController.Style.alert)
                 let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                 alert.addAction(okButton)
                 self.present(alert , animated: true)*/
                print("succes")
            } catch{
                print("error")
            }
        }
      
        
        /*var num = nameArray
         for num1 in num {
         print(num1)
         }*/
        
    }
    
       
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toMainFromSignup" {
            if let destinationVC = segue.destination as? ViewController{
                print(nameText2)
                destinationVC.selectedUsername = nameText2
                destinationVC.SelectedPassword = passwordText2
            }
            
        }
    }*/
        
        
    }
