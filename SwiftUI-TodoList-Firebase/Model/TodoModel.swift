//
//  todoModel.swift
//  SwiftUI-todoList
//
//  Created by Waleerat Gottlieb on 2020-12-04.
//

import Foundation
import SwiftUI

struct TodoModel: Identifiable, Hashable {
    var id: String = ""
    var title: String = ""
    var note: String = ""
    var imageURL: String = ""
    var isDone: Bool = false
    var todoItems: [TodoItemModel]?
    var createdByUser: String = ""
    var createdAt: Date = Date()
    var updateAt: Date? = nil
    
    mutating func updateProgressStatus(updateProgressSatatus : Bool) {
        isDone = updateProgressSatatus
    }
    
    func dictionaryFrom(_ rowdata: TodoModel) -> [String : Any] {
        
        return NSDictionary(objects: [rowdata.id,
                                      rowdata.title,
                                      rowdata.note,
                                      rowdata.imageURL,
                                      rowdata.isDone,
                                      rowdata.todoItems ?? [],
                                      rowdata.createdByUser,
                                      rowdata.createdAt,
                                      rowdata.updateAt ?? Date()
                                    ],
                            forKeys: [kID as NSCopying,
                                      kTODOTITLE as NSCopying,
                                      kTODOMEMO as NSCopying,
                                      kTODOIMAGEURL as NSCopying,
                                      kTODOISDONE as NSCopying,
                                      kTODOITEMS as NSCopying,
                                      kCREATEDBYUSER as NSCopying,
                                      kCREATEDDATE as NSCopying,
                                      kUPDATEDAT as NSCopying,
        ]) as! [String : Any]
    } 

}
