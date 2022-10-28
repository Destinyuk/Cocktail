//
//  Drink.swift
//  Cocktails
//
//  Created by Ash on 28/10/2022.
//

import Foundation

import Foundation

struct Drink: Codable, Identifiable {
    let id = UUID()
    var name: String!
    var ingredients: [String]!
    var instructions: String!
    
}

class Api: ObservableObject {
    @Published var drinks = [Drink]()
    
    func loadData(query:String, completion:@escaping ([Drink]) -> ()) {
        
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/cocktail?name="+query!)!
        var request = URLRequest(url: url)
        request.setValue("GNb1wRzrprV4OB7mZK4vQbEf3lWGeW7sAJaQsvPS", forHTTPHeaderField: "X-Api-Key")
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8))
            let drinks = try! JSONDecoder().decode([Drink].self, from: data)
            
            DispatchQueue.main.async {
                completion(drinks)
            }
            
        }
        .resume()
    }
}
