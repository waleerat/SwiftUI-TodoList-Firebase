//
//  CustomTabSwitcher.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-08.
//

import SwiftUI

struct CustomTabSwitcher: View {
    @StateObject var todoVM = TodoVM()
    
    @State private var currentTab: CustomTab = .showAll
    
    var tabs: [CustomTab]
    @Binding var isUpdateRecord: Bool
    @Binding var isTodoItemList: Bool
    
    @State var todoListRows: [TodoModel] = []
    @State var pendingRows: [TodoModel] = []
    @State var doneRows: [TodoModel] = []
    
    @State var selectedTab: CustomTab = .showAll
    @State var selectedRow: TodoModel?
    @State var all: CustomTab = .showAll
    @State var pending: CustomTab = .showPending
    @State var done: CustomTab = .showDone
 
    @Binding var isUpdateCheckBox: Bool
  
    
    func widthForTab(_ tab: CustomTab) -> CGFloat {
        let string = tab.rawValue
        
        return string.widthOfString(usingFont: .systemFont(ofSize: 16, weight: .bold))
    }
    
    var body: some View {
        VStack {
            // CUSTOM TAB PICKER
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(tabs, id: \.self) { tab in
                        VStack {
                            Rectangle()
                                .frame(width: widthForTab(tab), height: 6)
                                .foregroundColor(tab == currentTab ? Color.red : Color.clear)
                            
                            Button(action: {
                                // action do something
                                selectedTab = tab
                                
                            }, label: {
                                Text(tab.rawValue)
                                    .font(.system(size: 16, weight: .bold ))
                                    .foregroundColor(tab == currentTab ? Color.blue : Color.gray)
                            })
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: widthForTab(tab), height: 30)
                            
                        }
                    }
                }
            }
            .padding(.horizontal,10)
           
            // SELECTED VIEW
            switch selectedTab {
            case .showAll:
                TodoListView(isUpdateRecord: $isUpdateRecord, isTodoItemList: $isTodoItemList, selectedRow: $selectedRow, selectedTab: $selectedTab, previewRows: $todoVM.todoListRows)
            case .showPending:
                TodoListView(isUpdateRecord: $isUpdateRecord, isTodoItemList: $isTodoItemList, selectedRow: $selectedRow, selectedTab: $selectedTab, previewRows: $todoVM.pendingRows)
            case .showDone:
                TodoListView(isUpdateRecord: $isUpdateRecord, isTodoItemList: $isTodoItemList, selectedRow: $selectedRow, selectedTab: $selectedTab, previewRows: $todoVM.doneRows)
            }
        }
        
        .onChange(of: isUpdateCheckBox, perform: { value in
            //todoVM.getDataFromFirebase()
        })
        .onAppear(){
            todoVM.getDataFromFirebase()
        }
       
    }
}


struct CustomTabSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            CustomTabSwitcher(tabs: [.showAll, .showPending,.showDone], isUpdateRecord: .constant(false), isTodoItemList: .constant(false), isUpdateCheckBox: .constant(false))
            
        }
        
    }
}
