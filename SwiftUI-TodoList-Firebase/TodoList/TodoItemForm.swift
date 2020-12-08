//
//  TodoItemForm.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-08.
//

import SwiftUI

struct TodoItemForm: View {
    @StateObject var todoItemsVM = TodoItemsVM()
    
    @Binding var isUpdateItemRecord: Bool
    @Binding var selectedRow: TodoModel?
    @Binding var todoItems: [TodoItemModel]
    
    @Binding var selectedItemRow: TodoItemModel?
    @State var todoListRefId: String = ""
    @State var objectId: String!
    @State var item: String = ""
    @State var note: String = ""
    @State var isDone: Bool = false
    
    var loadParent = {}
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                IconView(imageName: "xmark.circle", backgroundColor: Color.blue, frameSize: 25) {
                    self.isUpdateItemRecord.toggle()
                }
            }
            .padding(.horizontal, 10)
            .foregroundColor(.blue)
            .padding()
           
            VStack {
                Text(objectId == "" ? "Add Todo Item" : "Update Todo Item")
                    .font(.title)
                    .bold()
                    .padding(.top, -50)
                
                Text("\(selectedRow?.title ?? "Unknown")")
                    .font(.title3)
                    .bold()
                    .padding()
                
            }
           
            // Start Form
            VStack (alignment: .leading){
                HStack {
                    Spacer()
                    Toggle(isOn: $isDone) {
                            Text("Done")
                        }
                    .frame(width:120)
                }
                
                Text("Todo Title")
                    .font(.headline)
                    .fontWeight(.light)
                    .opacity(0.75)
                TextField("Requied", text: $item)
                    .padding(10)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(7)
                Text("Note")
                    .font(.headline)
                    .fontWeight(.light)
                    .opacity(0.75)
                TextEditor(text: $note)
                    .border(Color.black)
                    .frame(height: 100)

            }.padding()
            .foregroundColor(Color.black)
            // End Form
        
            HStack(spacing: 5) {
                ButtonView(
                    text: "Cancel",backgroundColor: .gray, frameWidth: screen.width * 0.4) {
                    isUpdateItemRecord = false
                }
                
                ButtonView(
                    text: (selectedItemRow == nil) ? "Save" : "Update",
                    backgroundColor: item == "" ? Color.blue.opacity(0.7) : Color.blue,
                    frameWidth: screen.width * 0.4) {
                    saveDataToFirebase()
                    self.loadParent()
                }
                .disabled(item == "")
            }
            .padding(.bottom, 40)
            
        Spacer()
        }
        .onAppear(){
            if (isUpdateItemRecord) {
                if let row = selectedItemRow {
                    objectId = row.id
                    item = row.item
                    note = row.note
                    isDone = row.isDone
                }
            }
 
            if let row = selectedRow {
                todoListRefId = row.id
            } else {
                isUpdateItemRecord = false
            }
 
        }
        .foregroundColor(.primary)
        .frame(width: screen.width * 0.95, height: screen.height * 0.85)
//        .background(Color.white)
//        .cornerRadius(10)
//        .shadow(radius: 10)
    }
    
    // MARK: - Helper Functions
    func saveDataToFirebase(){
        
        if objectId == "" {
            doCreateRecord()
        } else {
            doUpdateRecord()
        }
        todoItemsVM.resetStrucValues()
        self.isUpdateItemRecord = false
        
//        todoItems.append(
//            TodoItemModel(id: UUID().uuidString,
//                          item: newTodoItem
//            )
//        )
    }
    
    func doCreateRecord(){
        let newTodoItem = TodoItemModel(id: UUID().uuidString,
                                        item: item,
                                        note: note,
                                        isDone: isDone,
                                        createdAt: Date(),
                                        updateAt: Date()
                                    )
        todoItems.append(newTodoItem)
      
        self.todoItemsVM.createRecord(_todoListRefId: todoListRefId,
                                      _item: item,
                                       _note: note, 
                                       _isDone: isDone
                                ) { (response, error) in
            //
        }
    }
    
    func doUpdateRecord(){
        self.todoItemsVM.updateRecord(_objectId: objectId,
                                      _todoListRefId: todoListRefId,
                                       _item: item,
                                       _note: note,
                                       _isDone: isDone
                                ) { (response, error) in
                //

        }
    }
    
}

struct TodoItemForm_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemForm(isUpdateItemRecord: .constant(false), selectedRow: .constant(TodoModel()), todoItems: .constant([]), selectedItemRow: .constant(TodoItemModel()))
    }
}
