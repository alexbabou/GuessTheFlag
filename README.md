# GuessTheFlag
A flag quiz project app from Hacking with Swift

## Demo
<img src="https://dendev.net/Demos/GuessTheFlag-demo.gif"/>

## Notes
#### Under the hood:
Below is a shuffled array to randomize the flags, a random Int generator to choose a random flag as our correct answer, 
and the variables that decide when our alerts are shown, the content of that alert, and a variable to save your score.
```swift
    @State private var countries = ["Estonia", "France", "Germany", "Ireland",
    "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var scoreCount = 0

```

This is the ForEach that displays the next 4 shuffled flag from the previous array, a button is then added with the action 
sending which flag was tapped to the flagTapped function.
```swift
    ForEach(0 ..< 4) { number in
        Button(action : { self.flagTapped(number) } ) {
            Image(self.countries[number])
                 .renderingMode(.original)
                 .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                 .shadow(color: .black, radius: 3)
                 .opacity(0.8)
         }
     }
```

The flagTapped function takes in the tapped flag, and using a conditional statement, decides whether it's correct or not. 
The score and the alert are the updated to notify the user whether they picked the right or wrong answer.
```swift
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreCount += 5
            scoreTitle = "Correct Answer"
            scoreMessage = ""
        } else {
            scoreCount -= 5
            scoreTitle = "Wrong Answer"
            scoreMessage = "That's the flag of \(countries[number])!\n"
        }
        showingScore = true
    }
```

The following is the alert we use to notify the user of their result, what flag they tapped on, and their current score.
```swift
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage + 
            "Current score: \(scoreCount) points"), dismissButton: 
            .default(Text("Continue")) {
                self.askQuestion()
            })
        }
```

## Credit
Check out this project at [Hacking with Swift](https://www.hackingwithswift.com/100/swiftui)
