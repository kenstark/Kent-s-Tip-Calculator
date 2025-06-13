//
//  ContentView.swift
//  TipCalculator
//
//  Created by Kent Stark  on 6/7/25.
//
// input box
// display input number
// display tip amount
// display input + top (total)
// changeable tip percent choice
//


import SwiftUI

struct ContentView: View {
    @State var num: String = ""
    @State var total: Double = 0
    @State var tipPercent: Double = 0
    @State var withtip: Double = 0
    @State var calculated: calculatedTip?

    var body: some View {
        VStack {

            Text("Kent's Tip Calculator")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(35)
                Spacer()
            
            Text("Total with tip: \(String(format: "%.2f", calculated?.totalWithTip ?? 0))")

            TextField("Enter your total", text: $num)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)
                .shadow(radius: 3)
                .frame(width: 200, height: 30)
                .onChange(of: num) {
                    oldvalue, value in
                    let filtered = value.filter { $0.isNumber }
                    if filtered != value {
                        num = filtered
                    }
                    total = Double(num) ?? 0
                }
                .padding()
            HStack {
                Button {
                    tipPercent = 0.05
                    Task {
                        do {
                            calculated = try await calculate()
                            print (calculated ?? 0)
                        } catch AppError.invalidURL {
                            print("Invalid URL")
                        } catch AppError.invalidResponse {
                            print("Invalid Response")
                        } catch AppError.invalidData {
                            print("Invalid Data")
                        } catch {
                            print("Unexpected error")
                        }
                    }
                } label: {
                    Text("5%")
                }
                .fontWeight(.semibold)
                .foregroundStyle(.blue)
                .padding()
                .frame(maxWidth: 80)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 2)
                )
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                
                Button {
                    tipPercent = 0.1
                    Task {
                        do {
                            calculated = try await calculate()
                            print (calculated ?? 0)
                        } catch AppError.invalidURL {
                            print("Invalid URL")
                        } catch AppError.invalidResponse {
                            print("Invalid Response")
                        } catch AppError.invalidData {
                            print("Invalid Data")
                        } catch {
                            print("Unexpected error")
                        }
                    }
                } label: {
                    Text("10%")
                }
                .fontWeight(.semibold)
                .foregroundStyle(.blue)
                .padding()
                .frame(maxWidth: 80)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 2)
                )
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                
                Button {
                    tipPercent = 0.15
                    Task {
                        do {
                            calculated = try await calculate()
                            print (calculated ?? 0)
                        } catch AppError.invalidURL {
                            print("Invalid URL")
                        } catch AppError.invalidResponse {
                            print("Invalid Response")
                        } catch AppError.invalidData {
                            print("Invalid Data")
                        } catch {
                            print("Unexpected error")
                        }
                    }
                } label: {
                    Text("15%")
                }
                .fontWeight(.semibold)
                .foregroundStyle(.blue)
                .padding()
                .frame(maxWidth: 80)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 2)
                )
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
            }
            Button {
                num = ""
                withtip = 0
            } label: {
                Text("Clear")
            }
            .fontWeight(.semibold)
            .foregroundStyle(.red)
            .padding()
            .frame(maxWidth: 120)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.red, lineWidth: 2)
            )
            .shadow(color: Color.red.opacity(0.2), radius: 5, x: 0, y: 4)
        }
        Spacer()
        .padding()
        }
    func calculate() async throws -> calculatedTip {
        let endpoint = "https://calculate-325721882541.us-west1.run.app?total=\(total)&tip=\(tipPercent)"

        guard let url = URL(string: endpoint) else {
            throw AppError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        print (data)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200  else {
            throw AppError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(calculatedTip.self, from: data)
        } catch var e {
            print(e)
            throw AppError.invalidData
        }
    }
}


#Preview {
    ContentView()
}

struct calculatedTip: Codable {
    let totalWithTip: Double
}

enum AppError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
