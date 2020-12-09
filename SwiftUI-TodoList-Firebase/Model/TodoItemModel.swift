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
    var note: String = ""
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
        
        return [kID: rowdata.id,
                kTODOITEMITEM: rowdata.item,
                kTODOITEMNOTE: rowdata.note,
                kTODOIMAGEURL: rowdata.imageURL,
                kTODOLISTREFID: rowdata.todoListRefId,
                kCREATEDBYUSER: rowdata.createdByUser,
                kTODOISDONE: rowdata.isDone,
                kDONEBYUSER: rowdata.doneByUser,
                kDONEAT: rowdata.doneAt ?? Date(),
                kCREATEDDATE: rowdata.createdAt,
                kUPDATEDAT: rowdata.updateAt ?? Date()
                ]
    }

}
