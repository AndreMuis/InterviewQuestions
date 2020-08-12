import SwiftUI

struct Artwork {
    let id = UUID()
    let artist: String
    let title: String
    let imageName: String
    let reaction: String
}

extension Artwork: Identifiable { }

let artData = [
    Artwork(artist: "Sean Browne", title: "Prince Jonah Kuhio Kalanianaole", imageName: "002_200105", reaction: ""),
    Artwork(artist: "Robert Lee Eskridge", title: "Makahiki Festival Mauka Mural", imageName: "19300102", reaction: "🙏"),
    Artwork(artist: "Kate Kelly", title: "Amelia Earhart Memorial Plaque", imageName: "193701", reaction: ""),
    Artwork(artist: "Marguerite Louis Blasingame", title: "Ka Wai Ake Akua", imageName: "193901-5", reaction: "💕"),
    Artwork(artist: "Juliette May Fraser", title: "Pure Water: Man's Greatest Need", imageName: "195801", reaction: "")
]

