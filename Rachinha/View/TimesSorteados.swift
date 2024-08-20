//
//  Times.swift
//   Rachinha
//
//  Created by Alvaro Filho on 19/08/24.
//

import SwiftUI

struct TimesSorteados: View {
    @StateObject var viewModel = ViewModel()
    
    @Binding var isSorted: Bool
    
    func limparTimes() {
        isSorted = false
        viewModel.deleteTimes()
        viewModel.chars.removeAll()
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color(.azul).ignoresSafeArea()
                VStack{
                    List{
                        ForEach(viewModel.chars, id: \._id){ section in
                            Section(header: Text(section.nameTime).foregroundStyle(.white)){
                                ForEach(section.players, id: \.self){ time in
                                    HStack{
                                        Text(time.name)
                                        Spacer()
                                        Text(time.position)
                                    }.foregroundColor(.white)
                                        .listRowBackground(Color.blue2)
                                        .scrollContentBackground(.hidden)
                                }
                            }
                        }
                    } .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("TIMES").font(.title)
                                .foregroundColor(.white)
                        }
                    }
                    .toolbarBackground(Color.azul)
                    .scrollContentBackground(.hidden)
                    .background(.azul)
                    .toolbarBackground(.visible, for: .navigationBar)
                }
                .navigationBarItems(trailing: Button("Clear time") {
                    limparTimes()
                }
                    .buttonStyle(NavButtonStyle()))
                .onAppear(){
                    viewModel.get()
                }
            }
        }
    }
}


struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        TimesSorteados(isSorted: .constant(true))
    }
}
