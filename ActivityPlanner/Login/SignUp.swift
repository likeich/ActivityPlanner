//
//  SignUp.swift
//  Semester Project
//
//  Created by Abu Jalloh on 12/3/20.
//

import SwiftUI

struct SignUp: View {
    @EnvironmentObject var userData: UserData
    @State private var password = ""
    @State private var samePassword = ""
    @State private var showPassword = false
    @State private var badPasswordAlert = false
    @State private var missingInput = false
    @State private var showSetPasswordAlert = false
    @State private var selectedIndex = 0
    @State private var answer = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            
            Form {
                
                Section(header: Text("Select a Security question")){
                    Picker("Selected:", selection: $selectedIndex) {
                        ForEach(0 ..< userData.securityQuestion.count, id: \.self) {
                            Text(self.userData.securityQuestion[$0])
                        }
                    }
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                } //end of section
                
                Section(header: Text("Enter answer to selected security question")){
                    HStack{
                        TextField("Enter Answer", text: $answer)
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
                } //end of section
                .alert(isPresented: $showSetPasswordAlert, content: { self.setPassword })
                
                Section(header: Text("Enter password")){
                    
                        HStack {
                            SecureField("Enter Password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 300, height: 36)
                                .padding(5)
                            Button(action: {
                                self.password = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                        }
                        .frame(minWidth: 300, maxWidth: 500)
                    
                } //end of section
                
                Section(header: Text("Verify password")){
                    
                        HStack {
                            SecureField("Verify Password", text: $samePassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 300, height: 36)
                                .padding(5)
                            Button(action: {
                                self.samePassword = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                        }
                        .frame(minWidth: 300, maxWidth: 500)
                    
                } //end of section
                
                Section(header: Text("Set Password")) {
                    Button(action: {
                        inputCheck()
                    }) {
                        NavigationLink(destination: Login()) {
                            HStack {
                                Text("Set Password to Unlock App")
                                    .frame(width: 300 , height: 36, alignment: .center)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .strokeBorder(Color.black, lineWidth: 1)
                                    )
                            }
                        }
                    }
                } //end of section
                
            }//end of form
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
            .font(.system(size: 14))
            .alert(isPresented: $badPasswordAlert, content: { self.notPassword })
            
        }.alert(isPresented: $missingInput, content: {self.missingInfo})

    }//end of body
    
    var notPassword: Alert {
        Alert(title: Text("Unmatched Password!"),
              message: Text("Two entries of the password must match!"),
              dismissButton: .default(Text("OK")) )
    }
    var missingInfo: Alert {
        Alert(title: Text("Missing Info!"),
              message: Text("Make sure you've filled out all the fields!"),
              dismissButton: .default(Text("OK")) )
    }
    var setPassword: Alert {
        Alert(title: Text("Password Set!"),
              message: Text("Password you entered is set to unlock the app!"),
              dismissButton: .default(Text("OK")) )
    }
    
    private func inputCheck() {
        if !password.isEmpty && !samePassword.isEmpty && !answer.isEmpty{
            if password == samePassword {
                UserDefaults.standard.set(self.password, forKey: "Password")
                UserDefaults.standard.set(self.userData.securityQuestion[selectedIndex], forKey: "securityQuestion")
                UserDefaults.standard.set(self.answer, forKey: "answer")
                self.password = ""
                self.samePassword = ""
                self.answer = ""
                self.showSetPasswordAlert = true
                self.missingInput = false
                self.badPasswordAlert = false
                self.presentationMode.wrappedValue.dismiss()
            } else {
                self.badPasswordAlert = true
            }
        }
        else {
            self.missingInput = true
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
