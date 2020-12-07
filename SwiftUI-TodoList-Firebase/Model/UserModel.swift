//
//  UserModel.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-06.
//

import Foundation

struct UserModel: Identifiable, Hashable {
    
    let id: String
    var email: String
    var firstName: String
    var lastName: String
    var fullName: String
    var phoneNumber: String
    
    var fullAddress: String?
    var onBoarding: Bool
    
    init(_id: String, _email: String, _firstName: String, _lastName: String, _phoneNumber: String) {
        
        id = _id
        email = _email
        firstName = _firstName
        lastName = _lastName
        fullName = firstName + " " + lastName
        phoneNumber = _phoneNumber
        onBoarding = false
    }
    
    init(_ dictionary : NSDictionary) {
        
        id = dictionary[kID] as? String ?? ""
        email = dictionary[kUSEREMAIL] as? String ?? ""
        firstName = dictionary[kFIRSTNAME] as? String ?? ""
        lastName = dictionary[kLASTNAME] as? String ?? ""
        
        fullName = firstName + " " + lastName
        fullAddress = dictionary[kFULLADDRESS] as? String ?? ""
        phoneNumber = dictionary[kPHONENUMBER] as? String ?? ""
        onBoarding = dictionary[kONBOARD] as? Bool ?? false
    }
    

}






//    let id: String = ""
//    var email: String = ""
//    var firstName: String = ""
//    var lastName: String = ""
//    var fullName: String = ""
//    var phoneNumber: String = ""
//    var fullAddress: String = ""
//    var onBoard: Bool = false
//    var createdAt: Date = Date()
//
//
//    mutating func updateProgressStatus(updateProgressSatatus : Bool) {
//        onBoard = updateProgressSatatus
//    }
//
//
//    func dictionaryFrom(_ rowdata: UserModel) -> [String : Any] {
//
//        return NSDictionary(objects: [rowdata.id,
//                                      rowdata.email,
//                                      rowdata.firstName,
//                                      rowdata.lastName,
//                                      rowdata.fullName,
//                                      rowdata.phoneNumber,
//                                      rowdata.fullAddress,
//                                      rowdata.onBoard,
//                                      rowdata.createdAt
//                                    ],
//
//                            forKeys: [kID as NSCopying,
//                                      kUSEREMAIL as NSCopying,
//                                      kFIRSTNAME as NSCopying,
//                                      kLASTNAME as NSCopying,
//                                      kFULLNAME as NSCopying,
//                                      kPHONENUMBER as NSCopying,
//                                      kFULLADDRESS as NSCopying,
//                                      kONBOARD as NSCopying,
//                                      kCREATEDDATE as NSCopying
//        ]) as! [String : Any]
//    }
