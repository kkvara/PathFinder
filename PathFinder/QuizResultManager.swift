//
//  QuizResultManager.swift
//  PathFinder
//
//  Created by AFP Student 6 on 10/11/25.
//
import Foundation
import Combine

final class QuizResultManager: ObservableObject {
    static let shared = QuizResultManager()

    @Published private(set) var lastCareer: Career?

    private let key = "quizResultCareer"

    private init() {
        loadResult()
    }

    func saveResult(_ career: Career) {
        UserDefaults.standard.set(career.rawValue, forKey: key)
        lastCareer = career
    }

    func clearResult() {
        UserDefaults.standard.removeObject(forKey: key)
        lastCareer = nil
    }

    private func loadResult() {
        if let raw = UserDefaults.standard.string(forKey: key),
           let career = Career(rawValue: raw) {
            lastCareer = career
        }
    }
}

