//
//  TodoVM.swift
//  SwiftUI-todoList
//
//  Created by Waleerat Gottlieb on 2020-12-04.
//

import Foundation
import Firebase

class TodoVM: ObservableObject {
    @Published var todoListRows: [TodoModel] = []
    var todoModel = TodoModel()
    
//    init() {
//        getDataFromFirebase()
//    }
    
    func getDataFromFirebase() {
        
        FirebaseReference(.TodoList)
            .order(by: kCREATEDDATE, descending: true)
            .getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty {
                self.todoListRows = self.getRowsFromDictionary(snapshot)
            }
        }
        
    }
    
    func getRowsFromDictionary(_ snapshot: QuerySnapshot) -> [TodoModel] {
        
        var allRows: [TodoModel] = []
        for snapshot in snapshot.documents {
            let rowData = snapshot.data()
           allRows.append(TodoModel(id: rowData[kID] as! String,
                                    title: rowData[kTODOTITLE] as! String,
                                    note: rowData[kTODOMEMO] as! String,
                                    imageURL: rowData[kTODOIMAGEURL] as! String,
                                    isDone: rowData[kTODOISDONE] as! Bool,
                                    createdAt: Date()
                                    )
                            )
        }
        return allRows
    }
    
    func saveRowDataToFirestore(rowData : TodoModel, completion: @escaping (_ error: Error?) -> Void) {
        let withData =  todoModel.dictionaryFrom(rowData)
          
        FirebaseReference(.TodoList).document(rowData.id).setData(withData) {
            error in
            DispatchQueue.main.async {
                if error != nil {
                    print("error saving order to firestore: ", error!.localizedDescription)
                }
                return
            }

        }
    }
    
    func updateCheckedTodoList(objectId: String, isDone: Bool){
        FirebaseReference(.TodoList).document(objectId).updateData(["isDone" : isDone])
    }
    
    func createRecord(_title: String,_note: String, _imageURL: String, _isDone: Bool, completion: @escaping (_ response:String, _ error: Error?) -> Void) {
            
        let rowData = TodoModel(id: UUID().uuidString,
                                 title: _title,
                                 note: _note,
                                 imageURL: _imageURL,
                                 isDone: _isDone,
                                 createdAt: Date()
                                )

        saveRowDataToFirestore(rowData: rowData) { (error) in
            if let error = error {
                completion("Error creating document: \(error)",error)
            } else {
                completion("Created!",nil)
            }
        }
    } 
    
    func updateRecord(_objectId: String,_title: String,_note: String, _imageURL: String, _isDone: Bool, completion: @escaping (_ response:String, _ error: Error?) -> Void) {
         
        let rowData = TodoModel(id: _objectId,
                                title: _title,
                                 note: _note,
                                 imageURL: _imageURL,
                                 isDone: _isDone,
                                 createdAt: Date()
                                )
           
        saveRowDataToFirestore(rowData: rowData) { (error) in
            if let error = error {
                completion("Error updating document: \(error)",error)
            } else {
                completion("updated!",nil)
            } 
        }
        
    }
    
    func removeRecord(objectId: String, completion: @escaping (_ response:String, _ error: Error?) -> Void) {
        FirebaseReference(.TodoList).document(objectId).delete() { error in
            if let error = error {
                completion("Error removing document: \(error)",error)
            } else {
                completion("Document successfully removed!",nil)
            }
        }
    }
 
    func emptyStrucValues(){
        _ = TodoModel(id: "", title: "", note: "", imageURL: "", isDone: false, createdAt: Date())
    }
    
}

//        todoListRows.append(TodoModel(id: UUID().uuidString, name: "List 1", isDone: false))
//        todoListRows.append(TodoModel(id: UUID().uuidString, name: "List 2", isDone: true))
//        todoListRows.append(TodoModel(id: UUID().uuidString, name: "List 3", isDone: false))
//        todoListRows.append(TodoModel(id: UUID().uuidString, name: "List 4", isDone: false))
        
