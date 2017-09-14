//
//  main.swift
//  configen
//
//  Created by Sam Dods on 29/09/2015.
//  Copyright © 2015 The App Business. All rights reserved.
//

import Foundation

let appName = (CommandLine.arguments.first! as NSString).lastPathComponent
let parser = OptionsParser(appName: appName)

guard let hints = parser.hints() else {
    fatalError("Missing root entries from root file")
}

let fileGenerator = FileGenerator(input: FileGeneratorInput(appName: parser.appName,
                                                            inputDictionary: parser.plistDictionary,
                                                            hintsDictionary: hints,
                                                            outputClass: parser.outputClassName),
                                  options: parser)

if parser.isObjC {
  let template = ObjectiveCTemplate(outClassDir: parser.outputClassDirectory,
                                    outClassName: parser.outputClassName)
  fileGenerator.generateHeaderFile(withTemplate: template)
  fileGenerator.generateImplementationFile(withTemplate: template)
} else {
    let template = SwiftTemplate(outClassDir: parser.outputClassDirectory,
                                 outClassName: parser.outputClassName)
  fileGenerator.generateImplementationFile(withTemplate: template)
}

