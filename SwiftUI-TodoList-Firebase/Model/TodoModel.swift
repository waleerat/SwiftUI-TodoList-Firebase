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
    var todoItems: [String]?
    var createdByUser: String = ""
    var createdAt: Date = Date()
    var updateAt: Date? = nil
    
    mutating func updateProgressStatus(updateProgressSatatus : Bool) {
        self.isDone = updateProgressSatatus
    }
  
    func dictionaryFrom(_ rowdata: TodoModel) -> [String : Any] {  
        return [kID : rowdata.id,
                kTODOTITLE : rowdata.title,
                kTODOMEMO : rowdata.note,
                kTODOIMAGEURL : rowdata.imageURL,
                kTODOISDONE : rowdata.isDone,
                kTODOITEMS : rowdata.todoItems as Any,
                kCREATEDBYUSER : rowdata.createdByUser,
                kCREATEDDATE : rowdata.createdAt,
                kUPDATEDAT : rowdata.updateAt ?? Date()
        ]
    } 

}
