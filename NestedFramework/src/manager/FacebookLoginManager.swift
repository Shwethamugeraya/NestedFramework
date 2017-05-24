//
//  FacebookManager.swift
//  McDonaldsSDK
//
//  Created by Shwetha Mugeraya on 5/23/17.
//  Copyright © 2017 McDonalds. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

/// provides methods for logging the user in and out and refreshing token, to get access token 
public struct FacebookLoginManager: SocialFacebookProtocol {

    /// Default initializer
    public init() {

    }

    /// Checks whether the user is logged in or not
    /// - returns: Boolean value true if access token exists, otherwise returns false
    public func isLoggedIn() -> Bool {
        if FBSDKAccessToken.current() == nil {
            return false
        }
        return true
    }

    /// Login to facebook with given specifed permission
    /// - parameter completionHandler: the callback which contains result like cancelled, success or error
    public func loggin(completionHandler:@escaping ((_ result: FacebookLoginResult) -> Void)) {
        let loginManager = FBSDKLoginManager()
        loginManager.loginBehavior = .systemAccount
        loginManager.logIn(withReadPermissions: ["email"], from: nil) { (result, error) in
            let loginResult = self.map(result, error)
            completionHandler(loginResult)
        }
    }

    /// Logs the user out
    public func logOut() {
         if FBSDKAccessToken.current() == nil {
            return
        }

        FBSDKLoginManager().logOut()
        FBSDKAccessToken.setCurrent(nil)
    }

    /// Refresh the current access token's permission state and extend the token's expiration date,
    /// If a token is already expired, it cannot be refreshed.
    /// - parameter completionHandler: A call back which contains error if any error occurs during refreshing token
    public func refreshAccessToken(completionHandler: @escaping (_ error: Error?) -> Void) {
        if isLoggedIn() == false {
            let error = NSError(domain:"", code:0, userInfo:[NSLocalizedDescriptionKey: "No token to refresh. Please login"])
            completionHandler(error)
        }
        FBSDKAccessToken.refreshCurrentAccessToken { (_, _, error) in
            completionHandler(error)
        }
    }

    /// To get access token
    /// - returns: Acesss token than saved in the keychain
    public func getAccessToken() -> String? {
        if FBSDKAccessToken.current() == nil {
            return nil
        }
        return FBSDKAccessToken.current().tokenString
    }

    /// To map FBSDKLoginManagerLoginResult to FacebookLoginResult
    /// - parameter result: Result retuned by facebook sdk
    /// - parameter error: Error returned by facebook sdk
    /// - returns: FacebookLoginResult object indicates whether loggin is success, failure or cancelled
    private func map(_ result: FBSDKLoginManagerLoginResult?, _ error: Error?) -> FacebookLoginResult {
        let defaultError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Login Failed"])
        var loginResult: FacebookLoginResult = .failed(defaultError)

        if let error = error {
            loginResult = FacebookLoginResult.failed(error)

        } else {
            if result?.isCancelled == true {
                loginResult = FacebookLoginResult.cancelled
            } else {
                loginResult = FacebookLoginResult.success
            }
        }
        return loginResult
    }
}
