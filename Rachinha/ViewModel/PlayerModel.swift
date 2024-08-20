//
//  PlayerModel.swift
//  Rachinha
//
//  Created by Alvaro Filho on 19/08/24.
//

import Foundation

class PlayerModel: ObservableObject{
    
    @Published var chars: [Player] = []
    
    func getPlayer() {
        guard let url = URL(string: "http://127.0.0.1:3333/player") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.chars = []
                }
                return
            }
            
            // Tenta decodificar a resposta como JSON
            do {
                // Verifica se os dados são válidos JSON antes de decodificar
                if try JSONSerialization.jsonObject(with: data, options: []) is [Any] {
                    let parsed = try JSONDecoder().decode([Player].self, from: data)
                    DispatchQueue.main.async {
                        self?.chars = parsed
                    }
                } else {
                    // Se não for um array de qualquer tipo, define chars como vazio
                    DispatchQueue.main.async {
                        self?.chars = []
                    }
                }
            } catch {
                // Se ocorrer um erro ao decodificar, imprime o erro
               // print(error)
                DispatchQueue.main.async {
                    self?.chars = []
                }
            }
        }
        task.resume()
    }

    
    func postPlayer(_ obj : Player){
        guard let url = URL(string: "http://127.0.0.1:3333/player") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(obj)
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            print("Error encoding to JSON: \(error.localizedDescription)")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error to send resource: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error to send resource: invalid response")
                return
            }
            
            if httpResponse.statusCode == 201 {
                print("Resource POST successfully")
            } else {
                print("Error POST resource: status code \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }
    
    func putPlayer(_ obj: Player, playerId: String) {
        // URL para o endpoint onde o recurso será atualizado
        guard let url = URL(string: "http://127.0.0.1:3333/player/\(playerId)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(obj)
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            print("Error encoding to JSON: \(error.localizedDescription)")
            return
        }
        
        // Executa a requisição
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error to send resource: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error to send resource: invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Resource PUT successfully")
            } else {
                print("Error PUT resource: status code \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }
    
    
    func deletePlayer(withId id: String) {
        guard let url = URL(string: "http://127.0.0.1:3333/player/\(id)") else { return } // Substitua o IP e a rota conforme necessário
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error deleting resource: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error deleting resource: invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Resource deleted successfully")
            } else {
                print("Error deleting resource: status code \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }
    
}
