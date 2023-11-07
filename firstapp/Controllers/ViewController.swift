//
//  ViewController.swift
//  firstapp
//
//  Created by tuğba on 10.10.2023.
//

import UIKit

class ViewController: UIViewController  {
   
    
    @IBOutlet weak var tableView : UITableView!
    var alertController  = UIAlertController()
    var list = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
    }
    
    @IBAction func didRemoveBarButtonItemTapped (_ sender:UIBarItem)
    {
        presentAlert(title: "UYARI!", message: "Listedeki bütün ögeleri silmek istediğinizden emin misiniz?", defaultButtonTitle: "EVET", cancelButttonTitle: "VAZGEÇ") { _ in
            self.list.removeAll()
            self.tableView.reloadData()
        }
       
    }
    
    
    @IBAction func didAddBarButtonItemtapped(_ sender: UIBarButtonItem) {
        presentAddAlert()
    }
    
    
    func presentAddAlert()
    {
      
        presentAlert(title: "yeni eleman ekle", message: nil,preferredStyle: .alert,
                     
                     defaultButtonTitle: "ekle", isTextFieldAvailable : true,
                     cancelButttonTitle: "vazgeç"  , defaultButtonHandler: { _ in
            
            let text = self.alertController.textFields?.first!.text
            if text != ""
            {
                self.list.append((text)!)
                self.tableView.reloadData()
            }
            else
            {
                self.presentWarningAlert()
            }
        }
                   
                );
                    

    
   
       
      
    }
    
    
    func presentWarningAlert()
    {
        
        presentAlert(title: "UYARI!", message: "listeye boş eleman eklenemez ", cancelButttonTitle: "tamam")
        
    }


    func presentAlert(title : String? ,
    message :String? ,
    preferredStyle : UIAlertController.Style = .alert ,
    defaultButtonTitle: String? = nil,
                      isTextFieldAvailable:Bool=false,
        cancelButttonTitle : String?,
                      defaultButtonHandler : ((UIAlertAction) -> Void)? = nil)
    {
        alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if defaultButtonTitle != nil
        {
            let defaultButton = UIAlertAction(title:defaultButtonTitle, style: .default, handler: defaultButtonHandler )
            alertController.addAction(defaultButton)
        }
      
            
        let cancelbutton = UIAlertAction(title: cancelButttonTitle, style: .cancel)
        if isTextFieldAvailable
        {
            alertController.addTextField()
                
            
        }
        
        
        alertController.addAction(cancelbutton)
        present(alertController, animated: true)
    }


}
extension ViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return list.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultcell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      
        let deleteAcition = UIContextualAction(style: .normal, title: "SİL") { _,_, _ in
            self.list.remove(at: indexPath.row)
            self.tableView.reloadData()
          
        }
        let editAction = UIContextualAction(style: .normal, title: "Düzenle") { _, _, _ in
            self.presentAlert(title: "elemanı düzenle", message: nil,preferredStyle: .alert,
                         
                         defaultButtonTitle: "düzenle", isTextFieldAvailable : true,
                         cancelButttonTitle: "vazgeç"  , defaultButtonHandler: { _ in
                
                let text = self.alertController.textFields?.first!.text
                if text != ""
                {
                    self.list[indexPath.row] = text!
                    self.tableView.reloadData()
                }
                else
                {
                    self.presentWarningAlert()
                }
            }
                       
                    );
        }
        deleteAcition.backgroundColor = .systemRed
       
        
        
        let config = UISwipeActionsConfiguration(actions: [deleteAcition , editAction])
    
        
        return config
    }}

