import Foundation
import Combine

class GameState: ObservableObject {
    @Published var hasPlayedGame: Bool

    init(hasPlayedGame: Bool = false) {
        self.hasPlayedGame = hasPlayedGame
    }
}
