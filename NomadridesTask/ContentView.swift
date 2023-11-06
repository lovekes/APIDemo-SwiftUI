//
//  ContentView.swift
//  NomadridesTask
//
//  Created by IM-LP-1819 on 12/12/22.
//

import SwiftUI

struct ContentView: View {
    @State var loading: String = "Loading..."
    @StateObject var currencyModel = CurrencyModel()
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            VStack{
                Spacer().frame(height:70)
                Image("image_top").resizable()
                    .aspectRatio(contentMode:.fit)
                    .frame(width:UIScreen.main.bounds.size.width,height: 60)
                Text("Hey thjere! The current\nprice of bitcoin is \(self.currencyModel.currency == nil ? loading:"below")").font(.system(size: 16).weight(.bold)) .padding(.bottom, 20)
                    .padding(.top,16).foregroundColor(Color("textColor"))
                
                Spacer()
                Text("Price").font(.subheadline.weight(.light))
                    .padding(.bottom, 2)
                    .foregroundColor(Color("textColor"))
                Text(self.currencyModel.currency == nil ? loading:"$ \u{36}"+self.currencyModel.currency.bpi.usd.rate).font(.title2.weight(.bold)) .foregroundColor(Color("textColor"))
                Spacer()
                Button(action: {
                    self.currencyModel.currency = nil
                    Task {
                        await self.currencyModel.getCurrency()
                    }
                }, label: {
                    Text("Refresh Price")
                        .font(.headline)
                        .foregroundColor(Color("buttonTextColor"))
                        .padding()
                        .frame(width: UIScreen.main.bounds.size.width-72, height: 50)
                        .background(self.currencyModel.currency == nil ? Color("buttonBgLoadingColor"):Color("buttonBgColor"))
                        .cornerRadius(25.0)
                })
                .padding(.bottom, 12)
                .padding(.leading,16)
                .padding(.trailing,16)
                .shadow(color: Color("buttonBgLoadingColor"), radius: 2, x: 0, y: 0)
                
                Spacer().frame(height:70)
                
            }
        }
        .task {
            await self.currencyModel.getCurrency()
        }
        .onAppear(perform: {
            //didGetBPIPrice()
        })
        .onReceive(self.currencyModel.timer) { time in
           if loading == "Loading." {
                loading = "Loading.."
            } else if loading == "Loading.." {
                loading = "Loading..."
            } else  if loading == "Loading..." {
                loading = "Loading."
            }
        }
    }
   

}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
