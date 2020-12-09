//
//  ForgotPassword.swift
//  Semester Project
//
//  Created by Abu Jalloh on 12/8/20.
//

import SwiftUI

struct ForgotPassword: View {
    @State private var showValues = false
    @State private var answer = ""
//    @State private var answered = false
    @State private var badAnswerAlert = false
    @State private var missingInputAlert = false
    @State private var resetAlert = false
    @EnvironmentObject var userData: UserData

    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
           
            Section(header: Text("Security question")){
                Text("\(UserDefaults.standard.string(forKey: "securityQuestion") ?? "question is missing")" )
            }
            Section(header: Text("Enter answer to selected security question")){
                
                    HStack{
                        SecureField("Enter Answer", text: $answer)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300, height: 36)
                            .padding(5)
                        Button(action: {
                            self.answer = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }
                    .frame(minWidth: 300, maxWidth: 500)
                
            }
            
            Section(header: Text("Reset Password")) {
                Button(action: {
//                    self.presentationMode.wrappedValue.dismiss()
                    inputCheck()
                }) {
                    NavigationLink(destination: SignUp()) {
                        HStack {
                            Text("Reset password to unlock app")
                                .frame(width: 300 , height: 36, alignment: .center)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(Color.black, lineWidth: 1)
                                )
                        }
                    }
                }
                
            }
            .alert(isPresented: $missingInputAlert, content: {self.missingInfo})
            

        }
        .alert(isPresented: $badAnswerAlert, content: { self.notAnswer })
//        .alert(isPresented: $resetAlert, content: {self.resetPassword})
        .navigationBarTitle(Text("Password Reset"), displayMode: .inline)
    }
    var notAnswer: Alert {
        Alert(title: Text("Bad Answer!"),
              message: Text("Answer entered was incorrect!"),
              dismissButton: .default(Text("OK")) )
    }
    var missingInfo: Alert {
        Alert(title: Text("Missing Info!"),
              message: Text("Make sure you've filled out all the fields!"),
              dismissButton: .default(Text("OK")) )
    }
    var resetPassword: Alert {
        Alert(title: Text("Password reset!"),
              message: Text("Enter sign up to create a new password"),
              dismissButton: .default(Text("OK")) )
    }
    
    private func inputCheck() {
        if !answer.isEmpty{
            if UserDefaults.standard.string(forKey: "answer") == answer {
//                self.answer = ""
                self.badAnswerAlert = false
                self.resetAlert = true
                UserDefaults.standard.set(nil, forKey: "Password")
                UserDefaults.standard.set(nil, forKey: "securityQuestion")
                UserDefaults.standard.set(nil, forKey: "answer")
                self.presentationMode.wrappedValue.dismiss()
//                userData.refresh += 1
                self.presentationMode.wrappedValue.dismiss()
            } else {
                self.badAnswerAlert = true
            }
        }
        else {
            self.missingInputAlert = true
        }
    }
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassword()
    }
}
