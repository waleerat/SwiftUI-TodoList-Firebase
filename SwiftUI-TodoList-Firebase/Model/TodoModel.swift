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
    var item: String = ""
    var note: String = ""
    var imageURL: String = ""
    var isDone: Bool = false
    var createdAt: Date = Date()
    
    mutating func updateProgressStatus(updateProgressSatatus : Bool) {
        isDone = updateProgressSatatus
    }
    
    
    func dictionaryFrom(_ rowdata: TodoModel) -> [String : Any] {
        
        return NSDictionary(objects: [rowdata.id,
                                      rowdata.item,
                                      rowdata.note,
                                      rowdata.imageURL,
                                      rowdata.isDone,
                                      rowdata.createdAt
                                    ],
                            forKeys: [kID as NSCopying,
                                      kTODOITEM as NSCopying,
                                      kTOTOMEMO as NSCopying,
                                      kTOTOIMAGEURL as NSCopying,
                                      kTOTOISDONE as NSCopying,
                                      kCREATEDDATE as NSCopying
        ]) as! [String : Any]
    } 

}
