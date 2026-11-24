/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

// THIS FILE IS GENERATED. DO NOT EDIT MANUALLY.
// Generator: scripts/bridge_generator/generate.py
// Schema: scripts/bridge_generator/schemas/barcode.json
//
// Fixture-driven round-trip tests: every fixture under
// serialization/tests/<module>/<name>/valid/ must decode without throwing
// (and its re-encoded/re-decoded form must decode too); every fixture
// under .../invalid/ must throw UNLESS the validation keyword that rejects
// it (minimum, pattern, oneOf, ...) is outside the set the hand-rolled
// validator supports, in which case the test is skipped (`XCTSkip`) rather
// than asserting a throw the code can't produce.

// For `UnknownPropertyError`, which core declares once for every module.
import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

// A union's Swift shape is a `protocol`, which has no synthesized `Decodable`
// dispatch of its own -- `JSONDecoder().decode(BarcodeArAnnotation.self, ...)` fails to
// compile against a protocol existential. This box gives the decoder a
// concrete type to allocate, routing through the discriminator-dispatching
// parser the same way a nested property does (schema-types.swift.jinja2).
private struct BarcodeArAnnotationTestBox: Decodable {
    let value: SchemaTypes.BarcodeArAnnotation
    init(from decoder: Decoder) throws {
        value = try SchemaTypes.BarcodeArAnnotationParser.parse(from: decoder)
    }
}
// A union's Swift shape is a `protocol`, which has no synthesized `Decodable`
// dispatch of its own -- `JSONDecoder().decode(BarcodeArHighlight.self, ...)` fails to
// compile against a protocol existential. This box gives the decoder a
// concrete type to allocate, routing through the discriminator-dispatching
// parser the same way a nested property does (schema-types.swift.jinja2).
private struct BarcodeArHighlightTestBox: Decodable {
    let value: SchemaTypes.BarcodeArHighlight
    init(from decoder: Decoder) throws {
        value = try SchemaTypes.BarcodeArHighlightParser.parse(from: decoder)
    }
}

final class SchemaTypesTest: XCTestCase {

    func testBarcodeArModuleFinishAnnotationForBarcodeAcceptsValid_no_annotation_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "barcodeId": "abc123", "annotation": null }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArModuleFinishAnnotationForBarcode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeArModuleFinishAnnotationForBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeArModuleFinishAnnotationForBarcodeAcceptsValid_with_custom_annotation_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "abc123",
              "annotation": { "type": "barcodeArCustomAnnotation", "annotationTrigger": "highlightTap" }
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArModuleFinishAnnotationForBarcode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeArModuleFinishAnnotationForBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeArModuleFinishAnnotationForBarcodeRejectsInvalid_missing_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "annotation": null }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArModuleFinishAnnotationForBarcode.self, from: raw)
        )
    }

    func testBarcodeArModuleFinishAnnotationForBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "barcodeId": "abc123", "annotation": null, "unexpected": true }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArModuleFinishAnnotationForBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArAnnotationAcceptsValid_custom_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "type": "barcodeArCustomAnnotation", "annotationTrigger": "highlightTap" }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(BarcodeArAnnotationTestBox.self, from: raw).value
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(BarcodeArAnnotationTestBox.self, from: reEncoded))
    }

    func testBarcodeArAnnotationAcceptsValid_info_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArInfoAnnotation",
              "anchor": "top",
              "width": "medium",
              "annotationTrigger": "highlightTap",
              "body": []
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(BarcodeArAnnotationTestBox.self, from: raw).value
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(BarcodeArAnnotationTestBox.self, from: reEncoded))
    }

    func testBarcodeArAnnotationAcceptsValid_popover_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArPopoverAnnotation",
              "buttons": [
                {
                  "icon": {
                    "icon": "checkmark",
                    "iconColor": null,
                    "backgroundColor": null,
                    "backgroundStrokeColor": null,
                    "backgroundStrokeWidth": 2.0,
                    "backgroundShape": null
                  },
                  "text": "Accept",
                  "textColor": "#FFFFFFFF",
                  "textSize": 14,
                  "fontFamily": "systemDefault"
                }
              ],
              "annotationTrigger": "highlightTap"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(BarcodeArAnnotationTestBox.self, from: raw).value
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(BarcodeArAnnotationTestBox.self, from: reEncoded))
    }

    func testBarcodeArAnnotationAcceptsValid_responsive_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArResponsiveAnnotation",
              "annotationTrigger": "highlightTap",
              "annotationsByThreshold": { "1.0": null }
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(BarcodeArAnnotationTestBox.self, from: raw).value
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(BarcodeArAnnotationTestBox.self, from: reEncoded))
    }

    func testBarcodeArAnnotationAcceptsValid_status_icon_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArStatusIconAnnotation",
              "icon": {
                "icon": "checkmark",
                "iconColor": "#FFFFFFFF",
                "backgroundColor": null,
                "backgroundStrokeColor": null,
                "backgroundStrokeWidth": 2.0,
                "backgroundShape": "circle"
              },
              "textColor": "#FFFFFFFF",
              "backgroundColor": "#00A45DFF",
              "annotationTrigger": "barcodeScan"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(BarcodeArAnnotationTestBox.self, from: raw).value
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(BarcodeArAnnotationTestBox.self, from: reEncoded))
    }

    func testBarcodeArAnnotationRejectsInvalid_missing_type_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {}
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(BarcodeArAnnotationTestBox.self, from: raw))
    }

    func testBarcodeArAnnotationRejectsInvalid_unknown_type_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "type": "barcodeArBubbleAnnotation" }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(BarcodeArAnnotationTestBox.self, from: raw))
    }

    func testBarcodeArInfoAnnotationAcceptsValid_all_properties_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArInfoAnnotation",
              "hasTip": true,
              "isEntireAnnotationTappable": true,
              "anchor": "bottom",
              "width": "large",
              "annotationTrigger": "highlightTapAndBarcodeScan",
              "header": {
                "text": "Item info",
                "icon": {
                  "icon": "checkmark",
                  "iconColor": "#FFFFFFFF",
                  "backgroundColor": null,
                  "backgroundStrokeColor": null,
                  "backgroundStrokeWidth": 2.0,
                  "backgroundShape": "circle"
                },
                "textSize": 14,
                "textColor": "#FFFFFFFF",
                "backgroundColor": "#000000FF",
                "fontFamily": "systemSans"
              },
              "footer": {
                "text": "Tap for more",
                "icon": null,
                "textSize": 12,
                "textColor": null,
                "backgroundColor": null,
                "fontFamily": "systemDefault"
              },
              "body": [
                {
                  "text": "In stock: 12",
                  "textColor": "#000000FF",
                  "textSize": 14,
                  "textAlign": "start",
                  "fontFamily": "modernMono",
                  "leftIcon": {
                    "icon": "lowStock",
                    "iconColor": null,
                    "backgroundColor": null,
                    "backgroundStrokeColor": null,
                    "backgroundStrokeWidth": 2.0,
                    "backgroundShape": null
                  },
                  "isLeftIconTappable": true,
                  "rightIcon": null,
                  "isRightIconTappable": false
                }
              ],
              "backgroundColor": "#1A1A1AFF",
              "hasListener": true
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArInfoAnnotation.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArInfoAnnotation.self, from: reEncoded))
    }

    func testBarcodeArInfoAnnotationAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArInfoAnnotation",
              "anchor": "top",
              "width": "medium",
              "annotationTrigger": "highlightTap",
              "body": []
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArInfoAnnotation.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArInfoAnnotation.self, from: reEncoded))
    }

    func testBarcodeArInfoAnnotationRejectsInvalid_body_component_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArInfoAnnotation",
              "anchor": "top",
              "width": "medium",
              "annotationTrigger": "highlightTap",
              "body": [
                {
                  "text": "In stock: 12",
                  "textColor": "#000000FF",
                  "textAlign": "start",
                  "fontFamily": "modernMono",
                  "unexpected": true
                }
              ]
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArInfoAnnotation.self, from: raw)) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArInfoAnnotationRejectsInvalid_invalid_width_enum_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArInfoAnnotation",
              "anchor": "top",
              "width": "huge",
              "annotationTrigger": "highlightTap",
              "body": []
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArInfoAnnotation.self, from: raw))
    }

    func testBarcodeArInfoAnnotationRejectsInvalid_missing_body_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArInfoAnnotation",
              "anchor": "top",
              "width": "medium",
              "annotationTrigger": "highlightTap"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArInfoAnnotation.self, from: raw))
    }

    func testBarcodeArPopoverAnnotationAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArPopoverAnnotation",
              "buttons": [
                {
                  "icon": {
                    "icon": "checkmark",
                    "iconColor": "#FFFFFFFF",
                    "backgroundColor": null,
                    "backgroundStrokeColor": null,
                    "backgroundStrokeWidth": 2.0,
                    "backgroundShape": "circle"
                  },
                  "text": "Accept",
                  "textColor": "#FFFFFFFF",
                  "textSize": 14,
                  "fontFamily": "systemDefault",
                  "index": 0
                }
              ],
              "annotationTrigger": "highlightTap"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotation.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotation.self, from: reEncoded))
    }

    func testBarcodeArPopoverAnnotationAcceptsValid_with_anchor_and_disabled_button_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArPopoverAnnotation",
              "buttons": [
                {
                  "icon": {
                    "icon": "xMark",
                    "iconColor": null,
                    "backgroundColor": null,
                    "backgroundStrokeColor": null,
                    "backgroundStrokeWidth": 2.0,
                    "backgroundShape": "square"
                  },
                  "text": "Reject",
                  "textColor": "#FF0000FF",
                  "textSize": 14,
                  "fontFamily": "modernMono",
                  "enabled": false
                }
              ],
              "isEntirePopoverTappable": true,
              "anchor": "top",
              "annotationTrigger": "barcodeScan",
              "hasListener": true
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotation.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotation.self, from: reEncoded))
    }

    func testBarcodeArPopoverAnnotationRejectsInvalid_button_missing_text_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArPopoverAnnotation",
              "buttons": [
                {
                  "icon": {
                    "icon": "checkmark",
                    "iconColor": null,
                    "backgroundColor": null,
                    "backgroundStrokeColor": null,
                    "backgroundStrokeWidth": 2.0,
                    "backgroundShape": null
                  },
                  "textColor": "#FFFFFFFF",
                  "textSize": 14,
                  "fontFamily": "systemDefault"
                }
              ],
              "annotationTrigger": "highlightTap"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotation.self, from: raw))
    }

    func testBarcodeArPopoverAnnotationRejectsInvalid_missing_buttons_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArPopoverAnnotation",
              "annotationTrigger": "highlightTap"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotation.self, from: raw))
    }

    func testBarcodeArStatusIconAnnotationAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArStatusIconAnnotation",
              "icon": {
                "icon": "checkmark",
                "iconColor": "#FFFFFFFF",
                "backgroundColor": null,
                "backgroundStrokeColor": null,
                "backgroundStrokeWidth": 2.0,
                "backgroundShape": "circle"
              },
              "textColor": "#FFFFFFFF",
              "backgroundColor": "#00A45DFF",
              "annotationTrigger": "barcodeScan"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArStatusIconAnnotation.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArStatusIconAnnotation.self, from: reEncoded))
    }

    func testBarcodeArStatusIconAnnotationAcceptsValid_with_jsmobile_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArStatusIconAnnotation",
              "icon": {
                "icon": "checkmark",
                "iconColor": "#FFFFFFFF",
                "backgroundColor": null,
                "backgroundStrokeColor": null,
                "backgroundStrokeWidth": 2.0,
                "backgroundShape": "circle"
              },
              "textColor": "#FFFFFFFF",
              "backgroundColor": "#00A45DFF",
              "annotationTrigger": "barcodeScan",
              "barcode": {
                "symbology": "ean13Upca",
                "data": "9783598215438",
                "rawData": "OTc4MzU5ODIxNTQzOA==",
                "compositeData": null,
                "compositeRawData": "",
                "addOnData": null,
                "encodingRanges": [
                  {
                    "ianaName": "UTF-8",
                    "startIndex": 0,
                    "endIndex": 13
                  }
                ],
                "location": {
                  "topLeft": { "x": 0.1, "y": 0.1 },
                  "topRight": { "x": 0.9, "y": 0.1 },
                  "bottomRight": { "x": 0.9, "y": 0.3 },
                  "bottomLeft": { "x": 0.1, "y": 0.3 }
                },
                "isGS1DataCarrier": false,
                "compositeFlag": "none",
                "isColorInverted": false,
                "symbolCount": 13,
                "frameID": 42,
                "moduleCountX": 0,
                "moduleCountY": 0,
                "structuredAppendData": null
              }
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArStatusIconAnnotation.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArStatusIconAnnotation.self, from: reEncoded))
    }

    func testBarcodeArStatusIconAnnotationAcceptsValid_with_text_and_anchor_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArStatusIconAnnotation",
              "hasTip": true,
              "icon": {
                "icon": "exclamationMark",
                "iconColor": null,
                "backgroundColor": null,
                "backgroundStrokeColor": null,
                "backgroundStrokeWidth": 2.0,
                "backgroundShape": null
              },
              "text": "Check item",
              "textColor": "#FFFFFFFF",
              "backgroundColor": "#FF0000FF",
              "annotationTrigger": "highlightTapAndBarcodeScan",
              "anchor": "top"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArStatusIconAnnotation.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArStatusIconAnnotation.self, from: reEncoded))
    }

    func testBarcodeArStatusIconAnnotationRejectsInvalid_invalid_anchor_enum_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArStatusIconAnnotation",
              "icon": {
                "icon": "checkmark",
                "iconColor": null,
                "backgroundColor": null,
                "backgroundStrokeColor": null,
                "backgroundStrokeWidth": 2.0,
                "backgroundShape": null
              },
              "textColor": "#FFFFFFFF",
              "backgroundColor": "#00A45DFF",
              "annotationTrigger": "barcodeScan",
              "anchor": "center"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArStatusIconAnnotation.self, from: raw))
    }

    func testBarcodeArStatusIconAnnotationRejectsInvalid_missing_icon_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArStatusIconAnnotation",
              "textColor": "#FFFFFFFF",
              "backgroundColor": "#00A45DFF",
              "annotationTrigger": "barcodeScan"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArStatusIconAnnotation.self, from: raw))
    }

    func testBarcodeArResponsiveAnnotationAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArResponsiveAnnotation",
              "annotationTrigger": "highlightTap",
              "annotationsByThreshold": {
                "0.4": {
                  "type": "barcodeArInfoAnnotation",
                  "anchor": "top",
                  "width": "small",
                  "annotationTrigger": "highlightTap",
                  "body": []
                },
                "1.0": null
              }
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArResponsiveAnnotation.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArResponsiveAnnotation.self, from: reEncoded))
    }

    func testBarcodeArResponsiveAnnotationAcceptsValid_legacy_shape_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArResponsiveAnnotation",
              "annotationTrigger": "barcodeScan",
              "closeUpAnnotation": {
                "type": "barcodeArInfoAnnotation",
                "anchor": "top",
                "width": "large",
                "annotationTrigger": "barcodeScan",
                "body": []
              },
              "farAwayAnnotation": null,
              "threshold": 0.5
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArResponsiveAnnotation.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArResponsiveAnnotation.self, from: reEncoded))
    }

    func testBarcodeArResponsiveAnnotationAcceptsValid_mixed_annotation_types_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArResponsiveAnnotation",
              "annotationTrigger": "highlightTap",
              "annotationsByThreshold": {
                "0.3": {
                  "type": "barcodeArStatusIconAnnotation",
                  "icon": {
                    "icon": "checkmark",
                    "iconColor": "#FFFFFFFF",
                    "backgroundColor": null,
                    "backgroundStrokeColor": null,
                    "backgroundStrokeWidth": 2.0,
                    "backgroundShape": "circle"
                  },
                  "textColor": "#FFFFFFFF",
                  "backgroundColor": "#00A45DFF",
                  "annotationTrigger": "highlightTap"
                },
                "0.6": {
                  "type": "barcodeArInfoAnnotation",
                  "anchor": "top",
                  "width": "small",
                  "annotationTrigger": "highlightTap",
                  "body": []
                },
                "1.0": {
                  "type": "barcodeArPopoverAnnotation",
                  "buttons": [
                    {
                      "icon": {
                        "icon": "checkmark",
                        "iconColor": "#FFFFFFFF",
                        "backgroundColor": null,
                        "backgroundStrokeColor": null,
                        "backgroundStrokeWidth": 2.0,
                        "backgroundShape": "circle"
                      },
                      "text": "Accept",
                      "textColor": "#FFFFFFFF",
                      "textSize": 14,
                      "fontFamily": "systemDefault",
                      "index": 0
                    }
                  ],
                  "annotationTrigger": "highlightTap",
                  "hasListener": true
                }
              }
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArResponsiveAnnotation.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArResponsiveAnnotation.self, from: reEncoded))
    }

    func testBarcodeArResponsiveAnnotationRejectsInvalid_missing_annotation_trigger_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArResponsiveAnnotation",
              "annotationsByThreshold": { "1.0": null }
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArResponsiveAnnotation.self, from: raw))
    }

    func testBarcodeArResponsiveAnnotationRejectsInvalid_nested_responsive_child_json() throws {
        throw XCTSkip("unenforceable keyword: oneOf (on generator-omitted property 'annotationsByThreshold')")
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArResponsiveAnnotation",
              "annotationTrigger": "highlightTap",
              "annotationsByThreshold": {
                "1.0": {
                  "type": "barcodeArResponsiveAnnotation",
                  "annotationTrigger": "highlightTap",
                  "annotationsByThreshold": {
                    "1.0": null
                  }
                }
              }
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArResponsiveAnnotation.self, from: raw))
    }

    func testBarcodeArResponsiveAnnotationRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArResponsiveAnnotation",
              "annotationTrigger": "highlightTap",
              "annotationsByThreshold": { "1.0": null },
              "unexpected": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArResponsiveAnnotation.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArCustomAnnotationAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "type": "barcodeArCustomAnnotation", "annotationTrigger": "highlightTap" }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArCustomAnnotation.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArCustomAnnotation.self, from: reEncoded))
    }

    func testBarcodeArCustomAnnotationAcceptsValid_update_wire_shape_with_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "type": "barcodeArCustomAnnotation", "annotationTrigger": "highlightTap", "barcodeId": "abc123" }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArCustomAnnotation.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArCustomAnnotation.self, from: reEncoded))
    }

    func testBarcodeArCustomAnnotationRejectsInvalid_missing_annotation_trigger_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "type": "barcodeArCustomAnnotation" }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArCustomAnnotation.self, from: raw))
    }

    func testBarcodeArModuleFinishHighlightForBarcodeAcceptsValid_no_highlight_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "barcodeId": "abc123", "highlight": null }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArModuleFinishHighlightForBarcode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeArModuleFinishHighlightForBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeArModuleFinishHighlightForBarcodeAcceptsValid_with_circle_highlight_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "abc123",
              "highlight": {
                "type": "barcodeArCircleHighlight",
                "preset": "dot",
                "brush": {
                  "fill": { "color": "#00000000" },
                  "stroke": { "color": "#FFFFFFFF", "width": 2 }
                },
                "size": 32
              }
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArModuleFinishHighlightForBarcode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeArModuleFinishHighlightForBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeArModuleFinishHighlightForBarcodeRejectsInvalid_missing_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "highlight": null }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArModuleFinishHighlightForBarcode.self, from: raw)
        )
    }

    func testBarcodeArModuleFinishHighlightForBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "barcodeId": "abc123", "highlight": null, "unexpected": true }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArModuleFinishHighlightForBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArHighlightAcceptsValid_circle_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArCircleHighlight",
              "preset": "dot",
              "brush": {
                "fill": { "color": "#00000000" },
                "stroke": { "color": "#FFFFFFFF", "width": 2 }
              },
              "size": 32
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(BarcodeArHighlightTestBox.self, from: raw).value
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(BarcodeArHighlightTestBox.self, from: reEncoded))
    }

    func testBarcodeArHighlightAcceptsValid_custom_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "type": "barcodeArCustomHighlight" }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(BarcodeArHighlightTestBox.self, from: raw).value
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(BarcodeArHighlightTestBox.self, from: reEncoded))
    }

    func testBarcodeArHighlightAcceptsValid_rectangle_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArRectangleHighlight",
              "brush": {
                "fill": { "color": "#00000000" },
                "stroke": { "color": "#FFFFFFFF", "width": 2 }
              }
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(BarcodeArHighlightTestBox.self, from: raw).value
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(BarcodeArHighlightTestBox.self, from: reEncoded))
    }

    func testBarcodeArHighlightRejectsInvalid_missing_type_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {}
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(BarcodeArHighlightTestBox.self, from: raw))
    }

    func testBarcodeArHighlightRejectsInvalid_unknown_type_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "type": "barcodeArDiamondHighlight" }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(BarcodeArHighlightTestBox.self, from: raw))
    }

    func testBarcodeArCircleHighlightAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArCircleHighlight",
              "preset": "dot",
              "brush": {
                "fill": { "color": "#00000000" },
                "stroke": { "color": "#FFFFFFFF", "width": 2 }
              },
              "size": 32
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArCircleHighlight.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArCircleHighlight.self, from: reEncoded))
    }

    func testBarcodeArCircleHighlightAcceptsValid_update_wire_shape_with_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArCircleHighlight",
              "preset": "dot",
              "brush": {
                "fill": { "color": "#00000000" },
                "stroke": { "color": "#FFFFFFFF", "width": 2 }
              },
              "size": 32,
              "barcodeId": "abc123"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArCircleHighlight.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArCircleHighlight.self, from: reEncoded))
    }

    func testBarcodeArCircleHighlightAcceptsValid_with_icon_and_pulsing_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArCircleHighlight",
              "preset": "icon",
              "brush": {
                "fill": { "color": "#00000000" },
                "stroke": { "color": "#FFFFFFFF", "width": 2 }
              },
              "icon": {
                "icon": "checkmark",
                "iconColor": "#FFFFFFFF",
                "backgroundColor": "#00A45DFF",
                "backgroundStrokeColor": null,
                "backgroundStrokeWidth": 2.0,
                "backgroundShape": "circle"
              },
              "size": 40,
              "isPulsing": true
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArCircleHighlight.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArCircleHighlight.self, from: reEncoded))
    }

    func testBarcodeArCircleHighlightRejectsInvalid_invalid_preset_enum_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArCircleHighlight",
              "preset": "ring",
              "size": 32
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArCircleHighlight.self, from: raw))
    }

    func testBarcodeArCircleHighlightRejectsInvalid_missing_size_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArCircleHighlight",
              "preset": "dot"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArCircleHighlight.self, from: raw))
    }

    func testBarcodeArCircleHighlightRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArCircleHighlight",
              "preset": "dot",
              "size": 32,
              "unexpected": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArCircleHighlight.self, from: raw)) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArRectangleHighlightAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArRectangleHighlight",
              "brush": {
                "fill": { "color": "#00000000" },
                "stroke": { "color": "#FFFFFFFF", "width": 2 }
              }
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArRectangleHighlight.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArRectangleHighlight.self, from: reEncoded))
    }

    func testBarcodeArRectangleHighlightAcceptsValid_with_icon_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArRectangleHighlight",
              "brush": {
                "fill": { "color": "#00000000" },
                "stroke": { "color": "#FFFFFFFF", "width": 2 }
              },
              "icon": {
                "icon": "xMark",
                "iconColor": null,
                "backgroundColor": null,
                "backgroundStrokeColor": null,
                "backgroundStrokeWidth": 2.0,
                "backgroundShape": "square"
              }
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArRectangleHighlight.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArRectangleHighlight.self, from: reEncoded))
    }

    func testBarcodeArRectangleHighlightRejectsInvalid_missing_brush_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArRectangleHighlight"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArRectangleHighlight.self, from: raw))
    }

    func testBarcodeArRectangleHighlightRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "type": "barcodeArRectangleHighlight",
              "brush": {
                "fill": { "color": "#00000000" },
                "stroke": { "color": "#FFFFFFFF", "width": 2 }
              },
              "unexpected": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArRectangleHighlight.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArCustomHighlightAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "type": "barcodeArCustomHighlight" }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArCustomHighlight.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArCustomHighlight.self, from: reEncoded))
    }

    func testBarcodeArCustomHighlightRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            { "type": "barcodeArCustomHighlight", "unexpected": true }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArCustomHighlight.self, from: raw)) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCaptureListenerDidUpdateSessionAcceptsValid_absent_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "modeId": 1,
              "event": "BarcodeCaptureListener.didUpdateSession"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidUpdateSession.self, from: reEncoded)
        )
    }

    func testBarcodeCaptureListenerDidUpdateSessionAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeCaptureListener.didUpdateSession"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidUpdateSession.self, from: reEncoded)
        )
    }

    func testBarcodeCaptureListenerDidUpdateSessionAcceptsValid_null_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": null,
              "modeId": 1,
              "event": "BarcodeCaptureListener.didUpdateSession"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidUpdateSession.self, from: reEncoded)
        )
    }

    func testBarcodeCaptureListenerDidUpdateSessionRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeCaptureListenerDidUpdateSessionRejectsInvalid_missing_mode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "event": "BarcodeCaptureListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeCaptureListenerDidUpdateSessionRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeCaptureListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeCaptureListenerDidUpdateSessionRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "unknownProperty": true,
              "event": "BarcodeCaptureListener.didUpdateSession"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidUpdateSession.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCaptureListenerDidUpdateSessionRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeCaptureListener.didUpdateSession.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeCaptureListenerDidUpdateSessionRejectsInvalid_wrong_type_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": 42,
              "modeId": 1,
              "event": "BarcodeCaptureListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeCaptureListenerDidUpdateSessionRejectsInvalid_wrong_type_mode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": "1",
              "event": "BarcodeCaptureListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeCaptureListenerDidUpdateSessionRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {
                "frameSequenceId": 1
              },
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeCaptureListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeCaptureListenerDidScanAcceptsValid_absent_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "modeId": 1,
              "event": "BarcodeCaptureListener.didScan"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidScan.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidScan.self, from: reEncoded))
    }

    func testBarcodeCaptureListenerDidScanAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeCaptureListener.didScan"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidScan.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidScan.self, from: reEncoded))
    }

    func testBarcodeCaptureListenerDidScanAcceptsValid_null_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": null,
              "modeId": 1,
              "event": "BarcodeCaptureListener.didScan"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidScan.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidScan.self, from: reEncoded))
    }

    func testBarcodeCaptureListenerDidScanRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidScan.self, from: raw))
    }

    func testBarcodeCaptureListenerDidScanRejectsInvalid_missing_mode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "event": "BarcodeCaptureListener.didScan"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidScan.self, from: raw))
    }

    func testBarcodeCaptureListenerDidScanRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeCaptureListener.didScan"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidScan.self, from: raw))
    }

    func testBarcodeCaptureListenerDidScanRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "unknownProperty": true,
              "event": "BarcodeCaptureListener.didScan"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidScan.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCaptureListenerDidScanRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeCaptureListener.didScan.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidScan.self, from: raw))
    }

    func testBarcodeCaptureListenerDidScanRejectsInvalid_wrong_type_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": 42,
              "modeId": 1,
              "event": "BarcodeCaptureListener.didScan"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidScan.self, from: raw))
    }

    func testBarcodeCaptureListenerDidScanRejectsInvalid_wrong_type_mode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"newlyLocalizedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": "1",
              "event": "BarcodeCaptureListener.didScan"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidScan.self, from: raw))
    }

    func testBarcodeCaptureListenerDidScanRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {
                "frameSequenceId": 1
              },
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeCaptureListener.didScan"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCaptureListenerDidScan.self, from: raw))
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerDispatchStartedAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": ["{\"data\": \"9012345678\", \"symbology\": \"code128\"}"]
              },
              "frameDataId": "frame-data-1",
              "event": "BarcodeCaptureAdaptiveRecognitionListener.dispatchStarted"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerDispatchStarted.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerDispatchStarted.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerDispatchStartedAcceptsValid_empty_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "frameDataId": "frame-data-1",
              "event": "BarcodeCaptureAdaptiveRecognitionListener.dispatchStarted"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerDispatchStarted.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerDispatchStarted.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerDispatchStartedRejectsInvalid_missing_frame_data_id_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "event": "BarcodeCaptureAdaptiveRecognitionListener.dispatchStarted"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerDispatchStarted.self,
                from: raw
            )
        )
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerDispatchStartedRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "frameDataId": "frame-data-1",
              "unknownProperty": true,
              "event": "BarcodeCaptureAdaptiveRecognitionListener.dispatchStarted"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerDispatchStarted.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerDispatchStartedRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "frameDataId": "frame-data-1",
              "event": "BarcodeCaptureAdaptiveRecognitionListener.dispatchStarted.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerDispatchStarted.self,
                from: raw
            )
        )
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerDispatchStartedRejectsInvalid_wrong_type_mode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": "1",
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "frameDataId": "frame-data-1",
              "event": "BarcodeCaptureAdaptiveRecognitionListener.dispatchStarted"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerDispatchStarted.self,
                from: raw
            )
        )
    }

    func testAdaptiveRecognitionFrameMetadataAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": 1,
              "barcodes": ["{\"data\": \"9012345678\", \"symbology\": \"code128\"}"]
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.AdaptiveRecognitionFrameMetadata.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.AdaptiveRecognitionFrameMetadata.self, from: reEncoded))
    }

    func testAdaptiveRecognitionFrameMetadataAcceptsValid_empty_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": 42,
              "barcodes": []
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.AdaptiveRecognitionFrameMetadata.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.AdaptiveRecognitionFrameMetadata.self, from: reEncoded))
    }

    func testAdaptiveRecognitionFrameMetadataRejectsInvalid_missing_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.AdaptiveRecognitionFrameMetadata.self, from: raw))
    }

    func testAdaptiveRecognitionFrameMetadataRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": 1,
              "barcodes": [],
              "unknownProperty": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.AdaptiveRecognitionFrameMetadata.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testAdaptiveRecognitionFrameMetadataRejectsInvalid_wrong_type_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": "1",
              "barcodes": []
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.AdaptiveRecognitionFrameMetadata.self, from: raw))
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerResponseAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": ["{\"data\": \"9012345678\", \"symbology\": \"code128\"}"]
              },
              "response": "{\"result\": \"ok\"}",
              "event": "BarcodeCaptureAdaptiveRecognitionListener.response"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerResponse.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerResponse.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerResponseAcceptsValid_empty_response_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "response": "",
              "event": "BarcodeCaptureAdaptiveRecognitionListener.response"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerResponse.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerResponse.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerResponseRejectsInvalid_missing_response_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "event": "BarcodeCaptureAdaptiveRecognitionListener.response"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerResponse.self, from: raw)
        )
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerResponseRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "response": "{}",
              "unknownProperty": true,
              "event": "BarcodeCaptureAdaptiveRecognitionListener.response"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerResponse.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerResponseRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "response": "{}",
              "event": "BarcodeCaptureAdaptiveRecognitionListener.response.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerResponse.self, from: raw)
        )
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerResponseRejectsInvalid_wrong_type_response_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "response": 42,
              "event": "BarcodeCaptureAdaptiveRecognitionListener.response"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerResponse.self, from: raw)
        )
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerErrorAcceptsValid_timeout_reason_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": ["{\"data\": \"9012345678\", \"symbology\": \"code128\"}"]
              },
              "reason": "timeout",
              "event": "BarcodeCaptureAdaptiveRecognitionListener.error"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerError.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerError.self, from: reEncoded)
        )
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerErrorAcceptsValid_unknown_reason_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "reason": "unknown",
              "event": "BarcodeCaptureAdaptiveRecognitionListener.error"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerError.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerError.self, from: reEncoded)
        )
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerErrorRejectsInvalid_missing_reason_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "event": "BarcodeCaptureAdaptiveRecognitionListener.error"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerError.self, from: raw)
        )
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerErrorRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "reason": "unknown",
              "unknownProperty": true,
              "event": "BarcodeCaptureAdaptiveRecognitionListener.error"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerError.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerErrorRejectsInvalid_wrong_enum_reason_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "reason": "notARealReason",
              "event": "BarcodeCaptureAdaptiveRecognitionListener.error"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerError.self, from: raw)
        )
    }

    func testBarcodeCaptureAdaptiveRecognitionListenerErrorRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "modeId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "reason": "unknown",
              "event": "BarcodeCaptureAdaptiveRecognitionListener.error.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerError.self, from: raw)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSelectionAcceptsValid_absent_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "modeId": 1,
              "event": "BarcodeSelectionListener.didUpdateSelection"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSelection.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSelection.self, from: reEncoded)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSelectionAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeSelectionListener.didUpdateSelection"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSelection.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSelection.self, from: reEncoded)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSelectionAcceptsValid_null_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": null,
              "modeId": 1,
              "event": "BarcodeSelectionListener.didUpdateSelection"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSelection.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSelection.self, from: reEncoded)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSelectionRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSelection.self, from: raw)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSelectionRejectsInvalid_missing_mode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "event": "BarcodeSelectionListener.didUpdateSelection"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSelection.self, from: raw)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSelectionRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeSelectionListener.didUpdateSelection"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSelection.self, from: raw)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSelectionRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "unknownProperty": true,
              "event": "BarcodeSelectionListener.didUpdateSelection"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSelection.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeSelectionListenerDidUpdateSelectionRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeSelectionListener.didUpdateSelection.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSelection.self, from: raw)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSelectionRejectsInvalid_wrong_type_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": 42,
              "modeId": 1,
              "event": "BarcodeSelectionListener.didUpdateSelection"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSelection.self, from: raw)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSelectionRejectsInvalid_wrong_type_mode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": "1",
              "event": "BarcodeSelectionListener.didUpdateSelection"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSelection.self, from: raw)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSelectionRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {
                "frameSequenceId": 1
              },
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeSelectionListener.didUpdateSelection"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSelection.self, from: raw)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSessionAcceptsValid_absent_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "modeId": 1,
              "event": "BarcodeSelectionListener.didUpdateSession"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSession.self, from: reEncoded)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSessionAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeSelectionListener.didUpdateSession"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSession.self, from: reEncoded)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSessionAcceptsValid_null_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": null,
              "modeId": 1,
              "event": "BarcodeSelectionListener.didUpdateSession"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSession.self, from: reEncoded)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSessionRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSessionRejectsInvalid_missing_mode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "event": "BarcodeSelectionListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSessionRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeSelectionListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSessionRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "unknownProperty": true,
              "event": "BarcodeSelectionListener.didUpdateSession"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSession.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeSelectionListenerDidUpdateSessionRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeSelectionListener.didUpdateSession.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSessionRejectsInvalid_wrong_type_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": 42,
              "modeId": 1,
              "event": "BarcodeSelectionListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSessionRejectsInvalid_wrong_type_mode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"selectedBarcodes\": [], \"newlySelectedBarcodes\": [], \"newlyUnselectedBarcodes\": [], \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": "1",
              "event": "BarcodeSelectionListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeSelectionListenerDidUpdateSessionRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {
                "frameSequenceId": 1
              },
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeSelectionListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeSelectionAimedBrushProviderBrushForBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"123456\"}",
              "event": "BarcodeSelectionAimedBrushProvider.brushForBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeSelectionAimedBrushProviderBrushForBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeSelectionAimedBrushProviderBrushForBarcode.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeSelectionAimedBrushProviderBrushForBarcodeRejectsInvalid_missing_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "event": "BarcodeSelectionAimedBrushProvider.brushForBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionAimedBrushProviderBrushForBarcode.self, from: raw)
        )
    }

    func testBarcodeSelectionAimedBrushProviderBrushForBarcodeRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"123456\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionAimedBrushProviderBrushForBarcode.self, from: raw)
        )
    }

    func testBarcodeSelectionAimedBrushProviderBrushForBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"123456\"}",
              "event": "BarcodeSelectionAimedBrushProvider.brushForBarcode",
              "unknownProperty": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionAimedBrushProviderBrushForBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeSelectionAimedBrushProviderBrushForBarcodeRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"123456\"}",
              "event": "BarcodeSelectionAimedBrushProvider.brushForBarcode.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionAimedBrushProviderBrushForBarcode.self, from: raw)
        )
    }

    func testBarcodeSelectionAimedBrushProviderBrushForBarcodeRejectsInvalid_wrong_type_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": 42,
              "event": "BarcodeSelectionAimedBrushProvider.brushForBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionAimedBrushProviderBrushForBarcode.self, from: raw)
        )
    }

    func testBarcodeSelectionTrackedBrushProviderBrushForBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"123456\"}",
              "event": "BarcodeSelectionTrackedBrushProvider.brushForBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeSelectionTrackedBrushProviderBrushForBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeSelectionTrackedBrushProviderBrushForBarcode.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeSelectionTrackedBrushProviderBrushForBarcodeRejectsInvalid_missing_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "event": "BarcodeSelectionTrackedBrushProvider.brushForBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionTrackedBrushProviderBrushForBarcode.self, from: raw)
        )
    }

    func testBarcodeSelectionTrackedBrushProviderBrushForBarcodeRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"123456\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionTrackedBrushProviderBrushForBarcode.self, from: raw)
        )
    }

    func testBarcodeSelectionTrackedBrushProviderBrushForBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"123456\"}",
              "event": "BarcodeSelectionTrackedBrushProvider.brushForBarcode",
              "unknownProperty": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionTrackedBrushProviderBrushForBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeSelectionTrackedBrushProviderBrushForBarcodeRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"123456\"}",
              "event": "BarcodeSelectionTrackedBrushProvider.brushForBarcode.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionTrackedBrushProviderBrushForBarcode.self, from: raw)
        )
    }

    func testBarcodeSelectionTrackedBrushProviderBrushForBarcodeRejectsInvalid_wrong_type_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": 42,
              "event": "BarcodeSelectionTrackedBrushProvider.brushForBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeSelectionTrackedBrushProviderBrushForBarcode.self, from: raw)
        )
    }

    func testBarcodeBatchListenerDidUpdateSessionAcceptsValid_absent_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"addedTrackedBarcodes\": [], \"removedTrackedBarcodes\": [], \"updatedTrackedBarcodes\": [], \"trackedBarcodes\": {}, \"frameSequenceId\": 1}",
              "modeId": 1,
              "event": "BarcodeBatchListener.didUpdateSession"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeBatchListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchListenerDidUpdateSession.self, from: reEncoded)
        )
    }

    func testBarcodeBatchListenerDidUpdateSessionAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"addedTrackedBarcodes\": [], \"removedTrackedBarcodes\": [], \"updatedTrackedBarcodes\": [], \"trackedBarcodes\": {}, \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeBatchListener.didUpdateSession"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeBatchListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchListenerDidUpdateSession.self, from: reEncoded)
        )
    }

    func testBarcodeBatchListenerDidUpdateSessionAcceptsValid_null_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"addedTrackedBarcodes\": [], \"removedTrackedBarcodes\": [], \"updatedTrackedBarcodes\": [], \"trackedBarcodes\": {}, \"frameSequenceId\": 1}",
              "frameId": null,
              "modeId": 1,
              "event": "BarcodeBatchListener.didUpdateSession"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeBatchListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchListenerDidUpdateSession.self, from: reEncoded)
        )
    }

    func testBarcodeBatchListenerDidUpdateSessionRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"addedTrackedBarcodes\": [], \"removedTrackedBarcodes\": [], \"updatedTrackedBarcodes\": [], \"trackedBarcodes\": {}, \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeBatchListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeBatchListenerDidUpdateSessionRejectsInvalid_missing_mode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"addedTrackedBarcodes\": [], \"removedTrackedBarcodes\": [], \"updatedTrackedBarcodes\": [], \"trackedBarcodes\": {}, \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "event": "BarcodeBatchListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeBatchListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeBatchListenerDidUpdateSessionRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeBatchListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeBatchListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeBatchListenerDidUpdateSessionRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"addedTrackedBarcodes\": [], \"removedTrackedBarcodes\": [], \"updatedTrackedBarcodes\": [], \"trackedBarcodes\": {}, \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "unknownProperty": true,
              "event": "BarcodeBatchListener.didUpdateSession"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeBatchListenerDidUpdateSession.self, from: raw))
        { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeBatchListenerDidUpdateSessionRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"addedTrackedBarcodes\": [], \"removedTrackedBarcodes\": [], \"updatedTrackedBarcodes\": [], \"trackedBarcodes\": {}, \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeBatchListener.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeBatchListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeBatchListenerDidUpdateSessionRejectsInvalid_wrong_type_mode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"addedTrackedBarcodes\": [], \"removedTrackedBarcodes\": [], \"updatedTrackedBarcodes\": [], \"trackedBarcodes\": {}, \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "modeId": "1",
              "event": "BarcodeBatchListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeBatchListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeBatchListenerDidUpdateSessionRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {
                "frameSequenceId": 1
              },
              "frameId": "frame-1",
              "modeId": 1,
              "event": "BarcodeBatchListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeBatchListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeBatchBasicOverlayListenerBrushForTrackedBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "event": "BarcodeBatchBasicOverlayListener.brushForTrackedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeBatchBasicOverlayListenerBrushForTrackedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchBasicOverlayListenerBrushForTrackedBarcode.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeBatchBasicOverlayListenerBrushForTrackedBarcodeRejectsInvalid_empty_object_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "event": "BarcodeBatchBasicOverlayListener.brushForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchBasicOverlayListenerBrushForTrackedBarcode.self, from: raw)
        )
    }

    func testBarcodeBatchBasicOverlayListenerBrushForTrackedBarcodeRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchBasicOverlayListenerBrushForTrackedBarcode.self, from: raw)
        )
    }

    func testBarcodeBatchBasicOverlayListenerBrushForTrackedBarcodeRejectsInvalid_missing_tracked_barcode_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "event": "BarcodeBatchBasicOverlayListener.brushForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchBasicOverlayListenerBrushForTrackedBarcode.self, from: raw)
        )
    }

    func testBarcodeBatchBasicOverlayListenerBrushForTrackedBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "unknownProperty": true,
              "event": "BarcodeBatchBasicOverlayListener.brushForTrackedBarcode"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchBasicOverlayListenerBrushForTrackedBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeBatchBasicOverlayListenerBrushForTrackedBarcodeRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "event": "BarcodeBatchListener.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchBasicOverlayListenerBrushForTrackedBarcode.self, from: raw)
        )
    }

    func testBarcodeBatchBasicOverlayListenerBrushForTrackedBarcodeRejectsInvalid_wrong_type_tracked_barcode_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "identifier": "1"
              },
              "event": "BarcodeBatchBasicOverlayListener.brushForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchBasicOverlayListenerBrushForTrackedBarcode.self, from: raw)
        )
    }

    func testBarcodeBatchBasicOverlayListenerDidTapTrackedBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "event": "BarcodeBatchBasicOverlayListener.didTapTrackedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeBatchBasicOverlayListenerDidTapTrackedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchBasicOverlayListenerDidTapTrackedBarcode.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeBatchBasicOverlayListenerDidTapTrackedBarcodeRejectsInvalid_empty_object_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "event": "BarcodeBatchBasicOverlayListener.didTapTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchBasicOverlayListenerDidTapTrackedBarcode.self, from: raw)
        )
    }

    func testBarcodeBatchBasicOverlayListenerDidTapTrackedBarcodeRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchBasicOverlayListenerDidTapTrackedBarcode.self, from: raw)
        )
    }

    func testBarcodeBatchBasicOverlayListenerDidTapTrackedBarcodeRejectsInvalid_missing_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "event": "BarcodeBatchBasicOverlayListener.didTapTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchBasicOverlayListenerDidTapTrackedBarcode.self, from: raw)
        )
    }

    func testBarcodeBatchBasicOverlayListenerDidTapTrackedBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "unknownProperty": true,
              "event": "BarcodeBatchBasicOverlayListener.didTapTrackedBarcode"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchBasicOverlayListenerDidTapTrackedBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeBatchBasicOverlayListenerDidTapTrackedBarcodeRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "event": "BarcodeBatchListener.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchBasicOverlayListenerDidTapTrackedBarcode.self, from: raw)
        )
    }

    func testBarcodeBatchBasicOverlayListenerDidTapTrackedBarcodeRejectsInvalid_wrong_type_tracked_barcode_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "identifier": "1"
              },
              "event": "BarcodeBatchBasicOverlayListener.didTapTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeBatchBasicOverlayListenerDidTapTrackedBarcode.self, from: raw)
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcodeAcceptsValid_elided_payload_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": 1,
              "location": "{\"topLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"topRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"bottomRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}, \"bottomLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}}",
              "event": "BarcodeBatchAdvancedOverlayListener.didTapViewForTrackedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcodeAcceptsValid_full_payload_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "event": "BarcodeBatchAdvancedOverlayListener.didTapViewForTrackedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcodeRejectsInvalid_elided_missing_location_json()
        throws
    {
        throw XCTSkip("unenforceable keyword: oneOf")
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": 1,
              "event": "BarcodeBatchAdvancedOverlayListener.didTapViewForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcodeRejectsInvalid_empty_object_json() throws {
        throw XCTSkip("unenforceable keyword: oneOf")
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "event": "BarcodeBatchAdvancedOverlayListener.didTapViewForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcodeRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcodeRejectsInvalid_mixed_variants_json() throws {
        throw XCTSkip("unenforceable keyword: oneOf")
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "identifier": 1,
              "location": "{\"topLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"topRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"bottomRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}, \"bottomLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}}",
              "event": "BarcodeBatchAdvancedOverlayListener.didTapViewForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcodeRejectsInvalid_unknown_property_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "unknownProperty": true,
              "event": "BarcodeBatchAdvancedOverlayListener.didTapViewForTrackedBarcode"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcodeRejectsInvalid_wrong_event_const_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "event": "BarcodeBatchListener.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcodeRejectsInvalid_wrong_type_identifier_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": "1",
              "location": "{\"topLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"topRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"bottomRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}, \"bottomLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}}",
              "event": "BarcodeBatchAdvancedOverlayListener.didTapViewForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcodeRejectsInvalid_wrong_type_location_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": 1,
              "location": {
                "topLeft": {}
              },
              "event": "BarcodeBatchAdvancedOverlayListener.didTapViewForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerViewForTrackedBarcodeAcceptsValid_elided_payload_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": 1,
              "location": "{\"topLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"topRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"bottomRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}, \"bottomLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}}",
              "event": "BarcodeBatchAdvancedOverlayListener.viewForTrackedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerViewForTrackedBarcodeAcceptsValid_full_payload_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "event": "BarcodeBatchAdvancedOverlayListener.viewForTrackedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerViewForTrackedBarcodeRejectsInvalid_elided_missing_location_json()
        throws
    {
        throw XCTSkip("unenforceable keyword: oneOf")
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": 1,
              "event": "BarcodeBatchAdvancedOverlayListener.viewForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerViewForTrackedBarcodeRejectsInvalid_empty_object_json() throws {
        throw XCTSkip("unenforceable keyword: oneOf")
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "event": "BarcodeBatchAdvancedOverlayListener.viewForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerViewForTrackedBarcodeRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerViewForTrackedBarcodeRejectsInvalid_mixed_variants_json() throws {
        throw XCTSkip("unenforceable keyword: oneOf")
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "identifier": 1,
              "location": "{\"topLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"topRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"bottomRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}, \"bottomLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}}",
              "event": "BarcodeBatchAdvancedOverlayListener.viewForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerViewForTrackedBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "unknownProperty": true,
              "event": "BarcodeBatchAdvancedOverlayListener.viewForTrackedBarcode"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeBatchAdvancedOverlayListenerViewForTrackedBarcodeRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "event": "BarcodeBatchListener.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerViewForTrackedBarcodeRejectsInvalid_wrong_type_identifier_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": "1",
              "location": "{\"topLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"topRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"bottomRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}, \"bottomLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}}",
              "event": "BarcodeBatchAdvancedOverlayListener.viewForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerViewForTrackedBarcodeRejectsInvalid_wrong_type_location_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": 1,
              "location": {
                "topLeft": {}
              },
              "event": "BarcodeBatchAdvancedOverlayListener.viewForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcodeAcceptsValid_elided_payload_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": 1,
              "location": "{\"topLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"topRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"bottomRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}, \"bottomLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}}",
              "event": "BarcodeBatchAdvancedOverlayListener.anchorForTrackedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcodeAcceptsValid_full_payload_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "event": "BarcodeBatchAdvancedOverlayListener.anchorForTrackedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcodeRejectsInvalid_elided_missing_location_json()
        throws
    {
        throw XCTSkip("unenforceable keyword: oneOf")
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": 1,
              "event": "BarcodeBatchAdvancedOverlayListener.anchorForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcodeRejectsInvalid_empty_object_json() throws {
        throw XCTSkip("unenforceable keyword: oneOf")
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "event": "BarcodeBatchAdvancedOverlayListener.anchorForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcodeRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcodeRejectsInvalid_mixed_variants_json() throws {
        throw XCTSkip("unenforceable keyword: oneOf")
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "identifier": 1,
              "location": "{\"topLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"topRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"bottomRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}, \"bottomLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}}",
              "event": "BarcodeBatchAdvancedOverlayListener.anchorForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "unknownProperty": true,
              "event": "BarcodeBatchAdvancedOverlayListener.anchorForTrackedBarcode"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcodeRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "event": "BarcodeBatchListener.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcodeRejectsInvalid_wrong_type_identifier_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": "1",
              "location": "{\"topLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"topRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"bottomRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}, \"bottomLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}}",
              "event": "BarcodeBatchAdvancedOverlayListener.anchorForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcodeRejectsInvalid_wrong_type_location_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": 1,
              "location": {
                "topLeft": {}
              },
              "event": "BarcodeBatchAdvancedOverlayListener.anchorForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcodeAcceptsValid_elided_payload_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": 1,
              "location": "{\"topLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"topRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"bottomRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}, \"bottomLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}}",
              "event": "BarcodeBatchAdvancedOverlayListener.offsetForTrackedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcodeAcceptsValid_full_payload_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "event": "BarcodeBatchAdvancedOverlayListener.offsetForTrackedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcodeRejectsInvalid_elided_missing_location_json()
        throws
    {
        throw XCTSkip("unenforceable keyword: oneOf")
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": 1,
              "event": "BarcodeBatchAdvancedOverlayListener.offsetForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcodeRejectsInvalid_empty_object_json() throws {
        throw XCTSkip("unenforceable keyword: oneOf")
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "event": "BarcodeBatchAdvancedOverlayListener.offsetForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcodeRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcodeRejectsInvalid_mixed_variants_json() throws {
        throw XCTSkip("unenforceable keyword: oneOf")
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "identifier": 1,
              "location": "{\"topLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"topRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"bottomRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}, \"bottomLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}}",
              "event": "BarcodeBatchAdvancedOverlayListener.offsetForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "unknownProperty": true,
              "event": "BarcodeBatchAdvancedOverlayListener.offsetForTrackedBarcode"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcodeRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"identifier\": \"1\", \"barcode\": {}}",
              "event": "BarcodeBatchListener.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcodeRejectsInvalid_wrong_type_identifier_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": "1",
              "location": "{\"topLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"topRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 0, \"unit\": \"pixel\"}}, \"bottomRight\": {\"x\": {\"value\": 1, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}, \"bottomLeft\": {\"x\": {\"value\": 0, \"unit\": \"pixel\"}, \"y\": {\"value\": 1, \"unit\": \"pixel\"}}}",
              "event": "BarcodeBatchAdvancedOverlayListener.offsetForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcodeRejectsInvalid_wrong_type_location_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "identifier": 1,
              "location": {
                "topLeft": {}
              },
              "event": "BarcodeBatchAdvancedOverlayListener.offsetForTrackedBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode.self,
                from: raw
            )
        )
    }

    func testBarcodeCountViewListenerBrushForRecognizedBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcode.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCountViewListenerBrushForRecognizedBarcodeAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "BarcodeCountViewListener.brushForRecognizedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcode.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCountViewListenerBrushForRecognizedBarcodeRejectsInvalid_missing_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerBrushForRecognizedBarcodeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerBrushForRecognizedBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerBrushForRecognizedBarcodeRejectsInvalid_wrong_type_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "data": "9012345678"
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerBrushForRecognizedBarcodeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerBrushForRecognizedBarcodeNotInListAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcodeNotInList.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcodeNotInList.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCountViewListenerBrushForRecognizedBarcodeNotInListAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "BarcodeCountViewListener.brushForRecognizedBarcodeNotInList"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcodeNotInList.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcodeNotInList.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCountViewListenerBrushForRecognizedBarcodeNotInListRejectsInvalid_missing_tracked_barcode_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcodeNotInList.self,
                from: raw
            )
        )
    }

    func testBarcodeCountViewListenerBrushForRecognizedBarcodeNotInListRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcodeNotInList.self,
                from: raw
            )
        )
    }

    func testBarcodeCountViewListenerBrushForRecognizedBarcodeNotInListRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcodeNotInList.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerBrushForRecognizedBarcodeNotInListRejectsInvalid_wrong_type_tracked_barcode_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "data": "9012345678"
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcodeNotInList.self,
                from: raw
            )
        )
    }

    func testBarcodeCountViewListenerBrushForRecognizedBarcodeNotInListRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcodeNotInList.self,
                from: raw
            )
        )
    }

    func testBarcodeCountViewListenerBrushForAcceptedBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerBrushForAcceptedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForAcceptedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerBrushForAcceptedBarcodeAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "BarcodeCountViewListener.brushForAcceptedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerBrushForAcceptedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForAcceptedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerBrushForAcceptedBarcodeRejectsInvalid_missing_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForAcceptedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerBrushForAcceptedBarcodeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForAcceptedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerBrushForAcceptedBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForAcceptedBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerBrushForAcceptedBarcodeRejectsInvalid_wrong_type_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "data": "9012345678"
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForAcceptedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerBrushForAcceptedBarcodeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForAcceptedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerBrushForRejectedBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerBrushForRejectedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForRejectedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerBrushForRejectedBarcodeAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "BarcodeCountViewListener.brushForRejectedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerBrushForRejectedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForRejectedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerBrushForRejectedBarcodeRejectsInvalid_missing_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForRejectedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerBrushForRejectedBarcodeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForRejectedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerBrushForRejectedBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForRejectedBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerBrushForRejectedBarcodeRejectsInvalid_wrong_type_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "data": "9012345678"
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForRejectedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerBrushForRejectedBarcodeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerBrushForRejectedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerIconForRecognizedBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerIconForRecognizedBarcodeAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "BarcodeCountViewListener.iconForRecognizedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerIconForRecognizedBarcodeRejectsInvalid_missing_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerIconForRecognizedBarcodeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerIconForRecognizedBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerIconForRecognizedBarcodeRejectsInvalid_wrong_type_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "data": "9012345678"
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerIconForRecognizedBarcodeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerIconForRecognizedBarcodeNotInListAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcodeNotInList.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcodeNotInList.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCountViewListenerIconForRecognizedBarcodeNotInListAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "BarcodeCountViewListener.iconForRecognizedBarcodeNotInList"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcodeNotInList.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcodeNotInList.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCountViewListenerIconForRecognizedBarcodeNotInListRejectsInvalid_missing_tracked_barcode_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcodeNotInList.self,
                from: raw
            )
        )
    }

    func testBarcodeCountViewListenerIconForRecognizedBarcodeNotInListRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcodeNotInList.self,
                from: raw
            )
        )
    }

    func testBarcodeCountViewListenerIconForRecognizedBarcodeNotInListRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcodeNotInList.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerIconForRecognizedBarcodeNotInListRejectsInvalid_wrong_type_tracked_barcode_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "data": "9012345678"
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcodeNotInList.self,
                from: raw
            )
        )
    }

    func testBarcodeCountViewListenerIconForRecognizedBarcodeNotInListRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcodeNotInList.self,
                from: raw
            )
        )
    }

    func testBarcodeCountViewListenerIconForAcceptedBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerIconForAcceptedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForAcceptedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerIconForAcceptedBarcodeAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "BarcodeCountViewListener.iconForAcceptedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerIconForAcceptedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForAcceptedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerIconForAcceptedBarcodeRejectsInvalid_missing_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForAcceptedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerIconForAcceptedBarcodeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForAcceptedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerIconForAcceptedBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForAcceptedBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerIconForAcceptedBarcodeRejectsInvalid_wrong_type_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "data": "9012345678"
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForAcceptedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerIconForAcceptedBarcodeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForAcceptedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerIconForRejectedBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerIconForRejectedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForRejectedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerIconForRejectedBarcodeAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "BarcodeCountViewListener.iconForRejectedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerIconForRejectedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForRejectedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerIconForRejectedBarcodeRejectsInvalid_missing_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForRejectedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerIconForRejectedBarcodeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForRejectedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerIconForRejectedBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForRejectedBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerIconForRejectedBarcodeRejectsInvalid_wrong_type_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "data": "9012345678"
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForRejectedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerIconForRejectedBarcodeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerIconForRejectedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapRecognizedBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerDidTapRecognizedBarcodeAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "BarcodeCountViewListener.didTapRecognizedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerDidTapRecognizedBarcodeRejectsInvalid_missing_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapRecognizedBarcodeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapRecognizedBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerDidTapRecognizedBarcodeRejectsInvalid_wrong_type_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "data": "9012345678"
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapRecognizedBarcodeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapFilteredBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapFilteredBarcode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapFilteredBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerDidTapFilteredBarcodeAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "BarcodeCountViewListener.didTapFilteredBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapFilteredBarcode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapFilteredBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerDidTapFilteredBarcodeRejectsInvalid_missing_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapFilteredBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapFilteredBarcodeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapFilteredBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapFilteredBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapFilteredBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerDidTapFilteredBarcodeRejectsInvalid_wrong_type_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "data": "9012345678"
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapFilteredBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapFilteredBarcodeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapFilteredBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapRecognizedBarcodeNotInListAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcodeNotInList.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcodeNotInList.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCountViewListenerDidTapRecognizedBarcodeNotInListAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "BarcodeCountViewListener.didTapRecognizedBarcodeNotInList"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcodeNotInList.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcodeNotInList.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCountViewListenerDidTapRecognizedBarcodeNotInListRejectsInvalid_missing_tracked_barcode_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcodeNotInList.self,
                from: raw
            )
        )
    }

    func testBarcodeCountViewListenerDidTapRecognizedBarcodeNotInListRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcodeNotInList.self,
                from: raw
            )
        )
    }

    func testBarcodeCountViewListenerDidTapRecognizedBarcodeNotInListRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcodeNotInList.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerDidTapRecognizedBarcodeNotInListRejectsInvalid_wrong_type_tracked_barcode_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "data": "9012345678"
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcodeNotInList.self,
                from: raw
            )
        )
    }

    func testBarcodeCountViewListenerDidTapRecognizedBarcodeNotInListRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcodeNotInList.self,
                from: raw
            )
        )
    }

    func testBarcodeCountViewListenerDidTapAcceptedBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapAcceptedBarcode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapAcceptedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerDidTapAcceptedBarcodeAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "BarcodeCountViewListener.didTapAcceptedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapAcceptedBarcode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapAcceptedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerDidTapAcceptedBarcodeRejectsInvalid_missing_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapAcceptedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapAcceptedBarcodeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapAcceptedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapAcceptedBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapAcceptedBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerDidTapAcceptedBarcodeRejectsInvalid_wrong_type_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "data": "9012345678"
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapAcceptedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapAcceptedBarcodeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapAcceptedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapRejectedBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRejectedBarcode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRejectedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerDidTapRejectedBarcodeAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "BarcodeCountViewListener.didTapRejectedBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRejectedBarcode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRejectedBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerDidTapRejectedBarcodeRejectsInvalid_missing_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRejectedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapRejectedBarcodeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRejectedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapRejectedBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRejectedBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerDidTapRejectedBarcodeRejectsInvalid_wrong_type_tracked_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": {
                "data": "9012345678"
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRejectedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapRejectedBarcodeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "trackedBarcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapRejectedBarcode.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidCompleteCaptureListAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerDidCompleteCaptureList.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidCompleteCaptureList.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerDidCompleteCaptureListAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "BarcodeCountViewListener.didCompleteCaptureList"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewListenerDidCompleteCaptureList.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidCompleteCaptureList.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerDidCompleteCaptureListRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {}
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidCompleteCaptureList.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidCompleteCaptureListRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidCompleteCaptureList.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerDidCompleteCaptureListRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidCompleteCaptureList.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapClusterAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
              ],
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapCluster.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapCluster.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerDidTapClusterAcceptsValid_empty_cluster_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [],
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapCluster.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapCluster.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerDidTapClusterAcceptsValid_multiple_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
                "{\"data\": \"4006381333931\", \"symbology\": \"ean13Upca\"}",
                "{\"data\": \"012345678905\", \"symbology\": \"upca\"}"
              ],
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapCluster.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapCluster.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerDidTapClusterAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
              ],
              "viewId": 1,
              "event": "BarcodeCountViewListener.didTapCluster"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapCluster.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapCluster.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewListenerDidTapClusterRejectsInvalid_missing_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapCluster.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapClusterRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
              ]
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapCluster.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapClusterRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
              ],
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapCluster.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewListenerDidTapClusterRejectsInvalid_wrong_type_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": "not-an-array",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapCluster.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapClusterRejectsInvalid_wrong_type_barcodes_item_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                {
                  "data": "9012345678"
                }
              ],
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapCluster.self, from: raw)
        )
    }

    func testBarcodeCountViewListenerDidTapClusterRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
              ],
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewListenerDidTapCluster.self, from: raw)
        )
    }

    func testBarcodeCountViewUiListenerOnListButtonTappedAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnListButtonTapped.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnListButtonTapped.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewUiListenerOnListButtonTappedAcceptsValid_with_empty_snapshot_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "snapshot": "{}"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnListButtonTapped.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnListButtonTapped.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewUiListenerOnListButtonTappedAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "BarcodeCountViewUiListener.onListButtonTapped"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnListButtonTapped.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnListButtonTapped.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewUiListenerOnListButtonTappedAcceptsValid_with_snapshot_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "snapshot": "{\"recognizedBarcodes\": [{\"symbology\": \"code128\", \"data\": \"9012345678\", \"rawData\": \"OTAxMjM0NTY3OA==\", \"encodingRanges\": [{\"ianaName\": \"UTF-8\", \"startIndex\": 0, \"endIndex\": 10}], \"location\": {\"topLeft\": {\"x\": {\"value\": 0.1, \"unit\": \"fraction\"}, \"y\": {\"value\": 0.2, \"unit\": \"fraction\"}}, \"topRight\": {\"x\": {\"value\": 0.9, \"unit\": \"fraction\"}, \"y\": {\"value\": 0.2, \"unit\": \"fraction\"}}, \"bottomRight\": {\"x\": {\"value\": 0.9, \"unit\": \"fraction\"}, \"y\": {\"value\": 0.8, \"unit\": \"fraction\"}}, \"bottomLeft\": {\"x\": {\"value\": 0.1, \"unit\": \"fraction\"}, \"y\": {\"value\": 0.8, \"unit\": \"fraction\"}}}, \"compositeFlag\": \"none\", \"isGS1DataCarrier\": false, \"isColorInverted\": false, \"symbolCount\": 11, \"frameId\": 10}], \"additionalBarcodes\": [], \"recognizedClusters\": [], \"frameSequenceId\": 42}"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnListButtonTapped.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnListButtonTapped.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewUiListenerOnListButtonTappedRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {}
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnListButtonTapped.self, from: raw)
        )
    }

    func testBarcodeCountViewUiListenerOnListButtonTappedRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnListButtonTapped.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewUiListenerOnListButtonTappedRejectsInvalid_wrong_type_snapshot_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "snapshot": 42
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnListButtonTapped.self, from: raw)
        )
    }

    func testBarcodeCountViewUiListenerOnListButtonTappedRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnListButtonTapped.self, from: raw)
        )
    }

    func testBarcodeCountViewUiListenerOnExitButtonTappedAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnExitButtonTapped.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnExitButtonTapped.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewUiListenerOnExitButtonTappedAcceptsValid_with_empty_snapshot_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "snapshot": "{}"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnExitButtonTapped.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnExitButtonTapped.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewUiListenerOnExitButtonTappedAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "BarcodeCountViewUiListener.onExitButtonTapped"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnExitButtonTapped.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnExitButtonTapped.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewUiListenerOnExitButtonTappedAcceptsValid_with_snapshot_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "snapshot": "{\"recognizedBarcodes\": [{\"symbology\": \"code128\", \"data\": \"9012345678\", \"rawData\": \"OTAxMjM0NTY3OA==\", \"encodingRanges\": [{\"ianaName\": \"UTF-8\", \"startIndex\": 0, \"endIndex\": 10}], \"location\": {\"topLeft\": {\"x\": {\"value\": 0.1, \"unit\": \"fraction\"}, \"y\": {\"value\": 0.2, \"unit\": \"fraction\"}}, \"topRight\": {\"x\": {\"value\": 0.9, \"unit\": \"fraction\"}, \"y\": {\"value\": 0.2, \"unit\": \"fraction\"}}, \"bottomRight\": {\"x\": {\"value\": 0.9, \"unit\": \"fraction\"}, \"y\": {\"value\": 0.8, \"unit\": \"fraction\"}}, \"bottomLeft\": {\"x\": {\"value\": 0.1, \"unit\": \"fraction\"}, \"y\": {\"value\": 0.8, \"unit\": \"fraction\"}}}, \"compositeFlag\": \"none\", \"isGS1DataCarrier\": false, \"isColorInverted\": false, \"symbolCount\": 11, \"frameId\": 10}], \"additionalBarcodes\": [], \"recognizedClusters\": [], \"frameSequenceId\": 42}"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnExitButtonTapped.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnExitButtonTapped.self, from: reEncoded)
        )
    }

    func testBarcodeCountViewUiListenerOnExitButtonTappedRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {}
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnExitButtonTapped.self, from: raw)
        )
    }

    func testBarcodeCountViewUiListenerOnExitButtonTappedRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnExitButtonTapped.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewUiListenerOnExitButtonTappedRejectsInvalid_wrong_type_snapshot_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "snapshot": 42
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnExitButtonTapped.self, from: raw)
        )
    }

    func testBarcodeCountViewUiListenerOnExitButtonTappedRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnExitButtonTapped.self, from: raw)
        )
    }

    func testBarcodeCountViewUiListenerOnSingleScanButtonTappedAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewUiListenerOnSingleScanButtonTapped.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewUiListenerOnSingleScanButtonTapped.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCountViewUiListenerOnSingleScanButtonTappedAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "BarcodeCountViewUiListener.onSingleScanButtonTapped"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountViewUiListenerOnSingleScanButtonTapped.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountViewUiListenerOnSingleScanButtonTapped.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCountViewUiListenerOnSingleScanButtonTappedRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {}
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnSingleScanButtonTapped.self, from: raw)
        )
    }

    func testBarcodeCountViewUiListenerOnSingleScanButtonTappedRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnSingleScanButtonTapped.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountViewUiListenerOnSingleScanButtonTappedRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountViewUiListenerOnSingleScanButtonTapped.self, from: raw)
        )
    }

    func testBarcodeCountListenerOnScanAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcodes\": []}",
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerOnScan.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerOnScan.self, from: reEncoded))
    }

    func testBarcodeCountListenerOnScanRejectsInvalid_missing_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcodes\": []}",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerOnScan.self, from: raw))
    }

    func testBarcodeCountListenerOnScanRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerOnScan.self, from: raw))
    }

    func testBarcodeCountListenerOnScanRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcodes\": []}",
              "frameId": "frame-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerOnScan.self, from: raw))
    }

    func testBarcodeCountListenerOnScanRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcodes\": []}",
              "frameId": "frame-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerOnScan.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountListenerOnScanRejectsInvalid_wrong_type_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcodes\": []}",
              "frameId": 1,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerOnScan.self, from: raw))
    }

    func testBarcodeCountListenerOnScanRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {
                "newlyRecognizedBarcodes": []
              },
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerOnScan.self, from: raw))
    }

    func testBarcodeCountListenerOnScanRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcodes\": []}",
              "frameId": "frame-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerOnScan.self, from: raw))
    }

    func testBarcodeCountListenerDidUpdateSessionAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcodes\": []}",
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerDidUpdateSession.self, from: reEncoded)
        )
    }

    func testBarcodeCountListenerDidUpdateSessionRejectsInvalid_missing_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcodes\": []}",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeCountListenerDidUpdateSessionRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeCountListenerDidUpdateSessionRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcodes\": []}",
              "frameId": "frame-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeCountListenerDidUpdateSessionRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcodes\": []}",
              "frameId": "frame-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerDidUpdateSession.self, from: raw))
        { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountListenerDidUpdateSessionRejectsInvalid_wrong_type_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcodes\": []}",
              "frameId": 1,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeCountListenerDidUpdateSessionRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {
                "newlyRecognizedBarcodes": []
              },
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeCountListenerDidUpdateSessionRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcodes\": []}",
              "frameId": "frame-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeCountListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeCountAdaptiveRecognitionListenerDispatchStartedAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": ["{\"data\": \"9012345678\", \"symbology\": \"code128\"}"]
              },
              "frameDataId": "frame-data-1",
              "event": "BarcodeCountAdaptiveRecognitionListener.dispatchStarted"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountAdaptiveRecognitionListenerDispatchStarted.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountAdaptiveRecognitionListenerDispatchStarted.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCountAdaptiveRecognitionListenerDispatchStartedAcceptsValid_empty_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "frameDataId": "frame-data-1",
              "event": "BarcodeCountAdaptiveRecognitionListener.dispatchStarted"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountAdaptiveRecognitionListenerDispatchStarted.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountAdaptiveRecognitionListenerDispatchStarted.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCountAdaptiveRecognitionListenerDispatchStartedRejectsInvalid_missing_frame_data_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "event": "BarcodeCountAdaptiveRecognitionListener.dispatchStarted"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerDispatchStarted.self, from: raw)
        )
    }

    func testBarcodeCountAdaptiveRecognitionListenerDispatchStartedRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "frameDataId": "frame-data-1",
              "unknownProperty": true,
              "event": "BarcodeCountAdaptiveRecognitionListener.dispatchStarted"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerDispatchStarted.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountAdaptiveRecognitionListenerDispatchStartedRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "frameDataId": "frame-data-1",
              "event": "BarcodeCountAdaptiveRecognitionListener.dispatchStarted.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerDispatchStarted.self, from: raw)
        )
    }

    func testBarcodeCountAdaptiveRecognitionListenerDispatchStartedRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": "1",
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "frameDataId": "frame-data-1",
              "event": "BarcodeCountAdaptiveRecognitionListener.dispatchStarted"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerDispatchStarted.self, from: raw)
        )
    }

    func testBarcodeCountAdaptiveRecognitionListenerResponseAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": ["{\"data\": \"9012345678\", \"symbology\": \"code128\"}"]
              },
              "response": "{\"result\": \"ok\"}",
              "event": "BarcodeCountAdaptiveRecognitionListener.response"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountAdaptiveRecognitionListenerResponse.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerResponse.self, from: reEncoded)
        )
    }

    func testBarcodeCountAdaptiveRecognitionListenerResponseAcceptsValid_empty_response_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "response": "",
              "event": "BarcodeCountAdaptiveRecognitionListener.response"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountAdaptiveRecognitionListenerResponse.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerResponse.self, from: reEncoded)
        )
    }

    func testBarcodeCountAdaptiveRecognitionListenerResponseRejectsInvalid_missing_response_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "event": "BarcodeCountAdaptiveRecognitionListener.response"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerResponse.self, from: raw)
        )
    }

    func testBarcodeCountAdaptiveRecognitionListenerResponseRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "response": "{}",
              "unknownProperty": true,
              "event": "BarcodeCountAdaptiveRecognitionListener.response"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerResponse.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountAdaptiveRecognitionListenerResponseRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "response": "{}",
              "event": "BarcodeCountAdaptiveRecognitionListener.response.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerResponse.self, from: raw)
        )
    }

    func testBarcodeCountAdaptiveRecognitionListenerResponseRejectsInvalid_wrong_type_response_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "response": 42,
              "event": "BarcodeCountAdaptiveRecognitionListener.response"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerResponse.self, from: raw)
        )
    }

    func testBarcodeCountAdaptiveRecognitionListenerErrorAcceptsValid_timeout_reason_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": ["{\"data\": \"9012345678\", \"symbology\": \"code128\"}"]
              },
              "reason": "timeout",
              "event": "BarcodeCountAdaptiveRecognitionListener.error"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerError.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerError.self, from: reEncoded)
        )
    }

    func testBarcodeCountAdaptiveRecognitionListenerErrorAcceptsValid_unknown_reason_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "reason": "unknown",
              "event": "BarcodeCountAdaptiveRecognitionListener.error"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerError.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerError.self, from: reEncoded)
        )
    }

    func testBarcodeCountAdaptiveRecognitionListenerErrorRejectsInvalid_missing_reason_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "event": "BarcodeCountAdaptiveRecognitionListener.error"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerError.self, from: raw)
        )
    }

    func testBarcodeCountAdaptiveRecognitionListenerErrorRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "reason": "unknown",
              "unknownProperty": true,
              "event": "BarcodeCountAdaptiveRecognitionListener.error"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerError.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountAdaptiveRecognitionListenerErrorRejectsInvalid_wrong_enum_reason_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "reason": "notARealReason",
              "event": "BarcodeCountAdaptiveRecognitionListener.error"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerError.self, from: raw)
        )
    }

    func testBarcodeCountAdaptiveRecognitionListenerErrorRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "frameMetadata": {
                "frameId": 1,
                "barcodes": []
              },
              "reason": "unknown",
              "event": "BarcodeCountAdaptiveRecognitionListener.error.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountAdaptiveRecognitionListenerError.self, from: raw)
        )
    }

    func testBarcodeCountCaptureListListenerDidUpdateSessionAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"scannedItems\": []}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountCaptureListListenerDidUpdateSession.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountCaptureListListenerDidUpdateSession.self, from: reEncoded)
        )
    }

    func testBarcodeCountCaptureListListenerDidUpdateSessionAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"scannedItems\": []}",
              "viewId": 1,
              "event": "BarcodeCountCaptureListListener.didUpdateSession"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountCaptureListListenerDidUpdateSession.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountCaptureListListenerDidUpdateSession.self, from: reEncoded)
        )
    }

    func testBarcodeCountCaptureListListenerDidUpdateSessionRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountCaptureListListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeCountCaptureListListenerDidUpdateSessionRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"scannedItems\": []}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountCaptureListListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeCountCaptureListListenerDidUpdateSessionRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"scannedItems\": []}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountCaptureListListenerDidUpdateSession.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountCaptureListListenerDidUpdateSessionRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {
                "scannedItems": []
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountCaptureListListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeCountCaptureListListenerDidUpdateSessionRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"scannedItems\": []}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountCaptureListListenerDidUpdateSession.self, from: raw)
        )
    }

    func testBarcodeCountCaptureListListenerDidCompleteCaptureListAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"scannedItems\": []}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountCaptureListListenerDidCompleteCaptureList.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountCaptureListListenerDidCompleteCaptureList.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCountCaptureListListenerDidCompleteCaptureListAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"scannedItems\": []}",
              "viewId": 1,
              "event": "BarcodeCountCaptureListListener.didCompleteCaptureList"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeCountCaptureListListenerDidCompleteCaptureList.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeCountCaptureListListenerDidCompleteCaptureList.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeCountCaptureListListenerDidCompleteCaptureListRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountCaptureListListenerDidCompleteCaptureList.self, from: raw)
        )
    }

    func testBarcodeCountCaptureListListenerDidCompleteCaptureListRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"scannedItems\": []}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountCaptureListListenerDidCompleteCaptureList.self, from: raw)
        )
    }

    func testBarcodeCountCaptureListListenerDidCompleteCaptureListRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"scannedItems\": []}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountCaptureListListenerDidCompleteCaptureList.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountCaptureListListenerDidCompleteCaptureListRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {
                "scannedItems": []
              },
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountCaptureListListenerDidCompleteCaptureList.self, from: raw)
        )
    }

    func testBarcodeCountCaptureListListenerDidCompleteCaptureListRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"scannedItems\": []}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountCaptureListListenerDidCompleteCaptureList.self, from: raw)
        )
    }

    func testBarcodeDataTransformerTransformBarcodeDataAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "data": "9012345678",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeDataTransformerTransformBarcodeData.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeDataTransformerTransformBarcodeData.self, from: reEncoded)
        )
    }

    func testBarcodeDataTransformerTransformBarcodeDataRejectsInvalid_missing_data_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeDataTransformerTransformBarcodeData.self, from: raw)
        )
    }

    func testBarcodeDataTransformerTransformBarcodeDataRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "data": "9012345678"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeDataTransformerTransformBarcodeData.self, from: raw)
        )
    }

    func testBarcodeDataTransformerTransformBarcodeDataRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "data": "9012345678",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeDataTransformerTransformBarcodeData.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeDataTransformerTransformBarcodeDataRejectsInvalid_wrong_type_data_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "data": 9012345678,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeDataTransformerTransformBarcodeData.self, from: raw)
        )
    }

    func testBarcodeDataTransformerTransformBarcodeDataRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "data": "9012345678",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeDataTransformerTransformBarcodeData.self, from: raw)
        )
    }

    func testBarcodeCountStatusProviderOnStatusRequestedAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
              ],
              "requestId": "6f9619ff-8b86-d011-b42d-00cf4fc964ff",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: reEncoded)
        )
    }

    func testBarcodeCountStatusProviderOnStatusRequestedAcceptsValid_multiple_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
                "{\"data\": \"4006381333931\", \"symbology\": \"ean13Upca\"}"
              ],
              "requestId": "6f9619ff-8b86-d011-b42d-00cf4fc964ff",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: reEncoded)
        )
    }

    func testBarcodeCountStatusProviderOnStatusRequestedAcceptsValid_no_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [],
              "requestId": "6f9619ff-8b86-d011-b42d-00cf4fc964ff",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: reEncoded)
        )
    }

    func testBarcodeCountStatusProviderOnStatusRequestedAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
              ],
              "requestId": "6f9619ff-8b86-d011-b42d-00cf4fc964ff",
              "viewId": 1,
              "event": "BarcodeCountStatusProvider.onStatusRequested"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: reEncoded)
        )
    }

    func testBarcodeCountStatusProviderOnStatusRequestedRejectsInvalid_missing_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": "6f9619ff-8b86-d011-b42d-00cf4fc964ff",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: raw)
        )
    }

    func testBarcodeCountStatusProviderOnStatusRequestedRejectsInvalid_missing_request_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
              ],
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: raw)
        )
    }

    func testBarcodeCountStatusProviderOnStatusRequestedRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
              ],
              "requestId": "6f9619ff-8b86-d011-b42d-00cf4fc964ff"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: raw)
        )
    }

    func testBarcodeCountStatusProviderOnStatusRequestedRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
              ],
              "requestId": "6f9619ff-8b86-d011-b42d-00cf4fc964ff",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeCountStatusProviderOnStatusRequestedRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
              ],
              "requestId": "6f9619ff-8b86-d011-b42d-00cf4fc964ff",
              "viewId": 1,
              "event": "BarcodeCountStatusProvider.someOtherEvent"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: raw)
        )
    }

    func testBarcodeCountStatusProviderOnStatusRequestedRejectsInvalid_wrong_type_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "requestId": "6f9619ff-8b86-d011-b42d-00cf4fc964ff",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: raw)
        )
    }

    func testBarcodeCountStatusProviderOnStatusRequestedRejectsInvalid_wrong_type_barcodes_item_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                {
                  "data": "9012345678"
                }
              ],
              "requestId": "6f9619ff-8b86-d011-b42d-00cf4fc964ff",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: raw)
        )
    }

    func testBarcodeCountStatusProviderOnStatusRequestedRejectsInvalid_wrong_type_request_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
              ],
              "requestId": 42,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: raw)
        )
    }

    func testBarcodeCountStatusProviderOnStatusRequestedRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
              ],
              "requestId": "6f9619ff-8b86-d011-b42d-00cf4fc964ff",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeCountStatusProviderOnStatusRequested.self, from: raw)
        )
    }

    func testSparkScanFeedbackDelegateFeedbackForBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForBarcode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForBarcode.self, from: reEncoded)
        )
    }

    func testSparkScanFeedbackDelegateFeedbackForBarcodeAcceptsValid_with_android_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "SparkScanFeedbackDelegate.feedbackForBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForBarcode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForBarcode.self, from: reEncoded)
        )
    }

    func testSparkScanFeedbackDelegateFeedbackForBarcodeRejectsInvalid_missing_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForBarcode.self, from: raw)
        )
    }

    func testSparkScanFeedbackDelegateFeedbackForBarcodeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForBarcode.self, from: raw)
        )
    }

    func testSparkScanFeedbackDelegateFeedbackForBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testSparkScanFeedbackDelegateFeedbackForBarcodeRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1,
              "event": "SparkScanFeedbackDelegate.feedbackForScannedItem"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForBarcode.self, from: raw)
        )
    }

    func testSparkScanFeedbackDelegateFeedbackForBarcodeRejectsInvalid_wrong_type_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": 123,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForBarcode.self, from: raw)
        )
    }

    func testSparkScanFeedbackDelegateFeedbackForBarcodeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForBarcode.self, from: raw)
        )
    }

    func testSparkScanFeedbackDelegateFeedbackForScannedItemAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "scannedItem": "{\"barcode\": {\"data\": \"9012345678\", \"symbology\": \"code128\"}}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.SparkScanFeedbackDelegateFeedbackForScannedItem.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForScannedItem.self, from: reEncoded)
        )
    }

    func testSparkScanFeedbackDelegateFeedbackForScannedItemAcceptsValid_with_android_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "scannedItem": "{\"barcode\": {\"data\": \"9012345678\", \"symbology\": \"code128\"}}",
              "viewId": 1,
              "event": "SparkScanFeedbackDelegate.feedbackForScannedItem"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.SparkScanFeedbackDelegateFeedbackForScannedItem.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForScannedItem.self, from: reEncoded)
        )
    }

    func testSparkScanFeedbackDelegateFeedbackForScannedItemRejectsInvalid_missing_scanned_item_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForScannedItem.self, from: raw)
        )
    }

    func testSparkScanFeedbackDelegateFeedbackForScannedItemRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "scannedItem": "{\"barcode\": {\"data\": \"9012345678\", \"symbology\": \"code128\"}}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForScannedItem.self, from: raw)
        )
    }

    func testSparkScanFeedbackDelegateFeedbackForScannedItemRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "scannedItem": "{\"barcode\": {\"data\": \"9012345678\", \"symbology\": \"code128\"}}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForScannedItem.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testSparkScanFeedbackDelegateFeedbackForScannedItemRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "scannedItem": "{\"barcode\": {\"data\": \"9012345678\", \"symbology\": \"code128\"}}",
              "viewId": 1,
              "event": "SparkScanFeedbackDelegate.feedbackForBarcode"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForScannedItem.self, from: raw)
        )
    }

    func testSparkScanFeedbackDelegateFeedbackForScannedItemRejectsInvalid_wrong_type_scanned_item_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "scannedItem": 123,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForScannedItem.self, from: raw)
        )
    }

    func testSparkScanFeedbackDelegateFeedbackForScannedItemRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "scannedItem": "{\"barcode\": {\"data\": \"9012345678\", \"symbology\": \"code128\"}}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanFeedbackDelegateFeedbackForScannedItem.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerBarcodeFindButtonTappedAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.SparkScanViewUiListenerBarcodeFindButtonTapped.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerBarcodeFindButtonTapped.self, from: reEncoded)
        )
    }

    func testSparkScanViewUiListenerBarcodeFindButtonTappedAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "SparkScanViewUiListener.barcodeFindButtonTapped"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.SparkScanViewUiListenerBarcodeFindButtonTapped.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerBarcodeFindButtonTapped.self, from: reEncoded)
        )
    }

    func testSparkScanViewUiListenerBarcodeFindButtonTappedRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "event": "SparkScanViewUiListener.barcodeFindButtonTapped"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerBarcodeFindButtonTapped.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerBarcodeFindButtonTappedRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerBarcodeFindButtonTapped.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testSparkScanViewUiListenerBarcodeFindButtonTappedRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "SparkScanViewUiListener.someOtherEvent"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerBarcodeFindButtonTapped.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerBarcodeFindButtonTappedRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerBarcodeFindButtonTapped.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerBarcodeCountButtonTappedAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.SparkScanViewUiListenerBarcodeCountButtonTapped.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerBarcodeCountButtonTapped.self, from: reEncoded)
        )
    }

    func testSparkScanViewUiListenerBarcodeCountButtonTappedAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "SparkScanViewUiListener.barcodeCountButtonTapped"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.SparkScanViewUiListenerBarcodeCountButtonTapped.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerBarcodeCountButtonTapped.self, from: reEncoded)
        )
    }

    func testSparkScanViewUiListenerBarcodeCountButtonTappedRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "event": "SparkScanViewUiListener.barcodeCountButtonTapped"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerBarcodeCountButtonTapped.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerBarcodeCountButtonTappedRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerBarcodeCountButtonTapped.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testSparkScanViewUiListenerBarcodeCountButtonTappedRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "SparkScanViewUiListener.someOtherEvent"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerBarcodeCountButtonTapped.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerBarcodeCountButtonTappedRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerBarcodeCountButtonTapped.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerLabelCaptureButtonTappedAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.SparkScanViewUiListenerLabelCaptureButtonTapped.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerLabelCaptureButtonTapped.self, from: reEncoded)
        )
    }

    func testSparkScanViewUiListenerLabelCaptureButtonTappedAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "SparkScanViewUiListener.labelCaptureButtonTapped"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.SparkScanViewUiListenerLabelCaptureButtonTapped.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerLabelCaptureButtonTapped.self, from: reEncoded)
        )
    }

    func testSparkScanViewUiListenerLabelCaptureButtonTappedRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "event": "SparkScanViewUiListener.labelCaptureButtonTapped"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerLabelCaptureButtonTapped.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerLabelCaptureButtonTappedRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerLabelCaptureButtonTapped.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testSparkScanViewUiListenerLabelCaptureButtonTappedRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "SparkScanViewUiListener.someOtherEvent"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerLabelCaptureButtonTapped.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerLabelCaptureButtonTappedRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerLabelCaptureButtonTapped.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerDidChangeViewStateAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "state": "idle",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeViewState.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeViewState.self, from: reEncoded)
        )
    }

    func testSparkScanViewUiListenerDidChangeViewStateAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "state": "idle",
              "viewId": 1,
              "event": "SparkScanViewUiListener.didChangeViewState"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeViewState.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeViewState.self, from: reEncoded)
        )
    }

    func testSparkScanViewUiListenerDidChangeViewStateRejectsInvalid_missing_state_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeViewState.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerDidChangeViewStateRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "state": "idle"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeViewState.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerDidChangeViewStateRejectsInvalid_unknown_enum_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "state": "paused",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeViewState.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerDidChangeViewStateRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "state": "idle",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeViewState.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testSparkScanViewUiListenerDidChangeViewStateRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "state": "idle",
              "viewId": 1,
              "event": "SparkScanViewUiListener.someOtherEvent"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeViewState.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerDidChangeViewStateRejectsInvalid_wrong_type_state_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "state": {"visible": true},
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeViewState.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerDidChangeViewStateRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "state": "idle",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeViewState.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerDidChangeScanningModeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "scanningMode": "{\"type\": \"default\", \"settings\": {\"scanningBehavior\": \"single\", \"previewBehavior\": \"default\"}}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeScanningMode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeScanningMode.self, from: reEncoded)
        )
    }

    func testSparkScanViewUiListenerDidChangeScanningModeAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "scanningMode": "{\"type\": \"default\", \"settings\": {\"scanningBehavior\": \"single\", \"previewBehavior\": \"default\"}}",
              "viewId": 1,
              "event": "SparkScanViewUiListener.didChangeScanningMode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeScanningMode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeScanningMode.self, from: reEncoded)
        )
    }

    func testSparkScanViewUiListenerDidChangeScanningModeRejectsInvalid_missing_scanning_mode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeScanningMode.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerDidChangeScanningModeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "scanningMode": "{\"type\": \"default\", \"settings\": {\"scanningBehavior\": \"single\", \"previewBehavior\": \"default\"}}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeScanningMode.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerDidChangeScanningModeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "scanningMode": "{\"type\": \"default\", \"settings\": {\"scanningBehavior\": \"single\", \"previewBehavior\": \"default\"}}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeScanningMode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testSparkScanViewUiListenerDidChangeScanningModeRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "scanningMode": "{\"type\": \"default\", \"settings\": {\"scanningBehavior\": \"single\", \"previewBehavior\": \"default\"}}",
              "viewId": 1,
              "event": "SparkScanViewUiListener.someOtherEvent"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeScanningMode.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerDidChangeScanningModeRejectsInvalid_wrong_type_scanning_mode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "scanningMode": 123,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeScanningMode.self, from: raw)
        )
    }

    func testSparkScanViewUiListenerDidChangeScanningModeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "scanningMode": "{\"type\": \"default\", \"settings\": {\"scanningBehavior\": \"single\", \"previewBehavior\": \"default\"}}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.SparkScanViewUiListenerDidChangeScanningMode.self, from: raw)
        )
    }

    func testSparkScanListenerDidUpdateSessionAcceptsValid_absent_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"frameSequenceId\": 1}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidUpdateSession.self, from: reEncoded))
    }

    func testSparkScanListenerDidUpdateSessionAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidUpdateSession.self, from: reEncoded))
    }

    func testSparkScanListenerDidUpdateSessionAcceptsValid_null_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"frameSequenceId\": 1}",
              "frameId": null,
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidUpdateSession.self, from: reEncoded))
    }

    func testSparkScanListenerDidUpdateSessionRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidUpdateSession.self, from: raw))
    }

    func testSparkScanListenerDidUpdateSessionRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"frameSequenceId\": 1}",
              "frameId": "frame-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidUpdateSession.self, from: raw))
    }

    func testSparkScanListenerDidUpdateSessionRejectsInvalid_unexpected_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "viewId": 1,
              "event": "SparkScanListener.didUpdateSession"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidUpdateSession.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testSparkScanListenerDidUpdateSessionRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidUpdateSession.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testSparkScanListenerDidUpdateSessionRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {"newlyRecognizedBarcode": null},
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidUpdateSession.self, from: raw))
    }

    func testSparkScanListenerDidUpdateSessionRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": null, \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidUpdateSession.self, from: raw))
    }

    func testSparkScanListenerDidScanAcceptsValid_absent_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": {}, \"frameSequenceId\": 1}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidScan.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidScan.self, from: reEncoded))
    }

    func testSparkScanListenerDidScanAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": {}, \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidScan.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidScan.self, from: reEncoded))
    }

    func testSparkScanListenerDidScanAcceptsValid_null_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": {}, \"frameSequenceId\": 1}",
              "frameId": null,
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidScan.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidScan.self, from: reEncoded))
    }

    func testSparkScanListenerDidScanRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidScan.self, from: raw))
    }

    func testSparkScanListenerDidScanRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": {}, \"frameSequenceId\": 1}",
              "frameId": "frame-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidScan.self, from: raw))
    }

    func testSparkScanListenerDidScanRejectsInvalid_unexpected_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": {}, \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "viewId": 1,
              "event": "SparkScanListener.didScan"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidScan.self, from: raw)) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testSparkScanListenerDidScanRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": {}, \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidScan.self, from: raw)) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testSparkScanListenerDidScanRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {"newlyRecognizedBarcode": {}},
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidScan.self, from: raw))
    }

    func testSparkScanListenerDidScanRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"newlyRecognizedBarcode\": {}, \"frameSequenceId\": 1}",
              "frameId": "frame-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.SparkScanListenerDidScan.self, from: raw))
    }

    func testBarcodePickListenerDidUpdateSessionAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"pickedObjects\": []}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodePickListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodePickListenerDidUpdateSession.self, from: reEncoded)
        )
    }

    func testBarcodePickListenerDidUpdateSessionRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodePickListenerDidUpdateSessionRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"pickedObjects\": []}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodePickListenerDidUpdateSessionRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"pickedObjects\": []}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickListenerDidUpdateSession.self, from: raw))
        { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodePickListenerDidUpdateSessionRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {"pickedObjects": []},
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodePickListenerDidUpdateSessionRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"pickedObjects\": []}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodePickScanningListenerDidCompleteScanningSessionAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"pickedObjects\": []}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodePickScanningListenerDidCompleteScanningSession.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickScanningListenerDidCompleteScanningSession.self,
                from: reEncoded
            )
        )
    }

    func testBarcodePickScanningListenerDidCompleteScanningSessionRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickScanningListenerDidCompleteScanningSession.self, from: raw)
        )
    }

    func testBarcodePickScanningListenerDidCompleteScanningSessionRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"pickedObjects\": []}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickScanningListenerDidCompleteScanningSession.self, from: raw)
        )
    }

    func testBarcodePickScanningListenerDidCompleteScanningSessionRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"pickedObjects\": []}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickScanningListenerDidCompleteScanningSession.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodePickScanningListenerDidCompleteScanningSessionRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {"pickedObjects": []},
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickScanningListenerDidCompleteScanningSession.self, from: raw)
        )
    }

    func testBarcodePickScanningListenerDidCompleteScanningSessionRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"pickedObjects\": []}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickScanningListenerDidCompleteScanningSession.self, from: raw)
        )
    }

    func testBarcodePickScanningListenerDidUpdateScanningSessionAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"pickedObjects\": []}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodePickScanningListenerDidUpdateScanningSession.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickScanningListenerDidUpdateScanningSession.self,
                from: reEncoded
            )
        )
    }

    func testBarcodePickScanningListenerDidUpdateScanningSessionRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickScanningListenerDidUpdateScanningSession.self, from: raw)
        )
    }

    func testBarcodePickScanningListenerDidUpdateScanningSessionRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"pickedObjects\": []}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickScanningListenerDidUpdateScanningSession.self, from: raw)
        )
    }

    func testBarcodePickScanningListenerDidUpdateScanningSessionRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"pickedObjects\": []}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickScanningListenerDidUpdateScanningSession.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodePickScanningListenerDidUpdateScanningSessionRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {"pickedObjects": []},
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickScanningListenerDidUpdateScanningSession.self, from: raw)
        )
    }

    func testBarcodePickScanningListenerDidUpdateScanningSessionRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"pickedObjects\": []}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickScanningListenerDidUpdateScanningSession.self, from: raw)
        )
    }

    func testBarcodePickActionListenerDidPickAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemData": "item-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodePickActionListenerDidPick.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodePickActionListenerDidPick.self, from: reEncoded))
    }

    func testBarcodePickActionListenerDidPickRejectsInvalid_missing_item_data_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickActionListenerDidPick.self, from: raw))
    }

    func testBarcodePickActionListenerDidPickRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemData": "item-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickActionListenerDidPick.self, from: raw))
    }

    func testBarcodePickActionListenerDidPickRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemData": "item-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickActionListenerDidPick.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodePickActionListenerDidPickRejectsInvalid_wrong_type_item_data_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemData": 1,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickActionListenerDidPick.self, from: raw))
    }

    func testBarcodePickActionListenerDidPickRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemData": "item-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickActionListenerDidPick.self, from: raw))
    }

    func testBarcodePickActionListenerDidUnpickAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemData": "item-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodePickActionListenerDidUnpick.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodePickActionListenerDidUnpick.self, from: reEncoded))
    }

    func testBarcodePickActionListenerDidUnpickRejectsInvalid_missing_item_data_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickActionListenerDidUnpick.self, from: raw))
    }

    func testBarcodePickActionListenerDidUnpickRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemData": "item-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickActionListenerDidUnpick.self, from: raw))
    }

    func testBarcodePickActionListenerDidUnpickRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemData": "item-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickActionListenerDidUnpick.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodePickActionListenerDidUnpickRejectsInvalid_wrong_type_item_data_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemData": 1,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickActionListenerDidUnpick.self, from: raw))
    }

    func testBarcodePickActionListenerDidUnpickRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemData": "item-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodePickActionListenerDidUnpick.self, from: raw))
    }

    func testBarcodePickViewListenerDidStartScanningAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidStartScanning.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidStartScanning.self, from: reEncoded)
        )
    }

    func testBarcodePickViewListenerDidStartScanningRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {}
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidStartScanning.self, from: raw)
        )
    }

    func testBarcodePickViewListenerDidStartScanningRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidStartScanning.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodePickViewListenerDidStartScanningRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidStartScanning.self, from: raw)
        )
    }

    func testBarcodePickViewListenerDidFreezeScanningAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidFreezeScanning.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidFreezeScanning.self, from: reEncoded)
        )
    }

    func testBarcodePickViewListenerDidFreezeScanningRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {}
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidFreezeScanning.self, from: raw)
        )
    }

    func testBarcodePickViewListenerDidFreezeScanningRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidFreezeScanning.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodePickViewListenerDidFreezeScanningRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidFreezeScanning.self, from: raw)
        )
    }

    func testBarcodePickViewListenerDidPauseScanningAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidPauseScanning.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidPauseScanning.self, from: reEncoded)
        )
    }

    func testBarcodePickViewListenerDidPauseScanningRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {}
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidPauseScanning.self, from: raw)
        )
    }

    func testBarcodePickViewListenerDidPauseScanningRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidPauseScanning.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodePickViewListenerDidPauseScanningRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidPauseScanning.self, from: raw)
        )
    }

    func testBarcodePickViewListenerDidStopScanningAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidStopScanning.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidStopScanning.self, from: reEncoded)
        )
    }

    func testBarcodePickViewListenerDidStopScanningRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {}
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidStopScanning.self, from: raw)
        )
    }

    func testBarcodePickViewListenerDidStopScanningRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidStopScanning.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodePickViewListenerDidStopScanningRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewListenerDidStopScanning.self, from: raw)
        )
    }

    func testBarcodePickViewUiListenerDidTapFinishButtonAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodePickViewUiListenerDidTapFinishButton.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewUiListenerDidTapFinishButton.self, from: reEncoded)
        )
    }

    func testBarcodePickViewUiListenerDidTapFinishButtonRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {}
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewUiListenerDidTapFinishButton.self, from: raw)
        )
    }

    func testBarcodePickViewUiListenerDidTapFinishButtonRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewUiListenerDidTapFinishButton.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodePickViewUiListenerDidTapFinishButtonRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodePickViewUiListenerDidTapFinishButton.self, from: raw)
        )
    }

    func testBarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItemsAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemsData": ["item-1", "item-2"],
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItems.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItems.self,
                from: reEncoded
            )
        )
    }

    func testBarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItemsAcceptsValid_empty_items_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemsData": [],
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItems.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItems.self,
                from: reEncoded
            )
        )
    }

    func
        testBarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItemsRejectsInvalid_missing_items_data_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItems.self,
                from: raw
            )
        )
    }

    func
        testBarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItemsRejectsInvalid_missing_view_id_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemsData": ["item-1"]
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItems.self,
                from: raw
            )
        )
    }

    func
        testBarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItemsRejectsInvalid_unknown_property_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemsData": ["item-1"],
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItems.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func
        testBarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItemsRejectsInvalid_wrong_type_items_data_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemsData": "item-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItems.self,
                from: raw
            )
        )
    }

    func
        testBarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItemsRejectsInvalid_wrong_type_items_data_element_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemsData": [1, 2],
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItems.self,
                from: raw
            )
        )
    }

    func
        testBarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItemsRejectsInvalid_wrong_type_view_id_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "itemsData": ["item-1"],
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItems.self,
                from: raw
            )
        )
    }

    func testBarcodePickViewHighlightStyleAsyncProviderStyleForRequestAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": 42,
              "request": "{\"trackedBarcodeId\": 1}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodePickViewHighlightStyleAsyncProviderStyleForRequest.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleAsyncProviderStyleForRequest.self,
                from: reEncoded
            )
        )
    }

    func testBarcodePickViewHighlightStyleAsyncProviderStyleForRequestRejectsInvalid_missing_request_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": 42,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleAsyncProviderStyleForRequest.self,
                from: raw
            )
        )
    }

    func testBarcodePickViewHighlightStyleAsyncProviderStyleForRequestRejectsInvalid_missing_request_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "request": "{\"trackedBarcodeId\": 1}",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleAsyncProviderStyleForRequest.self,
                from: raw
            )
        )
    }

    func testBarcodePickViewHighlightStyleAsyncProviderStyleForRequestRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": 42,
              "request": "{\"trackedBarcodeId\": 1}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleAsyncProviderStyleForRequest.self,
                from: raw
            )
        )
    }

    func testBarcodePickViewHighlightStyleAsyncProviderStyleForRequestRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": 42,
              "request": "{\"trackedBarcodeId\": 1}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleAsyncProviderStyleForRequest.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodePickViewHighlightStyleAsyncProviderStyleForRequestRejectsInvalid_wrong_type_request_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": 42,
              "request": {"trackedBarcodeId": 1},
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleAsyncProviderStyleForRequest.self,
                from: raw
            )
        )
    }

    func testBarcodePickViewHighlightStyleAsyncProviderStyleForRequestRejectsInvalid_wrong_type_request_id_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": "42",
              "request": "{\"trackedBarcodeId\": 1}",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleAsyncProviderStyleForRequest.self,
                from: raw
            )
        )
    }

    func testBarcodePickViewHighlightStyleAsyncProviderStyleForRequestRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": 42,
              "request": "{\"trackedBarcodeId\": 1}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleAsyncProviderStyleForRequest.self,
                from: raw
            )
        )
    }

    func testBarcodePickViewHighlightStyleCustomViewProviderViewForRequestAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": 42,
              "request": "{\"trackedBarcodeId\": 1}",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodePickViewHighlightStyleCustomViewProviderViewForRequest.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleCustomViewProviderViewForRequest.self,
                from: reEncoded
            )
        )
    }

    func testBarcodePickViewHighlightStyleCustomViewProviderViewForRequestRejectsInvalid_missing_request_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": 42,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleCustomViewProviderViewForRequest.self,
                from: raw
            )
        )
    }

    func testBarcodePickViewHighlightStyleCustomViewProviderViewForRequestRejectsInvalid_missing_request_id_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "request": "{\"trackedBarcodeId\": 1}",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleCustomViewProviderViewForRequest.self,
                from: raw
            )
        )
    }

    func testBarcodePickViewHighlightStyleCustomViewProviderViewForRequestRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": 42,
              "request": "{\"trackedBarcodeId\": 1}"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleCustomViewProviderViewForRequest.self,
                from: raw
            )
        )
    }

    func testBarcodePickViewHighlightStyleCustomViewProviderViewForRequestRejectsInvalid_unknown_property_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": 42,
              "request": "{\"trackedBarcodeId\": 1}",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleCustomViewProviderViewForRequest.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodePickViewHighlightStyleCustomViewProviderViewForRequestRejectsInvalid_wrong_type_request_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": 42,
              "request": {"trackedBarcodeId": 1},
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleCustomViewProviderViewForRequest.self,
                from: raw
            )
        )
    }

    func testBarcodePickViewHighlightStyleCustomViewProviderViewForRequestRejectsInvalid_wrong_type_request_id_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": "42",
              "request": "{\"trackedBarcodeId\": 1}",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleCustomViewProviderViewForRequest.self,
                from: raw
            )
        )
    }

    func testBarcodePickViewHighlightStyleCustomViewProviderViewForRequestRejectsInvalid_wrong_type_view_id_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "requestId": 42,
              "request": "{\"trackedBarcodeId\": 1}",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodePickViewHighlightStyleCustomViewProviderViewForRequest.self,
                from: raw
            )
        )
    }

    func testBarcodeFindViewUiListenerOnFinishButtonTappedAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624", "0012345678905"],
              "viewId": 1,
              "event": "BarcodeFindViewUiListener.onFinishButtonTapped"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeFindViewUiListenerOnFinishButtonTapped.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindViewUiListenerOnFinishButtonTapped.self, from: reEncoded)
        )
    }

    func testBarcodeFindViewUiListenerOnFinishButtonTappedAcceptsValid_empty_found_items_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": [],
              "viewId": 1,
              "event": "BarcodeFindViewUiListener.onFinishButtonTapped"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeFindViewUiListenerOnFinishButtonTapped.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindViewUiListenerOnFinishButtonTapped.self, from: reEncoded)
        )
    }

    func testBarcodeFindViewUiListenerOnFinishButtonTappedRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624"],
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindViewUiListenerOnFinishButtonTapped.self, from: raw)
        )
    }

    func testBarcodeFindViewUiListenerOnFinishButtonTappedRejectsInvalid_missing_found_items_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "BarcodeFindViewUiListener.onFinishButtonTapped"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindViewUiListenerOnFinishButtonTapped.self, from: raw)
        )
    }

    func testBarcodeFindViewUiListenerOnFinishButtonTappedRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624"],
              "event": "BarcodeFindViewUiListener.onFinishButtonTapped"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindViewUiListenerOnFinishButtonTapped.self, from: raw)
        )
    }

    func testBarcodeFindViewUiListenerOnFinishButtonTappedRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624"],
              "viewId": 1,
              "unknownProperty": true,
              "event": "BarcodeFindViewUiListener.onFinishButtonTapped"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindViewUiListenerOnFinishButtonTapped.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeFindViewUiListenerOnFinishButtonTappedRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624"],
              "viewId": 1,
              "event": "BarcodeFindViewUiListener.onFinishButtonTapped.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindViewUiListenerOnFinishButtonTapped.self, from: raw)
        )
    }

    func testBarcodeFindViewUiListenerOnFinishButtonTappedRejectsInvalid_wrong_type_found_items_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": [123, 456],
              "viewId": 1,
              "event": "BarcodeFindViewUiListener.onFinishButtonTapped"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindViewUiListenerOnFinishButtonTapped.self, from: raw)
        )
    }

    func testBarcodeFindListenerOnSearchStartedAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "BarcodeFindListener.onSearchStarted"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStarted.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStarted.self, from: reEncoded))
    }

    func testBarcodeFindListenerOnSearchStartedRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStarted.self, from: raw))
    }

    func testBarcodeFindListenerOnSearchStartedRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "event": "BarcodeFindListener.onSearchStarted"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStarted.self, from: raw))
    }

    func testBarcodeFindListenerOnSearchStartedRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "unknownProperty": true,
              "event": "BarcodeFindListener.onSearchStarted"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStarted.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeFindListenerOnSearchStartedRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "BarcodeFindListener.onSearchStarted.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStarted.self, from: raw))
    }

    func testBarcodeFindListenerOnSearchStartedRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": "1",
              "event": "BarcodeFindListener.onSearchStarted"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStarted.self, from: raw))
    }

    func testBarcodeFindListenerOnSearchPausedAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624", "0012345678905"],
              "viewId": 1,
              "event": "BarcodeFindListener.onSearchPaused"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchPaused.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchPaused.self, from: reEncoded))
    }

    func testBarcodeFindListenerOnSearchPausedAcceptsValid_empty_found_items_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": [],
              "viewId": 1,
              "event": "BarcodeFindListener.onSearchPaused"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchPaused.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchPaused.self, from: reEncoded))
    }

    func testBarcodeFindListenerOnSearchPausedRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624"],
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchPaused.self, from: raw))
    }

    func testBarcodeFindListenerOnSearchPausedRejectsInvalid_missing_found_items_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "BarcodeFindListener.onSearchPaused"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchPaused.self, from: raw))
    }

    func testBarcodeFindListenerOnSearchPausedRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624"],
              "event": "BarcodeFindListener.onSearchPaused"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchPaused.self, from: raw))
    }

    func testBarcodeFindListenerOnSearchPausedRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624"],
              "viewId": 1,
              "unknownProperty": true,
              "event": "BarcodeFindListener.onSearchPaused"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchPaused.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeFindListenerOnSearchPausedRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624"],
              "viewId": 1,
              "event": "BarcodeFindListener.onSearchPaused.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchPaused.self, from: raw))
    }

    func testBarcodeFindListenerOnSearchPausedRejectsInvalid_wrong_type_found_items_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": [123, 456],
              "viewId": 1,
              "event": "BarcodeFindListener.onSearchPaused"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchPaused.self, from: raw))
    }

    func testBarcodeFindListenerOnSearchStoppedAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624", "0012345678905"],
              "viewId": 1,
              "event": "BarcodeFindListener.onSearchStopped"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStopped.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStopped.self, from: reEncoded))
    }

    func testBarcodeFindListenerOnSearchStoppedAcceptsValid_empty_found_items_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": [],
              "viewId": 1,
              "event": "BarcodeFindListener.onSearchStopped"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStopped.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStopped.self, from: reEncoded))
    }

    func testBarcodeFindListenerOnSearchStoppedRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624"],
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStopped.self, from: raw))
    }

    func testBarcodeFindListenerOnSearchStoppedRejectsInvalid_missing_found_items_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "BarcodeFindListener.onSearchStopped"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStopped.self, from: raw))
    }

    func testBarcodeFindListenerOnSearchStoppedRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624"],
              "event": "BarcodeFindListener.onSearchStopped"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStopped.self, from: raw))
    }

    func testBarcodeFindListenerOnSearchStoppedRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624"],
              "viewId": 1,
              "unknownProperty": true,
              "event": "BarcodeFindListener.onSearchStopped"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStopped.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeFindListenerOnSearchStoppedRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": ["9780201379624"],
              "viewId": 1,
              "event": "BarcodeFindListener.onSearchStopped.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStopped.self, from: raw))
    }

    func testBarcodeFindListenerOnSearchStoppedRejectsInvalid_wrong_type_found_items_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "foundItems": [123, 456],
              "viewId": 1,
              "event": "BarcodeFindListener.onSearchStopped"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerOnSearchStopped.self, from: raw))
    }

    func testBarcodeFindListenerDidUpdateSessionAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"foundItems\": []}",
              "viewId": 1,
              "event": "BarcodeFindListener.didUpdateSession"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerDidUpdateSession.self, from: reEncoded)
        )
    }

    func testBarcodeFindListenerDidUpdateSessionRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"foundItems\": []}",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeFindListenerDidUpdateSessionRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "BarcodeFindListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeFindListenerDidUpdateSessionRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"foundItems\": []}",
              "event": "BarcodeFindListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeFindListenerDidUpdateSessionRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"foundItems\": []}",
              "viewId": 1,
              "unknownProperty": true,
              "event": "BarcodeFindListener.didUpdateSession"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerDidUpdateSession.self, from: raw))
        { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeFindListenerDidUpdateSessionRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"foundItems\": []}",
              "viewId": 1,
              "event": "BarcodeFindListener.didUpdateSession.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeFindListenerDidUpdateSessionRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": 123,
              "viewId": 1,
              "event": "BarcodeFindListener.didUpdateSession"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeFindListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeFindTransformerTransformBarcodeDataAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "data": "9780201379624",
              "viewId": 1,
              "event": "BarcodeFindTransformer.transformBarcodeData"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeFindTransformerTransformBarcodeData.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindTransformerTransformBarcodeData.self, from: reEncoded)
        )
    }

    func testBarcodeFindTransformerTransformBarcodeDataAcceptsValid_null_data_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "data": null,
              "viewId": 1,
              "event": "BarcodeFindTransformer.transformBarcodeData"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeFindTransformerTransformBarcodeData.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindTransformerTransformBarcodeData.self, from: reEncoded)
        )
    }

    func testBarcodeFindTransformerTransformBarcodeDataRejectsInvalid_missing_data_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1,
              "event": "BarcodeFindTransformer.transformBarcodeData"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindTransformerTransformBarcodeData.self, from: raw)
        )
    }

    func testBarcodeFindTransformerTransformBarcodeDataRejectsInvalid_missing_event_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "data": "9780201379624",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindTransformerTransformBarcodeData.self, from: raw)
        )
    }

    func testBarcodeFindTransformerTransformBarcodeDataRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "data": "9780201379624",
              "event": "BarcodeFindTransformer.transformBarcodeData"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindTransformerTransformBarcodeData.self, from: raw)
        )
    }

    func testBarcodeFindTransformerTransformBarcodeDataRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "data": "9780201379624",
              "viewId": 1,
              "unknownProperty": true,
              "event": "BarcodeFindTransformer.transformBarcodeData"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindTransformerTransformBarcodeData.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeFindTransformerTransformBarcodeDataRejectsInvalid_wrong_event_const_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "data": "9780201379624",
              "viewId": 1,
              "event": "BarcodeFindTransformer.transformBarcodeData.wrongEventName"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindTransformerTransformBarcodeData.self, from: raw)
        )
    }

    func testBarcodeFindTransformerTransformBarcodeDataRejectsInvalid_wrong_type_data_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "data": 123,
              "viewId": 1,
              "event": "BarcodeFindTransformer.transformBarcodeData"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeFindTransformerTransformBarcodeData.self, from: raw)
        )
    }

    func testBarcodeArViewUiListenerDidTapHighlightForBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArViewUiListenerDidTapHighlightForBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeArViewUiListenerDidTapHighlightForBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeArViewUiListenerDidTapHighlightForBarcodeAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "BarcodeArViewUiListener.didTapHighlightForBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArViewUiListenerDidTapHighlightForBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeArViewUiListenerDidTapHighlightForBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeArViewUiListenerDidTapHighlightForBarcodeRejectsInvalid_missing_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArViewUiListenerDidTapHighlightForBarcode.self, from: raw)
        )
    }

    func testBarcodeArViewUiListenerDidTapHighlightForBarcodeRejectsInvalid_missing_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArViewUiListenerDidTapHighlightForBarcode.self, from: raw)
        )
    }

    func testBarcodeArViewUiListenerDidTapHighlightForBarcodeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArViewUiListenerDidTapHighlightForBarcode.self, from: raw)
        )
    }

    func testBarcodeArViewUiListenerDidTapHighlightForBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArViewUiListenerDidTapHighlightForBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArViewUiListenerDidTapHighlightForBarcodeRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "BarcodeArViewUiListener.someOtherEvent"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArViewUiListenerDidTapHighlightForBarcode.self, from: raw)
        )
    }

    func testBarcodeArViewUiListenerDidTapHighlightForBarcodeRejectsInvalid_wrong_type_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": 123,
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArViewUiListenerDidTapHighlightForBarcode.self, from: raw)
        )
    }

    func testBarcodeArViewUiListenerDidTapHighlightForBarcodeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArViewUiListenerDidTapHighlightForBarcode.self, from: raw)
        )
    }

    func testBarcodeArAnnotationProviderAnnotationForBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArAnnotationProviderAnnotationForBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeArAnnotationProviderAnnotationForBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeArAnnotationProviderAnnotationForBarcodeAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "BarcodeArAnnotationProvider.annotationForBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArAnnotationProviderAnnotationForBarcode.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeArAnnotationProviderAnnotationForBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeArAnnotationProviderAnnotationForBarcodeRejectsInvalid_missing_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArAnnotationProviderAnnotationForBarcode.self, from: raw)
        )
    }

    func testBarcodeArAnnotationProviderAnnotationForBarcodeRejectsInvalid_missing_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArAnnotationProviderAnnotationForBarcode.self, from: raw)
        )
    }

    func testBarcodeArAnnotationProviderAnnotationForBarcodeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArAnnotationProviderAnnotationForBarcode.self, from: raw)
        )
    }

    func testBarcodeArAnnotationProviderAnnotationForBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArAnnotationProviderAnnotationForBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArAnnotationProviderAnnotationForBarcodeRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "BarcodeArAnnotationProvider.someOtherEvent"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArAnnotationProviderAnnotationForBarcode.self, from: raw)
        )
    }

    func testBarcodeArAnnotationProviderAnnotationForBarcodeRejectsInvalid_wrong_type_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": {
                "data": "x"
              },
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArAnnotationProviderAnnotationForBarcode.self, from: raw)
        )
    }

    func testBarcodeArAnnotationProviderAnnotationForBarcodeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArAnnotationProviderAnnotationForBarcode.self, from: raw)
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIconAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 0,
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIconAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 0,
              "viewId": 1,
              "event": "BarcodeArInfoAnnotationListener.didTapInfoAnnotationRightIcon"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIconAcceptsValid_with_responsive_annotation_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 2,
              "viewId": 1,
              "responsiveAnnotationType": "farAway",
              "responsiveAnnotationThreshold": 1.5
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIconRejectsInvalid_missing_barcode_id_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "componentIndex": 0,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIconRejectsInvalid_missing_component_index_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIconRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 0
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIconRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 0,
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIconRejectsInvalid_wrong_event_value_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 0,
              "viewId": 1,
              "event": "SomeOther.event"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.self,
                from: raw
            )
        )
    }

    func
        testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIconRejectsInvalid_wrong_responsive_annotation_type_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 0,
              "viewId": 1,
              "responsiveAnnotationType": "sideways"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.self,
                from: raw
            )
        )
    }

    func
        testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIconRejectsInvalid_wrong_type_component_index_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": "0",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIconRejectsInvalid_wrong_type_view_id_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 0,
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIconAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 0,
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIconAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 0,
              "viewId": 1,
              "event": "BarcodeArInfoAnnotationListener.didTapInfoAnnotationLeftIcon"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIconAcceptsValid_with_responsive_annotation_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 2,
              "viewId": 1,
              "responsiveAnnotationType": "farAway",
              "responsiveAnnotationThreshold": 1.5
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIconRejectsInvalid_missing_barcode_id_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "componentIndex": 0,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIconRejectsInvalid_missing_component_index_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIconRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 0
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIconRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 0,
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIconRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 0,
              "viewId": 1,
              "event": "SomeOther.event"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.self,
                from: raw
            )
        )
    }

    func
        testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIconRejectsInvalid_wrong_responsive_annotation_type_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 0,
              "viewId": 1,
              "responsiveAnnotationType": "sideways"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIconRejectsInvalid_wrong_type_component_index_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": "0",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIconRejectsInvalid_wrong_type_view_id_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "componentIndex": 0,
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "BarcodeArInfoAnnotationListener.didTapInfoAnnotation"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationAcceptsValid_with_responsive_annotation_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "responsiveAnnotationType": "closeUp",
              "responsiveAnnotationThreshold": 0.5
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRejectsInvalid_missing_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.self, from: raw)
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.self, from: raw)
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "SomeOther.event"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.self, from: raw)
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRejectsInvalid_wrong_responsive_annotation_type_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "responsiveAnnotationType": "sideways"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.self, from: raw)
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRejectsInvalid_wrong_type_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": 1,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.self, from: raw)
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.self, from: raw)
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeaderAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeaderAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "BarcodeArInfoAnnotationListener.didTapInfoAnnotationHeader"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeaderAcceptsValid_with_responsive_annotation_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "responsiveAnnotationType": "closeUp",
              "responsiveAnnotationThreshold": 0.5
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeaderRejectsInvalid_missing_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeaderRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeaderRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeaderRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "SomeOther.event"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.self,
                from: raw
            )
        )
    }

    func
        testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeaderRejectsInvalid_wrong_responsive_annotation_type_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "responsiveAnnotationType": "sideways"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeaderRejectsInvalid_wrong_type_barcode_id_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": 1,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeaderRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooterAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooterAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "BarcodeArInfoAnnotationListener.didTapInfoAnnotationFooter"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooterAcceptsValid_with_responsive_annotation_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "responsiveAnnotationType": "closeUp",
              "responsiveAnnotationThreshold": 0.5
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooterRejectsInvalid_missing_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooterRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooterRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.self,
                from: raw
            )
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooterRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "SomeOther.event"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.self,
                from: raw
            )
        )
    }

    func
        testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooterRejectsInvalid_wrong_responsive_annotation_type_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "responsiveAnnotationType": "sideways"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooterRejectsInvalid_wrong_type_barcode_id_json() throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": 1,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.self,
                from: raw
            )
        )
    }

    func testBarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooterRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.self,
                from: raw
            )
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopover.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopover.self, from: reEncoded)
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverAcceptsValid_nested_in_responsive_annotation_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "responsiveAnnotationThreshold": 0.3
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopover.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopover.self, from: reEncoded)
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "BarcodeArPopoverAnnotationListener.didTapPopover"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopover.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopover.self, from: reEncoded)
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverRejectsInvalid_missing_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopover.self, from: raw)
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopover.self, from: raw)
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopover.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "SomeOther.event"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopover.self, from: raw)
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverRejectsInvalid_wrong_responsive_annotation_type_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "responsiveAnnotationType": "middle"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopover.self, from: raw)
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverRejectsInvalid_wrong_type_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": 1,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopover.self, from: raw)
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopover.self, from: raw)
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverButtonAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "buttonIndex": 0,
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopoverButton.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopoverButton.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverButtonAcceptsValid_nested_in_responsive_annotation_json()
        throws
    {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "buttonIndex": 0,
              "viewId": 1,
              "responsiveAnnotationType": "closeUp",
              "responsiveAnnotationThreshold": 1.0
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopoverButton.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopoverButton.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverButtonAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "buttonIndex": 1,
              "viewId": 1,
              "event": "BarcodeArPopoverAnnotationListener.didTapPopoverButton"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(
            SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopoverButton.self,
            from: raw
        )
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(
                SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopoverButton.self,
                from: reEncoded
            )
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverButtonRejectsInvalid_missing_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "buttonIndex": 0,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopoverButton.self, from: raw)
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverButtonRejectsInvalid_missing_button_index_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopoverButton.self, from: raw)
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverButtonRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "buttonIndex": 0
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopoverButton.self, from: raw)
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverButtonRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "buttonIndex": 0,
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopoverButton.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverButtonRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "buttonIndex": 0,
              "viewId": 1,
              "event": "SomeOther.event"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopoverButton.self, from: raw)
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverButtonRejectsInvalid_wrong_type_button_index_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "buttonIndex": "0",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopoverButton.self, from: raw)
        )
    }

    func testBarcodeArPopoverAnnotationListenerDidTapPopoverButtonRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "buttonIndex": 0,
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopoverButton.self, from: raw)
        )
    }

    func testBarcodeArHighlightProviderHighlightForBarcodeAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArHighlightProviderHighlightForBarcode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeArHighlightProviderHighlightForBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeArHighlightProviderHighlightForBarcodeAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "BarcodeArHighlightProvider.highlightForBarcode"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArHighlightProviderHighlightForBarcode.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(
            try JSONDecoder().decode(SchemaTypes.BarcodeArHighlightProviderHighlightForBarcode.self, from: reEncoded)
        )
    }

    func testBarcodeArHighlightProviderHighlightForBarcodeRejectsInvalid_missing_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArHighlightProviderHighlightForBarcode.self, from: raw)
        )
    }

    func testBarcodeArHighlightProviderHighlightForBarcodeRejectsInvalid_missing_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArHighlightProviderHighlightForBarcode.self, from: raw)
        )
    }

    func testBarcodeArHighlightProviderHighlightForBarcodeRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArHighlightProviderHighlightForBarcode.self, from: raw)
        )
    }

    func testBarcodeArHighlightProviderHighlightForBarcodeRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArHighlightProviderHighlightForBarcode.self, from: raw)
        ) { error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArHighlightProviderHighlightForBarcodeRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "BarcodeArHighlightProvider.someOtherEvent"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArHighlightProviderHighlightForBarcode.self, from: raw)
        )
    }

    func testBarcodeArHighlightProviderHighlightForBarcodeRejectsInvalid_wrong_type_barcode_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": {
                "data": "x"
              },
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArHighlightProviderHighlightForBarcode.self, from: raw)
        )
    }

    func testBarcodeArHighlightProviderHighlightForBarcodeRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "barcodeId": "id-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(
            try JSONDecoder().decode(SchemaTypes.BarcodeArHighlightProviderHighlightForBarcode.self, from: raw)
        )
    }

    func testBarcodeArAugmentationsEvictedAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArAugmentationsEvicted.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArAugmentationsEvicted.self, from: reEncoded))
    }

    func testBarcodeArAugmentationsEvictedAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "BarcodeArAugmentations.evicted"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArAugmentationsEvicted.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArAugmentationsEvicted.self, from: reEncoded))
    }

    func testBarcodeArAugmentationsEvictedRejectsInvalid_missing_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArAugmentationsEvicted.self, from: raw))
    }

    func testBarcodeArAugmentationsEvictedRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArAugmentationsEvicted.self, from: raw))
    }

    func testBarcodeArAugmentationsEvictedRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArAugmentationsEvicted.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArAugmentationsEvictedRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": 1,
              "event": "BarcodeArAugmentations.someOtherEvent"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArAugmentationsEvicted.self, from: raw))
    }

    func testBarcodeArAugmentationsEvictedRejectsInvalid_wrong_type_barcode_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": 1,
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArAugmentationsEvicted.self, from: raw))
    }

    func testBarcodeArAugmentationsEvictedRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodeId": "id-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArAugmentationsEvicted.self, from: raw))
    }

    func testBarcodeArFilterFilterBarcodesAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                {
                  "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
                  "barcodeId": "id-1"
                }
              ],
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: reEncoded))
    }

    func testBarcodeArFilterFilterBarcodesAcceptsValid_multiple_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                {
                  "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
                  "barcodeId": "id-1"
                },
                {
                  "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
                  "barcodeId": "id-2"
                }
              ],
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: reEncoded))
    }

    func testBarcodeArFilterFilterBarcodesAcceptsValid_no_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [],
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: reEncoded))
    }

    func testBarcodeArFilterFilterBarcodesAcceptsValid_with_ios_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                {
                  "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
                  "barcodeId": "id-1"
                }
              ],
              "viewId": 1,
              "event": "BarcodeArFilter.filterBarcodes"
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: reEncoded))
    }

    func testBarcodeArFilterFilterBarcodesRejectsInvalid_missing_barcode_id_in_item_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                {
                  "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}"
                }
              ],
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: raw))
    }

    func testBarcodeArFilterFilterBarcodesRejectsInvalid_missing_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: raw))
    }

    func testBarcodeArFilterFilterBarcodesRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                {
                  "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
                  "barcodeId": "id-1"
                }
              ]
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: raw))
    }

    func testBarcodeArFilterFilterBarcodesRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                {
                  "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
                  "barcodeId": "id-1"
                }
              ],
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArFilterFilterBarcodesRejectsInvalid_wrong_event_value_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                {
                  "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
                  "barcodeId": "id-1"
                }
              ],
              "viewId": 1,
              "event": "BarcodeArFilter.someOtherEvent"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: raw))
    }

    func testBarcodeArFilterFilterBarcodesRejectsInvalid_wrong_type_barcodes_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: raw))
    }

    func testBarcodeArFilterFilterBarcodesRejectsInvalid_wrong_type_barcodes_item_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                {
                  "data": "9012345678"
                }
              ],
              "viewId": 1
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArFilterFilterBarcodesRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "barcodes": [
                {
                  "barcode": "{\"data\": \"9012345678\", \"symbology\": \"code128\"}",
                  "barcodeId": "id-1"
                }
              ],
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArFilterFilterBarcodes.self, from: raw))
    }

    func testBarcodeArListenerDidUpdateSessionAcceptsValid_basic_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"trackedBarcodes\": []}",
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArListenerDidUpdateSession.self, from: reEncoded))
    }

    func testBarcodeArListenerDidUpdateSessionAcceptsValid_null_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"trackedBarcodes\": []}",
              "frameId": null,
              "viewId": 1
            }
            """#.utf8
        )
        let parsed = try JSONDecoder().decode(SchemaTypes.BarcodeArListenerDidUpdateSession.self, from: raw)
        let reEncoded = try JSONEncoder().encode(parsed)
        XCTAssertNoThrow(try JSONDecoder().decode(SchemaTypes.BarcodeArListenerDidUpdateSession.self, from: reEncoded))
    }

    func testBarcodeArListenerDidUpdateSessionRejectsInvalid_missing_frame_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"trackedBarcodes\": []}",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeArListenerDidUpdateSessionRejectsInvalid_missing_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeArListenerDidUpdateSessionRejectsInvalid_missing_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"trackedBarcodes\": []}",
              "frameId": "frame-1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeArListenerDidUpdateSessionRejectsInvalid_unexpected_event_key_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"trackedBarcodes\": []}",
              "frameId": "frame-1",
              "viewId": 1,
              "event": "BarcodeArListener.didUpdateSession"
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArListenerDidUpdateSession.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArListenerDidUpdateSessionRejectsInvalid_unknown_property_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"trackedBarcodes\": []}",
              "frameId": "frame-1",
              "viewId": 1,
              "bogus": true
            }
            """#.utf8
        )
        // Asserts the TYPE: the unknown-key class must surface as core's one shared
        // `UnknownPropertyError`, so a cross-module catch keeps matching.
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArListenerDidUpdateSession.self, from: raw)) {
            error in
            XCTAssertTrue(error is UnknownPropertyError, "expected UnknownPropertyError, got \(error)")
        }
    }

    func testBarcodeArListenerDidUpdateSessionRejectsInvalid_wrong_type_session_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": {
                "trackedBarcodes": []
              },
              "frameId": "frame-1",
              "viewId": 1
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArListenerDidUpdateSession.self, from: raw))
    }

    func testBarcodeArListenerDidUpdateSessionRejectsInvalid_wrong_type_view_id_json() throws {
        // Raw string literal (#"""..."""#): a plain Swift multi-line literal processes
        // backslash escapes, so a fixture carrying an embedded JSON string (any property
        // with contentMediaType: application/json) would have its \" collapsed to a bare "
        // and stop being valid JSON. Raw literals keep the fixture bytes verbatim.
        let raw = Data(
            #"""
            {
              "session": "{\"trackedBarcodes\": []}",
              "frameId": "frame-1",
              "viewId": "1"
            }
            """#.utf8
        )
        XCTAssertThrowsError(try JSONDecoder().decode(SchemaTypes.BarcodeArListenerDidUpdateSession.self, from: raw))
    }
}
