//
//  VKManager.swift
//  vk-market
//
//  Created by Александр on 26.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import VK_ios_sdk

class VKManager: NSObject, VKSdkUIDelegate, VKSdkDelegate {
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        //
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.didOpenAuthorizeController?(controller)
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        self.didSuccessAuthorize?()
    }
    
    func vkSdkUserAuthorizationFailed() {
        self.didFailAuthorize?()
    }

    var vkInstance: VKSdk!
    
    var didOpenAuthorizeController: ((UIViewController)->())?
    var didSuccessAuthorize: (()->())?
    var didFailAuthorize: (()->())?
    
    static let shared = VKManager()
    
    static let APP_ID = "7641761"
    private let scope = ["market", "groups"]
    
    override init() {
        super.init()

    }
    
    func initialize() {
        let vkInstance = VKSdk.initialize(withAppId: VKManager.APP_ID, apiVersion: "5.124")
        vkInstance?.register(self)
        vkInstance?.uiDelegate = self
    }
    
    func getAuthorized(completion: @escaping ((Bool)->())) {
        VKSdk.wakeUpSession(scope) { (state, error) in
            if state == .authorized {
                completion(true)
            }
        }
    }
    
    func authorize() {
        VKSdk.authorize(scope)
    }
    
    func logout() {
        VKSdk.forceLogout()
    }
    
}
