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
