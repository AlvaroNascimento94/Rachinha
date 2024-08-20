//
//  EditPlayer.swift
//   Rachinha
//
//  Created by Alvaro Filho on 19/08/24.
//

import SwiftUI



struct EditPlayer: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewPlayer = PlayerModel()

    @Binding var player: Player
    @State var positions: [String] = [""]
    @State var esporte: String = "Volei"
    
    func SelecModalidade(modalide: String){
        switch modalide {
        case "Basquete":
            positions = ["Ala", "Ala-Armador", "Ala-Pivo", "Armador", "Pivo", "Linha"]
        case "Futebol":
            positions = ["Goleiro", "Lateral", "Zagueiro", "Meio", "Atacante", "Linha"]
        case "Futsal":
            positions = ["Goleiro", "Fixo", "Ala", "Pivo", "Linha"]
          
        case "Handebol":
            positions = ["Goleiro", "Armador", "Ponta", "Pivo", "Linha"]
         
        case "Volei":
            positions = [ "Meio", "Saida", "Levantador","Ponteiro"]
          
        case "Society":
            positions = ["Goleiro", "Lateral", "Zagueiro", "Meio", "Atacante", "Linha"]
        default:
            print("error")
        }
    }
    
    func update(){
        viewPlayer.putPlayer(player, playerId: player._id!)
    }
    
    var body: some View {
        
        ZStack{
            Color.blue3.ignoresSafeArea()
            VStack{
                Spacer()
                Image(systemName: "person.crop.square.fill").resizable().scaledToFill().frame(width: 200,height: 200).foregroundColor(.gray)
                Spacer()
                
                HStack{
                    Spacer()
                    TextField("", text: $player.name, prompt: Text(" Nome ")
                        .foregroundColor(Color.laranja.opacity(0.8))).foregroundColor(.white)
                        .font(.title2).padding().background(.gray.opacity(0.3)).cornerRadius(10)
                    Picker("Selecione a posicao", selection: $player.position){
                        ForEach(positions, id: \.self){
                            Text($0)
                        }
                    }.tint(Color.laranja)
                    
                }.padding()
                
                Button("Confirm") {
                    update()
                    dismiss()
                }.buttonStyle(NavButtonStyle())
                Spacer()
            }.onAppear(){
                
                SelecModalidade(modalide: esporte)
                if !positions.contains(player.position) {
                    player.position = positions.first ?? ""
                }
            }
        }
        
    }
}
struct EditPlayer_Previews: PreviewProvider {
    @State static var samplePlayer = Player(_id: "", __v:0,name: "", position: "")
    
    static var previews: some View {
        EditPlayer(player: $samplePlayer, esporte: "Volei")
            .previewLayout(.sizeThatFits)
    }
}
