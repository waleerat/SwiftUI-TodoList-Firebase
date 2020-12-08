//
//  TodoItemModel.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-07.
//

import Foundation

struct TodoItemModel: Identifiable, Hashable {
    var id: String = ""
    var item: String = ""
    var imageURL: String = ""
    var todoListRefId: String = ""
    var createdByUser: String = ""
    var doneByUser: String = ""
    var doneAt: Date? = nil
    var isDone: Bool = false
    var createdAt: Date = Date()
    var updateAt: Date? = nil
    
    mutating func updateProgressStatus(updateProgressSatatus : Bool) {
        isDone = updateProgressSatatus
    }
    
    func dictionaryFrom(_ rowdata: TodoItemModel) -> [String : Any] {
        
        return NSDictionary(objects: [rowdata.id,
                                      rowdata.item,
                                      rowdata.imageURL,
                                      rowdata.todoListRefId,
                                      rowdata.createdByUser,
                                      rowdata.isDone,
                                      rowdata.doneByUser,
                                      rowdata.doneAt ?? Date(), //*Need to Fix 
                                      rowdata.createdAt,
                                      rowdata.updateAt ?? Date() //*Need to Fix
                                    ],
                            forKeys: [kID as NSCopying,
                                      kTODOITEMITEM as NSCopying,
                                      kTODOIMAGEURL as NSCopying,
                                      kTODOLISTREFID as NSCopying,
                                      kCREATEDBYUSER as NSCopying,
                                      kTODOISDONE as NSCopying,
                                      kDONEBYUSER as NSCopying,
                                      kDONEAT as NSCopying,
                                      kCREATEDDATE as NSCopying,
                                      kUPDATEDAT as NSCopying
        ]) as! [String : Any]
    }

}


/**
 
 if let date = _dictionary[kDATEOFBIRTH] as? Timestamp {
     dateOfBirth = date.dateValue()
 } else {
     dateOfBirth = _dictionary[kDATEOFBIRTH] as? Date ?? Date()
 }
 */
