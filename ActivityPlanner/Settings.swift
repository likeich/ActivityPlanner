//
//  Settings.swift
//  Semester Project
//
//  Created by Abu Jalloh on 12/8/20.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var userData: UserData
    @State private var selectedIndex = 0
    @State private var currency = "USD"
    
    @State private var password = ""
    @State private var samePassword = ""
    @State private var showPassword = false
    @State private var badPasswordAlert = false
    @State private var missingInput = false
    @State private var showSetPasswordAlert = false
    @State private var selectedIndex2 = 0
    @State private var answer = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select currency")){
                    Picker("Selected:", selection: $selectedIndex) {
                        ForEach(0 ..< userData.currencyChoices.count, id: \.self) {
                            Text(self.userData.currencyChoices[$0])
                        }
                    }.frame(minWidth: 300, maxWidth: 500, alignment: .center)
                }
                
                Section(header: Text("Select a Security question")){
                    Picker("Selected:", selection: $selectedIndex2) {
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
                    
                }.alert(isPresented: $badPasswordAlert, content: { self.notPassword }) //end of section
                
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
                    .frame(minWidth: 300, maxWidth: 400)
                    
                } //end of section
                
                Section(){
                    Button(action: {
                        inputCheck()
                    }) {
                        //                    NavigationLink(destination: Login()) {
                        HStack {
                            Text("SAVE")
                                .frame(width: 300 , height: 36, alignment: .center)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(Color.black, lineWidth: 1)
                                )
                        }
                        //                    }
                    }
                }
                
            }.navigationBarTitle(("Settings"), displayMode: .inline) // end of Form
        }
    }
    
    func save(){
        //        print(userData.currency)
        userData.currency = userData.currencies[selectedIndex]
        //        print(userData.currency)
    }
    
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
        Alert(title: Text("Settings saved!"),
              message: Text("Your changes have saved!"),
              dismissButton: .default(Text("OK")) )
    }
    
    private func inputCheck() {
        userData.currency = userData.currencies[selectedIndex]
        if (!password.isEmpty || !samePassword.isEmpty) && answer != "" {
            if password == samePassword {
                UserDefaults.standard.set(self.password, forKey: "Password")
                UserDefaults.standard.set(self.userData.securityQuestion[selectedIndex2], forKey: "securityQuestion")
                UserDefaults.standard.set(self.answer, forKey: "answer")
                self.password = ""
                self.samePassword = ""
                self.answer = ""
                self.showSetPasswordAlert = true
                self.missingInput = false
                self.badPasswordAlert = false
            } else {
                self.badPasswordAlert = true
            }
        }
        else {
            self.showSetPasswordAlert = true
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
