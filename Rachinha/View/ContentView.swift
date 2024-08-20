//
//  ContentView.swift
//  Rachinha
//
//  Created by Alvaro Filho on 19/08/24.
//

import SwiftUI

struct ContentView: View {
    @State var isSorted: Bool = true
    var body: some View {
        NavigationStack {
            
            ZStack{
                Color(.azul)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    HStack{
                        Spacer()
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                    }.frame(height: 20).padding()
                    
                    Image("rachinha")
                        .resizable()
                        .scaledToFit()
                    
                    NavigationLink(destination: Modalidades()){
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                            Text("Criar Novo Time")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.laranja)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        
                    }.padding()
                    
                    NavigationLink( destination: TimesSorteados( isSorted: $isSorted)){  HStack {
                        Image(systemName: "person.3.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("Ver Times")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.laranja)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    }.padding()
                    
                    Spacer()
                }.padding()
            }
            
        }.tint(.laranja)
    }
}

#Preview {
    ContentView()
}
