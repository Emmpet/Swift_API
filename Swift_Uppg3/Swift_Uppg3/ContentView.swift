//
//  ContentView.swift
//  Swift_Uppg3
//
//  Created by Emmelie Elisabeth Gabriella Petersson on 2024-10-24.
//

import SwiftUI

struct ContentView: View {
    
    @State var catText : String = "Cat Fact"
    
    var body: some View {
        
        VStack {
            
            Text("Uppgift 3 Swift")
                .font(.title)
                
            
            Text(catText)
                .font(.title2)
                .padding()
            
            Button("New Cat Fact") {
                Task {
                    await getCatFact()
                }
                
            }
            .padding()
            .border(Color.black, width: 4)
            
        }
        .padding()
        .task {
            await getCatFact()
        }
    }
    
    func getCatFact() async {
        
        let catApi = "https://meowfacts.herokuapp.com/"
        let catUrl = URL (string : catApi)
       
        do  {
            
            let (catdata, _) = try await URLSession.shared.data(from: catUrl!)
            
            if let decodedfact = try? JSONDecoder().decode(catFact.self, from: catdata) {
                
                print(decodedfact.data)
                catText = decodedfact.data.first ?? "No cat fact available"
            }
        } catch {
            print("Error")
        }
    }
}

#Preview {
    ContentView()
}


struct catFact : Codable {
    var data: [String]
}
