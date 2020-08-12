//
//  ContentView.swift
//  DemoApp
//
//  Created by user176866 on 8/9/20.
//

import SwiftUI

struct ContentView: View {
    let artworks = artData
    @State private var hideVisited = false
    var showArt: [Artwork] {
      hideVisited ? artworks.filter { $0.reaction == "" } : artworks
    }
    var body: some View {
        NavigationView {
            List(showArt) { artwork in
                NavigationLink(destination: DetailView(artwork: artwork)) {
                    Text("\(artwork.reaction) \(artwork.title)")
                }
            }
            .navigationBarTitle("Artworks")
            .navigationBarItems(trailing:
            Toggle(isOn: $hideVisited, label: { Text("Hide Visited") }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
