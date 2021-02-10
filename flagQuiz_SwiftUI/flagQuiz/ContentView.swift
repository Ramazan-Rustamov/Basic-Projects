//
//  ContentView.swift
//  flagQuiz
//
//  Created by Nasraddin Rustamov on 2/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [ "Azerbaijan", "Italy", "Belgium", "Russia", "UK", "France", "Spain", "Portugal", "Brazil"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var rightOrWrong = ""
    @State private var showingAlert = false
    
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20){
                Text ("Choose the flag")
                Text ("\(self.countries[correctAnswer])")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.largeTitle)
                VStack(spacing: 30){
                    ForEach(0..<3) { number in
                        Button(action: {
                            self.flagTapped(number)
                            self.showingAlert = true
                        }) {
                            Image (self.countries[number])
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 250, height: 130, alignment: .center)
                        }
                    }
                }
                Text ("Your score: \(score)")
                    .font(.title)
                
            }
        }.alert(isPresented: $showingAlert) {
            Alert (title: Text (rightOrWrong), message: Text ("Your score: \(score)"), dismissButton: .default(Text ("Continue")) {
                askNextQuestion()
            })
        }
    }
    func askNextQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            rightOrWrong = "Correct!"
        }else {
            score -= 1
            rightOrWrong = "Incorrect! Correct answer is \(countries[correctAnswer])"
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
