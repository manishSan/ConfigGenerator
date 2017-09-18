//
//  FileGeneratorInput.swift
//  configen
//
//  Created by Sanwal, Manish on 9/13/17.
//  Copyright © 2017 The App Business. All rights reserved.
//

import Foundation

struct FileGeneratorInput {
    let appName: String
    let inputDictionary: Dictionary<String, AnyObject>
    let hintsDictionary: Dictionary<String, String>
    let outputClass: String
    let outputFile: String
}
