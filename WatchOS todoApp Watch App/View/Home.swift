//
//  ContentView.swift
//  WatchOS todoApp Watch App
//
//  Created by Nebula on 26.07.24.
//

import SwiftUI

struct Home: View {
    
    //MARK: - PROPERTY
    
    @State private var text: String = ""
    let navTitle: String = "Notes"
    
    @ObservedObject var viewModel = HomeViewModel()
    
    //MARK: - BODY
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .center,spacing: 6) {
                    TextField("Add New Note", text: $text)
                    
                    Button {
                        
                        guard !text.isEmpty else {return}
                        let note = Note(id: UUID(), text: text)
                        viewModel.notes.append(note)
                        text = ""
                        viewModel.save()
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    .fixedSize()
                    .foregroundColor(.accentColor)
                    
                } //: HStack
                Spacer()
                
                if viewModel.notes.count >= 1 {
                    List {
                        ForEach(0..<viewModel.notes.count, id: \.self) { i in
                            HStack {
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                Text(viewModel.notes[i].text)
                                    .lineLimit(1)
                                    .padding(.leading, 5)
                            } //: HStack
                        } //: Loop
                        .onDelete(perform: viewModel.delete)
                    }
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .padding(10)
                    Spacer()
                } //: List
            } //: VStack
            .navigationTitle(navTitle)
            .onAppear(perform: {
                viewModel.load()
            })
        } //: NavigationStack
    }
}


    //MARK: - PREVIEW

#Preview {
    Home()
}
