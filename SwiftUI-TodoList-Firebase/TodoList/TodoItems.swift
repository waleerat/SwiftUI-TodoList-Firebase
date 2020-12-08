//
//  TodoItemsView.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-07.
//

import SwiftUI

struct TodoItems: View {
    @StateObject var todoItemsVM = TodoItemsVM()
    
    @Binding var isTodoItemList: Bool
    @Binding var selectedRow: TodoModel?
    //@State var isUpdateRecord: Bool = false
    
    @State var createdByUserName: String = ""
    @State var progressStatus: String = "No"
    @State var newTodoItem: String = ""
    
    @State var todoItems: [TodoItemModel] = []
    @State var isUpdateCheckBox: Bool = false
    // Popup Values
    @State var isUpdateItemRecord: Bool = false
    @State var selectedItemRow: TodoItemModel?
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                HeaderView(isTodoItemList: $isTodoItemList, isUpdateRecord: $isUpdateItemRecord, selectedRow: $selectedRow)
                VStack{
                    HStack {
                        Text("Todo : \(selectedRow?.title ?? "Unknown")")
                        Spacer()
                    }
                    HStack(alignment: .center, spacing: 10) {
                        Text("Create By  : \(createdByUserName)")
                        Spacer()
                        Text("Done ?  : \(progressStatus)")
                    }
                    
                    HStack {
                        Spacer()
                        IconView(imageName: "plus.circle.fill", backgroundColor: Color.green, frameSize: 25) {
                            isUpdateItemRecord.toggle()
                            selectedItemRow = TodoItemModel()
                        }
                    }
                }.padding() 
                
                VStack {
                    // Start Body
                    List {
                        Section {
                            ForEach(todoItemsVM.todoItemRows) { rowData in
                                // List Body
                                HStack {
                                    TodoItemCheckBox(rowData: rowData, isCheckBox: false, isUpdateCheckBox: $isUpdateCheckBox)
                                    
                                    Text(rowData.item)
                                    Spacer()
                                    /*
                                    // get Popup detail
                                    if (rowData.note != "") {
                                        IconView(imageName: "info.circle", backgroundColor: Color.blue, frameSize: 25) {
                                             
                                        }
                                    }
                                    
                                    // Add todo list Button
                                    
                                    IconView(imageName: "camera", backgroundColor: Color.blue, frameSize: 25) {
                                        
                                    }*/
                                }
                                .onLongPressGesture {
                                    self.isUpdateItemRecord.toggle()
                                    selectedItemRow = rowData
                                }
                                .buttonStyle(PlainButtonStyle())
                                // End List Body
                                
                            }//End of ForEach
                            
                            .onDelete { (indexSet) in
                                self.deleteRow(at: indexSet)
                            }
                        }
                        .frame(height: 60)
                        
                    }
                    .onChange(of: isUpdateCheckBox, perform: { value in
                        todoItemsVM.getDataFromFirebase(todoListRefId: selectedRow?.id ?? "")
                    })
                    // End Body
                    
                } .padding()

                Spacer()
            }
            .sheet(isPresented: $isUpdateItemRecord, content: {
                TodoItemForm(isUpdateItemRecord: $isUpdateItemRecord , selectedRow: $selectedRow, todoItems: $todoItems, selectedItemRow: $selectedItemRow) {
                    todoItemsVM.getDataFromFirebase(todoListRefId: selectedRow?.id ?? "")
                }
            })
            
            .onAppear(){
                if let row = selectedRow {
                    todoItemsVM.getDataFromFirebase(todoListRefId: row.id)
                    progressStatus = row.isDone ? "Yes" : "No"
                    createdByUserName = "Lee"  //*Need to get username
                }
            }
        }
    }
    
    // MARK: - Helper Function
    func deleteRow(at offsets: IndexSet) {
        let objectId = todoItemsVM.todoItemRows[offsets.first!].id
         todoItemsVM.removeRecord(objectId: objectId) { (response, error) in
            //
        }
        todoItemsVM.todoItemRows.remove(at: offsets.first!)
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
