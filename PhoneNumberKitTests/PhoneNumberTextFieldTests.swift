//
//  PhoneNumberTextFieldTests.swift
//  PhoneNumberKitTests
//
//  Created by Travis Kaufman on 10/4/19.
//  Copyright © 2019 Roy Marmelstein. All rights reserved.
//

#if os(iOS)

import PhoneNumberKit
import UIKit
import XCTest

final class PhoneNumberTextFieldTests: XCTestCase {
    private var phoneNumberKit: PhoneNumberKit!

    override func setUp() {
        super.setUp()
        phoneNumberKit = PhoneNumberKit()
    }

    override func tearDown() {
        phoneNumberKit = nil
        super.tearDown()
    }

    func testWorksWithPhoneNumberKitInstance() {
        let textField = PhoneNumberTextField(withPhoneNumberKit: phoneNumberKit)
        textField.partialFormatter.defaultRegion = "US"
        textField.text = "4125551212"
        XCTAssertEqual(textField.text, "(412) 555-1212")
    }

    func testWorksWithFrameAndPhoneNumberKitInstance() {
        let frame = CGRect(x: 10.0, y: 20.0, width: 400.0, height: 250.0)
        let textField = PhoneNumberTextField(frame: frame, phoneNumberKit: phoneNumberKit)
        textField.partialFormatter.defaultRegion = "US"
        XCTAssertEqual(textField.frame, frame)
        textField.text = "4125551212"
        XCTAssertEqual(textField.text, "(412) 555-1212")
    }

    func testPhoneNumberProperty() {
        let textField = PhoneNumberTextField(withPhoneNumberKit: phoneNumberKit)
        textField.partialFormatter.defaultRegion = "US"
        textField.text = "4125551212"
        XCTAssertNotNil(textField.phoneNumber)
        textField.text = ""
        XCTAssertNil(textField.phoneNumber)
    }

    func testUSPhoneNumberWithFlag() {
        let pnk = PhoneNumberKit()
        let tf = PhoneNumberTextField(withPhoneNumberKit: pnk)
        tf.partialFormatter.defaultRegion = "US"
        tf.withFlag = true
        tf.text = "4125551212"
        XCTAssertNotNil(tf.flagButton)
        XCTAssertEqual(tf.flagButton.titleLabel?.text, " 🇺🇸 ")
    }

    func testNonUSPhoneNumberWithFlag() {
        let pnk = PhoneNumberKit()
        let tf = PhoneNumberTextField(withPhoneNumberKit: pnk)
        tf.partialFormatter.defaultRegion = "US"
        tf.withFlag = true
        tf.text = "5872170177"
        XCTAssertNotNil(tf.flagButton)
        XCTAssertEqual(tf.flagButton.titleLabel?.text, " 🇨🇦 ")
    }
}

#endif
