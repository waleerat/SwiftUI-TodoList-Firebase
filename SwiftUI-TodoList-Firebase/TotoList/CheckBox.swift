//
//  CheckBox.swift
//  SwiftUI-todoList
//
//  Created by Waleerat Gottlieb on 2020-12-04.
//

import SwiftUI

struct CheckBox: View {
    @StateObject var todoVM = TodoVM()
    
    @State var todoItem = TodoModel()
    @State var isCheckBox:Bool = false
    
    var body: some View {
        HStack {
            Button(action: {
                isCheckBox.toggle()
                todoItem.isDone = isCheckBox
                todoVM.updateCheckedTodoList(objectId: todoItem.id, isDone: isCheckBox)
                //todoVM.updateCheckedTodoList(isDone: isCheckBox)
            }, label: {
                Image(systemName: isCheckBox ?  "checkmark.square":"square")
                    .resizable()
                    .frame(width: 25, height: 25)
            })
            .frame(width: 30, height: 30) 
        }
        .onAppear {
            isCheckBox = todoItem.isDone
        }
    }
    
    
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox()
    }
}
