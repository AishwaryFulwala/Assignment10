//
//  File.swift
//  assignment10
//
//  Created by DCS on 11/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation

class File {
    static func getDocDir() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("Doc Dir \(paths[0])")
        return paths[0]
    }
    
    static func getfilenm() -> [String] {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path
        
        var nm = [String]()
        do {
            nm = try FileManager.default.contentsOfDirectory(atPath: paths)
            return nm
        }
        catch {
            print(error)
        }
        return nm
    }
}
