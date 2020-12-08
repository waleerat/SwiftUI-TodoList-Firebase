//
//  HeaderView.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-08.
//

import SwiftUI

struct HeaderView: View {
    @Binding var isTodoItemList: Bool
    @Binding var isUpdateRecord: Bool
    @Binding var selectedRow: TodoModel?
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("My to do list").font(.title2)
                Spacer()
                if !isTodoItemList {
                    IconView(imageName: "plus.circle.fill", backgroundColor: Color.white) {
                        selectedRow = TodoModel()
                        isUpdateRecord.toggle()
                    }
                } else {
                    IconView(imageName: "house.fill", backgroundColor: Color.white) {
                        selectedRow = TodoModel()
                        isTodoItemList.toggle()
                    }
                }
            }
        }
        .padding()
        .frame(height:80)
        .padding(.top, 30)
        .background( Color.blue)
        .foregroundColor(.white)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(isTodoItemList: .constant(false), isUpdateRecord: .constant(false), selectedRow: .constant(TodoModel()))
    }
}


/*
 if isTodoItemList {
     if let row = selectedRow {
         HStack {
             Text("List to : \(row.title)").font(.title2)
             Spacer()
             Button(action: {
                 //selectedRow = TodoModel()
                 //isUpdateRecord.toggle()
             }, label: {
                 Image(systemName: "plus.circle.fill")
                     .resizable()
                     .frame(width: 35, height: 35)
                     .foregroundColor(.pink)
                     .imageScale(.large)
             })
         }
     }
 }
 */
