//
//  HomeViewModel.swift
//  FlightSimCheckList
//
//  Created by Tabita Barbosa on 07/11/23.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func updateManufacturers(manufacturers: [ManufacturersModel])
    func updateModels(models: [AirplaneModel])
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelProtocol?
    var manufacturersArray: [ManufacturersModel]?
    var modelsArray: [AirplaneModel]?
    
    func returnManufacturers() -> [ManufacturersModel] {
        self.getManufacturers()
        guard let array = manufacturersArray else { return [] }
        self.delegate?.updateManufacturers(manufacturers: array)
        return array
    }
    
    func returnModels(with type: ManufacturersType) -> [AirplaneModel] {
        self.getModels(type: .airbus)
        guard let array = modelsArray else { return [] }
        self.delegate?.updateModels(models: array)
        return array
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
    
    func getModels(type: ManufacturersType) {
        func loadJson(filename fileName: String) -> [AirplaneModel]? { // aqui troca person pelo nome do retorno
            if let url = Bundle.main.url(forResource: "airplanesMock", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(AirplanesResponse.self, from: data)
                    modelsArray = jsonData.data
                    return modelsArray
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

struct AirplanesResponse: Decodable {
    let data: [AirplaneModel]
}

struct AirplaneModel: Decodable {
    let type: ManufacturersType? = .airbus
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "nome_modelo"
    }
}
