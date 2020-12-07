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
    @State var selectedRow: TodoModel?
    
    var body: some View {
        ZStack {
            
            VStack {
                HeaderView(isUpdateRecord: $isUpdateRecord, selectedRow: $selectedRow)
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
                                LazyHStack {
                                    CheckBox(rowData: rowData, isCheckBox: false)
                                   
                                    Text(rowData.title)
                                    // get Popup detail
                                    if (rowData.note != "") {
                                        Button(action: {
                                            
                                        }, label: {
                                            Image(systemName: "info.circle")
                                                .resizable()
                                                .frame(width:25, height: 25)
                                        })
                                    }
                                    Spacer()
                                    // Edit Button
//                                    Button(action: {
//                                        self.isUpdateRecord.toggle()
//                                        selectedRow = rowData
//                                    }, label: {
//                                        Image(systemName: "pencil.circle")
//                                            .resizable()
//                                            .frame(width: 35, height: 35, alignment: .center)
//
//                                    })
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

struct HeaderView: View {
    @Binding var isUpdateRecord: Bool
    @Binding var selectedRow: TodoModel?
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("My to do list").font(.title2)
                Spacer()
                Button(action: {
                    selectedRow = TodoModel()
                    isUpdateRecord.toggle()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.green)
                        .imageScale(.large)
                })
            }
        }
        .padding()
        .frame(height:80)
        .padding(.top, 30)
        .background(Color.blue)
        .foregroundColor(.white)
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
