//
//  BPIModel.swift
//  NomadridesTask
//
//  Created by IM-LP-1819 on 12/12/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

@MainActor class CurrencyModel: ObservableObject {
    @Published var currency : Currency!
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // data get from server side
    func getCurrency() async {
        startTimer()
        let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!
        let urlSession = URLSession.shared
        do {
            let (data, response) = try await urlSession.data(from: url)
            print(response)
            self.currency = try JSONDecoder().decode(Currency.self, from: data)
            stopTimer()
        }
        catch {
            // Error handling in case the data couldn't be loaded
            // For now, only display the error on the console
            debugPrint("Error loading \(url): \(String(describing: error))")
            stopTimer()
        }
    }
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every:1, on: .main, in: .common).autoconnect()
    }
}
// MARK: - Welcome
struct Currency: Codable {
    //let time: Time
    //let disclaimer, chartName: String
    let bpi: Bpi
}

// MARK: - Bpi
struct Bpi: Codable {
    let usd, gbp, eur: Eur
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

// MARK: - Eur
struct Eur: Codable {
    let code, symbol, rate, eurDescription: String
    let rateFloat: Double
    
    enum CodingKeys: String, CodingKey {
        case code, symbol, rate
        case eurDescription = "description"
        case rateFloat = "rate_float"
    }
}

// MARK: - Time
struct Time: Codable {
    let updated: String
    let updatedISO: Date
    let updateduk: String
}


@objc protocol SetValuesa {
    var name : String {set get}
    var age : Int {set get}
    @objc optional func fffff()
}





