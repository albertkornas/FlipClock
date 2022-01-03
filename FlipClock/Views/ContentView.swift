import SwiftUI

struct ContentView: View {
    @StateObject var clockViewModel = ClockViewModel()
    var body: some View {
        HomeView().environmentObject(clockViewModel)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
