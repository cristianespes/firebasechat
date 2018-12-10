//
//  UserFirebase.swift
//  ChatKeepcoding
//
//  Created by CRISTIAN ESPES on 10/12/2018.
//  Copyright © 2018 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import MessageKit

class UserFirebase: UserManager {
    func register(user: User, onSuccess: @escaping (User) -> Void, onError: ErrorClosure?) {
        Auth.auth().createUser(withEmail: user.email, password: user.password!) { (user, error) in
            // Si hay algún error, devuelve el error
            if let err = error, let retError = onError {
                retError(err)
            }
            
            // Si hay un usuario y no hay error, devolvemos el success
            if let u = user {
                onSuccess(User.init(id: u.user.uid, email: u.user.email!, password: nil))
            }
        }
    }
    
    func login(user: User, onSuccess: @escaping (User) -> Void, onError: ErrorClosure?) {
        Auth.auth().signIn(withEmail: user.email, password: user.password!) { (user, error) in
            if let err = error, let retError = onError {
                retError(err)
            }
            
            if let u = user {
                onSuccess(User.init(id: u.user.uid, email: u.user.email!, password: nil))
            }
        }
    }
    
    func recoverPassword(user: User, onSuccess: @escaping (User) -> Void, onError: ErrorClosure?) {
        Auth.auth().sendPasswordReset(withEmail: user.email) { (error) in
            if let err = error, let retError = onError {
                retError(err)
            }
            
            onSuccess(user)
        }
    }
    
    func isLogged(onSuccess: @escaping (User?) -> Void, onError: ErrorClosure?) {
        if let user = Auth.auth().currentUser {
            let user = User.init(id: user.uid, email: user.email!, password: nil)
            onSuccess(user)
        }
        
        onSuccess(nil) // Devolvemos nil cuando el usuario no está logeado, lo controlamos desde el VC
    }
    
    func logout(onSuccess: @escaping () -> Void, onError: ErrorClosure?) {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print(error.localizedDescription)
            if let retError = onError {
                retError(error)
            }
        }
        
    }
}
