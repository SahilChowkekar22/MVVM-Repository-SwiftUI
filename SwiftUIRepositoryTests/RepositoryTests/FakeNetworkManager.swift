import Foundation
@testable import SwiftUIRepository

class FakeNetworkManager: NetworkManagerActions {
    var testPath = ""

    func fetchDataFromURL<T>(urlRequest: any SwiftUIRepository.Requestable, modelType: T.Type) async throws -> T where T: Decodable {
        guard !testPath.isEmpty else {
            print("Error: `testPath` is empty")
            throw NetworkError.invalidURL
        }

        let bundle = Bundle(for: FakeNetworkManager.self)
        print("Searching for test JSON file: \(testPath).json in \(bundle.bundlePath)")

        guard let url = bundle.url(forResource: testPath, withExtension: "json") else {
            print("Error: Test JSON file `\(testPath).json` not found!")
            throw NetworkError.invalidURL
        }

        do {
            print("Found JSON file: \(url)")
            let fileData = try Data(contentsOf: url)
            let parsedData = try JSONDecoder().decode(modelType.self, from: fileData)
            return parsedData
        } catch {
            print("JSON Decoding Error: \(error.localizedDescription)")
            throw error
        }
    }
}
