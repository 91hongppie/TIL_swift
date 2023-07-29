//
//  main.swift
//  Structs vs Classes
//
//  Created by Kyuhong Jo on 2023/07/29.
//

import Foundation

//var hero = ClassHero(name: "Iron Man", universe: "Marvel")
//
//var anotherMarvelHero = hero
//anotherMarvelHero.name = "The Hulk"
//
//var avengers = [hero, anotherMarvelHero]
//
//avengers[0].name = "Thor"
//
//print("hero name = \(hero.name)")
//print("anotherMarvelHero name = \(anotherMarvelHero.name)")
//print("first avanger name = \(avengers[0].name)")

let hero = StructHero(name: "Iron Man", universe: "Marvel")

print(hero.reverseName())
