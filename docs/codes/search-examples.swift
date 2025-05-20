ContentUnavailableView 的文档里，搜索功能的一种实现

struct ContentView: View {
    @ObservedObject private var viewModel = ContactsViewModel()


    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.searchResults) { contact in
                    NavigationLink {
                        ContactsView(contact)
                    } label: {
                        Text(contact.name)
                    }
                }
            }
            .navigationTitle("Contacts")
            .searchable(text: $viewModel.searchText)
            .overlay { // 注意这里的用法
                if searchResults.isEmpty {
                    ContentUnavailableView.search
                }
            }
        }
    }
}
