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
    @State var item: String = ""
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
                                    Text((selectedRow?.id == "") ? "Add Item" : "Update Item")
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
                                    
                                    Text("Todo item")
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
                                    .background(item == "" ? Color.blue.opacity(0.7) : Color.blue)
                                    .clipShape(Capsule())
                                    .padding(.top, 45)
                                    .disabled(item == "")
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
                        item = row.item
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
        if (selectedRow == nil) {
            doCreateRecord()
        } else {
            doUpdateRecord()
        }
        todoVM.emptyStrucValues()
        self.isUpdateRecord = false
    }
    
    func doCreateRecord(){
        self.todoVM.createRecord(_item: item,
                               _note: note,
                               _imageURL: "",
                               _isDone: isDone
                                ) { (response, error) in
            
            DispatchQueue.main.async {
                print("DispatchQueue.main.async")
            }
        }
    }
    
    func doUpdateRecord(){
        self.todoVM.updateRecord(_objectId: objectId ?? UUID().uuidString,
                               _item: item,
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

/*
 import SwiftUI
 import KingfisherSwiftUI

 struct ProductForm: View {
     @Environment(\.presentationMode) var presentationMode
     @EnvironmentObject var productListener: ProductListener
     
     @Binding var productData: Product?
     @Binding var isUpdateRecord: Bool
     
     @State private var image: SwiftUI.Image?
     @State private var imageSeleted: UIImage?
     @State private var filterIntensity = 0.5
     @State private var showingImagePicker = false
     @State private var inputImage: UIImage?
     
     @State var name: String = ""

     @State var price: String = ""
     @State var isActive: Bool = true
     @State var uploadImage: String = kDEFAULEUPLOADIMAGE
     
     @State var IsPopupInfo: Bool = false
     @State var popupInfo: PopupInfo
     @State var imageURL: String = ""
     
     var loadParent = {}
     
     var body: some View {
         
         return ZStack {
             Color.init("myBackground")
             VStack {
                 // Start Form
                 ScrollView {
                     VStack (spacing: 50) {
             
                         ZStack {
                             if image != nil {
                                 image?
                                     .resizable()
                                     .scaledToFit()
                                     .frame(width: screen.width * 0.9)
                             } else {
                                 if imageURL != "" {
                                     KFImage(URL(string: imageURL)!)
                                         .resizable()
                                         .scaledToFit()
                                         .frame(width: screen.width * 0.5)
                                         .onTapGesture {
                                             self.showingImagePicker = true
                                         }
                                     
                                 } else {
                                     Image(uploadImage)
                                         .resizable()
                                         .scaledToFit()
                                         .frame(width: screen.width * 0.5)
                                         .onTapGesture {
                                             self.showingImagePicker = true
                                         }
                                 }
                                 
                             }
                             
                              
                         }
                         .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                             ImagePicker(image: self.$inputImage, imageSeleted: $imageSeleted)
                         }
                         
                         VStack (alignment: .leading){
                             Text("Product Name")
                                 .font(.headline)
                                 .fontWeight(.light)
                                 .foregroundColor(Color.init(.label))
                                 .opacity(0.75)
                             TextField("Requied", text: $name)
                                 .padding(10)
                                 .background(Color.gray.opacity(0.3))
                                 .cornerRadius(7)
                             
                             HStack {
                                 Text("Price")
                                     .font(.headline)
                                     .fontWeight(.light)
                                     .foregroundColor(Color.init(.label))
                                     .opacity(0.75)
                                 TextField("0.0", text: $price)
                                     .padding(10)
                                     .background(Color.gray.opacity(0.3))
                                     .cornerRadius(7)
                                     .keyboardType(.numberPad)
                                 
                                 
                                 Toggle(isOn: $isActive) {
                                     Text("Active")
                                 }.padding()

                             }
                             
                             
                         }
                         
                         Button(action: {
                             saveDataToFirebase()
                             self.loadParent()
                         }, label: {
                             Text("Save")
                                 .foregroundColor(.white)
                                 .frame(width: screen.width - 120)
                                 .padding()
                                 .padding(.horizontal)
                         })
                         .background((name == "" || price == "") ? Color.gray : Color.blue)
                         .clipShape(Capsule())
                         .padding(.top, 45)
                         .disabled((name == "" || price == ""))
                         
                     }.padding()
                 } // End ScrollView
                 // End Form
             }
             
             
             if IsPopupInfo {

                 Text("Wait a minute")
                 .fullScreenCover(isPresented: .constant(true), content: {
                     // for navigation
 //                    ProductIndexView() {
 //                        isUpdateRecord = false
 //                        //self.loadParent()
 //                        self.presentationMode.wrappedValue.dismiss()
 //                    }
                     // For Buttom bar menu
                     HomeView().tag(1)
                 })
                  
                 
             }
             
         }
         .onAppear {
             if (isUpdateRecord) {
                 if let productData = productData {
                     name = productData.name ?? ""
                     price = String(productData.price ?? 0.0)
                     imageURL = productData.imageURL ?? ""
                     isActive = productData.isActive ?? true
                 }
             }
         }
         
         // End of ZStack
     }
     
     // MARK: - Helper Functions
     func loadImage() {
         guard let inputImage = inputImage else { return }
         image = Image(uiImage: inputImage)
     }
     
     private func uploadImage(_ image: UIImage, completion: @escaping (_ imageURL: String?)-> Void) {
         //let fileDirectory = "Avatars/_" + FUser.currentId() + ".jpg"
        
         let fileName = UUID().uuidString
         let fileDirectory = "Category/" + fileName + ".jpg"
         
         FileStorage.uploadImage(image, directory: fileDirectory) { (imageURL) in
             FileStorage.saveImageLocally(imageData: image.jpegData(compressionQuality: 0.8)! as NSData, fileName: fileName)
             completion(imageURL)
         }
     
     }
     
     
     func saveDataToFirebase(){
         if let inputImage = self.inputImage {
             uploadImage(inputImage) { (uploadedImageURL) in
                 let imageURL = uploadedImageURL ?? ""
                 DispatchQueue.main.async {
                     if (productData == nil) {
                         doCreateRecord(imageURL: imageURL)
                     } else {
                         print(">> Respons URL : \(imageURL)")
                         doUpdateRecord(imageURL: imageURL)
                     }
                 }
             }
         } else {
             if (productData == nil) {
                 doCreateRecord(imageURL: "")
             } else {
                 doUpdateRecord(imageURL: productData?.imageURL ?? "")
             }
         }
         
     }
     
     func doUpdateRecord(imageURL: String){
      
         ProductCMS().updateRecord(_objectId: productData?.id ?? "", _name: self.name, _price: Double(self.price) ?? 0.0, _imageURL: imageURL,  _isActive: self.isActive) { (infoType, message)  in
             self.IsPopupInfo = true
             
         }
     }
     
     func doCreateRecord(imageURL: String){
         ProductCMS().createRecord(_name: self.name, _price: Double(self.price) ?? 0.0, _imageURL: imageURL,  _isActive: self.isActive) { (infoType, message)  in
                 // reset form and popup Info
             self.IsPopupInfo = true
             self.name = ""
             self.price = ""
             self.image = nil
             self.inputImage = nil
         }
     }
     
  
 }


 //NOT ACTIVE JUST FOR DEBUGING
 //struct ProductForm_Previews: PreviewProvider {
 //    static var previews: some View {
 //        ProductForm(productData: .constant(nil), popupInfo: PopupInfo())
 //    }
 //}


 /*
  //PopUpInfoView(isUpdateRecord: $isUpdateRecord, IsPopupInfo: $IsPopupInfo, popupInfoType: popupInfo.popupType, popupInfoTitle: popupInfo.title, popupInfoDescription: popupInfo.description)
  
  self.popupInfo.newValue(popupType: infoType ?? .Information, title: "Update Category", description: message!)
  */

 
 */
