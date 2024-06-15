import SwiftUI

struct ContentView: View {
    @StateObject var dataService = DataService()

    var body: some View {
        NavigationView {
            Group {
                if dataService.isLoading {
                    ProgressView()
                } else if let error = dataService.error {
                    ErrorView(error: error) {
                        dataService.loadData()
                    }
                } else {
                    List(dataService.contentItems) { item in
                        ListRowView(item: item)
                    }
                }
            }
            .onAppear {
                dataService.loadData()
            }
            .navigationTitle("Content")
        }
    }
}
