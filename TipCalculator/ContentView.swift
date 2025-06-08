//
//  ContentView.swift
//  TipCalculator
//
//  Created by Jersie Yang  on 6/7/25.
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
    @State var tip: Double = 0
    @State var withtip: Double = 0

    var body: some View {
        VStack {

            Text("Kent's Tip Calculator")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(35)
                Spacer()
            
            Text("Total with tip: \(String(format: "%.2f", withtip))")

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
                    tip = 0.05
                    withtip = total * tip + total
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
                    tip = 0.1
                    withtip = total * tip + total
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
                    tip = 0.15
                    withtip = total * tip + total
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
}

#Preview {
    ContentView()
}
