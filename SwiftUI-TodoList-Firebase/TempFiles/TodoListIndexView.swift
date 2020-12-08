//
//  TodoListIndexView.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-08.
//
  

import SwiftUI

struct TodoListIndexView: View {
    @StateObject var todoVM = TodoVM()
 
    @State var isUpdateRecord: Bool = false
    @State var isTodoItemList: Bool = false
    @State var selectedRow: TodoModel?
    
    @Binding var selectedTab: CustomTab
    @State var isUpdateCheckBox: Bool = false
     
    var body: some View {
        ZStack {
            VStack {
                HeaderView(isTodoItemList: $isTodoItemList, isUpdateRecord: $isUpdateRecord, selectedRow: $selectedRow)
                 
                /*CustomTabSwitcher(tabs: [.showAll, .showPending,.showDone],
                                  isUpdateRecord: $isUpdateRecord,
                                  isTodoItemList: $isTodoItemList, isUpdateCheckBox: $isUpdateCheckBox
                                )*/
 
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

struct TodoListIndexView_Previews: PreviewProvider {
    static var previews: some View {
        todoListIndex()
    }
}
 

struct TodoListView: View {
    @StateObject var todoVM = TodoVM()
    
    @Binding var isUpdateRecord: Bool
    @Binding var isTodoItemList: Bool
    @Binding var selectedRow: TodoModel?
    @Binding var selectedTab: CustomTab
    
    @State var isUpdateCheckBox: Bool = false
    @Binding var previewRows: [TodoModel]
    
    var body: some View {
        VStack {
           Text("TodoListView")
            List {
                Section {
                    ForEach(previewRows) { rowData in
                        // List Body
                        HStack {
                            TodoListCheckBox(rowData: rowData, isCheckBox: false, isUpdateCheckBox: $isUpdateCheckBox)
                            
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
            
        }
    }
    
  
    func deleteRow(at offsets: IndexSet) {
        let objectId = todoVM.todoListRows[offsets.first!].id
        todoVM.removeRecord(objectId: objectId) { (response, error) in
            //
        }
        todoVM.todoListRows.remove(at: offsets.first!)

    }
}



/*
 Old list
 // Start
 VStack {
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
     .onAppear(){
         todoVM.getDataFromFirebase()
     }
     .onChange(of: isUpdateCheckBox, perform: { value in
         todoVM.getDataFromFirebase()
     })
 }
 
 // End
 

 import SwiftUI

 struct todoListIndex: View {
     @StateObject var todoVM = TodoVM()
  
     @State var isUpdateRecord: Bool = false
     @State var isTodoItemList: Bool = false
     @State var selectedRow: TodoModel?
     
     var body: some View {
         ZStack {
             Color.white
                 
             VStack {
                 HeaderView(isTodoItemList: $isTodoItemList, isUpdateRecord: $isUpdateRecord)
            
                 CustomTabSwitcher(tabs: [.showAll, .showPending,.showDone],
                                   isUpdateRecord: $isUpdateRecord,
                                   isTodoItemList: $isTodoItemList
                                 )
                  
                 Spacer()
             }
              
         }
         .edgesIgnoringSafeArea(.all)
     }

 }

 struct todoListIndex_Previews: PreviewProvider {
     static var previews: some View {
         todoListIndex()
     }
 }

  
 struct TodoListView: View {
     @StateObject var todoVM = TodoVM()
     
     @Binding var isUpdateRecord: Bool
     @Binding var isTodoItemList: Bool
     @State var RowsData: [TodoModel]
     @State var selectedRow: TodoModel?
     
     @State var isUpdateCheckBox: Bool = false
     
     var body: some View {
         ZStack {
             
             List {
                 Section {
                     ForEach(RowsData) { rowData in
                         // List Body
                         HStack {
                             
                             CheckBox(rowData: rowData, isCheckBox: false, isUpdateCheckBox: $isUpdateCheckBox)
                             
                             Text(rowData.title)
                             Spacer()
                             // get Popup detail
                             if (rowData.note != "") {
                                 IconView(imageName: "info.circle", backgroundColor: Color.blue, frameSize: 25) {
                                     
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
     
     
     // MARK: - Helper Function
     func deleteRow(at offsets: IndexSet) {
         let objectId = todoVM.todoListRows[offsets.first!].id
         todoVM.removeRecord(objectId: objectId) { (response, error) in
             //
         }
         todoVM.todoListRows.remove(at: offsets.first!)

     }
 }
 
*/
