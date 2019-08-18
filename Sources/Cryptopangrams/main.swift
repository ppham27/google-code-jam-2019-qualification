func gcd<T: BinaryInteger>(_ x: T, _ y: T) -> T {
    let a = max(x, y)
    let b = x + y - a
    let r = a % b
    return r == 0 ? b : gcd(b, r)
}

func unique<T: Comparable>(_ xs: [T]) -> [T] {
    var sorted: [T] = []
    for x in xs.sorted() {
        if sorted.last != x { sorted.append(x) }
    }
    return sorted
}

func decode<T: BinaryInteger>(_ encodedText: [T]) -> String {
    var decodedText: [T] = Array(repeating: -1, count: encodedText.count + 1)      
    for i in 1..<encodedText.count {
        if encodedText[i - 1] != encodedText[i] {
            decodedText[i] = gcd(encodedText[i - 1], encodedText[i])
            for j in stride(from: i - 1, through: 0, by: -1) {
                decodedText[j] = encodedText[j] / decodedText[j + 1]
            }
            for j in i..<encodedText.count {
                decodedText[j + 1] = encodedText[j] / decodedText[j]
            }
            break
        }
    }
    let keys = unique(decodedText)
    assert(keys.count == 26, "There must be 26 primes.")
    var characters: [T : String] = [:]
    let A = Int(Character("A").asciiValue!)
    for (i, key) in keys.enumerated() {
        characters[key] = String(UnicodeScalar(A + i)!)
    }  
    return decodedText.compactMap { characters[$0] }.joined()
}

let T = Int(readLine()!)!

for t in 1...T {
    let _ = readLine()
    let encodedText = readLine().flatMap {
        $0.split(separator: " ").compactMap { Int($0) }
    }
    print("Case #\(t): \(decode(encodedText ?? []))")
}
