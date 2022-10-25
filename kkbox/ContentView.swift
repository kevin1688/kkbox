//
//  ContentView.swift
//  kkbox
//
//  Created by kai wen chen on 2022/10/18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var joke: String = ""
    
    //abcd
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(joke)
            Button {
                Task {
                                let (data, _) = try await URLSession.shared.data(from: URL(string:"https://api.chucknorris.io/jokes/random")!)
                                let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
                                joke = decodedResponse?.value ?? ""
                            }
            } label: {
                Text("擷取資料")
            }

        }
        .padding()
    }
}

struct Joke: Codable {
    let value: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func fetchForecastDataFromCity(city: String) -> String {
        var des = ""
        let urlstr = "https://api.openweathermap.org/data/2.5/\(API.forecast)?q=\(city)&appid=\(API.apiKey)&units=\(API.imperial)&lang=zh_tw"
        print(urlstr)
        if let url = URL(string: urlstr) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                if let data = data {
                    do {
                        des = data.description
                        /*
                        let searchResponse = try decoder.decode(ForecastWeather.self, from: data)
                        self.forecastInfo = searchResponse
                        DispatchQueue.main.async {
                            self.forecastRow = (self.forecastInfo?.list)!
                            self.tableView.reloadData()
                        }*/
                    } catch {
                        des = "error"
                        print("error")
                    }
                }
            }.resume()
        }
    return des
    }
