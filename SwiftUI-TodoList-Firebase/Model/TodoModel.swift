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
    var createdAt: Date = Date()
    
    mutating func updateProgressStatus(updateProgressSatatus : Bool) {
        isDone = updateProgressSatatus
    }
    
    
    func dictionaryFrom(_ rowdata: TodoModel) -> [String : Any] {
        
        return NSDictionary(objects: [rowdata.id,
                                      rowdata.title,
                                      rowdata.note,
                                      rowdata.imageURL,
                                      rowdata.isDone,
                                      rowdata.createdAt
                                    ],
                            forKeys: [kID as NSCopying,
                                      kTODOTITLE as NSCopying,
                                      kTODOMEMO as NSCopying,
                                      kTODOIMAGEURL as NSCopying,
                                      kTODOISDONE as NSCopying,
                                      kCREATEDDATE as NSCopying
        ]) as! [String : Any]
    } 

}



struct TodoItemModel: Identifiable, Hashable {
    var id: String = ""
    var item: String = ""
    var imageURL: String = ""
    var isDone: Bool = false
    var createdAt: Date = Date()
    
    mutating func updateProgressStatus(updateProgressSatatus : Bool) {
        isDone = updateProgressSatatus
    }
    
    
    func dictionaryFrom(_ rowdata: TodoItemModel) -> [String : Any] {
        
        return NSDictionary(objects: [rowdata.id,
                                      rowdata.item,
                                      rowdata.imageURL,
                                      rowdata.isDone,
                                      rowdata.createdAt
                                    ],
                            forKeys: [kID as NSCopying,
                                      kTODOITEMITEM as NSCopying,
                                      kTODOIMAGEURL as NSCopying,
                                      kTODOISDONE as NSCopying,
                                      kCREATEDDATE as NSCopying
        ]) as! [String : Any]
    }

}
