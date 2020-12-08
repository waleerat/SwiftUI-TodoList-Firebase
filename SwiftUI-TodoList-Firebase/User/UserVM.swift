//
//  UserVM.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-06.
//

import Foundation
import FirebaseAuth

class UserVM: ObservableObject {
    //@Published var userData: UserModel = UserModel(nil)
    // MARK: - Current User
     
    class func currentId() -> String {
        if let uid = Auth.auth().currentUser?.uid {
            return uid
        } else {
            return  ""
        }
    }
    
    class func currentUser() -> UserModel? {
        
        if Auth.auth().currentUser != nil {
            if let dictionary = userDefaults.object(forKey: kCURRENTUSER) {
                return UserModel.init(dictionary as! NSDictionary)

            }
        }
        
        return nil
    }
    
    class func loginUserWith(email: String, password: String, completion: @escaping (_ error: Error?, _ isEmailVerified: Bool) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            
            if error == nil {
                if kISVERIFYEMAIL {
                    if authDataResult!.user.isEmailVerified {
                            downloadUserFromFirestore(userId: authDataResult!.user.uid, email: email) { (error) in
                                completion(error, true)
                            }
                    } else {
                        completion(error, false)
                    }
                }  else {
                    downloadUserFromFirestore(userId: authDataResult!.user.uid, email: email) { (error) in
                        completion(error, true)
                    }
                }
            } else {
                completion(error, false)
            }
        }
        
    }
    
    class func registerUserWith(email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            
            completion(error)
            
            if error == nil {
                if kISVERIFYEMAIL {
                    authDataResult!.user.sendEmailVerification { (error) in
                        print("verification email sent error is: ", error?.localizedDescription ?? "")
                    }
                } 
            }
        }
    }
    
    class func resetPassword(email: String, completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            completion(error)
        }
    }
    
    class func logOutCurrentUser(completion: @escaping(_ error: Error?) ->Void) {
        
        do {
            try Auth.auth().signOut()
            userDefaults.removeObject(forKey: kCURRENTUSER)
            userDefaults.synchronize()
            completion(nil)
            print("Log out")
        } catch let error as NSError {
            completion(error)
        }
    }
    
    // MARK: - User Listener
    class func downloadUserFromFirestore(userId: String, email: String, completion: @escaping (_ error: Error?) -> Void) {
        
        FirebaseReference(.User).document(userId).getDocument { (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            if snapshot.exists {
                self.saveUserLocally(userDictionary: snapshot.data()! as NSDictionary)
            } else {
                let user = UserModel(_id: userId, _email: email, _firstName: "", _lastName: "", _phoneNumber: "")
                self.saveUserLocally(userDictionary: self.userDictionaryFrom(user: user) as NSDictionary)
                self.saveUserToFirestore(fUser: user)
            }
            
            completion(error)
        }
    }


    class func saveUserToFirestore(fUser: UserModel) {
        
        FirebaseReference(.User).document(fUser.id).setData(self.userDictionaryFrom(user: fUser)) { (error) in
            if error != nil {
                print("Error creating fuser object: ", error!.localizedDescription)
            }
        }
    }

    class func saveUserLocally(userDictionary: NSDictionary) {
        userDefaults.set(userDictionary, forKey: kCURRENTUSER)
        userDefaults.synchronize()
    }

    class func userDictionaryFrom(user: UserModel) -> [String : Any] {
        
        return NSDictionary(objects: [user.id,
                                      user.email,
                                      user.firstName,
                                      user.lastName,
                                      user.fullName,
                                      user.fullAddress ?? "",
                                      user.onBoarding,
                                      user.phoneNumber
                                    ],
                            forKeys: [kID as NSCopying,
                                      kUSEREMAIL as NSCopying,
                                      kFIRSTNAME as NSCopying,
                                      kLASTNAME as NSCopying,
                                      kFULLNAME as NSCopying,
                                      kFULLADDRESS as NSCopying,
                                      kONBOARD as NSCopying,
                                      kPHONENUMBER as NSCopying
        ]) as! [String : Any]
        
    }


    class func updateCurrentUser(withValues: [String : Any], completion: @escaping (_ error: Error?) -> Void) {
        
        
        if let dictionary = userDefaults.object(forKey: kCURRENTUSER) {
            let userObject = (dictionary as! NSDictionary).mutableCopy() as! NSMutableDictionary
            userObject.setValuesForKeys(withValues)
            FirebaseReference(.User).document(UserVM.currentId()).updateData(withValues) { (error) in
                completion(error)
                if error == nil {
                    self.saveUserLocally(userDictionary: userObject)
                }
            }
        }
    }
    
}
