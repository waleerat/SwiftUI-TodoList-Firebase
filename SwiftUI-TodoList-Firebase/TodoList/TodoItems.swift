//
//  TodoItemsView.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-07.
//

import SwiftUI

struct TodoItems: View {
    @Binding var isTodoItemList: Bool
    @Binding var selectedRow: TodoModel?
    
    @State var isUpdateRecord: Bool = false
    
    @State var selectedObjectId: String = "9F159285-F92E-460A-8953-440AAEF799F0"
    @State var title: String = ""
    
    @State var newTodoItem: String = ""
    
    var body: some View {
        
        return ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                HeaderView(isTodoItemList: $isTodoItemList, isUpdateRecord: $isUpdateRecord, selectedRow: $selectedRow)
                
              //  Text("Here is \(title)")
                
                VStack {
                    HStack {
                        TextField("New Item", text: self.$newTodoItem)
                        
                        IconView(imageName: "plus.circle.fill", backgroundColor: Color.green, frameSize: 25) {
                            self.newTodoItem = ""
                        }
                         
                    }
                    
                    ButtonView(text: "Close",
                               frameWidth: screen.width * 0.5) {
                        selectedRow = nil
                        isTodoItemList = false
                    }
                     
                    
                } .padding()
                
                

                Spacer()
            }
            
            .onAppear(){
                if let row = selectedRow {
                    title = row.title
                }
                //selectedRow = TodoModel(id: "9F159285-F92E-460A-8953-440AAEF799F0", title: "Dummy TodoList", note: "Just test", imageURL: "", isDone: false, todoItems: [], createdByUser: "", createdAt: Date(), updateAt: Date())
            }
        }
    }
        
}

struct TodoItems_Previews: PreviewProvider {
    static var previews: some View {
        TodoItems(isTodoItemList: .constant(false), selectedRow: .constant(TodoModel()))
    }
}


/*
ZStack {
    Color.white
        .edgesIgnoringSafeArea(.all)
    HStack {
        Text("My Item").font(.title2)
        Spacer()
        Button(action: {
            isTodoItemList.toggle()
        }, label: {
            Image(systemName: "minus")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(.green)
                .imageScale(.large)
        })
    }
    Spacer()
}
.padding()
.frame(height:80)
.padding(.top, 30)
.background(Color.blue)
.foregroundColor(.white)
.onAppear() {
    guard let _ = selectedRow else {
        isTodoItemList.toggle()
        return
    }
    
}
}*/
