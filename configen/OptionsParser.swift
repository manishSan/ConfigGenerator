//
//  OptionsParser.swift
//  configen
//
//  Created by Dónal O'Brien on 10/08/2016.
//  Copyright © 2016 The App Business. All rights reserved.
//

import Foundation

class OptionsParser {

    let appName: String
    let inputPlistFilePath: String
    let inputHintsFilePath: String
    let outputClassName: String
    let outputClassDirectory: String
    let isObjC: Bool

    init(appName: String) {
        let cli = CommandLineKit()
        let inputPlistFilePath = StringOption(shortFlag: "p", longFlag: "plist-path", required: true, helpMessage: "Path to the input plist file")
        let inputHintsFilePath = StringOption(shortFlag: "h", longFlag: "hints-path", required: true, helpMessage: "Path to the input hints file")
        let outputClassName = StringOption(shortFlag: "n", longFlag: "class-name", required: true, helpMessage: "The output config class name")
        let outputClassDirectory = StringOption(shortFlag: "o", longFlag: "output-directory", required: true, helpMessage: "The output config class directory")
        let useObjc = BoolOption(shortFlag: "c", longFlag: "objective-c", helpMessage: "Whether to generate Objective-C files instead of Swift")
        cli.addOptions(inputPlistFilePath, inputHintsFilePath, outputClassName, outputClassDirectory, useObjc)

        do {
            try cli.parse()
        } catch {
            cli.printUsage(error)
            fatalError()
        }

        self.appName = appName
        self.inputPlistFilePath = inputPlistFilePath.value!
        self.inputHintsFilePath = inputHintsFilePath.value!
        self.outputClassName = outputClassName.value!
        self.outputClassDirectory = outputClassDirectory.value!
        self.isObjC = useObjc.value
    }

    lazy var plistDictionary: Dictionary<String, AnyObject> = { [unowned self] in

        let inputPlistFilePathURL = URL(fileURLWithPath: self.inputPlistFilePath)
        guard let data = try? Data(contentsOf: inputPlistFilePathURL) else {
            fatalError("No data at path: \(self.inputPlistFilePath)")
        }

        guard let plistDictionary = (try? PropertyListSerialization.propertyList(from: data, options: [], format: nil)) as? Dictionary<String, AnyObject> else {
            fatalError("Failed to create plist")
        }

        return plistDictionary
        }()

    /// get hints dictionary for a class
    /// if the key passes in nil then returns root dictionary
    ///
    /// - Parameter key: Dictionary<String, String>
    func hints(key: String? = nil) -> Dictionary<String, String>? {
        if let className = key {
            return hintsDictionary[className]
        } else {
            return hintsDictionary["root"]
        }
    }

    /// currently we support only 1 leve of nesting

    private lazy var hintsDictionary: Dictionary<String, Dictionary<String, String>> = { [unowned self] in
        guard let hintsString = try? String(contentsOfFile: self.inputHintsFilePath, encoding: String.Encoding.utf8) else {
            fatalError("No data at path: \(self.inputHintsFilePath)")
        }

        var hintsDictionary = Dictionary<String, Dictionary<String, String>>()

        let hintLines = hintsString.components(separatedBy: CharacterSet.newlines)
        for hintLine in hintLines where hintLine.trimmed.characters.count > 0 {
            let hints = hintLine.components(separatedBy: CharacterSet(charactersIn: ":")).map { $0.trimmed }
            guard hints.count == 2 else {
                fatalError("Expected \"variableName : Type\", instead of \"\(hintLine)\"")
            }

            let keyParts = hints[0].components(separatedBy: CharacterSet(charactersIn: ".")).map { $0.trimmed }
            guard keyParts.count <= 2 else {
                fatalError("Currently Only supports one nesting level - variableName : \"\(hintLine)\"")
            }

            let key: String
            let (variableName, type): (String, String)

            if keyParts.count == 1 {
                key = "root"
                (variableName, type) = (keyParts[0], hints[1])
            } else {
                key = keyParts[0]
                (variableName, type) = (keyParts[1], hints[1])
            }

            if var dict = hintsDictionary[key] {
                dict[variableName] = type
                hintsDictionary[key] = dict
            } else {
                var newDict = Dictionary<String, String>()
                newDict[variableName] = type
                hintsDictionary[key] = newDict
            }
        }

        return hintsDictionary
        }()
}

