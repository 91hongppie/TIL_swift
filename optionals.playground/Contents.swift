
//var payer1Username: String = nil

var player1Username: String? = nil

player1Username = "jackbauerisawesome"

//print(player1Username) // Optional("jackbauerisawesome")

print(player1Username!) // "jackbauerisawesome"

var unwrappedP1Username = player1Username!

player1Username = nil

if player1Username != nil {
    print(player1Username)
}

for score in 0...5 {
    print(score)
}

print(max(3, 5))
