//
//  SignupView.swift
//  ShopToday
//
//  Created by Waleerat Gottlieb on 2020-11-30.
//

import SwiftUI

struct SignupView: View {
     
    @Binding var IsPopSignupView: Bool
    
    @State var infoDescription: String = ""
    @State var isShowInfo: Bool = false
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            Group {
                
                ScrollView {
                    VStack {
                        // Signup form
                       SignupForm(IsPopSignupView: $IsPopSignupView, infoDescription: $infoDescription, isShowInfo: $isShowInfo)
                    }
                    .foregroundColor(.primary)
                    .padding()
                    .padding(.bottom, 20)
                }
                
            }
            
            if (isShowInfo) {
                ShowInfoView(infoDescription: $infoDescription, isShowInfo: $isShowInfo, IsPopSignupView: $IsPopSignupView)
            }
        }
    }
     
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(IsPopSignupView: .constant(false))
    }
}

struct SignupForm: View {
    @StateObject var userVM = UserVM()
   
    @State var email = "waleerat.sang@gmail.com"
    @State var password = ""
    @State var repeatPassword = ""
    @State var isValidate: Bool = false
    
    @Binding var IsPopSignupView: Bool
    @Binding var infoDescription: String
    @Binding var isShowInfo: Bool
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Sign Up")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding([.bottom, .top], 20)
                
                VStack(alignment: .leading) {
                    
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    TextField("Enter your email", text: $email)
                    Divider()
                    
                    Text("Password")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(
                            (password != "" && (password  != repeatPassword)) ? Color.red :   Color.init(.label)
                            )
                        .opacity(0.75)
                    
                    SecureField("Enter your password", text: $password)
                    Divider()
                    
                    Text("Repeat Password")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(
                            (repeatPassword != "" && (password  != repeatPassword)) ? Color.red :   Color.init(.label)
                            )
                        .opacity(0.75)
                    
                    SecureField("Repeat password", text: $repeatPassword)
                    Divider()

                }
                .padding(.bottom, 15)
                .animation(.easeOut(duration: 0.1))
     
                //Sign in Button
                Button(action: {
                    signUpUser()
                }, label: {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 120)
                        .padding()
                })
                .disabled((email == "" || (password == "" && repeatPassword == "") || (password  != repeatPassword)))
                .background((email == "" || (password == "" && repeatPassword == "") || (password  != repeatPassword)) ? Color.gray : Color.blue)
                
                .background(Color.blue)
                .clipShape(Capsule())
                .padding(.top, 45) 
                
                Spacer()
                
                HStack(spacing: 8) {
                    Text("Already have account?")
                        .foregroundColor(Color.gray.opacity(0.8))
                        
                    Button(action: {
                         self.IsPopSignupView.toggle()
                    }, label: {
                        Text("Sign In")
                    })
                    .foregroundColor(.blue)
                }
            }
        } // end of ZStack
    }
    
    private func signUpUser() {
        
        if email != "" && password != "" && repeatPassword != "" {
            if password == repeatPassword { 
                UserVM.registerUserWith(email: email, password: password) { (error) in
                    
                    if let error = error {
                        self.isShowInfo = true
                        self.infoDescription = error.localizedDescription
                        return
                    }
                    
                    if kISVERIFYEMAIL {
                        // need to verify email
                        self.isShowInfo = true
                        self.infoDescription = "Verification email was send, Please check your inbox."
                        print(infoDescription)
                    } else {
                       // Login
                        UserVM.loginUserWith(email: email, password: password) { (error, isEmailVerified) in
                            if let error = error {
                                self.isShowInfo = true
                                self.infoDescription = error.localizedDescription
                                return
                            }else {
                                
                            }
                        }
                    }
                     
                }
            } else {
                self.isShowInfo = true
                self.infoDescription = "passwords dont match."
                print(infoDescription)
            }
            
            
        } else {
            self.isShowInfo = true
            self.infoDescription = "Check your email to verify."
        }
        
    }
}



//How can we manage Movies with Episods
 // Struct --
 struct Movie: Identifiable {
   var id: String
   var name: String
   var moreLikeThisMovies: [Movie]
   var episodes: [Episode]?
 }
 struct Episode: Identifiable {
   var id = UUID().uuidString
   var name: String
   var season: Int
   var episodeNumber: Int
   var thumbnailImageURLString: String
   var description: String
 }
 // Prepare Data --
let episode1 = Episode(name: "Beginnings and Endings",season: 1,episodeNumber: 1,thumbnailImageURLString: "ImageURL",description: "Description 1")
let episode2 = Episode(name: "Beginnings and Endings",season: 1,episodeNumber: 1,thumbnailImageURLString: "ImageURL",description: "Description 2")
 
let movie1 = Movie(id: "id2", name: "Travelers",moreLikeThisMovies: [])
let movie2 = Movie(id: "id2", name: "Travelers",moreLikeThisMovies: [])
 
 // prepare data and ready to save to firebase
let exampleMovie1 = Movie(
   id: UUID().uuidString,
   name: "DARK",
   moreLikeThisMovies: [movie1, movie2],
   episodes: [episode1, episode2]
 )

let exampleMovie4 = Movie(
   id: UUID().uuidString,
   name: "DARK",
    moreLikeThisMovies: [movie1, movie2]
 )
