//
//  AuthController.swift
//  vk-market
//
//  Created by Александр on 27.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class AuthController: UIViewController {

    @IBOutlet var authorizeButton: UIButton! {
        didSet {
            self.authorizeButton.layer.cornerRadius = 10
            self.authorizeButton.layer.masksToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        VKManager.shared.getAuthorized { (success) in
            if success {
                VKManager.shared
                self.performSegue(withIdentifier: "toMain", sender: nil)
            } else {
                
            }
        }
        VKManager.shared.didOpenAuthorizeController = { controller in
            self.present(controller, animated: true, completion: nil)
        }
        VKManager.shared.didSuccessAuthorize = {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toMain", sender: nil)
            }
        }
        VKManager.shared.didFailAuthorize = {
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func didAuthorizeTapped(_ sender: Any) {
        VKManager.shared.authorize()
    }

}
