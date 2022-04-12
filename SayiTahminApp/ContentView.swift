//
//  ContentView.swift
//  SayiTahminApp
//
//  Created by Berat Yavuz on 12.04.2022.
//

import SwiftUI

struct GirisSayfasi: View {
    
    var body: some View {
       
        NavigationView{
            VStack(spacing:100){
           
                Text("Tahmin Oyunu").font(.largeTitle).foregroundColor(.gray)
                Image("dice").resizable().padding().frame(width: UIScreen.main.bounds.width*0.7, height: UIScreen.main.bounds.height*0.3, alignment: .center)
            NavigationLink(
                destination: TahminSayfasi(),
                label: {
                    Text("Oyuna Başla").font(.title).foregroundColor(.pink).frame(width: 250, height: 90, alignment: .center).background(Color.yellow).cornerRadius(20.0)
                })
            
            
        }.navigationBarTitle("giris sayfasi")

        }
    }
}

struct TahminSayfasi: View {
    @State var tahminGirdisi = ""
    @State var sayfaAcilsinmi : Bool = false
    @State var sonuc  = false
    @State var rastgeleSayi = 15
    @State var kalanHak = 5
    @State var yonlendirme = ""
    var body: some View {
        VStack(spacing:100){
            Text("Kalan Hak:\(kalanHak)").font(.largeTitle).foregroundColor(.pink)
            Text("\(yonlendirme)").font(.title)
            TextField("tahmininizi giriniz",text:$tahminGirdisi).textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                kalanHak -= 1
                if(kalanHak != 0){
                    if let gelentahmin = Int(self.tahminGirdisi){
                        if gelentahmin > rastgeleSayi {
                            self.yonlendirme = "Azaltın"
                        }
                        else if (gelentahmin < rastgeleSayi){
                            self.yonlendirme = "Arttırın"
                        }
                        else{self.yonlendirme = "Bildiniz"
                            self.sayfaAcilsinmi = true
                            self.sonuc = true
                            oyunuSifirla()
                        }
                    }
                }
                else{self.sayfaAcilsinmi = true
                    self.sonuc = false
                    oyunuSifirla()
                    
                }
                self.tahminGirdisi = ""
            }, label: {
                Text("Tahmin Et")
              
           
            }).frame(width: UIScreen.main.bounds.width*0.5, height: UIScreen.main.bounds.height*0.1, alignment: .center).background(Color.pink).foregroundColor(.white).cornerRadius(20.0)
            
            
        }.navigationBarTitle("Tahmin Et").sheet(isPresented:$sayfaAcilsinmi) {
            SonucSayfasi( gelenSonuc: self.sonuc)
        }.onAppear(){
            self.rastgeleSayi = Int.random(in: 1...100)
            print(rastgeleSayi)
        }
        
    }
    func oyunuSifirla(){
        self.rastgeleSayi = Int.random(in: 1...100)
        self.kalanHak = 5
        self.tahminGirdisi = ""
        self.yonlendirme = ""
    }
}

struct SonucSayfasi: View {
    @Environment (\.presentationMode) var sunumModu
    var gelenSonuc : Bool?
    var body: some View {
        VStack(spacing:100){
            if gelenSonuc! {
                Text("KAZANDINIZ").font(.largeTitle)
                Image("mutlu").resizable().padding().frame(width: UIScreen.main.bounds.width*0.5, height: UIScreen.main.bounds.height*0.3, alignment: .center)
                
            }
            else{
                Text("KAYBETİNİZ").font(.largeTitle)
                Image("uzgun").resizable().padding().frame(width: UIScreen.main.bounds.width*0.5, height: UIScreen.main.bounds.height*0.3, alignment: .center)
            }
            
          
            
            Button(action: {self.sunumModu.wrappedValue.dismiss()
            }, label: {
                Text("tekrar Başla")
           
            }).frame(width: UIScreen.main.bounds.width*0.5, height: UIScreen.main.bounds.height*0.1, alignment: .center).background(Color.pink).foregroundColor(.white).cornerRadius(20.0)
        
        
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SonucSayfasi()
    }
}
