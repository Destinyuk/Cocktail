//
//  ContentView.swift
//  Cocktails
//
//  Created by Ash on 27/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var drinks = [Drink]()
    @State var query: String = ""
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
        func getRecipe() {
            Api().loadData(query: self.query) {(drinks) in
                self.drinks = drinks
        }
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                VStack(alignment: .leading) {
                    VStack {
                        TextField(
                            "Enter a drink or spirit",
                            text: $query
                        )
                        .multilineTextAlignment(.center)
                        .font(Font.title.weight(.light))
                        .foregroundColor(Color.white)
                        .padding()
                        
                        HStack {
                            Spacer()
                            Button(action: getRecipe) {
                                Text("Get Recipe")
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            }
                            .font(.title2)
                            .foregroundColor(Color.white)
                            Spacer()
                        }
                    }
                    .padding(30.0)
                    
                    List {
                        ForEach(drinks) { drink in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(drink.name)
                                        .font(.title)
                                        .padding(.bottom)
                                    Text("Ingredients: \(drink.ingredients.formatted())")
                                        .font(.title3)
                                }
                                .minimumScaleFactor(0.01)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("Instructions: \(drink.instructions)")
                                }
                                .minimumScaleFactor(0.01)
                                .font(.system(size: 13.0))
                            }
                            .listRowBackground(Color.clear)
                            .foregroundColor(.black)
                            .padding()
                        }
                    }
                }
            )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
