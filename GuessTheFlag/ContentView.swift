//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alex Babou on 5/4/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var scoreCount = 0
    
    @State private var rotateCorrect = 0.0
    @State private var animateOpacity = 1.0
    @State private var selectedFlag = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .font(.title2)
                        .fontWeight(.light)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }.foregroundColor(.black)
                
                ForEach(0 ..< 4) { number in
                    Button(action : { self.flagTapped(number) } ) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                            .shadow(color: .black, radius: 3)
                            .opacity(number != correctAnswer && showingScore ? animateOpacity : 1)
                            .rotation3DEffect(.degrees(number == correctAnswer ? rotateCorrect : 0), axis: (x: 0, y: 1, z: 0))
                    }
                }
                
                LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]), startPoint: .top, endPoint: .bottom).frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(30)
                    .overlay(Text("Score: \(scoreCount)")
                                .font(.title)
                                .foregroundColor(.black)
                                .fontWeight(.medium))
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage + "Current score: \(scoreCount) points"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreCount += 5
            scoreTitle = "Correct Answer"
            scoreMessage = ""
            
            withAnimation {
                rotateCorrect += 360
                animateOpacity = 0.25
            }
        } else {
            scoreCount -= 5
            scoreTitle = "Wrong Answer"
            scoreMessage = "That's the flag of \(countries[number])!\n"
            
            withAnimation {
                animateOpacity = 0.25
            }
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
