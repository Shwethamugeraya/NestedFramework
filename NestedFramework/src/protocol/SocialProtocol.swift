//
//  FacebookManagerProtocol.swift
//  McDonaldsSDK
//
//  Created by Shwetha Mugeraya on 5/23/17.
//  Copyright © 2017 McDonalds. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

///  Describes the result of a login attempt.

public enum FacebookLoginResult {
    /// User succesfully logged in.
    case success
    /// Login attempt was cancelled by the user.
    case cancelled
    /// Login attempt failed.
    case failed(Error)

}

/// Defines interface to be defined by facebook login manager
public protocol SocialFacebookProtocol {

    /// Checks whether the user is logged in or not
    /// - returns: Boolean value true if access token exists, otherwise returns false
    func isLoggedIn() -> Bool

    /// Login to facebook with given specifed permission
    /// - parameter completionHandler: the callback which contains result like cancelled, success or error
    func loggin(completionHandler:@escaping ((_ result: FacebookLoginResult) -> Void))

    /// Logs the user out
    func logOut()

    /// To get access token
    /// - returns: Acesss token than saved in the keychain
    func getAccessToken() -> String?

    /// Refresh the current access token's permission state and extend the token's expiration date,
    /// If a token is already expired, it cannot be refreshed.
    /// - parameter completionHandler: A call back which contains error if any error occurs during refreshing token
    func refreshAccessToken(completionHandler: @escaping (_ error: Error?) -> Void)
}
