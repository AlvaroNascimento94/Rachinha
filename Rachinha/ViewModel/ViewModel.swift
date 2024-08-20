//
//  ViewModel.swift
//  Rachinha
//
//  Created by Alvaro Filho on 19/08/24.
//

import Foundation

class ViewModel: ObservableObject{
    
    @Published var chars:[Times] = []
    @Published var isDataSent = false
    
    
    func get(){
            guard let url = URL(string: "http://127.0.0.1:3333/equipes") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){[weak self] data, _ ,error in
            
            guard let data = data, error == nil else{
                return
            }
            do{
                let parsed = try JSONDecoder().decode([Times].self, from: data)
                DispatchQueue.main.async {
                    self?.chars = parsed
                }
            } catch{
                print(error)
            }
        }
        task.resume()
    }

    func postTimes(_ obj : Times){
        print("comecou")
        guard let url = URL(string: "http://127.0.0.1:3333/equipes") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let encoder = JSONEncoder()
        print("encoder")
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
            
            if httpResponse.statusCode == 200 {
                print("Resource POST successfully")
            } else {
                print("Error POST resource: status code \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }

    func deleteTimes() {
        print("começou")
        guard let url = URL(string: "http://127.0.0.1:3333/equipes/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error to delete resource: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error to delete resource: invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Resource DELETE successfully")
            } else {
                print("Error DELETE resource: status code \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }

    
    
}
