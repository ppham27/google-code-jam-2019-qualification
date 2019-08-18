func findPair(_ N: String) -> (String, String) {
    let digits: [Int] = N.compactMap { $0.wholeNumberValue }
    var A: [Int] = []
    var B: [Int] = []
    for d in digits.reversed() {
        if d == 4 {
            A.append(d - 1)
            B.append(1)
        } else {
            A.append(d)
            B.append(0)
        }
    }
    let aStr = A.map { String($0) }.reversed().joined()
    while B.last == 0 { B.removeLast() }
    let bStr = B.map { String($0) }.reversed().joined()
    return (aStr, bStr)
}

let T: Int = Int(readLine()!)!
for t in 1...T {
    let pair = findPair(readLine()!)
    print("Case #\(t): \(pair.0) \(pair.1)")
}
