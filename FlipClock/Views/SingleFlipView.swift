import SwiftUI

struct SingleFlipView: View {

    init(text: String, type: FlipType) {
        self.text = text
        self.type = type
    }

    var body: some View {
        someText
    }

    var someText: some View {
        ZStack {
//            Rectangle()
//                .foregroundColor(.white)
//                .cornerRadius(4)
//                .clipped()
//                .frame(width: 34, height: 25, alignment: type.alignment)
//            GradientView()
//                .mask(Text(text)
//                        .font(.system(size: 40))
//                        .fontWeight(.heavy)
//                        .fixedSize()
//                        .padding(type.padding, -20)
//                        .frame(width: 15, height: 20, alignment: type.alignment)
//                        .padding(type.paddingEdges, 10)
//                        .clipped()
//                        .cornerRadius(4)
//                        .padding(type.padding, -4.5)
//                        .clipped())
            Rectangle()
                .cornerRadius(4)
                .clipped()
                
                .frame(width: 34, height: 25, alignment: type.alignment)
                .inverseMask(
                    Text(text)
                            .font(.system(size: 40))
                            .fontWeight(.heavy)
                            .fixedSize()
                            .padding(type.padding, -20)
                            .frame(width: 15, height: 20, alignment: type.alignment)
                            .padding(type.paddingEdges, 10)
                            .clipped()
                            .cornerRadius(4)
                            .padding(type.padding, -4.5)
                            .clipped()
                )
            }
    }
    enum FlipType {
        case top
        case bottom

        var padding: Edge.Set {
            switch self {
            case .top:
                return .bottom
            case .bottom:
                return .top
            }
        }

        var paddingEdges: Edge.Set {
            switch self {
            case .top:
                return [.top, .leading, .trailing]
            case .bottom:
                return [.bottom, .leading, .trailing]
            }
        }

        var alignment: Alignment {
            switch self {
            case .top:
                return .bottom
            case .bottom:
                return .top
            }
        }

    }

    // MARK: - Private

    private let text: String
    private let type: FlipType

}

extension View {
    // view.inverseMask(_:)
    public func inverseMask<M: View>(_ mask: M) -> some View {
        // exchange foreground and background
        let inversed = mask
            .foregroundColor(.black)  // hide foreground
            .background(Color.white)  // let the background stand out
            .compositingGroup()       // ⭐️ composite all layers
            .luminanceToAlpha()       // ⭐️ turn luminance into alpha (opacity)
        return self.mask(inversed)
    }
}
