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
        
        userAuthetication()
        //context for local authentication
        
//                else{
//
//
//                    let err = error as! LAError
//                    print(err.errorCode)
//                    //error code for enter password
//                    if(err.errorCode == -3){
//                        self.enterPassword()
//
//
//        print("here---------")
//
//    }
//                }
        }
    
    @IBAction func enterPasswordAction(_ sender: UIButton) {
            userAuthetication()

    }
    
    
    func userAuthetication(){

        let laContext=LAContext()
        
        var authError:NSError?
        
        if laContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError){
        laContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Unlock Noted!") { (result, error) in
            if(result){
                DispatchQueue.main.async {
                    
                    
                    print("Auth Success")
                    let vcObj=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationvc") as! NavigationController
                    vcObj.loadView()
                    self.present(vcObj, animated: true, completion: nil)
                }
                
            }
        }
        }
        else{
            let vcObj=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationvc") as! NavigationController
            vcObj.loadView()
            self.present(vcObj, animated: true, completion: nil)
        }
        
}


}
        
    
    
    
    


