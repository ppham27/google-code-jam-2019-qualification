import Foundation

func makeQuery(bit: Int, count: Int) -> String {
    let query = 1 << bit
    return (0..<count).map({ $0 & query > 0 ? "1" : "0" }).joined()
}

func query(_ q: String) -> String{
    print(q); fflush(stdout)
    return readLine() ?? ""
}

func unmask(N: Int, B: Int, F: Int) -> [Int] {
    // Store the complement of the mask.
    var complement = Array(repeating: 0, count: N - B)
    // Find the unmasked indices bit by bit. We can often use less than F
    // queries, but F is small. Might as well use all F queries for clarity.
    for bit in 0..<(F - 1) {
        let summand = 1 << bit
        for (i, indicator) in query(makeQuery(bit: bit, count: N)).enumerated() {
            if indicator.wholeNumberValue == 1 { complement[i] += summand }
        }
    }
    // The following update takes advantage of the fact that there are at most
    // 2^(F - 1) - 1 masked elements.
    let finalQuery = makeQuery(bit: F - 1, count: N)
    var (previousIndicator, segmentOffset) = (finalQuery.first, 0)
    for (i, indicator) in query(finalQuery).enumerated() {
        if previousIndicator != indicator {
            segmentOffset += 1 << (F - 1)
            previousIndicator = indicator
        }
        complement[i] += segmentOffset
    }
    // Now, we can compute the mask by filtering out `complement`.
    var mask: [Int] = complement.first == 0 ? [] : Array(0..<(complement.first ?? N))
    complement.append(N)
    for i in 1..<complement.count {
        for j in (complement[i - 1] + 1)..<complement[i] { mask.append(j) }
    }
    return mask
}

func readTestCaseArgs(_ args: String) -> (N: Int, B: Int, F: Int) {
    let testCase = args.split(separator: " ").compactMap { Int($0) }
    return (testCase[0], testCase[1], testCase[2])
}

let T = Int(readLine() ?? "0") ?? 0
for _ in 1...T {        
    guard let testCaseArgs = readLine() else { break }
    let (N, B, F) = readTestCaseArgs(testCaseArgs)
    let mask = unmask(N: N, B: B, F: F)
    print(mask.map { String($0) }.joined(separator: " ")); fflush(stdout)
    assert(readLine() == "1", "Solution should be correct.")
}
