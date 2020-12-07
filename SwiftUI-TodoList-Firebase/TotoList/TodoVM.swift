//
//  TodoVM.swift
//  SwiftUI-todoList
//
//  Created by Waleerat Gottlieb on 2020-12-04.
//

import Foundation
import Firebase


/**
 Functions for TodoList View
 ===================
 - Author: Waleerat Gottlieb
 - Remark:
    * Before you read this code please check :
        ** TodoModel.swift : Structure design
        ** FirebaseReference.swift : define collection
        ** Constant.swift : filds in document
 
 
     * func getDataFromFirebase : get all documents form firebase
     * func getRowsFromDictionary : help function of getDataFromFirebase
     * func saveRowDataToFirestore : Save document to firebase
     * func updateCheckedTodoList : update only idDone field
     * func createRecord : create new document
     * func updateRecord : update document
     * func removeRecord : remove document
     * func resetStrucValues : reset value in TodoListModel
   
 
 */
class TodoVM: ObservableObject {
    @Published var todoListRows: [TodoModel] = []
    var todoModel = TodoModel()
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
    
    /**
     Convert NSDictionary to Structure
     ===================
     - Parameters  QuerySnapshot
     - Returns
        [TodoModel]
     - Remark:
        return [TodoModel] to the main function "getDataFromFirebase"
     */
    
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
    
    func updateCheckedTodoList(objectId: String, isDone: Bool){
        FirebaseReference(.TodoList).document(objectId).updateData(["isDone" : isDone])
    }
    
    /**
     createRecord Function
     ===================
     - Remark:
        Prepare TodoList Structure
     */
    
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
    
    /**
     updateRecord Function
     ===================
     - Remark:
        Prepare TodoList Structure
     */
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
    
    /**
     removeRecord Function
     ===================
     - Remark:
        Remove document form Collection
     */
    func removeRecord(objectId: String, completion: @escaping (_ response:String, _ error: Error?) -> Void) {
        FirebaseReference(.TodoList).document(objectId).delete() { error in
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
        _ = TodoModel(id: "", title: "", note: "", imageURL: "", isDone: false, createdAt: Date())
    }
    
}
