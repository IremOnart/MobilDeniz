//
//  MainViewController.swift
//  FirstProject
//
//  Created by iremo on 25.01.2023.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
   
    
    @IBOutlet var tableView: UITableView!
    var nameArrayinList = [String]()
    var idArrayinList = [UUID]()
    
    var userListVM = UserListVCviewModel()
    
    var userlist : UIView!
    var loginvc : UIView!
    
    var chosenName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        //userlist = UserListVC().tableView
        //loginvc = LoginVC()
        // Do any additional setup after loading the view.
        
        getData()
    }
    func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                if let name = result.value(forKey: "name") as? String{
                    nameArrayinList.append(name)
                }
                if let id = result.value(forKey: "id") as? UUID{
                    idArrayinList.append(id)
                }
                tableView.reloadData()
            }
            
        } catch  {
            print("error")
        }
    }
    
    

   @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        switch  sender.selectedSegmentIndex{
        case 0:
            //dismiss(animated: true)
            /*let toFirstPage = LoginVC(nibName: nil, bundle: nil)
            toFirstPage.modalPresentationStyle = .fullScreen
            self.present(toFirstPage, animated: true)*/
            self.present(LoginVC(nibName: "LoginVC", bundle: nil), animated: true)
        case 1:
            print("u are there")
        default:
            break
        }
    }
    
    
    
    @IBAction func toTheMainClicked(_ sender: Any) {
        view.window?.rootViewController?.dismiss(animated: true)
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArrayinList.count
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text =  nameArrayinList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenName = nameArrayinList[indexPath.row]
        view.window?.rootViewController?.dismiss(animated: true)
        let thename = chosenName
        UserData2.shared.userName2 = thename
        let loginRespons = ["userName" : thename]
        NotificationCenter.default.post(name: NSNotification.Name("tableViewNotification"), object: nil , userInfo: loginRespons)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
            
            let idString = idArrayinList[indexPath.row].uuidString
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
               let results = try context.fetch(fetchRequest)
                if results.count > 0{
                    
                    for result in results as! [NSManagedObject]{
                        if let id = result.value(forKey: "id") as? UUID{
                            if id == idArrayinList[indexPath.row]{
                                context.delete(result)
                                nameArrayinList.remove(at: indexPath.row)
                                idArrayinList.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                do {
                                    try context.save()
                                } catch  {
                                    print("error")
                                }
                                break
                            }
                        }
                    }
                }
            } catch  {
                print("error")
            }
        }
    }

}
