let T = Int(readLine()!)!

for t in 1...T {
    let _ = readLine()
    let path = readLine()!
    let newPath = path.map { $0 == "E" ? "S" : "E"}.joined()
    print("Case #\(t): \(newPath)")
}
