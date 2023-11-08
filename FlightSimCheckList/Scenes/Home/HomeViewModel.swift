//
//  HomeViewModel.swift
//  FlightSimCheckList
//
//  Created by Tabita Barbosa on 07/11/23.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func updateManufacturers(manufacturers: [ManufacturersModel])
    func updateModels(models: [String])
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelProtocol?
    var manufacturersArray: [ManufacturersModel]?
    
    func returnManufacturers() -> [ManufacturersModel] {
        self.getManufacturers()
        guard let array = manufacturersArray else { return [] }
        return array
    }
    
    func returnModels(with type: AirplaneModel) -> [String] {
        return ["A320", "A320Neo"]
    }
    
    func getManufacturers() {
        func loadJson(filename fileName: String) -> [ManufacturersModel]? { // aqui troca person pelo nome do retorno
            if let url = Bundle.main.url(forResource: "manufacturersMock", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(ManufacturersResponse.self, from: data)
                    manufacturersArray = jsonData.data
                    return manufacturersArray
                } catch {
                    print("error:\(error)")
                }
            }
            return nil
        }
    }
}

public enum ManufacturersType {
    case airbus
    case boeing
    
    var name: String {
        switch self {
        case .airbus:
            return "Airbus"
        case .boeing:
            return "Boeing"
        }
    }
}

struct ManufacturersResponse: Decodable {
    let data: [ManufacturersModel]
}

struct ManufacturersModel: Decodable {
    let type: ManufacturersType? = .airbus
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "nome_fabricante"
    }
}

struct AirplaneModel: Decodable {
    let type: ManufacturersType? = .airbus
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "nome_modelo"
    }
}
