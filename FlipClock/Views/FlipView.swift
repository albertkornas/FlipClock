import SwiftUI

struct FlipView: View {

    init(viewModel: FlipViewModel) {
        self.viewModel = viewModel
    }
    @State var putAway = false
    
    @ObservedObject var viewModel: FlipViewModel
    let timer = Timer.publish(every: 0.55, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                SingleFlipView(text: viewModel.newValue ?? "", type: .top)
                SingleFlipView(text: viewModel.oldValue ?? "", type: .top)
                    .rotation3DEffect(.init(degrees: self.viewModel.animateTop ? -90 : .zero),
                                      axis: (1, 0, 0),
                                      anchor: .bottom,
                                      perspective: 0.5)
            }
            
            Color.separator
                .frame(height: 1)
            ZStack {
                SingleFlipView(text: viewModel.newValue ?? "", type: .bottom)
                    .rotation3DEffect(.init(degrees: self.viewModel.animateBottom ? .zero : 90),
                                      axis: (1, 0, 0),
                                      anchor: .top,
                                      perspective: 0.5)
                BadRectangle(viewModel: self.viewModel, putAways: $putAway)
                    .onReceive(timer) { input in
                        self.putAway.toggle()
                    }

            }
        }
            .fixedSize()
    }

}

struct BadRectangle: View {
    @Binding var putAway: Bool
    @ObservedObject var viewModel: FlipViewModel
    
    init(viewModel: FlipViewModel, putAways: Binding<Bool>) {
        self.viewModel = viewModel
        self._putAway = putAways
    }
    
    var body: some View {
        Rectangle()
            .opacity(putAway == true ? 0.0 : 1.0)
            .mask(SingleFlipView(text: viewModel.oldValue ?? "", type: .bottom))
    }
}
