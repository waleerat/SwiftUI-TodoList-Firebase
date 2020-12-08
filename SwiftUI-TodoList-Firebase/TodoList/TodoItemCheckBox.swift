//
//  TodoItemCheckBox.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-08.
//

import SwiftUI

import SwiftUI

struct TodoItemCheckBox: View {
    @StateObject var todoItemsVM = TodoItemsVM()
    
    @State var rowData = TodoItemModel()
    @State var isCheckBox: Bool = false
    @Binding var isUpdateCheckBox: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                isCheckBox.toggle()
                isUpdateCheckBox.toggle()
                rowData.isDone = isCheckBox
                todoItemsVM.updateCheckedTodoItem(objectId: rowData.id, isDone: isCheckBox)
                
            }, label: {
                Image(systemName: isCheckBox ?  "checkmark.square":"square")
                    .resizable()
                    .frame(width: 25, height: 25)
            })
            .frame(width: 30, height: 30)
        }
        .onAppear {
            isCheckBox = rowData.isDone
        }
    }
    
    
}

struct TodoItemCheckBox_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemCheckBox(isUpdateCheckBox: .constant(false))
    }
}
