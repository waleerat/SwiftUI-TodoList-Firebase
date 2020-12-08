//
//  todoItemVM.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-07.
//

import Foundation
import Firebase

class TodoItemsVM: ObservableObject {
    @Published var todoItemRows: [TodoItemModel] = []
    var todoItemModel = TodoItemModel()
   
    /**
     Get data form friebase
     ===================
     Get all data from Firestore
     - Parameters  No
     - Returns
        [TodoModel]
     - Remark:
        Get all data form TodoList Collection order by create/update descending in [NSDictionary] format
     - Note
        We aways get data from firestore as NSDictionary
     */
    
    func getDataFromFirebase(todoListRefId: String) {
       
        FirebaseReference(.TodoItemList)
             .whereField("todoListRefId", isEqualTo: todoListRefId)
            .order(by: kCREATEDDATE, descending: true)
            .getDocuments { (snapshot, error) in

            guard let snapshot = snapshot else { return }

            if !snapshot.isEmpty {
                self.getRowsFromDictionary(snapshot)
               
            }
        }
    }
    
    /**
     Convert NSDictionary to Structure
     ===================
     - Parameters  QuerySnapshot
     - Returns
        [TodoModel]
     - Remark:
        return [TodoModel] to the main function "getDataFromFirebase"
     */
    
    func getRowsFromDictionary(_ snapshot: QuerySnapshot) {
        todoItemRows = []
        var rowDataStructure: TodoItemModel
        for snapshot in snapshot.documents {
            let rowData = snapshot.data()
            rowDataStructure = TodoItemModel(id: rowData[kID] as! String,
                                    item: rowData[kTODOITEMITEM] as! String,
                                    note: rowData[kTODOMEMO] as! String,
                                    todoListRefId: rowData[kTODOLISTREFID] as! String,
                                    isDone: rowData[kTODOISDONE] as! Bool,
                                    createdAt: Date()
                                    )
            self.todoItemRows.append(rowDataStructure)
        }
        
    }
    
    /**
     Convert NSDictionary to Structure
     ===================
     - Parameters:
        - rowData: TodoModel
        - error: Error?
     - Returns
        completion Error?
     - Remark:
        * Convert TodoModel struture to NSDictionary before save to firebase
        * dictionaryFrom(rowData) is the converting TodoModel struture to NSDictionary function
     */
    
    func saveRowDataToFirestore(rowData : TodoItemModel, completion: @escaping (_ error: Error?) -> Void) {
        let withData =  todoItemModel.dictionaryFrom(rowData)
          
        FirebaseReference(.TodoItemList).document(rowData.id).setData(withData) {
            error in
            DispatchQueue.main.async {
                if error != nil {
                    print("error saving order to firestore: ", error!.localizedDescription)
                }
                return
            }

        }
    }
    /**
     Update isDone in the document
     ===================
     - Parameters:
        - objectId: UUID
        - isDone: Bool
     - Returns
        - None
     - Remark:
        when user click checkBox in the todoList screen
     */
    
    func updateCheckedTodoItem(objectId: String, isDone: Bool){
        FirebaseReference(.TodoItemList).document(objectId).updateData(["isDone" : isDone])
    }
    
    /**
     createRecord Function
     ===================
     - Remark:
        Prepare TodoList Structure
     */
    
    func createRecord(_todoListRefId: String,_item: String,_note: String, _isDone: Bool, completion: @escaping (_ response:String, _ error: Error?) -> Void) {

        let rowData = TodoItemModel(id: UUID().uuidString,
                                 item: _item,
                                 note: _note,
                                 todoListRefId: _todoListRefId,
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
    
    /**
     updateRecord Function
     ===================
     - Remark:
        Prepare TodoList Structure
     */
    func updateRecord(_objectId: String,_todoListRefId: String,_item: String,_note: String, _isDone: Bool, completion: @escaping (_ response:String, _ error: Error?) -> Void) {

        let rowData = TodoItemModel(id: _objectId,
                                    item: _item,
                                    note: _note,
                                    todoListRefId: _todoListRefId,
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
    
    /**
     removeRecord Function
     ===================
     - Remark:
        Remove document form Collection
     */
    func removeRecord(objectId: String, completion: @escaping (_ response:String, _ error: Error?) -> Void) {
        FirebaseReference(.TodoItemList).document(objectId).delete() { error in
            if let error = error {
                completion("Error removing document: \(error)",error)
            } else {
                completion("Document successfully removed!",nil)
            }
        }
    }
 
    /**
     emptyStrucValues Function
     ===================
     - Remark:
        Reset TotoList Structure after Create/Update to firebase
     */
    func resetStrucValues(){
        func resetStrucValues(){
            _ = TodoItemModel(id: "", item: "", note: "",  isDone: false, createdAt: Date())
        }
    }
    
}
