//
//  PlayerModel.swift
//  SoloLevel
//
//  Created by Edwin on 4/15/24.
//

import Foundation

struct User: Encodable, Decodable {
    let userId: String
    let email: String
    let dateCreated: Date
    let level: Int
    let name: String
    let job: String
    let title: String
    let hp: Int
    let mp: Int
    let strength: Int
    let health: Int
    let agility: Int
    let intelligence: Int
    let sense: Int
    let mind: Int
    let ability: String
    var lastLevelUp: Date?
}
