//
//  todoItemVM.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-07.
//

import Foundation

class TodoItemsVM: ObservableObject {
    @Published var todoItemRows: [TodoItemModel] = []
    var todoModel = TodoItemModel() 
     
    
}
