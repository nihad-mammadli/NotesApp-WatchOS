//
//  HomeViewModel.swift
//  WatchOS todoApp Watch App
//
//  Created by Nebula on 27.07.24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var notes: [Note] = [Note]()
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask)
        return path[0]
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            try data.write(to: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load() {
        DispatchQueue.main.async { [weak self] in
            do {
                let url = self?.getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url!)
                self?.notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                    
            }
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
}
