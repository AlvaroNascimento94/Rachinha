//
//  Model.swift
//  Rachinha
//
//  Created by Alvaro Filho on 19/08/24.
//

import Foundation
import SwiftUI

struct DeleteRequestBody: Codable {
    let _id: String
}

struct Times: Codable, Hashable{
    let _id: String?
    let __v: Int?
    var nameTime: String
    var players: [Player]
}


struct Player: Codable, Hashable {
    let _id: String?
    let __v: Int?
    var name: String
    var position: String
}

struct NavButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.subheadline)
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.laranja.opacity(0.5) : Color.laranja)
            .cornerRadius(10)
    }
}
