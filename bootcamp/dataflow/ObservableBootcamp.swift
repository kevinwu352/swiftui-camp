//
//  ObservableBootcamp.swift
//  bootcamp
//
//  Created by Nick Sarno on 1/27/24.
//

import SwiftUI

@Observable class ObservableViewModel { // ios 17

    var title: String = "Some title"
    //@ObservationIgnored var value: String = "Some title"
}

struct ObservableBootcamp: View {
    
    @State private var viewModel = ObservableViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            Button(viewModel.title) {
                viewModel.title = "new title!"
            }
            
            SomeChildView(viewModel: viewModel)
            
            SomeThirdView()
        }
        .environment(viewModel) // ios 17
    }
}

struct SomeChildView: View {
    
    @Bindable var viewModel: ObservableViewModel // ios 17
    
    var body: some View {
        Button(viewModel.title) {
            viewModel.title = "asdkjf;alsdjfl;ksadjf!"
        }
    }
}

struct SomeThirdView: View {
    
    @Environment(ObservableViewModel.self) var vm

    var body: some View {
        Button(vm.title) {
            vm.title = "Third view!!!!!"
        }
    }
}

#Preview {
    ObservableBootcamp()
}
