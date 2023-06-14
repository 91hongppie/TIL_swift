import UIKit

func loveCalculator() {
    let loveScore = Int.random(in: 0...100)
    if 80 <= loveScore {
        print("You love each other like Kanye loves Kanye")
    } else if 40 < loveScore {
        print("you go together like Coke and Mentos")
    } else {
        print("You'll be forever alone")
    }
}

loveCalculator()
