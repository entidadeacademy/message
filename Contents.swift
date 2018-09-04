extension String {
    static let encodingBase: [Character] = "N1u7TVn.kdfOE2?3xw/vJM0CFU6QcsYm8,Ga:lHgW4pyBDoIP!tL9XS5KZzAbhrRjqei".map { $0 }

    private static func shiftCharacterForMessageFromEntity(_ character: Character, key: Character, signal: Int) -> Character {
        let keyShift = (signal * Int(String.encodingBase.index(of: key) ?? 0) + String.encodingBase.count) % String.encodingBase.count

        if let characterIndex = String.encodingBase.index(of: character) {
            let newIndex = (characterIndex + keyShift) % String.encodingBase.count
            return String.encodingBase[newIndex]
        } else {
            return character
        }
    }

    func decodeMessageFromEntity(withKey key: String) -> String {
        if key.isEmpty {
            return self
        }
        let keyCharacters = Array(key)
        return String(self.enumerated().map { String.shiftCharacterForMessageFromEntity($0.element, key: keyCharacters[$0.offset % key.count], signal: 1) })
    }
}


let message = "GNqaZNtO FQ3iwHbFs rJ .UwmrPgTaB Nar álaaQV jKohFKej .ob Uijz j1PTN cs PFbQa 7o 8NlB 7a vebG,A .xWtmhhdO ?jRB mmF Z,8ob hjeQxbiQN m Lbur Nnq7,UQW"

print(message.decodeMessageFromEntity(withKey: "esta não é a chave verdadeira, descubram com URGÊNCIA!"))
