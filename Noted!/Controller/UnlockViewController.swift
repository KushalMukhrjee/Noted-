//
//  UnlockViewController.swift
//  Noted!
//
//  Created by Kushal Mukherjee on 27/05/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import UIKit
import LocalAuthentication

class UnlockViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.cyan
        
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        //context for local authentication
        let laContext=LAContext()
        
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock Noted!") { (result, error) in
                if(result){
                    DispatchQueue.main.async {
                        
                    
                    print("fingerprint scan Success")
                    let vcObj=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationvc") as! NavigationController
                    vcObj.loadView()
                    self.present(vcObj, animated: true, completion: nil)
                    }

                }
                else{
                    
                    
                    let err = error as! LAError
                    print(err.errorCode)
                    //error code for enter password
                    if(err.errorCode == -3){
                        self.enterPassword()
                        
        
        print("here---------")
        
    }
                }
        }
    }
    @IBAction func enterPasswordAction(_ sender: UIButton) {
        
        enterPassword()
    }
    
    
    func enterPassword(){
        
        let alertVC=UIAlertController(title: "Enter passcode", message: "Please enter your passcode", preferredStyle: .alert)
        let okButton=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
            
            //for password success
            if(alertVC.textFields![0].text == "1234"){
                DispatchQueue.main.async {
                    
                    
                    print("Success")
                    
                    let vcObj=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationvc") as! NavigationController
                    vcObj.loadView()
                    self.present(vcObj, animated: true, completion: nil)
                }
            }
            else{
                alertVC.message="Wrong Password!!!"
                self.present(alertVC, animated: true, completion: nil)
            }
        })
        
        
        alertVC.addTextField(configurationHandler: { (textfield) in
            textfield.isSecureTextEntry=true
            textfield.keyboardType=UIKeyboardType(rawValue: 4)!
        })
        
        let cancelButton=UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        alertVC.addAction(okButton)
        alertVC.addAction(cancelButton)
        self.present(alertVC, animated: true, completion: nil)
        }
}


        
        
    
    
    
    


