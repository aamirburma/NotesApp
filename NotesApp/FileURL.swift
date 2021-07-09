//
//  FileURL.swift
//  NotesApp
//
//  Created by Aamir Burma on 08/07/21.
//
import UIKit
class DataService {
    func getDocDir() -> URL
    {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("path::  \(path[0])")
        return path[0]
    }
}
