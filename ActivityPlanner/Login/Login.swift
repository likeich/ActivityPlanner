//
//  Login.swift
//  Semester Project
//
//  Created by Abu Jalloh on 12/2/20.
//

import SwiftUI
import LocalAuthentication


struct Login : View {
    
    @State var userName = ""
    @State var password = ""
    @EnvironmentObject var userData: UserData
    
    @State private var enteredPassword = ""
    @State private var showInvalidPasswordAlert = false
    @State private var showMissingAccount = false
    
    // when first time user logged in via email store this for future biometric login....
    //    @AppStorage("stored_User") var pass = UserDefaults.standard.set(password, forKey: "Password")
    //    @AppStorage("status") var logged = false
    let myContext = LAContext()
    
    
    var body: some View{
        NavigationView{
            VStack() {
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                Image("logo")
                    .resizable()
                    .frame(width: 150.0, height: 150.0)
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal,35)
                    .padding(.vertical)
                
                Spacer()
                
                
                HStack() {
                    VStack(alignment: .leading, spacing: 12, content: {
                        
                        Text("Login")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.black)
                        
                        Text("Please sign in to continue")
                            .foregroundColor(Color.black.opacity(0.5))
                    })
                    
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                }//end of HStack
                .padding()
                .padding(.leading,15)
                
                
                HStack{
                    Image(systemName: "lock")
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 35)
                    
                    SecureField("PASSWORD", text: $password)
                        .autocapitalization(.none)
                }//end of HStack
                .padding()
                .background(Color.black.opacity(password == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
                HStack(spacing: 15){
                    Button(action: {
                        if UserDefaults.standard.string(forKey: "Password") == nil {
                            self.showMissingAccount = true
                        }
                        else{
                            let validPassword = UserDefaults.standard.string(forKey: "Password")
                            if self.password == validPassword {
                                userData.userAuthenticated = true
                                self.showInvalidPasswordAlert = false
                                self.showMissingAccount = false
                            }
                            else {
                                self.showInvalidPasswordAlert = true
                            }
                        }
                    }, label: {
                        Text("LOGIN")
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            //use width of device - 150 px
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    }).padding(.top)
                    .opacity(password != "" ? 1 : 0.5)
                    //                .disabled(password != "" ? false : true)
                    let v = myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
                    
                    if UserDefaults.standard.string(forKey: "Password") != nil {
                        
                        Button(action: authenticateUser, label: {
                            
                            // getting biometrictype...
                            Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                        })
                    }
                    
                } //end of HStack
                .padding(.top)
                .alert(isPresented: $showInvalidPasswordAlert, content: { self.invalidPasswordAlert })
                
                if UserDefaults.standard.string(forKey: "Password") != nil{
                    Button(action: {
                        
                    }, label: {
                        NavigationLink(destination: ForgotPassword()){
                            HStack {
                                Text("Forgot Password")
                                    .fontWeight(.medium)
                                    .foregroundColor(.blue)
                            }
                        }
                    }).padding(.top,8)
                }
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                if UserDefaults.standard.string(forKey: "Password") == nil {
                    HStack(spacing: 5){
                        Text("Don't have an account?")
                            .foregroundColor(Color.black)
                        
                        Button(action: {
                        }, label: {
                            NavigationLink(destination: SignUp()){
                                HStack {
                                    Text("Sign up")
                                        .fontWeight(.medium)
                                        .foregroundColor(.blue)
                                }
                            }
                        })
                        
                    }.padding(.vertical)//end of HStack
                }
                
                
            }//end of VStack
        }
        .alert(isPresented: $showMissingAccount, content: { self.MissingAccount })
        
    }//end of body
    
    var MissingAccount: Alert {
        Alert(title: Text("Account does not exist!"),
              message: Text("Please sign up using the button below!"),
              dismissButton: .default(Text("OK")) )
    }
    var invalidPasswordAlert: Alert {
        Alert(title: Text("Invalid Login!"),
              message: Text("Your password is incorrect!"),
              dismissButton: .default(Text("OK")) )
    }
    
    
    func authenticateUser(){
        
        myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Unlock") { (status, err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            // setting logged status as true
            withAnimation(.easeOut){userData.userAuthenticated = true}
        }
    }
}



