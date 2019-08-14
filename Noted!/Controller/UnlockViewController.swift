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
                    let vcObj=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationvc") as! NotesNavigationController
//                    vcObj.loadView()
                    self.present(vcObj, animated: true, completion: nil)
                }
                
            }
        }
        }
        else{
            let vcObj=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationvc") as! NotesNavigationController
//            vcObj.loadView()
            self.present(vcObj, animated: true, completion: nil)
        }
        
}


}
        
    
    
    
    


