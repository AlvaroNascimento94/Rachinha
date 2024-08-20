//
//  CreateList.swift
//   Rachinha
//
//  Created by Alvaro Filho on 19/08/24.
//

import SwiftUI



struct CreateList: View {
    @StateObject var viewModel = ViewModel()
    @StateObject var viewPlayer = PlayerModel()
    
    @State private var showingAlert = false
    @State private var showingAlert2 = false
    @State private var showingAlert3 = false
    @State private var showingAlert4 = false
    @State private var showingAlert5 = false
    @State private var showingSheet = false
    
    @State var isSorted: Bool = false
    @State var players2: [Player] = []
    @State var player:Player = Player( _id: "", __v: 0,name: "", position: "")
    @State var name: String = ""
    @State var esporte: String = "Volei"
    @State var numberPeople: Int = 0
    @State var numberTimes: Int = 0
    @State var position = ""
    @State var positions: [String] = [""]
    @State var auxPlayer: Player = Player(_id: "", __v: 0, name: "",position: "")
    @State var equipe : Times = Times(_id: "",__v: 0, nameTime: "", players: [])
    @State var equipes: [Times] = []
    
    func SelecModalidade(modalide: String){
        switch modalide {
        case "Basquete":
            positions = ["Ala", "Ala-Armador", "Ala-Pivo", "Armador", "Pivo", "Linha"]
            position = "Ala"
        case "Futebol":
            positions = ["Goleiro", "Lateral", "Zagueiro", "Meio", "Atacante", "Linha"]
            position = "Goleiro"
        case "Futsal":
            positions = ["Goleiro", "Fixo", "Ala", "Pivo", "Linha"]
            position = "Goleiro"
        case "Handebol":
            positions = ["Goleiro", "Armador", "Ponta", "Pivo", "Linha"]
            position = "Goleiro"
        case "Volei":
            positions = [ "Meio", "Saida", "Levantador","Ponteiro"]
            position = "Meio"
        case "Society":
            positions = ["Goleiro", "Lateral", "Zagueiro", "Meio", "Atacante", "Linha"]
            position = "Goleiro"
        default:
            print("error")
        }
    }
    
    func addPlayer( name: String, position: String){
        let player = Player(_id: nil, __v: nil, name: name, position: position)
        viewPlayer.postPlayer(player)
    }
    
    func removePlayer(player:Player){
        viewPlayer.deletePlayer(withId: player._id!)
    }
    
    func sorteioTime (qtde: Int){
        isSorted = true
        var players: [Player] = []
        for play in viewPlayer.chars {
            players.append(play)
        }
        var time: [Player] = []
        var sort = players.shuffled()
        var round = 1
        
        while round <= numberTimes {
            
            let Lev = sort.filter({$0.position == "Levantador"}).shuffled().first
            if Lev != nil{
                let index = sort.firstIndex(of: Lev!)
                time.append(Lev!)
                sort.remove(at: index!)
            }
            
            let Pon = sort.filter({$0.position == "Ponteiro"}).shuffled().first
            if Pon != nil{
                let index = sort.firstIndex(of: Pon!)
                time.append(Pon!)
                sort.remove(at: index!)
            }
            
            let Mei = sort.filter({$0.position == "Meio"}).shuffled().first
            if Mei != nil{
                let index = sort.firstIndex(of: Mei!)
                time.append(Mei!)
                sort.remove(at: index!)
            }
            
            let Sai = sort.filter({$0.position == "Saida"}).shuffled().first
            if Sai != nil{
                let index = sort.firstIndex(of: Sai!)
                time.append(Sai!)
                sort.remove(at: index!)
            }
            switch qtde {
            case 6:
                let Pon2 = sort.filter({ $0.position == "Ponteiro" }).shuffled().first
                if Pon2 != nil {
                    let index = sort.firstIndex(of: Pon2!)
                    time.append(Pon2!)
                    sort.remove(at: index!)
                }
                
                let Mei2 = sort.filter({ $0.position == "Meio" }).shuffled().first
                if Mei2 != nil {
                    let index = sort.firstIndex(of: Mei2!)
                    time.append(Mei2!)
                    sort.remove(at: index!)
                }
            default:
                break
            }
            
            if !time.isEmpty {
                let equipe = Times(_id: nil, __v: nil, nameTime: "Time \(round)", players: time)
                viewModel.postTimes(equipe)
            }
            time.removeAll()
            round += 1
        }
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.azul.ignoresSafeArea()
                VStack{
                    VStack{
                        HStack{
                            Text("Quantidade de Times").foregroundColor(.white).font(.title3)
                            Spacer()
                            Picker("", selection: $numberTimes){
                                ForEach(0..<11){
                                    Text("\($0)")
                                }
                            }.tint(Color.laranja)
                        }.padding()
                        HStack{
                            Text("Quantidade de Altetas por time").foregroundColor(.white).font(.title3)
                            Spacer()
                            Picker("", selection: $numberPeople){
                                ForEach(0..<11){
                                    Text("\($0)")
                                }
                            }.tint(Color.laranja)
                        }.padding(.leading).padding(.trailing).padding(.bottom)
                    }
                    HStack{
                        TextField("", text: $name, prompt: Text(" Nome ")
                            .foregroundColor(Color.laranja.opacity(0.8)))
                        .font(.title3).foregroundColor(.white).padding().cornerRadius(10).border(Color.white)
                        Picker("Selecione a posicao", selection: $position){
                            ForEach(positions, id: \.self){
                                Text($0)
                            }
                        }.tint(Color.laranja)
                    }.padding()
                    
                    Button{
                        if !name.isEmpty{
                            addPlayer(name: name, position: position)
                            name = ""
                        }
                        else{
                            showingAlert = true
                        }
                    }label: {
                        Image(systemName: "plus.app.fill").resizable().scaledToFit().foregroundColor(Color.laranja)
                    }.alert("Insira um nome!", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    }.frame(height: 30).padding(.bottom)
                    VStack{
                        ScrollView{
                            HStack{
                                
                                Text("Jogadores").font(.title2)
                                    .foregroundColor(.white)
                                Spacer()
                                Text("Posição").font(.title2)
                                    .foregroundColor(.white)
                                Spacer()
                                
                            }.padding()
                            ForEach(viewPlayer.chars, id: \._id){ jogador in
                                HStack{
                                    Text(jogador.name).font(.title3).foregroundColor(.white).frame(width: 150)
                                    Spacer()
                                    Text(jogador.position).foregroundColor(.white).font(.title3)
                                    Spacer()
                                    Button{
                                        auxPlayer = jogador
                                        showingSheet.toggle()
                                    }label: {
                                        Image(systemName: "pencil")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.white)
                                    }.sheet( isPresented: $showingSheet, onDismiss: {
                                        if let index = players2.firstIndex(where: {
                                            $0._id == auxPlayer._id}){
                                            players2[index] = auxPlayer
                                        }
                                    }
                                    ){
                                        EditPlayer(player: $auxPlayer, esporte: esporte)
                                    }
                                    
                                    Button{
                                        auxPlayer = jogador
                                        removePlayer(player: auxPlayer)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .resizable().scaledToFit().foregroundColor(.white)
                                        
                                    }.padding(.leading)
                                    
                                }
                                Divider().padding(.bottom)
                            }.frame(width: 350, height: 20)
                        }.frame(width: 350).refreshable {
                            viewPlayer.getPlayer()
                        }
                        HStack{
                            Spacer()
                            Button("Sortear Times"){
                                if numberTimes == 0 {
                                    showingAlert2 = true
                                }
                                else if viewPlayer.chars.isEmpty {
                                    showingAlert3 = true
                                }
                                else if isSorted {
                                    showingAlert4 = true
                                } else{
                                    
                                    sorteioTime(qtde: numberPeople)
                                    showingAlert5 = true
                                }
                            }.alert("Quantidadde de time insuficiente", isPresented: $showingAlert2) {
                                Button("OK", role: .cancel) { }
                            }.alert("Adicione um Jogador!", isPresented: $showingAlert3) {
                                Button("OK", role: .cancel) { }
                            }.alert("Os times ja foram sorteados!", isPresented: $showingAlert4) {
                                Button("OK", role: .cancel) { }
                            }.alert("Times Sorteados!", isPresented: $showingAlert5) {
                                Button("OK", role: .cancel) { }
                            }.onAppear(){
                                viewModel.get()
                            }.buttonStyle(NavButtonStyle())
                            Spacer()
                            NavigationLink(destination: TimesSorteados(isSorted: $isSorted)){
                                Text("Times")
                                    .font(.subheadline).foregroundColor(.white).padding().background(Color.laranja).cornerRadius(10)
                            }
                            Spacer()
                        }
                    }.padding()
                    
                }.padding()
            }
        }.onAppear(){
            viewPlayer.getPlayer()
            viewModel.get()
            SelecModalidade(modalide: esporte)
        }
    }
}


#Preview {
    CreateList()
}
