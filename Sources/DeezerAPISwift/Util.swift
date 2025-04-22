//
//  Util.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/21/25.
//

extension String {

    enum StringConversionError: Error {
        case invalidInt
    }

    // Convenience func for converting to int
    func toInt() throws -> Int {

        guard let intValue = Int(self) else {
            throw StringConversionError.invalidInt
        }
        
        return intValue

    }

}

func deezerCoverUrlToId(_ url: String?) throws -> String? {
    
    guard url != nil else {
        return nil
    }
    
    guard let substr = url!.matches(of: try Regex("\\/(cover|playlist)\\/([[:alnum:]]+)\\/")).first?[2].substring else {
        return nil
    }
    
    return String(substr)
}
