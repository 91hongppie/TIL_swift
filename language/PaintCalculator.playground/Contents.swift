import Foundation

var width: Float = 3.4
var height: Float = 2.1

var bucketsOfPaint: Int {
    get {
        let area = width * height
        let areaCoveredPerBucket: Float = 1.5
        let numberOfBuckets = ceilf(area / areaCoveredPerBucket)
        return Int(numberOfBuckets)
    }
    set {
        let areaCanCover = Double(newValue) * 1.5
        print("This amount of paint can cover an area of \(areaCanCover)")
    }
}

print(bucketsOfPaint)

bucketsOfPaint = 8



