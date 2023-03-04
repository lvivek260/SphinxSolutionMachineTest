//
//  DataModelPopulation.swift
//  Sphinx Solutions Machine Test
//
//  Created by Admin on 04/03/23.
//

import Foundation

struct DataModelPopulation:Decodable{
    let data:[PopulationData]
    
    enum CodingKeys: CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([PopulationData].self, forKey: .data)
    }
}
struct PopulationData:Decodable{
    let population:Int
    let year:String
    
    enum PopulationKeys:String, CodingKey {
      case population = "Population"
      case year = "Year"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PopulationKeys.self)
        population = try container.decode(Int.self, forKey: .population)
        year = try container.decode(String.self, forKey: .year)
    }
}
