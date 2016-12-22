import XCTest
@testable import SlidingSegmentedControl

class SlidingSegmentedControlTests: XCTestCase {

    lazy var slidingSegmentedControl = SlidingSegmentedControl(images: Array(repeating: UIImage(), count: 3))

    // MARK: Main

    func testSuperclass() {
        XCTAssert(slidingSegmentedControl as Any is UIControl)
    }

    func testUnarchiving() {
        let slidingSegmentedControl = SlidingSegmentedControl(coder: .empty)
        XCTAssertNil(slidingSegmentedControl)
    }

    func testFrame() {
        XCTAssertEqual(slidingSegmentedControl.frame, .zero)
    }

    func testSubviews() {
        XCTAssertEqual(slidingSegmentedControl.subviews, [slidingSegmentedControl.selectionView, slidingSegmentedControl.stackView])
    }

    // MARK: Stack view

    func testStackViewType() {
        XCTAssert(slidingSegmentedControl.stackView as Any is UIStackView)
    }

    func testStackViewIsUserInteractionEnabledFalse() {
        XCTAssertFalse(slidingSegmentedControl.stackView.isUserInteractionEnabled)
    }

    func testStackViewEqualDistribution() {
        XCTAssertEqual(slidingSegmentedControl.stackView.distribution, .fillEqually)
    }

    func testStackViewArrangedSubviews() {
        XCTAssertEqual(slidingSegmentedControl.stackView.arrangedSubviews, slidingSegmentedControl.imageViews)
    }

    func testStackViewIgnoresAutoresizingMask() {
        XCTAssertFalse(slidingSegmentedControl.stackView.translatesAutoresizingMaskIntoConstraints)
    }

    func testStackViewTopConstraint() {
        let expectedConstraint = slidingSegmentedControl.stackView.topAnchor.constraint(equalTo: slidingSegmentedControl.topAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testStackViewLeadingConstraint() {
        let expectedConstraint = slidingSegmentedControl.stackView.leadingAnchor.constraint(equalTo: slidingSegmentedControl.leadingAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testStackViewBottomConstraint() {
        let expectedConstraint = slidingSegmentedControl.stackView.bottomAnchor.constraint(equalTo: slidingSegmentedControl.bottomAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testStackViewTrailingConstraint() {
        let expectedConstraint = slidingSegmentedControl.stackView.trailingAnchor.constraint(equalTo: slidingSegmentedControl.trailingAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    // MARK: UIImageViews

    func testImageViewsType() {
        XCTAssertTrue(slidingSegmentedControl.imageViews as Any is [UIImageView])
    }

    func testImageViewCount1() {
        let slidingSegmentedControl = SlidingSegmentedControl(images: [UIImage()])
        XCTAssertEqual(slidingSegmentedControl.imageViews.count, 1)
    }

    func testImageViewCount2() {
        let slidingSegmentedControl = SlidingSegmentedControl(images: [UIImage(), UIImage()])
        XCTAssertEqual(slidingSegmentedControl.imageViews.count, 2)
    }

    func testImageViewsImage1() {
        let image = UIImage()
        let slidingSegmentedControl = SlidingSegmentedControl(images: [image, UIImage()])
        XCTAssertEqual(slidingSegmentedControl.imageViews.first?.image, image)
    }

    func testImageViewsImage2() {
        let image = UIImage()
        let slidingSegmentedControl = SlidingSegmentedControl(images: [UIImage(), image])
        XCTAssertEqual(slidingSegmentedControl.imageViews.last?.image, image)
    }

    func testImageViewsContentMode1() {
        let slidingSegmentedControl = SlidingSegmentedControl(images: [UIImage(), UIImage()])
        XCTAssertEqual(slidingSegmentedControl.imageViews.first?.contentMode, .center)
    }

    func testImageViewsContentMode2() {
        let slidingSegmentedControl = SlidingSegmentedControl(images: [UIImage(), UIImage()])
        XCTAssertEqual(slidingSegmentedControl.imageViews.last?.contentMode, .center)
    }

    func testImageViewsIsAccessibilityElement1() {
        let slidingSegmentedControl = SlidingSegmentedControl(images: [UIImage(), UIImage()])
        XCTAssertTrue(slidingSegmentedControl.imageViews.first?.isAccessibilityElement)
    }

    func testImageViewsIsAccessibilityElement2() {
        let slidingSegmentedControl = SlidingSegmentedControl(images: [UIImage(), UIImage()])
        XCTAssertTrue(slidingSegmentedControl.imageViews.last?.isAccessibilityElement)
    }

    func testImageViewsAccessibilityTraits1() {
        let slidingSegmentedControl = SlidingSegmentedControl(images: [UIImage(), UIImage()])
        XCTAssertEqual(slidingSegmentedControl.imageViews.first?.accessibilityTraits, UIAccessibilityTraitButton)
    }

    func testImageViewsAccessibilityTraits2() {
        let slidingSegmentedControl = SlidingSegmentedControl(images: [UIImage(), UIImage()])
        XCTAssertEqual(slidingSegmentedControl.imageViews.last?.accessibilityTraits, UIAccessibilityTraitButton)
    }

    // MARK: Selected segment

    func testSelectedSegmentType() {
        XCTAssert(slidingSegmentedControl.selectedSegment as Any is Int)
    }

    func testSelectedSegmentDefault() {
        XCTAssertEqual(slidingSegmentedControl.selectedSegment, 0)
    }

    // MARK: Selection view

    func testSelectionViewType() {
        XCTAssert(slidingSegmentedControl.selectionView as Any is UIView)
    }

    func testSelectionViewIsUserInteractionEnabled() {
        XCTAssertFalse(slidingSegmentedControl.selectionView.isUserInteractionEnabled)
    }

    func testSelectionViewBackgroundColor() {
        XCTAssertEqual(slidingSegmentedControl.selectionView.backgroundColor, .white)
    }

    func testSelectionViewIgnoresAutoresizingMask() {
        XCTAssertFalse(slidingSegmentedControl.selectionView.translatesAutoresizingMaskIntoConstraints)
    }

    func testSelectionViewLayerMasksToBounds() {
        XCTAssert(slidingSegmentedControl.selectionView.layer.masksToBounds)
    }

    func testSelectionViewLayerCornerRadius1() {
        testSelectionViewLayerCornerRadius(withStackViewHeight: 10)
    }

    func testSelectionViewLayerCornerRadius2() {
        testSelectionViewLayerCornerRadius(withStackViewHeight: 20)
    }

    func testSelectionViewLayerCornerRadius(withStackViewHeight stackViewHeight: CGFloat, file: StaticString = #file, line: UInt = #line) {
        slidingSegmentedControl.stackView.bounds.size = CGSize(width: 0, height: stackViewHeight)
        slidingSegmentedControl.layoutSubviews()
        XCTAssertEqual(slidingSegmentedControl.selectionView.layer.cornerRadius, stackViewHeight / 2, file: file, line: line)
    }

    func testSelectionViewTopConstraint() {
        let expectedConstraint = slidingSegmentedControl.selectionView.topAnchor.constraint(equalTo: slidingSegmentedControl.stackView.topAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewBottomConstraint() {
        let expectedConstraint = slidingSegmentedControl.selectionView.bottomAnchor.constraint(equalTo: slidingSegmentedControl.stackView.bottomAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewWidthConstraint() {
        let expectedConstraint = slidingSegmentedControl.selectionView.widthAnchor.constraint(equalTo: slidingSegmentedControl.selectionView.heightAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl.selectionView)
    }

    func testSelectionViewWidthConstraintInScrubMode() {
        slidingSegmentedControl.isInScrubMode = true
        let expectedConstraint = slidingSegmentedControl.selectionView.widthAnchor.constraint(equalTo: slidingSegmentedControl.stackView.widthAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewWidthConstraintGetsRemoved() {
        let constraint = slidingSegmentedControl.selectionView.widthAnchor.constraint(equalTo: slidingSegmentedControl.selectionView.heightAnchor)
        slidingSegmentedControl.isInScrubMode = true
        XCTAssertNotConstraint(constraint, inView: slidingSegmentedControl.selectionView)
    }

    func testSelectionViewCenterXConstraintDefault() {
        let expectedConstraint = slidingSegmentedControl.selectionView.centerXAnchor.constraint(equalTo: slidingSegmentedControl.imageViews[0].centerXAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewCenterXConstraint1() { testSelectionViewCenterXConstraint(withSelectedSegment: 1) }
    func testSelectionViewCenterXConstraint2() { testSelectionViewCenterXConstraint(withSelectedSegment: 2) }

    func testSelectionViewCenterXConstraint(withSelectedSegment selectedSegment: Int, file: StaticString = #file, line: UInt = #line) {
        slidingSegmentedControl.selectedSegment = selectedSegment
        let expectedConstraint = slidingSegmentedControl.selectionView.centerXAnchor.constraint(equalTo: slidingSegmentedControl.imageViews[selectedSegment].centerXAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl, file: file, line: line)
    }

    func testSelectionViewCenterXConstraintGetsRemoved() {
        let constraint = slidingSegmentedControl.selectionView.centerXAnchor.constraint(equalTo: slidingSegmentedControl.imageViews[0].centerXAnchor)
        slidingSegmentedControl.selectedSegment = 1
        XCTAssertNotConstraint(constraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewCenterXConstraintInScrubMode1() {
        slidingSegmentedControl.isInScrubMode = true
        let expectedConstraint = slidingSegmentedControl.selectionView.centerXAnchor.constraint(equalTo: slidingSegmentedControl.stackView.centerXAnchor)
        XCTAssertConstraint(expectedConstraint, inView: slidingSegmentedControl)
    }

    func testSelectionViewCenterXConstraintInScrubMode2() {
        // Arrange
        slidingSegmentedControl.isInScrubMode = true

        // Act
        slidingSegmentedControl.selectedSegment = 0

        // Assert
        let constraint = slidingSegmentedControl.selectionView.centerXAnchor.constraint(equalTo: slidingSegmentedControl.imageViews[0].centerXAnchor)
        XCTAssertNotConstraint(constraint, inView: slidingSegmentedControl)
    }

    // MARK: Animate selection change

    func testAnimatingType() {
        XCTAssertTrue(slidingSegmentedControl.animating as Any is Animating.Type)
    }

    func testAnimatingDefault() {
        XCTAssertTrue(slidingSegmentedControl.animating == UIView.self)
    }

    func testAnimationDurationType() {
        XCTAssertTrue(slidingSegmentedControl.animationDuration as Any is TimeInterval)
    }

    func testAnimationDurationDefault() {
        XCTAssertEqual(slidingSegmentedControl.animationDuration, 0.35)
    }

    func testSelectionViewSelectedSegmentAnimationParams1() { testSelectionViewSelectedSegmentAnimationParams(withAnimationDuration: 1) }
    func testSelectionViewSelectedSegmentAnimationParams2() { testSelectionViewSelectedSegmentAnimationParams(withAnimationDuration: 2.5) }

    func testSelectionViewSelectedSegmentAnimationParams(withAnimationDuration animationDuration: TimeInterval, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        AnimatingMock.reset()
        slidingSegmentedControl.animating = AnimatingMock.self
        slidingSegmentedControl.animationDuration = animationDuration

        // Act
        slidingSegmentedControl.selectedSegment = 1

        // Assert
        let expectedParams = AnimatingMock.ConfigurationParams(duration: animationDuration, delay: 0, dampingRatio: 1, velocity: 0, options: [])
        XCTAssertEqual(AnimatingMock.capturedConfiguration, [expectedParams], file: file, line: line)
    }

    func testSelectionViewXAfterSelectedSegmentAnimation1() { testSelectionViewXAfterSelectedSegmentAnimation(withSelectedSegment: 1, numberOfSegments: 3) }
    func testSelectionViewXAfterSelectedSegmentAnimation2() { testSelectionViewXAfterSelectedSegmentAnimation(withSelectedSegment: 2, numberOfSegments: 5) }

    func testSelectionViewXAfterSelectedSegmentAnimation(withSelectedSegment selectedSegment: Int, numberOfSegments: Int, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        AnimatingMock.reset()
        let imageWidth = 40
        let expectedCenterX = CGFloat(imageWidth * selectedSegment + imageWidth / 2)
        let slidingSegmentedControl = SlidingSegmentedControl(images: Array(repeating: UIImage(), count: numberOfSegments))
        slidingSegmentedControl.frame = CGRect(x: 0, y: 0, width: imageWidth * numberOfSegments, height: 30)
        slidingSegmentedControl.animating = AnimatingMock.self
        let initialSelectionViewCenterX = slidingSegmentedControl.selectionView.center.x

        // Act
        slidingSegmentedControl.selectedSegment = selectedSegment
        AnimatingMock.capturedAnimations.first?()

        // Assert
        XCTAssertEqual(initialSelectionViewCenterX, 0, file: file, line: line)
        XCTAssertEqual(slidingSegmentedControl.selectionView.center.x, expectedCenterX, file: file, line: line)
    }

    func testSelectionViewScrubModeAnimationParams1() { testSelectionViewScrubModeAnimationParams(withAnimationDuration: 1) }
    func testSelectionViewScrubModeAnimationParams2() { testSelectionViewScrubModeAnimationParams(withAnimationDuration: 2.5) }

    func testSelectionViewScrubModeAnimationParams(withAnimationDuration animationDuration: TimeInterval, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        AnimatingMock.reset()
        slidingSegmentedControl.animating = AnimatingMock.self
        slidingSegmentedControl.animationDuration = animationDuration

        // Act
        slidingSegmentedControl.isInScrubMode = true

        // Assert
        let expectedParams = AnimatingMock.ConfigurationParams(duration: animationDuration, delay: 0, dampingRatio: 1, velocity: 0, options: [])
        XCTAssertEqual(AnimatingMock.capturedConfiguration, [expectedParams], file: file, line: line)
    }

    func testSelectionViewWidthAfterScrubModeAnimation1() { testSelectionViewWidthAfterScrubModeAnimation(withFrameWidth: 100) }
    func testSelectionViewWidthAfterScrubModeAnimation2() { testSelectionViewWidthAfterScrubModeAnimation(withFrameWidth: 200) }

    func testSelectionViewWidthAfterScrubModeAnimation(withFrameWidth width: CGFloat, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        AnimatingMock.reset()
        slidingSegmentedControl.frame = CGRect(x: 0, y: 0, width: width, height: 30)
        slidingSegmentedControl.animating = AnimatingMock.self
        let initialSelectionViewWidth = slidingSegmentedControl.selectionView.frame.width

        // Act
        slidingSegmentedControl.isInScrubMode = true
        AnimatingMock.capturedAnimations.first?()

        // Assert
        XCTAssertEqual(initialSelectionViewWidth, 0, file: file, line: line)
        XCTAssertEqual(slidingSegmentedControl.selectionView.frame.width, width, file: file, line: line)
    }

    // MARK: Start touch location

    func testStartTouchLocationType() {
        XCTAssertTrue(slidingSegmentedControl.startTouchLocation as Any? is CGPoint?)
    }

    func testStartTouchLocationDefault() {
        XCTAssertNil(slidingSegmentedControl.startTouchLocation)
    }

    // MARK: Segment locator

    func testSegmentLocatorType() {
        XCTAssertTrue(slidingSegmentedControl.segmentLocator as Any? is DefaultSegmentLocator?)
    }

    // MARK: Scrub mode

    func testIsInScrubModeType() {
        XCTAssertTrue(slidingSegmentedControl.isInScrubMode as Any is Bool)
    }

    func testIsInScrubModeDefault() {
        XCTAssertFalse(slidingSegmentedControl.isInScrubMode)
    }

    // MARK: Minimum pan distance for scrub mode

    func testMinPanDistanceType() {
        XCTAssertTrue(slidingSegmentedControl.minPanDistance as Any is CGFloat)
    }

    func testMinPanDistanceDefault() {
        XCTAssertEqual(slidingSegmentedControl.minPanDistance, 10)
    }

    // MARK: Begin tracking

    func testBeginTrackingReturnsTrue() {
        XCTAssertTrue(slidingSegmentedControl.beginTracking(UITouch(), with: nil))
    }

    func testBeginTrackingSetsStartTouchLocation1() { testBeginTrackingSetsStartTouchLocation(withTouchLocation: CGPoint(x: 10, y: 10)) }
    func testBeginTrackingSetsStartTouchLocation2() { testBeginTrackingSetsStartTouchLocation(withTouchLocation: CGPoint(x: 20, y: 20)) }

    func testBeginTrackingSetsStartTouchLocation(withTouchLocation touchLocation: CGPoint, file: StaticString = #file, line: UInt = #line) {
        let touchStub = TouchStub(location: touchLocation, view: slidingSegmentedControl)
        _ = slidingSegmentedControl.beginTracking(touchStub, with: nil)
        XCTAssertEqual(slidingSegmentedControl.startTouchLocation, touchLocation, file: file, line: line)
    }

    func testBeginTrackingCreatesSegmentLocator1() { testBeginTrackingCreatesSegmentLocator(withNumberOfSegments: 3, boundsWidth: 100) }
    func testBeginTrackingCreatesSegmentLocator2() { testBeginTrackingCreatesSegmentLocator(withNumberOfSegments: 2, boundsWidth: 200) }

    func testBeginTrackingCreatesSegmentLocator(withNumberOfSegments numberOfSegments: Int, boundsWidth: CGFloat, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let slidingSegmentedControl = SlidingSegmentedControl(images: Array(repeating: UIImage(), count: numberOfSegments))
        slidingSegmentedControl.bounds = CGRect(x: 0, y: 0, width: boundsWidth, height: 0)
        slidingSegmentedControl.SegmentLocatorType = SegmentLocatorMock.self

        // Act
        _ = slidingSegmentedControl.beginTracking(UITouch(), with: nil)

        // Assert
        let segmentLocatorMock = slidingSegmentedControl.segmentLocator as! SegmentLocatorMock
        XCTAssertEqual(segmentLocatorMock.boundsWidth, boundsWidth, file: file, line: line)
        XCTAssertEqual(segmentLocatorMock.numberOfSegments, numberOfSegments, file: file, line: line)
    }

    // MARK: Continue tracking

    func testContinueTrackingReturnsTrue() {
        _ = slidingSegmentedControl.beginTracking(UITouch(), with: nil)
        XCTAssertTrue(slidingSegmentedControl.continueTracking(UITouch(), with: nil))
    }

    func testContinueWithoutStartTouchLocationReturnsFalse() {
        slidingSegmentedControl.startTouchLocation = nil
        XCTAssertFalse(slidingSegmentedControl.continueTracking(UITouch(), with: nil))
    }

    func testIsInScrubModeTrue1() {
        slidingSegmentedControl.minPanDistance = 2
        testIsInScrubModeWithPan(from: .zero, to: CGPoint(x: slidingSegmentedControl.minPanDistance, y: 0), expected: true)
    }

    func testIsInScrubModeTrue2() {
        let point1 = CGPoint(x: 100, y: 0)
        let point2 = CGPoint(x: point1.x - slidingSegmentedControl.minPanDistance, y: 0)
        testIsInScrubModeWithPan(from: point1, to: point2, expected: true)
    }

    func testIsInScrubModeFalse1() {
        testIsInScrubModeWithPan(from: .zero, to: CGPoint(x: slidingSegmentedControl.minPanDistance - 1, y: 0), expected: false)
    }

    func testIsInScrubModeFalse2() {
        let point1 = CGPoint(x: 100, y: 0)
        let point2 = CGPoint(x: point1.x + 1, y: 0)
        testIsInScrubModeWithPan(from: point1, to: point2, expected: false)
    }

    func testIsInScrubModeWithPan(from point1: CGPoint, to point2: CGPoint, expected expectedIsInScrubMode: Bool, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        slidingSegmentedControl.bounds = CGRect(x: 0, y: 0, width: 100, height: 0)

        // Act
        _ = slidingSegmentedControl.beginTracking(TouchStub(location: point1, view: slidingSegmentedControl), with: nil)
        _ = slidingSegmentedControl.continueTracking(TouchStub(location: point2, view: slidingSegmentedControl), with: nil)

        // Assert
        XCTAssertEqual(slidingSegmentedControl.isInScrubMode, expectedIsInScrubMode, file: file, line: line)
    }

    func testScrubModeStays() {
        // Arrange
        slidingSegmentedControl.bounds = CGRect(x: 0, y: 0, width: 100, height: 0)

        // Act
        _ = slidingSegmentedControl.beginTracking(TouchStub(location: .zero, view: slidingSegmentedControl), with: nil)
        slidingSegmentedControl.isInScrubMode = true
        _ = slidingSegmentedControl.continueTracking(TouchStub(location: .zero, view: slidingSegmentedControl), with: nil)

        // Assert
        XCTAssertTrue(slidingSegmentedControl.isInScrubMode)
    }

    // MARK: Change active segment with a pan

    func testPanCallsSegmentLocator1() {
        testPanCallsSegmentLocator(withLocation: CGPoint(x: slidingSegmentedControl.minPanDistance, y: 1))
    }

    func testPanCallsSegmentLocator2() {
        testPanCallsSegmentLocator(withLocation: CGPoint(x: slidingSegmentedControl.minPanDistance * 20, y: 2))
    }

    func testPanCallsSegmentLocator(withLocation location: CGPoint, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let segmentLocatorMock = SegmentLocatorMock()
        slidingSegmentedControl.segmentLocator = segmentLocatorMock
        slidingSegmentedControl.startTouchLocation = .zero
        let touchStub = TouchStub(location: location, view: slidingSegmentedControl)

        // Act
        _ = slidingSegmentedControl.continueTracking(touchStub, with: nil)

        // Assert
        XCTAssertEqual(segmentLocatorMock.xCoordinates, [touchStub.location.x], file: file, line: line)
    }

    func testPanDoesNotCallSegmentLocator1() {
        testPanDoesNotCallSegmentLocator(withXDistance: slidingSegmentedControl.minPanDistance - 1)
    }

    func testPanDoesNotCallSegmentLocator2() {
        slidingSegmentedControl.minPanDistance = 100
        testPanDoesNotCallSegmentLocator(withXDistance: slidingSegmentedControl.minPanDistance - 1)
    }

    func testPanDoesNotCallSegmentLocator(withXDistance xDistance: CGFloat, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let segmentLocatorMock = SegmentLocatorMock()
        slidingSegmentedControl.segmentLocator = segmentLocatorMock
        slidingSegmentedControl.startTouchLocation = .zero
        let touchStub = TouchStub(location: CGPoint(x: xDistance, y: 0), view: slidingSegmentedControl)

        // Act
        _ = slidingSegmentedControl.continueTracking(touchStub, with: nil)

        // Assert
        XCTAssertEqual(segmentLocatorMock.xCoordinates, [], file: file, line: line)
    }

    func testPanCallsActiveSegmentInScrubMode() {
        slidingSegmentedControl.isInScrubMode = true
        testPanCallsSegmentLocator(withLocation: CGPoint(x: slidingSegmentedControl.minPanDistance, y: 1))
    }

    func testPanChangesSelection1() { testPanChangesSelection(withSegmentIndex: 1) }
    func testPanChangesSelection2() { testPanChangesSelection(withSegmentIndex: 2) }

    func testPanChangesSelection(withSegmentIndex segmentIndex: Int, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let segmentLocatorStub = SegmentLocatorStub(indexOfSegment: segmentIndex)
        slidingSegmentedControl.segmentLocator = segmentLocatorStub
        slidingSegmentedControl.startTouchLocation = .zero
        let panTouch = TouchStub(location: CGPoint(x: slidingSegmentedControl.minPanDistance, y: 0), view: slidingSegmentedControl)

        // Act
        _ = slidingSegmentedControl.continueTracking(panTouch, with: nil)

        // Assert
        XCTAssertEqual(slidingSegmentedControl.selectedSegment, segmentIndex, file: file, line: line)
    }

    // MARK: End tracking

    func testIsInScrubModeIsFalseAfterEndTracking() {
        slidingSegmentedControl.isInScrubMode = true
        slidingSegmentedControl.endTracking(nil, with: nil)
        XCTAssertFalse(slidingSegmentedControl.isInScrubMode)
    }

    func testEndTrackingWithNilTouch() {
        slidingSegmentedControl.endTracking(nil, with: nil)
    }

    // MARK: Change active segment with a tap

    func testTapCallsSegmentLocator1() { testTapCallsSegmentLocator(withLocation: CGPoint(x: 0, y: 0)) }
    func testTapCallsSegmentLocator2() { testTapCallsSegmentLocator(withLocation: CGPoint(x: 0, y: 1)) }

    func testTapCallsSegmentLocator(withLocation location: CGPoint, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let segmentLocatorMock = SegmentLocatorMock()
        slidingSegmentedControl.segmentLocator = segmentLocatorMock
        let endTouch = TouchStub(location: location, view: slidingSegmentedControl)

        // Act
        slidingSegmentedControl.endTracking(endTouch, with: nil)

        // Assert
        XCTAssertEqual(segmentLocatorMock.xCoordinates, [endTouch.location.x], file: file, line: line)
    }

    func testTapChangesSelection1() { testTapChangesSelection(withSegmentIndex: 1) }
    func testTapChangesSelection2() { testTapChangesSelection(withSegmentIndex: 2) }

    func testTapChangesSelection(withSegmentIndex segmentIndex: Int, file: StaticString = #file, line: UInt = #line) {
        // Arrange
        let segmentLocatorStub = SegmentLocatorStub(indexOfSegment: segmentIndex)
        slidingSegmentedControl.segmentLocator = segmentLocatorStub

        // Act
        slidingSegmentedControl.endTracking(TouchStub(location: .zero, view: slidingSegmentedControl), with: nil)

        // Assert
        XCTAssertEqual(slidingSegmentedControl.selectedSegment, segmentIndex, file: file, line: line)
    }

    // MARK: Cancel tracking

    func testIsInScrubModeIsFalseAfterCancelTracking() {
        slidingSegmentedControl.isInScrubMode = true
        slidingSegmentedControl.cancelTracking(with: nil)
        XCTAssertFalse(slidingSegmentedControl.isInScrubMode)
    }

}

class TouchStub: UITouch {

    let location: CGPoint
    let touchView: UIView

    init(location: CGPoint, view: UIView) {
        self.location = location
        self.touchView = view
    }

    override func location(in view: UIView?) -> CGPoint {
        guard view == self.touchView else {
            XCTFail("View is not equal to \(self.view)")
            return .zero
        }
        return location
    }

}

final class SegmentLocatorMock: SegmentLocator {

    let numberOfSegments: Int
    let boundsWidth: CGFloat

    convenience init() {
        self.init(numberOfSegments: 0, boundsWidth: 0)
    }

    init(numberOfSegments: Int, boundsWidth: CGFloat) {
        self.numberOfSegments = numberOfSegments
        self.boundsWidth = boundsWidth
    }

    var xCoordinates: [CGFloat] = []

    func indexOfSegment(forX x: CGFloat) -> Int {
        xCoordinates.append(x)
        return 0
    }

}

struct SegmentLocatorStub: SegmentLocator {

    let indexOfSegment: Int

    init(indexOfSegment: Int) {
        self.indexOfSegment = indexOfSegment
    }

    init(numberOfSegments: Int, boundsWidth: CGFloat) {
        indexOfSegment = 0
    }

    func indexOfSegment(forX x: CGFloat) -> Int {
        return indexOfSegment
    }

}

class AnimatingMock: Animating {

    struct ConfigurationParams: Equatable {
        let duration: TimeInterval
        let delay: TimeInterval
        let dampingRatio: CGFloat
        let velocity: CGFloat
        let options: UIViewAnimationOptions
    }

    static var capturedConfiguration: [ConfigurationParams] = []
    static var capturedAnimations: [() -> Void] = []

    static func reset() {
        capturedConfiguration = []
        capturedAnimations = []
    }

    static func animate(withDuration duration: TimeInterval, delay: TimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat, options: UIViewAnimationOptions, animations: @escaping () -> Void, completion: ((Bool) -> Swift.Void)?) {
        let params = ConfigurationParams(duration: duration, delay: delay, dampingRatio: dampingRatio, velocity: velocity, options: options)
        capturedConfiguration.append(params)
        capturedAnimations.append(animations)
    }

}

func == (lhs: AnimatingMock.ConfigurationParams, rhs: AnimatingMock.ConfigurationParams) -> Bool {
    return String(describing: lhs) == String(describing: rhs)
}
