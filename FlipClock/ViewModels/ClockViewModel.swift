import Foundation
import Combine
import SwiftUI

class ClockViewModel: ObservableObject {
    
    public var minsToChange: Int = 60
    
    public func getRemainingMinutes() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let goalDate = calendar.date(bySettingHour: 20, minute: 0, second: 0, of: date)!
        
        let diffComponents = calendar.dateComponents([.hour, .minute], from: date, to: goalDate)
        let hours = diffComponents.hour!
        let minutes = diffComponents.minute!
        
        let res = (hours*60)+minutes
        return res
    }
    
    @Published var gradientValues: [[Double]] = [[42, 210, 255], [255, 246, 108], [245, 166, 63]] //morning
    
    private var afternoonGradientValues: [[Double]] = [[20, 132, 205], [42, 210, 255], [123, 217, 246]]
    
    @Published var militaryTime: Bool = false {
        didSet {
            self.updateDateFormatter()
        }
    }
    
    private func updateDateFormatter() {
        self.timeFormatter.dateFormat = militaryTime == true ? "HHmmss" : "hhmmss"
    }
    
    init() {
        setupTimer()
    }

    private(set) lazy var flipViewModels = { (0...5).map { _ in FlipViewModel() } }()

    // MARK: - Private
    
    @objc func updateTimer() {
        self.minsToChange = getRemainingMinutes()
        for i in 0..<gradientValues.count {
            for j in 0..<gradientValues[i].count {
                var diff:Double = afternoonGradientValues[i][j]-gradientValues[i][j]
                diff /= Double(self.minsToChange)
                gradientValues[i][j] += diff
                print("Updating value by \(diff)")
            }
        }
    }

    private func setupTimer() {
        _ = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .map { [timeFormatter] in timeFormatter.string(from: $0) }
            .removeDuplicates()
            .sink(receiveValue: { [weak self] in self?.setTimeInViewModels(time: $0) })
            .store(in: &cancellables)
    }

    private func setTimeInViewModels(time: String) {
        zip(time, flipViewModels).forEach { number, viewModel in
            viewModel.text = "\(number)"
        }
    }

    private var cancellables = Set<AnyCancellable>()
    private let timeFormatter = DateFormatter.timeFormatter

}
