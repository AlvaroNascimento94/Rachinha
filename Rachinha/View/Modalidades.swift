//
//  OpcoesSelecao.swift
//   Rachinha
//
//  Created by Alvaro Filho on 19/08/24.
//

import SwiftUI

struct Modalidades: View {
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.azul
                    .ignoresSafeArea()
                VStack{
                    Image("rachinha")
                        .resizable()
                        .frame(width: 110, height: 110)
                    ScrollView{
                        NavigationLink( destination: CreateList(esporte: "Basquete")){
                            Text("Basquete").font(.title).frame(width: 175).foregroundColor(.white).padding().background(Color.laranja).cornerRadius(5)
                        }
                        NavigationLink( destination: CreateList(esporte: "Futebol")){
                            Text("Futebol").font(.title).frame(width: 175).foregroundColor(.white).padding().background(Color.laranja).cornerRadius(5)
                        }.padding()
                        NavigationLink( destination: CreateList(esporte: "Futsal")){
                            Text("Futsal").font(.title).frame(width: 175).foregroundColor(.white).padding().background(Color.laranja).cornerRadius(5)
                        }
                        NavigationLink( destination: CreateList(esporte: "Handebol")){
                            Text("Handeball").font(.title).frame(width: 175).foregroundColor(.white).padding().background(Color.laranja).cornerRadius(5)
                        }.padding()
                        NavigationLink( destination: CreateList(esporte: "Society")){
                            Text("Society").font(.title).frame(width: 175).foregroundColor(.white).padding().background(Color.laranja).cornerRadius(5)
                        }
                        NavigationLink( destination: CreateList(esporte: "Volei")){
                            Text("Vôlei").font(.title).frame(width: 175).foregroundColor(.white).padding().background(Color.laranja).cornerRadius(5)
                        }.padding()
                    }
                }.padding()
                }
            }
        
    }
}

#Preview {
    Modalidades()
}
