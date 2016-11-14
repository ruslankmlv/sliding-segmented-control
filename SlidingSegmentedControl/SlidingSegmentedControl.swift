import UIKit

public class SlidingSegmentedControl: UIControl {

    // MARK: Initialization

    public init(images: [UIImage]) {
        imageViews = images.map { UIImageView(image: $0) }
        super.init(frame: .zero)
        initStackView()
        initSelectionView()
    }

    let imageViews: [UIImageView]

    required public init?(coder: NSCoder) {
        return nil
    }

    public var selectedSegment = 0 {
        didSet {
            updateSelectionViewLeadingConstraint()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        selectionView.layer.cornerRadius = min(stackView.bounds.width, stackView.bounds.height)
    }

    // MARK: Stack view

    let stackView = UIStackView()

    private func initStackView() {
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageViews.forEach(stackView.addArrangedSubview)
        NSLayoutConstraint.activate(stackViewConstraints)
    }

    private var stackViewConstraints: [NSLayoutConstraint] {
        return [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }


    // MARK: Selection view

    let selectionView = UIView()

    func initSelectionView() {
        insertSubview(selectionView, belowSubview: stackView)
        selectionView.layer.masksToBounds = true
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(selectionViewStaticConstraints)
        updateSelectionViewLeadingConstraint()
    }

    private var selectionViewStaticConstraints: [NSLayoutConstraint] {
        return [
            selectionView.topAnchor.constraint(equalTo: stackView.topAnchor),
            selectionView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            selectionView.widthAnchor.constraint(equalTo: imageViews[0].widthAnchor)
        ]
    }

    private lazy var selectionViewLeadingConstraint: NSLayoutConstraint = SlidingSegmentedControl.makeSelectionViewLeadingConstraint(slidingSegmentedControl: self)

    private var selectedButton: UIImageView {
        return imageViews[selectedSegment]
    }

    private func updateSelectionViewLeadingConstraint() {
        selectionViewLeadingConstraint.isActive = false
        selectionViewLeadingConstraint = SlidingSegmentedControl.makeSelectionViewLeadingConstraint(slidingSegmentedControl: self)
        selectionViewLeadingConstraint.isActive = true
    }

    private static func makeSelectionViewLeadingConstraint(slidingSegmentedControl: SlidingSegmentedControl) -> NSLayoutConstraint {
        return slidingSegmentedControl.selectionView.leadingAnchor.constraint(equalTo: slidingSegmentedControl.selectedButton.leadingAnchor)
    }

    // MARK: Touch tracking

    var touchStartLocation: CGPoint?

    var activeSegmentCalculator: ActiveSegmentCalculator = DefaultActiveSegmentCalculator(numberOfElements: 0, elementWidth: 0, boundsWidth: 0)

    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        touchStartLocation = touch.location(in: self)
        return true
    }

    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard let touchStartLocation = touchStartLocation else {
            // don't do fatal error, because we can't ensure UIKit always calls beginTracking (though it probably does)
            return false
        }
        let location = touch.location(in: self)
        selectedSegment = activeSegmentCalculator.indexOfActiveSegment(forTouchLocation: location)
        isInScrubMode = abs(location.x - touchStartLocation.x) >= minPanDistance
        return true
    }

    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        // required, but don't know how to test this
        super.endTracking(touch, with: event)

        isInScrubMode = false

        guard let touch = touch else { return }

        selectedSegment = activeSegmentCalculator.indexOfActiveSegment(forTouchLocation: touch.location(in: self))
    }

    // MARK: Scrub mode

    var isInScrubMode = false

    var minPanDistance: CGFloat = 10
    
}
