//
//  Pokemon.swift
//  Pokemon
//
//  Created by Field Employee on 12/4/20.
//

import Foundation

struct Pokemon {
    let name: String
    let baseExperience: Int
    
    
    init?(json: [String: Any]) {
        guard let name = json["name"] as?
                String, let exp = json["base_experience"] as? Int else {return nil }
        self.name = name
        self.baseExperience = exp
    }
}

struct PokemonWeight {
    let weight: Int
    
    
    init?(json: [String: Any]) {
        guard let exp = json["weight"] as? Int else {return nil }
        
        self.weight = exp
    }
}

struct CodablePokemon: Decodable {
    let name: String
    let baseExperience: Int
    let abilities: [Ability]
    let weight: Int
    let moves: [Moves]
    
    enum CodingKeys: String, CodingKey {
        case name
        case baseExperience = "base_experience"
        case abilities
        case weight
        case moves
    }
}

struct Moves: Decodable{
    // let move: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case move
        case name
    }
    
    enum MoveCodingKeys: String, CodingKey {
        case name
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try
            decoder.container(keyedBy: CodingKeys.self)
        
        let moveContainer = try
            container.nestedContainer(keyedBy: MoveCodingKeys.self, forKey: .move)
        
        
        self.name = try
            moveContainer.decode(String.self, forKey: .name)
    }
}

struct Ability: Decodable {
    let isHidden: Bool
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
         case ability
    }
    
    enum AbilityCodingKeys: String, CodingKey{
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try
            decoder.container(keyedBy: CodingKeys.self)
        
        let abilityContainer = try
            container.nestedContainer(keyedBy: AbilityCodingKeys.self, forKey: .ability)
        
        self.isHidden = try
            container.decode(Bool.self, forKey: .isHidden)
        self.name = try
            abilityContainer.decode(String.self, forKey: .name)
    }
}

