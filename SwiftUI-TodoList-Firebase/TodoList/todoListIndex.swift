//
//  todoListIndex.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-04.
//

import SwiftUI

struct todoListIndex: View {
    @StateObject var todoVM = TodoVM()
    
    @State private var newTodoItem = ""
    @State var isUpdateRecord: Bool = false
    @State var isTodoItemList: Bool = false
    @State var selectedRow: TodoModel?
    
    @State var isUpdateCheckBox: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView(isTodoItemList: $isTodoItemList, isUpdateRecord: $isUpdateRecord, selectedRow: $selectedRow)
                // End of What's Next? Section
                VStack {
                    HStack {
                        Text("What's to do? ").font(.headline)
                        Spacer()
                    }.padding()
                    // Start Body
                    List {
                        Section {
                            ForEach(todoVM.todoListRows) { rowData in
                                // List Body
                                HStack {
                                    
                                    CheckBox(rowData: rowData, isCheckBox: false, isUpdateCheckBox: $isUpdateCheckBox)
                                   
                                    Text(rowData.title)
                                    Spacer()
                                    // get Popup detail
                                    if (rowData.note != "") {
                                        IconView(imageName: "info.circle", backgroundColor: Color.blue, frameSize: 25) {
                                             //*Need Preview Info
                                        } 
                                    }
                                    
                                    // Add todo list Button
                                    IconView(imageName: "list.dash", backgroundColor: Color.blue, frameSize: 25) {
                                        isTodoItemList = true
                                        selectedRow = rowData
                                    }
                                }
                                
                                .onLongPressGesture {
                                    self.isUpdateRecord.toggle()
                                    selectedRow = rowData
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
                        todoVM.getDataFromFirebase()
                    })
                    .navigationBarTitle("All Records")
                   // .listStyle(GroupedListStyle())
                  
                }
                .onAppear {
                    todoVM.getDataFromFirebase()
                }
               
                Spacer()
 
            }
            
            VStack {
                if (isUpdateRecord) {
                    TodoListForm(isUpdateRecord: $isUpdateRecord, selectedRow: $selectedRow ) {
                        todoVM.getDataFromFirebase()
                        
                    }
                }
                
                if isTodoItemList {
                    TodoItems(isTodoItemList: $isTodoItemList, selectedRow: $selectedRow)
                }
            }
             
        }
        .edgesIgnoringSafeArea(.all)
        // End of NavigationView
    }
    
    // MARK: - Helper Function
    func deleteRow(at offsets: IndexSet) {
        let objectId = todoVM.todoListRows[offsets.first!].id
        todoVM.removeRecord(objectId: objectId) { (response, error) in
            //
        }
        todoVM.todoListRows.remove(at: offsets.first!)

    }
    
     
    
}

struct todoListIndex_Previews: PreviewProvider {
    static var previews: some View {
        todoListIndex()
    }
}






// Delete Button
//                                    Button(action: {
//                                        print("Delete Button")
//                                    }, label: {
//                                        Image(systemName: "trash.circle")
//                                            .resizable()
//                                            .frame(width: 35, height: 35, alignment: .center)
//                                    })
