//
//  login.swift
//  intern
//
//  Created by x21032xx on 2022/09/12.
//

import Foundation
import SwiftUI
import AudioToolbox


struct login_Previews: PreviewProvider {
    static var previews: some View {

        let localizationIds = ["en", "ja", "vi"]

        ForEach(localizationIds, id: \.self) { id in

            login()
                .previewDisplayName("Localized - \(id)")
                .environment(\.locale, .init(identifier: id))
        }
    }
}


struct login: View {
    @State private var LoginID = ""
    @State private var Password = ""
    @State private var showingLoginScreen = false
    @State private var showingError1: Bool = false//IDパスワード未入力
    @State private var showingError2: Bool = false//IDパスワード認証
    @State private var todo: TodoData = TodoData(login: false)
    
    let generator = UINotificationFeedbackGenerator()  //バイブレーション
    @State var Vibration = false
    
    @State var dateText = ""
    @State var nowDate = Date()
    private let dateFormatter = DateFormatter()
    init() {
        dateFormatter.dateFormat = "YYYY / MM / dd \n      HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "japan")
    }
    @State private var longPressed = false
    
    
    struct TodoData: Codable {
        var login: Bool
    }
    
    var JA = login_Previews()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text(dateText.isEmpty ? "\(dateFormatter.string(from: nowDate))" : dateText).padding(20).font(.title).background(Color.black.opacity(0.06)).cornerRadius(15).offset(x: 0, y: -90)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            self.nowDate = Date()
                            dateText = "\(dateFormatter.string(from: nowDate))"
                        }
                    }
                Text("F  O  I  S").font(.largeTitle).bold().padding(10).padding(.top, 20).offset(x: 0, y: -20)
                
                
                TextField("社員ID", text: $LoginID).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.12)).cornerRadius(100)
                
                SecureField("パスワード", text: $Password).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.12)).cornerRadius(100).offset(x: 0, y: 5)
                
                Button (action: {
                    //認証過程
                    todo.login = false
                    
                    if LoginID == "" || Password == "" {  //文字が打たれていない時のエラー
                        showingError1 = true  //"社員IDまたはパスワードを入力してください"
                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(1521)) {}
                    }else{
//                        showingError1 = false
                        getData()
                    }
                    
                    
                })
                {
                    Text("ログイン").bold().foregroundColor(.white).frame(width: 120, height: 45).background(Color.blue).cornerRadius(100).offset(x: 0, y: 20)
                    }
                

                
                if showingError1{
                    Text("社員IDまたはパスワードを入力してください。").foregroundColor(.red).bold().padding().background(Color.red.opacity(0.3)).offset(x: 0, y: 30)
                }
                else if showingError2 {
                    Text("ログインに失敗しました。").foregroundColor(.red).bold().padding().background(Color.red.opacity(0.3)).offset(x: 0, y: 30)
                }
                if showingLoginScreen == todo.login {
                    NavigationLink(destination: ContentView(ApiLogin: LoginID, ApiPassword: Password), isActive: $showingLoginScreen){
                }
                }
            }.navigationBarHidden(true).padding(.bottom, 90)
        }
    }
    
    func getData() {
        guard let url = URL(string: "http://192.168.11.100/WMI/Api/Login.ashx?LoginUser=\(LoginID)&LoginPass=\(Password)")else{ return }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let todoData = data {
                    let decodedData = try JSONDecoder().decode(TodoData.self, from: todoData)
                    self.todo = decodedData
                    //print(String(todo.login))
                } else {
                    print("No data", data as Any)
                }
            } catch {
                print("Error", error)
            }
            
                showingError1 = false
            if todo.login == false {  //ID,PWが正しくないとき
                showingError2 = true
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(1521)) {}
            }else{
                showingError2 = false
                showingLoginScreen = true
            }
        }.resume()
        
    }
}

struct loginView_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}
