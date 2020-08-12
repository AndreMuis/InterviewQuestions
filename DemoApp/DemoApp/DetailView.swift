//
//  DetailView.swift
//  DemoApp
//
//  Created by user176866 on 8/9/20.
//

import SwiftUI

struct DetailView: View {
    let artwork: Artwork
    var body: some View {
        VStack {
            Image(artwork.imageName)
                .resizable()
                .frame(maxWidth: 300, maxHeight: 600)
                .aspectRatio(contentMode: .fit)
            Text("\(artwork.title)")
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(3)
            Text("Artist: \(artwork.artist)")
                .font(.subheadline)
        }
    .padding()
    .navigationBarTitle(Text(artwork.title), displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(artwork: artData[0])
    }
}
