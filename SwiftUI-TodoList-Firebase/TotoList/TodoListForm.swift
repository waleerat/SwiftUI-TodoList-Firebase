//
//  TodoListForm.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-04.
//

import SwiftUI
 

struct TodoListForm: View {
    
    var todoVM = TodoVM()
    
    @Binding var isUpdateRecord: Bool
    @Binding var selectedRow: TodoModel?
    
    @State var objectId: String!
    @State var title: String = ""
    @State var note: String = ""
    @State var imageURL: String = ""
    @State var isDone: Bool = false
    
    var loadParent = {}

    var body: some View {
         ZStack {
            Group {
                Color.gray.opacity(0.6)
                            VStack {
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        self.isUpdateRecord.toggle()
                                    }, label: {
                                        Image(systemName: "xmark.circle")
                                            .font(.system(size: 30))
                                    })
                                }
                                .padding(.horizontal, 10)
                                .foregroundColor(.blue)
                                .padding()
                                
                                VStack {
                                    Text((selectedRow?.id == "") ? "Add Todo" : "Update Todo")
                                        .font(.title)
                                        .bold()
                                        .padding(.top, -50)
                                }
                                Spacer()
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
                                    TextField("Requied", text: $title)
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
                            Spacer()
                                HStack(spacing: 5) {
                                    Button(action: {
                                        isUpdateRecord = false
                                    }, label: {
                                        Text("Cancel")
                                            .foregroundColor(.white)
                                            .frame(width:100)
                                            .padding()
                                            .padding(.horizontal)
                                    })
                                    .background(Color.gray)
                                    .clipShape(Capsule())
                                    .padding(.top, 45)
                                     
                                    
                                    
                                    Button(action: {
                                        saveDataToFirebase()
                                        self.loadParent()
                                    }, label: {
                                        Text((selectedRow == nil) ? "Save" : "Update")
                                            .foregroundColor(.white)
                                            .frame(width:100)
                                            .padding()
                                            .padding(.horizontal)
                                    })
                                    .background(title == "" ? Color.blue.opacity(0.7) : Color.blue)
                                    .clipShape(Capsule())
                                    .padding(.top, 45)
                                    .disabled(title == "")
                                }
                                .padding(.bottom, 40)
                                
                            Spacer()
                            }
                            .foregroundColor(.primary)
                        
                            .frame(width: screen.width * 0.95, height: screen.height * 0.7)
                            .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            .onAppear { 
                if (isUpdateRecord) {
                    if let row = selectedRow {
                        objectId = row.id
                        title = row.title
                        note = row.note
                        imageURL = row.imageURL
                        isDone = row.isDone
                    }
                }
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    
    // MARK: - Helper Functions
    func saveDataToFirebase(){
        
        if let _ = selectedRow {
            doCreateRecord()
        } else {
            doUpdateRecord()
        }
        todoVM.resetStrucValues()
        self.isUpdateRecord = false
    }
    
    func doCreateRecord(){
      
        self.todoVM.createRecord(_title: title,
                               _note: note,
                               _imageURL: "",
                               _isDone: isDone
                                ) { (response, error) in
            
            
        }
    }
    
    func doUpdateRecord(){
        self.todoVM.updateRecord(_objectId: objectId ?? UUID().uuidString,
                               _title: title,
                               _note: note,
                               _imageURL: "",
                               _isDone: isDone
                                ) { (response, error) in
            

        }
    }
    

}

struct TodoListForm_Previews: PreviewProvider {
    static var previews: some View {
        TodoListForm(isUpdateRecord: .constant(false), selectedRow: .constant(nil))
    }
}
