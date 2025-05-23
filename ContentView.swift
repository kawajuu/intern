//
//  ContentView.swift
//  intern
//
//  Created by x21032xx on 2022/09/09.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    
    func makeUIView(context: Context) -> WKWebView{
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: URL(string: url)!))
    }
}
   


struct ContentView: View {
    
    
    var ApiLogin: String = ""
    var ApiPassword: String = ""
    
    @State var mainurl: String = "https://zozo.jp/_member/orderhistory/default.html?ohtype=1"//一時的なURL
  var body: some View {
      
      
      VStack {
      
          WebView(url: mainurl).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
          
      
      HStack {
          
          Button(action: {
              self.mainurl =  "http://192.168.11.100/WMI/View/WMI0200.aspx"
          }, label: {
              Image(systemName: "house")
                  .accentColor(.black)
                  .font(.largeTitle)
                  .frame(width: 70, height: 70)
                  .background(Color.white)
                  .cornerRadius(100)
                  .overlay(
                      RoundedRectangle(cornerRadius: 100)
                          .stroke(Color(.black), lineWidth: 1.5)
                  )
                  .offset(x: -14, y: 8)
                  .compositingGroup()
                  .shadow(color: .gray, radius: 5, x: 5, y: 5)
          })

        
        Button(action: {
            self.mainurl = "http://192.168.11.100/WMI/View/WMI0011.aspx"
        }, label: {
            Image(systemName: "newspaper")
                .accentColor(.black)
                .font(.largeTitle)
                .frame(width: 70, height: 70)
                .background(Color.white)
                .cornerRadius(100)
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(Color(.black), lineWidth: 1.5)
                )
                .offset(x: -7, y: 8)
                .compositingGroup()
                .shadow(color: .gray, radius: 5, x: 5, y: 5)
        })
//        {
//            Text("News")
//        }.padding().frame(height: 55.0).accentColor(.white).background(Color.black).cornerRadius(10)
        
          
          Button(action: {
              self.mainurl = "http://192.168.11.100/WMI/View/WMI7000.aspx"
          }, label: {
              Image(systemName: "person")
                  .accentColor(.black)
                  .font(.largeTitle)
                  .frame(width: 70, height: 70)
                  .background(Color.white)
                  .cornerRadius(100)
                  .overlay(
                      RoundedRectangle(cornerRadius: 100)
                          .stroke(Color(.black), lineWidth: 1.5)
                  )
                  .offset(x: 0, y: 8)
                  .compositingGroup()
                  .shadow(color: .gray, radius: 5, x: 5, y: 5)
          })
//          {
//              Text("User")
//        }.padding().frame(height: 55.0).accentColor(.white).background(Color.black).cornerRadius(10)
          
          Button(action: {
              self.mainurl = "http://192.168.11.100/WMI/View/WMI0300.aspx"
          }, label: {
              Image(systemName: "highlighter")
                  .accentColor(.black)
                  .font(.largeTitle)
                  .frame(width: 70, height: 70)
                  .background(Color.white)
                  .cornerRadius(100)
                  .overlay(
                      RoundedRectangle(cornerRadius: 100)
                          .stroke(Color(.black), lineWidth: 1.5)
                  )
                  .offset(x: 7, y: 8)
                  .compositingGroup()
                  .shadow(color: .gray, radius: 5, x: 5, y: 5)
          })
//          {
//              Text("Setting")
//          }.padding().frame(height: 55.0).accentColor(.white).background(Color.black).cornerRadius(10)
      }.padding(1)
    }.onAppear {
        mainurl = "http://192.168.11.100/WMI/View/WMI0200.aspx?LoginUser=\(ApiLogin)&LoginPass=\(ApiPassword)"
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

