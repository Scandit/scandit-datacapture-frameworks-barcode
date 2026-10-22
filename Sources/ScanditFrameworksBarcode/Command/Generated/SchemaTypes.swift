/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

// THIS FILE IS GENERATED. DO NOT EDIT MANUALLY.
// Generator: scripts/bridge_generator/generate.py
// Schema: scripts/bridge_generator/schemas/barcode.json
//
// Codable structs/enums derived from the serialization JSON schemas
// referenced by this module's bridge params -- the Swift twin of
// `SchemaTypes.kt` (SDC-32644) / `schemaTypes.ts` / `schema_types.dart`. No
// runtime dependency beyond Foundation: validation rides Codable's own
// throwing contract, hand-extended below for the keywords Codable doesn't
// natively enforce.
//
// init(from:) enforces the same JSON Schema keywords the Kotlin/Dart
// emitters do: required, type, enum, string const, additionalProperties,
// null-ness, and root-level oneOf (dispatched on the discriminator). NOT
// enforced -- a payload violating one of these still decodes: pattern,
// minimum/maximum, minLength/maxLength, multipleOf.
//
// Like the Kotlin emitter's `SchemaAssertions.requireValid` (SDC-33621:
// throws unconditionally in every build variant), every check below
// throws unconditionally in every build configuration: there is no
// `#if DEBUG` idiom in frameworks/shared/ios today, and Codable's
// `Decodable.init(from:)` throws by contract regardless of build config
// -- gating strictness behind DEBUG would fight the protocol it
// implements. Required-field absence, a null on a non-optional
// property, and a type mismatch are all
// surfaced automatically by `KeyedDecodingContainer.decode(_:forKey:)`
// (native `DecodingError.keyNotFound` / `.valueNotFound` /
// `.typeMismatch`) -- EXCEPT for a property that is both `required` and
// `nullable`, which must accept an explicit null while still rejecting a
// missing key; `decode(_:forKey:)` can't express that (it rejects null
// too) and plain `decodeIfPresent` can't express it either (it treats a
// missing key and an explicit null identically, both -> nil), so that case
// gets a hand-rolled `container.contains(forKey:)` guard below that throws
// `DecodingError.keyNotFound` before falling through to `decodeIfPresent`.
// unknown-enum-value and unknown-key (`additionalProperties: false`)
// checks are likewise hand-rolled below and throw
// `DecodingError.dataCorrupted` with a message naming the offending
// key/value.
//
// Full required/nullable matrix, kept coherent across every property kind
// (plain scalar, enum, array, ref, union) and both directions:
//
//   not required (nullable or not):
//     decode: missing key -> nil; explicit `null` -> nil.
//     encode: `nil` -> key omitted (`encodeIfPresent` / `if let`).
//   required, non-nullable:
//     decode: missing key -> throws `keyNotFound`; explicit `null` -> throws
//       `valueNotFound` (from `decode(_:forKey:)`, or from the union
//       parser's own decode when it hits null).
//     encode: always encodes the key (non-optional Swift property).
//   required, nullable:
//     decode: missing key -> throws `keyNotFound` (hand-rolled
//       `required_key_guard` below, since `decodeIfPresent`/`decodeNil`
//       alone can't distinguish missing-key from explicit-null); explicit
//       `null` -> nil.
//     encode: `nil` -> key present with an explicit `null`
//       (`encodeNil(forKey:)`), never omitted -- omitting it here would
//       make `init(from:)` throw `keyNotFound` on round-trip.
//
// A union-typed property follows the same matrix, but "decode" means
// dispatching through `<Union>Parser.parse(from:)` against a
// `superDecoder`; since that parser cannot itself observe null (it reads a
// discriminator key out of the nested container), every union branch below
// checks `decodeNil`/`contains` itself before ever calling into the parser.

import Foundation
// `UnknownPropertyError` is declared once, by hand, in core -- see its doc comment.
import ScanditFrameworksCore

// Reusable dynamic `CodingKey` for enumerating every key actually present
// in the payload -- needed only to implement `additionalProperties: false`
// (an unknown-key check), since a container keyed by a fixed `CodingKeys`
// enum never surfaces keys it doesn't already know about.
private struct AnyCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int? { nil }

    init(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        return nil
    }
}

// Codable stand-in for a property (or array element) the generator cannot
// give a nominal type -- an inline anonymous object with no `$ref`/`$defs`,
// like `barcode_ar_filter_filter_barcodes.json`'s `barcodes` items.
//
// Kotlin, Dart and TypeScript can spell "untyped" directly (`Any?`,
// `Object?`, `unknown`), so they render such a property as-is. Swift cannot:
// `Any` is not `Codable`, so `container.decode([Any].self, ...)` has no
// matching overload and the file does not compile. This enum is the Swift
// spelling of the same idea -- it round-trips arbitrary JSON without
// asserting a shape, so element-level validation stays exactly as absent
// here as it is on the other three platforms.
// Internal rather than `private`: unlike `AnyCodingKey` (used only inside
// function bodies), this type appears in the stored-property types of the
// generated structs, and Swift rejects an internal property whose type is
// private.
enum AnyJSON: Codable {
    case string(String)
    case number(Double)
    case integer(Int)
    case bool(Bool)
    case array([AnyJSON])
    case object([String: AnyJSON])
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .null
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode(Int.self) {
            // Int before Double: `decode(Double.self)` also accepts an
            // integer literal, and matching Double first would turn every
            // whole number into `1.0` on re-encode.
            self = .integer(value)
        } else if let value = try? container.decode(Double.self) {
            self = .number(value)
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode([AnyJSON].self) {
            self = .array(value)
        } else if let value = try? container.decode([String: AnyJSON].self) {
            self = .object(value)
        } else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "AnyJSON: value is not representable as JSON"
                )
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value): try container.encode(value)
        case .number(let value): try container.encode(value)
        case .integer(let value): try container.encode(value)
        case .bool(let value): try container.encode(value)
        case .array(let value): try container.encode(value)
        case .object(let value): try container.encode(value)
        case .null: try container.encodeNil()
        }
    }

    // Projection back to the plain Foundation JSON types that
    // `Event.emit(on:payload: [String: Any])` serializes.
    var jsonObject: Any {
        switch self {
        case .string(let value): return value
        case .number(let value): return value
        case .integer(let value): return value
        case .bool(let value): return value
        case .array(let value): return value.map(\.jsonObject)
        case .object(let value): return value.mapValues(\.jsonObject)
        case .null: return NSNull()
        }
    }
}

// Namespace container for every generated type below. A schema title is
// only unique within its own schema file (`serialization/schemas/**`); the
// Kotlin emitter gets collision safety for free from its
// `...command.generated` *package*, and the TS/Dart emitters keep their
// generated types out of the public barrel -- but a Swift target has no
// per-directory namespace and no barrel to exclude from, so an unqualified
// top-level type here can shadow an unrelated SDK type of the same name
// (e.g. a schema titled "SequenceFrameSource" collided with
// `SDCSequenceFrameSource`'s `NS_SWIFT_NAME(SequenceFrameSource)` from
// ScanditCaptureCore -- see SDC-32645). Wrapping every generated
// declaration in this uninhabited `enum` namespaces all of them under
// `SchemaTypes.<Name>`, so unqualified references elsewhere in the module
// keep resolving to the real SDK type.
enum SchemaTypes {

    /// A brush defining fill and stroke appearance.
    struct Brush: Codable {
        let fill: Fill?
        let stroke: Stroke?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            fill: Fill? = nil,
            stroke: Stroke? = nil
        ) {
            self.fill = fill
            self.stroke = stroke
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "fill",
            "stroke",
        ]

        enum CodingKeys: String, CodingKey {
            case fill
            case stroke
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "Brush: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            fill = try container.decodeIfPresent(Fill.self, forKey: .fill)
            stroke = try container.decodeIfPresent(Stroke.self, forKey: .stroke)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(fill, forKey: .fill)
            try container.encodeIfPresent(stroke, forKey: .stroke)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let fill { dict["fill"] = fill.toDictionary() }
            if let stroke { dict["stroke"] = stroke.toDictionary() }
            return dict
        }
    }

    struct Fill: Codable {
        let color: Color?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            color: Color? = nil
        ) {
            self.color = color
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "color"
        ]

        enum CodingKeys: String, CodingKey {
            case color
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "Fill: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            color = try container.decodeIfPresent(Color.self, forKey: .color)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(color, forKey: .color)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let color { dict["color"] = color }
            return dict
        }
    }

    /// A color expressed as a hex string with an optional # prefix. Accepted formats: RGB, RGBA,
    /// RRGGBB, RRGGBBAA (case-insensitive).
    typealias Color = String

    /// Throwing validator for the `Color` alias, used when a value of
    /// this shape must be parsed out of a raw (non-`Decoder`-backed) JSON blob.
    static func parseColor(_ raw: Any?) throws -> Color {
        guard let value = raw as? String else {
            throw DecodingError.typeMismatch(
                String.self,
                DecodingError.Context(codingPath: [], debugDescription: "Color: expected a String")
            )
        }
        return value
    }

    struct Stroke: Codable {
        let color: Color?
        let width: Double?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            color: Color? = nil,
            width: Double? = nil
        ) {
            self.color = color
            self.width = width
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "color",
            "width",
        ]

        enum CodingKeys: String, CodingKey {
            case color
            case width
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "Stroke: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            color = try container.decodeIfPresent(Color.self, forKey: .color)
            width = try container.decodeIfPresent(Double.self, forKey: .width)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(color, forKey: .color)
            try container.encodeIfPresent(width, forKey: .width)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let color { dict["color"] = color }
            if let width { dict["width"] = width }
            return dict
        }
    }

    /// Text customization settings for the BarcodeCount mapping flow. Ignored by the native SDK.
    struct BarcodeCountMappingFlowSettings: Codable {
        let scanBarcodesGuidanceText: String?
        let nextButtonText: String?
        let stepBackGuidanceText: String?
        let redoScanButtonText: String?
        let restartButtonText: String?
        let finishButtonText: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            scanBarcodesGuidanceText: String? = nil,
            nextButtonText: String? = nil,
            stepBackGuidanceText: String? = nil,
            redoScanButtonText: String? = nil,
            restartButtonText: String? = nil,
            finishButtonText: String? = nil
        ) {
            self.scanBarcodesGuidanceText = scanBarcodesGuidanceText
            self.nextButtonText = nextButtonText
            self.stepBackGuidanceText = stepBackGuidanceText
            self.redoScanButtonText = redoScanButtonText
            self.restartButtonText = restartButtonText
            self.finishButtonText = finishButtonText
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "scanBarcodesGuidanceText",
            "nextButtonText",
            "stepBackGuidanceText",
            "redoScanButtonText",
            "restartButtonText",
            "finishButtonText",
        ]

        enum CodingKeys: String, CodingKey {
            case scanBarcodesGuidanceText
            case nextButtonText
            case stepBackGuidanceText
            case redoScanButtonText
            case restartButtonText
            case finishButtonText
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCountMappingFlowSettings: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            scanBarcodesGuidanceText = try container.decodeIfPresent(String.self, forKey: .scanBarcodesGuidanceText)
            nextButtonText = try container.decodeIfPresent(String.self, forKey: .nextButtonText)
            stepBackGuidanceText = try container.decodeIfPresent(String.self, forKey: .stepBackGuidanceText)
            redoScanButtonText = try container.decodeIfPresent(String.self, forKey: .redoScanButtonText)
            restartButtonText = try container.decodeIfPresent(String.self, forKey: .restartButtonText)
            finishButtonText = try container.decodeIfPresent(String.self, forKey: .finishButtonText)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(scanBarcodesGuidanceText, forKey: .scanBarcodesGuidanceText)
            try container.encodeIfPresent(nextButtonText, forKey: .nextButtonText)
            try container.encodeIfPresent(stepBackGuidanceText, forKey: .stepBackGuidanceText)
            try container.encodeIfPresent(redoScanButtonText, forKey: .redoScanButtonText)
            try container.encodeIfPresent(restartButtonText, forKey: .restartButtonText)
            try container.encodeIfPresent(finishButtonText, forKey: .finishButtonText)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let scanBarcodesGuidanceText { dict["scanBarcodesGuidanceText"] = scanBarcodesGuidanceText }
            if let nextButtonText { dict["nextButtonText"] = nextButtonText }
            if let stepBackGuidanceText { dict["stepBackGuidanceText"] = stepBackGuidanceText }
            if let redoScanButtonText { dict["redoScanButtonText"] = redoScanButtonText }
            if let restartButtonText { dict["restartButtonText"] = restartButtonText }
            if let finishButtonText { dict["finishButtonText"] = finishButtonText }
            return dict
        }
    }

    /// An icon with optional colored background for use in SDK UI elements.
    struct ScanditIcon: Codable {
        let icon: ScanditIconType?
        let iconColor: Color?
        let backgroundColor: Color?
        let backgroundStrokeColor: Color?
        let backgroundStrokeWidth: Double?
        let backgroundShape: ScanditIconShape?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            icon: ScanditIconType? = nil,
            iconColor: Color? = nil,
            backgroundColor: Color? = nil,
            backgroundStrokeColor: Color? = nil,
            backgroundStrokeWidth: Double? = nil,
            backgroundShape: ScanditIconShape? = nil
        ) {
            self.icon = icon
            self.iconColor = iconColor
            self.backgroundColor = backgroundColor
            self.backgroundStrokeColor = backgroundStrokeColor
            self.backgroundStrokeWidth = backgroundStrokeWidth
            self.backgroundShape = backgroundShape
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "icon",
            "iconColor",
            "backgroundColor",
            "backgroundStrokeColor",
            "backgroundStrokeWidth",
            "backgroundShape",
        ]

        enum CodingKeys: String, CodingKey {
            case icon
            case iconColor
            case backgroundColor
            case backgroundStrokeColor
            case backgroundStrokeWidth
            case backgroundShape
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "ScanditIcon: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            icon = try container.decodeIfPresent(ScanditIconType.self, forKey: .icon)
            iconColor = try container.decodeIfPresent(Color.self, forKey: .iconColor)
            backgroundColor = try container.decodeIfPresent(Color.self, forKey: .backgroundColor)
            backgroundStrokeColor = try container.decodeIfPresent(Color.self, forKey: .backgroundStrokeColor)
            backgroundStrokeWidth = try container.decodeIfPresent(Double.self, forKey: .backgroundStrokeWidth)
            backgroundShape = try container.decodeIfPresent(ScanditIconShape.self, forKey: .backgroundShape)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(icon, forKey: .icon)
            try container.encodeIfPresent(iconColor, forKey: .iconColor)
            try container.encodeIfPresent(backgroundColor, forKey: .backgroundColor)
            try container.encodeIfPresent(backgroundStrokeColor, forKey: .backgroundStrokeColor)
            try container.encodeIfPresent(backgroundStrokeWidth, forKey: .backgroundStrokeWidth)
            try container.encodeIfPresent(backgroundShape, forKey: .backgroundShape)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["icon"] = icon.map { $0.rawValue } ?? NSNull()
            dict["iconColor"] = iconColor.map { $0 } ?? NSNull()
            dict["backgroundColor"] = backgroundColor.map { $0 } ?? NSNull()
            dict["backgroundStrokeColor"] = backgroundStrokeColor.map { $0 } ?? NSNull()
            if let backgroundStrokeWidth { dict["backgroundStrokeWidth"] = backgroundStrokeWidth }
            dict["backgroundShape"] = backgroundShape.map { $0.rawValue } ?? NSNull()
            return dict
        }
    }

    /// The icon type for a ScanditIcon.
    enum ScanditIconType: String, Codable {
        case toPick = "toPick"
        case checkmark = "checkmark"
        case xMark = "xMark"
        case questionMark = "questionMark"
        case exclamationMark = "exclamationMark"
        case wrongItem = "wrongItem"
        case lowStock = "lowStock"
        case inspectItem = "inspectItem"
        case expiredItem = "expiredItem"
        case fragileItem = "fragileItem"
        case starFilled = "starFilled"
        case starHalfFilled = "starHalfFilled"
        case starOutlined = "starOutlined"
        case arrowRight = "arrowRight"
        case arrowLeft = "arrowLeft"
        case arrowUp = "arrowUp"
        case arrowDown = "arrowDown"
        case chevronRight = "chevronRight"
        case chevronDown = "chevronDown"
        case chevronUp = "chevronUp"
        case chevronLeft = "chevronLeft"
        case print = "print"
        case plus = "plus"
        case delete = "delete"
        case slash = "slash"
        case minus = "minus"
    }

    /// The background shape for a ScanditIcon.
    enum ScanditIconShape: String, Codable {
        case circle = "circle"
        case square = "square"
    }

    /// The finishBarcodeArAnnotationForBarcode bridge call's root payload: the target barcode plus the
    /// annotation to display for it (or none).
    struct BarcodeArModuleFinishAnnotationForBarcode: Codable {
        let barcodeId: String
        let annotation: BarcodeArAnnotation?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcodeId: String,
            annotation: BarcodeArAnnotation? = nil
        ) {
            self.barcodeId = barcodeId
            self.annotation = annotation
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcodeId",
            "annotation",
        ]

        enum CodingKeys: String, CodingKey {
            case barcodeId
            case annotation
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArModuleFinishAnnotationForBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcodeId = try container.decode(String.self, forKey: .barcodeId)
            if container.contains(.annotation), try !container.decodeNil(forKey: .annotation) {
                annotation = try BarcodeArAnnotationParser.parse(from: container.superDecoder(forKey: .annotation))
            } else {
                annotation = nil
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcodeId, forKey: .barcodeId)
            if let annotation {
                try annotation.encode(to: container.superEncoder(forKey: .annotation))
            }
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcodeId"] = barcodeId
            dict["annotation"] = annotation?.toDictionary() ?? NSNull()
            return dict
        }
    }

    /// Discriminated union of all BarcodeAr annotation types. The type field selects the concrete
    /// schema.
    // Protocol + variant structs, not an associated-value enum: every variant
    // below is already an independently Codable struct (see the plain-object
    // branch of this template), so the protocol reuses that conformance
    // directly. An associated-value enum would need a wrapper case per variant
    // and hand-written encode/decode forwarding into each one anyway -- no
    // simpler, and it would duplicate the discriminator dispatch below inside
    // the enum's own init(from:).
    protocol BarcodeArAnnotation: Codable {
        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- the bridge event-emit
        // path takes a plain dictionary, not a Codable-encoded blob.
        func toDictionary() -> [String: Any]
    }

    enum BarcodeArAnnotationParser {
        static func parse(from decoder: Decoder) throws -> BarcodeArAnnotation {
            let container = try decoder.container(keyedBy: AnyCodingKey.self)
            let discriminant = try container.decodeIfPresent(
                String.self,
                forKey: AnyCodingKey(stringValue: "type")
            )
            switch discriminant {
            case "barcodeArInfoAnnotation":
                return try BarcodeArInfoAnnotation(from: decoder)
            case "barcodeArPopoverAnnotation":
                return try BarcodeArPopoverAnnotation(from: decoder)
            case "barcodeArStatusIconAnnotation":
                return try BarcodeArStatusIconAnnotation(from: decoder)
            case "barcodeArResponsiveAnnotation":
                return try BarcodeArResponsiveAnnotation(from: decoder)
            case "barcodeArCustomAnnotation":
                return try BarcodeArCustomAnnotation(from: decoder)
            default:
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArAnnotation: unknown type '\(discriminant ?? "nil")'"
                    )
                )
            }
        }
    }

    /// An annotation showing an optional header, a body of text/icon rows, and an optional footer next
    /// to a scanned barcode.
    struct BarcodeArInfoAnnotation: BarcodeArAnnotation {
        let type: String
        let hasTip: Bool?
        let isEntireAnnotationTappable: Bool?
        let anchor: String
        let width: String
        let annotationTrigger: BarcodeArAnnotationTrigger
        let header: BarcodeArInfoAnnotationHeaderOrFooter?
        let footer: BarcodeArInfoAnnotationHeaderOrFooter?
        let body: [BarcodeArInfoAnnotationBodyComponent]
        let backgroundColor: Color?
        let hasListener: Bool?
        let barcodeId: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            type: String,
            hasTip: Bool? = nil,
            isEntireAnnotationTappable: Bool? = nil,
            anchor: String,
            width: String,
            annotationTrigger: BarcodeArAnnotationTrigger,
            header: BarcodeArInfoAnnotationHeaderOrFooter? = nil,
            footer: BarcodeArInfoAnnotationHeaderOrFooter? = nil,
            body: [BarcodeArInfoAnnotationBodyComponent],
            backgroundColor: Color? = nil,
            hasListener: Bool? = nil,
            barcodeId: String? = nil
        ) {
            self.type = type
            self.hasTip = hasTip
            self.isEntireAnnotationTappable = isEntireAnnotationTappable
            self.anchor = anchor
            self.width = width
            self.annotationTrigger = annotationTrigger
            self.header = header
            self.footer = footer
            self.body = body
            self.backgroundColor = backgroundColor
            self.hasListener = hasListener
            self.barcodeId = barcodeId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "type",
            "hasTip",
            "isEntireAnnotationTappable",
            "anchor",
            "width",
            "annotationTrigger",
            "header",
            "footer",
            "body",
            "backgroundColor",
            "hasListener",
            "barcodeId",
        ]
        private static let typeAllowedValues: Set<String> = ["barcodeArInfoAnnotation"]
        private static let anchorAllowedValues: Set<String> = ["top", "bottom", "left", "right"]
        private static let widthAllowedValues: Set<String> = ["small", "medium", "large"]

        enum CodingKeys: String, CodingKey {
            case type
            case hasTip
            case isEntireAnnotationTappable
            case anchor
            case width
            case annotationTrigger
            case header
            case footer
            case body
            case backgroundColor
            case hasListener
            case barcodeId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArInfoAnnotation: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeRaw = try container.decode(String.self, forKey: .type)
            guard Self.typeAllowedValues.contains(typeRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArInfoAnnotation.type: unknown enum value '\(typeRaw)'"
                    )
                )
            }
            type = typeRaw
            hasTip = try container.decodeIfPresent(Bool.self, forKey: .hasTip)
            isEntireAnnotationTappable = try container.decodeIfPresent(Bool.self, forKey: .isEntireAnnotationTappable)
            let anchorRaw = try container.decode(String.self, forKey: .anchor)
            guard Self.anchorAllowedValues.contains(anchorRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArInfoAnnotation.anchor: unknown enum value '\(anchorRaw)'"
                    )
                )
            }
            anchor = anchorRaw
            let widthRaw = try container.decode(String.self, forKey: .width)
            guard Self.widthAllowedValues.contains(widthRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArInfoAnnotation.width: unknown enum value '\(widthRaw)'"
                    )
                )
            }
            width = widthRaw
            annotationTrigger = try container.decode(BarcodeArAnnotationTrigger.self, forKey: .annotationTrigger)
            header = try container.decodeIfPresent(BarcodeArInfoAnnotationHeaderOrFooter.self, forKey: .header)
            footer = try container.decodeIfPresent(BarcodeArInfoAnnotationHeaderOrFooter.self, forKey: .footer)
            body = try container.decode([BarcodeArInfoAnnotationBodyComponent].self, forKey: .body)
            backgroundColor = try container.decodeIfPresent(Color.self, forKey: .backgroundColor)
            hasListener = try container.decodeIfPresent(Bool.self, forKey: .hasListener)
            barcodeId = try container.decodeIfPresent(String.self, forKey: .barcodeId)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(type, forKey: .type)
            try container.encodeIfPresent(hasTip, forKey: .hasTip)
            try container.encodeIfPresent(isEntireAnnotationTappable, forKey: .isEntireAnnotationTappable)
            try container.encode(anchor, forKey: .anchor)
            try container.encode(width, forKey: .width)
            try container.encode(annotationTrigger, forKey: .annotationTrigger)
            try container.encodeIfPresent(header, forKey: .header)
            try container.encodeIfPresent(footer, forKey: .footer)
            try container.encode(body, forKey: .body)
            try container.encodeIfPresent(backgroundColor, forKey: .backgroundColor)
            try container.encodeIfPresent(hasListener, forKey: .hasListener)
            try container.encodeIfPresent(barcodeId, forKey: .barcodeId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["type"] = type
            if let hasTip { dict["hasTip"] = hasTip }
            if let isEntireAnnotationTappable { dict["isEntireAnnotationTappable"] = isEntireAnnotationTappable }
            dict["anchor"] = anchor
            dict["width"] = width
            dict["annotationTrigger"] = annotationTrigger.rawValue
            dict["header"] = header.map { $0.toDictionary() } ?? NSNull()
            dict["footer"] = footer.map { $0.toDictionary() } ?? NSNull()
            dict["body"] = body.map { $0.toDictionary() }
            if let backgroundColor { dict["backgroundColor"] = backgroundColor }
            if let hasListener { dict["hasListener"] = hasListener }
            if let barcodeId { dict["barcodeId"] = barcodeId }
            return dict
        }
    }

    /// The interaction that causes an annotation to be requested/shown for a barcode.
    enum BarcodeArAnnotationTrigger: String, Codable {
        case highlightTap = "highlightTap"
        case highlightTapAndBarcodeScan = "highlightTapAndBarcodeScan"
        case barcodeScan = "barcodeScan"
    }

    struct BarcodeArInfoAnnotationHeaderOrFooter: Codable {
        let text: String?
        let icon: ScanditIcon?
        let textSize: Double
        let textColor: Color?
        let backgroundColor: Color?
        let fontFamily: FontFamily

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            text: String? = nil,
            icon: ScanditIcon? = nil,
            textSize: Double,
            textColor: Color? = nil,
            backgroundColor: Color? = nil,
            fontFamily: FontFamily
        ) {
            self.text = text
            self.icon = icon
            self.textSize = textSize
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.fontFamily = fontFamily
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "text",
            "icon",
            "textSize",
            "textColor",
            "backgroundColor",
            "fontFamily",
        ]

        enum CodingKeys: String, CodingKey {
            case text
            case icon
            case textSize
            case textColor
            case backgroundColor
            case fontFamily
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArInfoAnnotationHeaderOrFooter: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            text = try container.decodeIfPresent(String.self, forKey: .text)
            icon = try container.decodeIfPresent(ScanditIcon.self, forKey: .icon)
            textSize = try container.decode(Double.self, forKey: .textSize)
            textColor = try container.decodeIfPresent(Color.self, forKey: .textColor)
            backgroundColor = try container.decodeIfPresent(Color.self, forKey: .backgroundColor)
            fontFamily = try container.decode(FontFamily.self, forKey: .fontFamily)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(text, forKey: .text)
            try container.encodeIfPresent(icon, forKey: .icon)
            try container.encode(textSize, forKey: .textSize)
            try container.encodeIfPresent(textColor, forKey: .textColor)
            try container.encodeIfPresent(backgroundColor, forKey: .backgroundColor)
            try container.encode(fontFamily, forKey: .fontFamily)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["text"] = text ?? NSNull()
            dict["icon"] = icon.map { $0.toDictionary() } ?? NSNull()
            dict["textSize"] = textSize
            dict["textColor"] = textColor.map { $0 } ?? NSNull()
            dict["backgroundColor"] = backgroundColor.map { $0 } ?? NSNull()
            dict["fontFamily"] = fontFamily.rawValue
            return dict
        }
    }

    /// A font family for SDK-rendered text.
    enum FontFamily: String, Codable {
        case systemDefault = "systemDefault"
        case modernMono = "modernMono"
        case systemSans = "systemSans"
    }

    struct BarcodeArInfoAnnotationBodyComponent: Codable {
        let text: String?
        let textColor: Color
        let textSize: Double?
        let textAlign: TextAlignment
        let fontFamily: FontFamily
        let leftIcon: ScanditIcon?
        let isLeftIconTappable: Bool?
        let rightIcon: ScanditIcon?
        let isRightIconTappable: Bool?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            text: String? = nil,
            textColor: Color,
            textSize: Double? = nil,
            textAlign: TextAlignment,
            fontFamily: FontFamily,
            leftIcon: ScanditIcon? = nil,
            isLeftIconTappable: Bool? = nil,
            rightIcon: ScanditIcon? = nil,
            isRightIconTappable: Bool? = nil
        ) {
            self.text = text
            self.textColor = textColor
            self.textSize = textSize
            self.textAlign = textAlign
            self.fontFamily = fontFamily
            self.leftIcon = leftIcon
            self.isLeftIconTappable = isLeftIconTappable
            self.rightIcon = rightIcon
            self.isRightIconTappable = isRightIconTappable
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "text",
            "textColor",
            "textSize",
            "textAlign",
            "fontFamily",
            "leftIcon",
            "isLeftIconTappable",
            "rightIcon",
            "isRightIconTappable",
        ]

        enum CodingKeys: String, CodingKey {
            case text
            case textColor
            case textSize
            case textAlign
            case fontFamily
            case leftIcon
            case isLeftIconTappable
            case rightIcon
            case isRightIconTappable
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArInfoAnnotationBodyComponent: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            text = try container.decodeIfPresent(String.self, forKey: .text)
            textColor = try container.decode(Color.self, forKey: .textColor)
            textSize = try container.decodeIfPresent(Double.self, forKey: .textSize)
            textAlign = try container.decode(TextAlignment.self, forKey: .textAlign)
            fontFamily = try container.decode(FontFamily.self, forKey: .fontFamily)
            leftIcon = try container.decodeIfPresent(ScanditIcon.self, forKey: .leftIcon)
            isLeftIconTappable = try container.decodeIfPresent(Bool.self, forKey: .isLeftIconTappable)
            rightIcon = try container.decodeIfPresent(ScanditIcon.self, forKey: .rightIcon)
            isRightIconTappable = try container.decodeIfPresent(Bool.self, forKey: .isRightIconTappable)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(text, forKey: .text)
            try container.encode(textColor, forKey: .textColor)
            try container.encodeIfPresent(textSize, forKey: .textSize)
            try container.encode(textAlign, forKey: .textAlign)
            try container.encode(fontFamily, forKey: .fontFamily)
            try container.encodeIfPresent(leftIcon, forKey: .leftIcon)
            try container.encodeIfPresent(isLeftIconTappable, forKey: .isLeftIconTappable)
            try container.encodeIfPresent(rightIcon, forKey: .rightIcon)
            try container.encodeIfPresent(isRightIconTappable, forKey: .isRightIconTappable)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["text"] = text ?? NSNull()
            dict["textColor"] = textColor
            if let textSize { dict["textSize"] = textSize }
            dict["textAlign"] = textAlign.rawValue
            dict["fontFamily"] = fontFamily.rawValue
            dict["leftIcon"] = leftIcon.map { $0.toDictionary() } ?? NSNull()
            if let isLeftIconTappable { dict["isLeftIconTappable"] = isLeftIconTappable }
            dict["rightIcon"] = rightIcon.map { $0.toDictionary() } ?? NSNull()
            if let isRightIconTappable { dict["isRightIconTappable"] = isRightIconTappable }
            return dict
        }
    }

    /// Horizontal alignment for SDK-rendered text.
    enum TextAlignment: String, Codable {
        case left = "left"
        case right = "right"
        case center = "center"
        case start = "start"
        case end = "end"
    }

    /// An annotation showing a row of buttons in a popover next to a scanned barcode.
    struct BarcodeArPopoverAnnotation: BarcodeArAnnotation {
        let type: String
        let buttons: [BarcodeArPopoverAnnotationButton]
        let isEntirePopoverTappable: Bool?
        let anchor: String?
        let annotationTrigger: BarcodeArAnnotationTrigger
        let hasListener: Bool?
        let barcodeId: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            type: String,
            buttons: [BarcodeArPopoverAnnotationButton],
            isEntirePopoverTappable: Bool? = nil,
            anchor: String? = nil,
            annotationTrigger: BarcodeArAnnotationTrigger,
            hasListener: Bool? = nil,
            barcodeId: String? = nil
        ) {
            self.type = type
            self.buttons = buttons
            self.isEntirePopoverTappable = isEntirePopoverTappable
            self.anchor = anchor
            self.annotationTrigger = annotationTrigger
            self.hasListener = hasListener
            self.barcodeId = barcodeId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "type",
            "buttons",
            "isEntirePopoverTappable",
            "anchor",
            "annotationTrigger",
            "hasListener",
            "barcodeId",
        ]
        private static let typeAllowedValues: Set<String> = ["barcodeArPopoverAnnotation"]
        private static let anchorAllowedValues: Set<String> = ["left", "right", "bottom", "top"]

        enum CodingKeys: String, CodingKey {
            case type
            case buttons
            case isEntirePopoverTappable
            case anchor
            case annotationTrigger
            case hasListener
            case barcodeId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArPopoverAnnotation: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeRaw = try container.decode(String.self, forKey: .type)
            guard Self.typeAllowedValues.contains(typeRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArPopoverAnnotation.type: unknown enum value '\(typeRaw)'"
                    )
                )
            }
            type = typeRaw
            buttons = try container.decode([BarcodeArPopoverAnnotationButton].self, forKey: .buttons)
            isEntirePopoverTappable = try container.decodeIfPresent(Bool.self, forKey: .isEntirePopoverTappable)
            let anchorRaw = try container.decodeIfPresent(String.self, forKey: .anchor)
            if let anchorRaw {
                guard Self.anchorAllowedValues.contains(anchorRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription: "BarcodeArPopoverAnnotation.anchor: unknown enum value '\(anchorRaw)'"
                        )
                    )
                }
            }
            anchor = anchorRaw
            annotationTrigger = try container.decode(BarcodeArAnnotationTrigger.self, forKey: .annotationTrigger)
            hasListener = try container.decodeIfPresent(Bool.self, forKey: .hasListener)
            barcodeId = try container.decodeIfPresent(String.self, forKey: .barcodeId)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(type, forKey: .type)
            try container.encode(buttons, forKey: .buttons)
            try container.encodeIfPresent(isEntirePopoverTappable, forKey: .isEntirePopoverTappable)
            try container.encodeIfPresent(anchor, forKey: .anchor)
            try container.encode(annotationTrigger, forKey: .annotationTrigger)
            try container.encodeIfPresent(hasListener, forKey: .hasListener)
            try container.encodeIfPresent(barcodeId, forKey: .barcodeId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["type"] = type
            dict["buttons"] = buttons.map { $0.toDictionary() }
            if let isEntirePopoverTappable { dict["isEntirePopoverTappable"] = isEntirePopoverTappable }
            if let anchor { dict["anchor"] = anchor }
            dict["annotationTrigger"] = annotationTrigger.rawValue
            if let hasListener { dict["hasListener"] = hasListener }
            if let barcodeId { dict["barcodeId"] = barcodeId }
            return dict
        }
    }

    struct BarcodeArPopoverAnnotationButton: Codable {
        let icon: ScanditIcon
        let text: String
        let textColor: Color
        let textSize: Double
        let fontFamily: FontFamily
        let enabled: Bool?
        let index: Int?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            icon: ScanditIcon,
            text: String,
            textColor: Color,
            textSize: Double,
            fontFamily: FontFamily,
            enabled: Bool? = nil,
            index: Int? = nil
        ) {
            self.icon = icon
            self.text = text
            self.textColor = textColor
            self.textSize = textSize
            self.fontFamily = fontFamily
            self.enabled = enabled
            self.index = index
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "icon",
            "text",
            "textColor",
            "textSize",
            "fontFamily",
            "enabled",
            "index",
        ]

        enum CodingKeys: String, CodingKey {
            case icon
            case text
            case textColor
            case textSize
            case fontFamily
            case enabled
            case index
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArPopoverAnnotationButton: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            icon = try container.decode(ScanditIcon.self, forKey: .icon)
            text = try container.decode(String.self, forKey: .text)
            textColor = try container.decode(Color.self, forKey: .textColor)
            textSize = try container.decode(Double.self, forKey: .textSize)
            fontFamily = try container.decode(FontFamily.self, forKey: .fontFamily)
            enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
            index = try container.decodeIfPresent(Int.self, forKey: .index)
            if let index {
                guard index >= Int(Int32.min), index <= Int(Int32.max) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription: "BarcodeArPopoverAnnotationButton.index: out of Int32 range"
                        )
                    )
                }
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(icon, forKey: .icon)
            try container.encode(text, forKey: .text)
            try container.encode(textColor, forKey: .textColor)
            try container.encode(textSize, forKey: .textSize)
            try container.encode(fontFamily, forKey: .fontFamily)
            try container.encodeIfPresent(enabled, forKey: .enabled)
            try container.encodeIfPresent(index, forKey: .index)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["icon"] = icon.toDictionary()
            dict["text"] = text
            dict["textColor"] = textColor
            dict["textSize"] = textSize
            dict["fontFamily"] = fontFamily.rawValue
            if let enabled { dict["enabled"] = enabled }
            if let index { dict["index"] = index }
            return dict
        }
    }

    /// An annotation showing a single status icon next to a scanned barcode.
    struct BarcodeArStatusIconAnnotation: BarcodeArAnnotation {
        let type: String
        let barcode: AnyJSON?
        let hasTip: Bool?
        let icon: ScanditIcon
        let text: String?
        let textColor: Color
        let backgroundColor: Color
        let annotationTrigger: BarcodeArAnnotationTrigger
        let anchor: String?
        let barcodeId: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            type: String,
            barcode: AnyJSON? = nil,
            hasTip: Bool? = nil,
            icon: ScanditIcon,
            text: String? = nil,
            textColor: Color,
            backgroundColor: Color,
            annotationTrigger: BarcodeArAnnotationTrigger,
            anchor: String? = nil,
            barcodeId: String? = nil
        ) {
            self.type = type
            self.barcode = barcode
            self.hasTip = hasTip
            self.icon = icon
            self.text = text
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.annotationTrigger = annotationTrigger
            self.anchor = anchor
            self.barcodeId = barcodeId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "type",
            "barcode",
            "hasTip",
            "icon",
            "text",
            "textColor",
            "backgroundColor",
            "annotationTrigger",
            "anchor",
            "barcodeId",
        ]
        private static let typeAllowedValues: Set<String> = ["barcodeArStatusIconAnnotation"]
        private static let anchorAllowedValues: Set<String> = ["top", "bottom", "left", "right"]

        enum CodingKeys: String, CodingKey {
            case type
            case barcode
            case hasTip
            case icon
            case text
            case textColor
            case backgroundColor
            case annotationTrigger
            case anchor
            case barcodeId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArStatusIconAnnotation: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeRaw = try container.decode(String.self, forKey: .type)
            guard Self.typeAllowedValues.contains(typeRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArStatusIconAnnotation.type: unknown enum value '\(typeRaw)'"
                    )
                )
            }
            type = typeRaw
            barcode = try container.decodeIfPresent(AnyJSON.self, forKey: .barcode)
            hasTip = try container.decodeIfPresent(Bool.self, forKey: .hasTip)
            icon = try container.decode(ScanditIcon.self, forKey: .icon)
            text = try container.decodeIfPresent(String.self, forKey: .text)
            textColor = try container.decode(Color.self, forKey: .textColor)
            backgroundColor = try container.decode(Color.self, forKey: .backgroundColor)
            annotationTrigger = try container.decode(BarcodeArAnnotationTrigger.self, forKey: .annotationTrigger)
            let anchorRaw = try container.decodeIfPresent(String.self, forKey: .anchor)
            if let anchorRaw {
                guard Self.anchorAllowedValues.contains(anchorRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription: "BarcodeArStatusIconAnnotation.anchor: unknown enum value '\(anchorRaw)'"
                        )
                    )
                }
            }
            anchor = anchorRaw
            barcodeId = try container.decodeIfPresent(String.self, forKey: .barcodeId)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(type, forKey: .type)
            try container.encodeIfPresent(barcode, forKey: .barcode)
            try container.encodeIfPresent(hasTip, forKey: .hasTip)
            try container.encode(icon, forKey: .icon)
            try container.encodeIfPresent(text, forKey: .text)
            try container.encode(textColor, forKey: .textColor)
            try container.encode(backgroundColor, forKey: .backgroundColor)
            try container.encode(annotationTrigger, forKey: .annotationTrigger)
            try container.encodeIfPresent(anchor, forKey: .anchor)
            try container.encodeIfPresent(barcodeId, forKey: .barcodeId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["type"] = type
            if let barcode { dict["barcode"] = barcode.jsonObject }
            if let hasTip { dict["hasTip"] = hasTip }
            dict["icon"] = icon.toDictionary()
            dict["text"] = text ?? NSNull()
            dict["textColor"] = textColor
            dict["backgroundColor"] = backgroundColor
            dict["annotationTrigger"] = annotationTrigger.rawValue
            if let anchor { dict["anchor"] = anchor }
            if let barcodeId { dict["barcodeId"] = barcodeId }
            return dict
        }
    }

    /// An annotation that swaps between annotation variants depending on the barcode's area relative to
    /// the view. Two wire shapes coexist: the current `annotationsByThreshold` map, and a legacy two-
    /// slot `closeUpAnnotation`/`farAwayAnnotation`/`threshold` shape kept for older emitters. A
    /// deserializer that understands `annotationsByThreshold` ignores the legacy keys when both are
    /// present; TypeScript currently emits both on every payload for backward compatibility.
    struct BarcodeArResponsiveAnnotation: BarcodeArAnnotation {
        let type: String
        let annotationTrigger: BarcodeArAnnotationTrigger
        let annotationsByThreshold: AnyJSON?
        let closeUpAnnotation: BarcodeArInfoAnnotation?
        let farAwayAnnotation: BarcodeArInfoAnnotation?
        let threshold: Double?
        let barcodeId: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            type: String,
            annotationTrigger: BarcodeArAnnotationTrigger,
            annotationsByThreshold: AnyJSON? = nil,
            closeUpAnnotation: BarcodeArInfoAnnotation? = nil,
            farAwayAnnotation: BarcodeArInfoAnnotation? = nil,
            threshold: Double? = nil,
            barcodeId: String? = nil
        ) {
            self.type = type
            self.annotationTrigger = annotationTrigger
            self.annotationsByThreshold = annotationsByThreshold
            self.closeUpAnnotation = closeUpAnnotation
            self.farAwayAnnotation = farAwayAnnotation
            self.threshold = threshold
            self.barcodeId = barcodeId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "type",
            "annotationTrigger",
            "annotationsByThreshold",
            "closeUpAnnotation",
            "farAwayAnnotation",
            "threshold",
            "barcodeId",
        ]
        private static let typeAllowedValues: Set<String> = ["barcodeArResponsiveAnnotation"]

        enum CodingKeys: String, CodingKey {
            case type
            case annotationTrigger
            case annotationsByThreshold
            case closeUpAnnotation
            case farAwayAnnotation
            case threshold
            case barcodeId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArResponsiveAnnotation: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeRaw = try container.decode(String.self, forKey: .type)
            guard Self.typeAllowedValues.contains(typeRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArResponsiveAnnotation.type: unknown enum value '\(typeRaw)'"
                    )
                )
            }
            type = typeRaw
            annotationTrigger = try container.decode(BarcodeArAnnotationTrigger.self, forKey: .annotationTrigger)
            annotationsByThreshold = try container.decodeIfPresent(AnyJSON.self, forKey: .annotationsByThreshold)
            closeUpAnnotation = try container.decodeIfPresent(BarcodeArInfoAnnotation.self, forKey: .closeUpAnnotation)
            farAwayAnnotation = try container.decodeIfPresent(BarcodeArInfoAnnotation.self, forKey: .farAwayAnnotation)
            threshold = try container.decodeIfPresent(Double.self, forKey: .threshold)
            barcodeId = try container.decodeIfPresent(String.self, forKey: .barcodeId)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(type, forKey: .type)
            try container.encode(annotationTrigger, forKey: .annotationTrigger)
            try container.encodeIfPresent(annotationsByThreshold, forKey: .annotationsByThreshold)
            try container.encodeIfPresent(closeUpAnnotation, forKey: .closeUpAnnotation)
            try container.encodeIfPresent(farAwayAnnotation, forKey: .farAwayAnnotation)
            try container.encodeIfPresent(threshold, forKey: .threshold)
            try container.encodeIfPresent(barcodeId, forKey: .barcodeId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["type"] = type
            dict["annotationTrigger"] = annotationTrigger.rawValue
            if let annotationsByThreshold { dict["annotationsByThreshold"] = annotationsByThreshold.jsonObject }
            dict["closeUpAnnotation"] = closeUpAnnotation.map { $0.toDictionary() } ?? NSNull()
            dict["farAwayAnnotation"] = farAwayAnnotation.map { $0.toDictionary() } ?? NSNull()
            if let threshold { dict["threshold"] = threshold }
            if let barcodeId { dict["barcodeId"] = barcodeId }
            return dict
        }
    }

    /// An annotation backed by a custom, application-provided view. Carries no configuration beyond the
    /// trigger: the native side only constructs an empty placeholder view and reports its position back
    /// through BarcodeArCustomAnnotation.create/update/dispose events.
    struct BarcodeArCustomAnnotation: BarcodeArAnnotation {
        let type: String
        let annotationTrigger: BarcodeArAnnotationTrigger
        let barcodeId: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            type: String,
            annotationTrigger: BarcodeArAnnotationTrigger,
            barcodeId: String? = nil
        ) {
            self.type = type
            self.annotationTrigger = annotationTrigger
            self.barcodeId = barcodeId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "type",
            "annotationTrigger",
            "barcodeId",
        ]
        private static let typeAllowedValues: Set<String> = ["barcodeArCustomAnnotation"]

        enum CodingKeys: String, CodingKey {
            case type
            case annotationTrigger
            case barcodeId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArCustomAnnotation: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeRaw = try container.decode(String.self, forKey: .type)
            guard Self.typeAllowedValues.contains(typeRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArCustomAnnotation.type: unknown enum value '\(typeRaw)'"
                    )
                )
            }
            type = typeRaw
            annotationTrigger = try container.decode(BarcodeArAnnotationTrigger.self, forKey: .annotationTrigger)
            barcodeId = try container.decodeIfPresent(String.self, forKey: .barcodeId)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(type, forKey: .type)
            try container.encode(annotationTrigger, forKey: .annotationTrigger)
            try container.encodeIfPresent(barcodeId, forKey: .barcodeId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["type"] = type
            dict["annotationTrigger"] = annotationTrigger.rawValue
            if let barcodeId { dict["barcodeId"] = barcodeId }
            return dict
        }
    }

    /// The finishBarcodeArHighlightForBarcode bridge call's root payload: the target barcode plus the
    /// highlight to display for it (or none).
    struct BarcodeArModuleFinishHighlightForBarcode: Codable {
        let barcodeId: String
        let highlight: BarcodeArHighlight?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcodeId: String,
            highlight: BarcodeArHighlight? = nil
        ) {
            self.barcodeId = barcodeId
            self.highlight = highlight
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcodeId",
            "highlight",
        ]

        enum CodingKeys: String, CodingKey {
            case barcodeId
            case highlight
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArModuleFinishHighlightForBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcodeId = try container.decode(String.self, forKey: .barcodeId)
            if container.contains(.highlight), try !container.decodeNil(forKey: .highlight) {
                highlight = try BarcodeArHighlightParser.parse(from: container.superDecoder(forKey: .highlight))
            } else {
                highlight = nil
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcodeId, forKey: .barcodeId)
            if let highlight {
                try highlight.encode(to: container.superEncoder(forKey: .highlight))
            }
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcodeId"] = barcodeId
            dict["highlight"] = highlight?.toDictionary() ?? NSNull()
            return dict
        }
    }

    /// Discriminated union of all BarcodeAr highlight types. The type field selects the concrete
    /// schema.
    // Protocol + variant structs, not an associated-value enum: every variant
    // below is already an independently Codable struct (see the plain-object
    // branch of this template), so the protocol reuses that conformance
    // directly. An associated-value enum would need a wrapper case per variant
    // and hand-written encode/decode forwarding into each one anyway -- no
    // simpler, and it would duplicate the discriminator dispatch below inside
    // the enum's own init(from:).
    protocol BarcodeArHighlight: Codable {
        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- the bridge event-emit
        // path takes a plain dictionary, not a Codable-encoded blob.
        func toDictionary() -> [String: Any]
    }

    enum BarcodeArHighlightParser {
        static func parse(from decoder: Decoder) throws -> BarcodeArHighlight {
            let container = try decoder.container(keyedBy: AnyCodingKey.self)
            let discriminant = try container.decodeIfPresent(
                String.self,
                forKey: AnyCodingKey(stringValue: "type")
            )
            switch discriminant {
            case "barcodeArCircleHighlight":
                return try BarcodeArCircleHighlight(from: decoder)
            case "barcodeArRectangleHighlight":
                return try BarcodeArRectangleHighlight(from: decoder)
            case "barcodeArCustomHighlight":
                return try BarcodeArCustomHighlight(from: decoder)
            default:
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArHighlight: unknown type '\(discriminant ?? "nil")'"
                    )
                )
            }
        }
    }

    /// A circular highlight drawn around a scanned barcode.
    struct BarcodeArCircleHighlight: BarcodeArHighlight {
        let type: String
        let preset: BarcodeArCircleHighlightPreset
        let brush: Brush?
        let icon: ScanditIcon?
        let size: Double
        let isPulsing: Bool?
        let barcodeId: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            type: String,
            preset: BarcodeArCircleHighlightPreset,
            brush: Brush? = nil,
            icon: ScanditIcon? = nil,
            size: Double,
            isPulsing: Bool? = nil,
            barcodeId: String? = nil
        ) {
            self.type = type
            self.preset = preset
            self.brush = brush
            self.icon = icon
            self.size = size
            self.isPulsing = isPulsing
            self.barcodeId = barcodeId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "type",
            "preset",
            "brush",
            "icon",
            "size",
            "isPulsing",
            "barcodeId",
        ]
        private static let typeAllowedValues: Set<String> = ["barcodeArCircleHighlight"]

        enum CodingKeys: String, CodingKey {
            case type
            case preset
            case brush
            case icon
            case size
            case isPulsing
            case barcodeId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArCircleHighlight: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeRaw = try container.decode(String.self, forKey: .type)
            guard Self.typeAllowedValues.contains(typeRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArCircleHighlight.type: unknown enum value '\(typeRaw)'"
                    )
                )
            }
            type = typeRaw
            preset = try container.decode(BarcodeArCircleHighlightPreset.self, forKey: .preset)
            brush = try container.decodeIfPresent(Brush.self, forKey: .brush)
            icon = try container.decodeIfPresent(ScanditIcon.self, forKey: .icon)
            size = try container.decode(Double.self, forKey: .size)
            isPulsing = try container.decodeIfPresent(Bool.self, forKey: .isPulsing)
            barcodeId = try container.decodeIfPresent(String.self, forKey: .barcodeId)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(type, forKey: .type)
            try container.encode(preset, forKey: .preset)
            try container.encodeIfPresent(brush, forKey: .brush)
            try container.encodeIfPresent(icon, forKey: .icon)
            try container.encode(size, forKey: .size)
            try container.encodeIfPresent(isPulsing, forKey: .isPulsing)
            try container.encodeIfPresent(barcodeId, forKey: .barcodeId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["type"] = type
            dict["preset"] = preset.rawValue
            if let brush { dict["brush"] = brush.toDictionary() }
            dict["icon"] = icon.map { $0.toDictionary() } ?? NSNull()
            dict["size"] = size
            if let isPulsing { dict["isPulsing"] = isPulsing }
            if let barcodeId { dict["barcodeId"] = barcodeId }
            return dict
        }
    }

    /// A preset determining the default brush/icon/size for a circle highlight.
    enum BarcodeArCircleHighlightPreset: String, Codable {
        case dot = "dot"
        case icon = "icon"
    }

    /// A rectangular highlight drawn around a scanned barcode's quadrilateral.
    struct BarcodeArRectangleHighlight: BarcodeArHighlight {
        let type: String
        let brush: Brush
        let icon: ScanditIcon?
        let barcodeId: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            type: String,
            brush: Brush,
            icon: ScanditIcon? = nil,
            barcodeId: String? = nil
        ) {
            self.type = type
            self.brush = brush
            self.icon = icon
            self.barcodeId = barcodeId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "type",
            "brush",
            "icon",
            "barcodeId",
        ]
        private static let typeAllowedValues: Set<String> = ["barcodeArRectangleHighlight"]

        enum CodingKeys: String, CodingKey {
            case type
            case brush
            case icon
            case barcodeId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArRectangleHighlight: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeRaw = try container.decode(String.self, forKey: .type)
            guard Self.typeAllowedValues.contains(typeRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArRectangleHighlight.type: unknown enum value '\(typeRaw)'"
                    )
                )
            }
            type = typeRaw
            brush = try container.decode(Brush.self, forKey: .brush)
            icon = try container.decodeIfPresent(ScanditIcon.self, forKey: .icon)
            barcodeId = try container.decodeIfPresent(String.self, forKey: .barcodeId)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(type, forKey: .type)
            try container.encode(brush, forKey: .brush)
            try container.encodeIfPresent(icon, forKey: .icon)
            try container.encodeIfPresent(barcodeId, forKey: .barcodeId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["type"] = type
            dict["brush"] = brush.toDictionary()
            dict["icon"] = icon.map { $0.toDictionary() } ?? NSNull()
            if let barcodeId { dict["barcodeId"] = barcodeId }
            return dict
        }
    }

    /// A highlight backed by a custom, application-provided view. Carries no configuration of its own:
    /// the native side only constructs an empty placeholder view and reports its position back through
    /// BarcodeArCustomHighlight.create/update/dispose events.
    struct BarcodeArCustomHighlight: BarcodeArHighlight {
        let type: String
        let barcodeId: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            type: String,
            barcodeId: String? = nil
        ) {
            self.type = type
            self.barcodeId = barcodeId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "type",
            "barcodeId",
        ]
        private static let typeAllowedValues: Set<String> = ["barcodeArCustomHighlight"]

        enum CodingKeys: String, CodingKey {
            case type
            case barcodeId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArCustomHighlight: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeRaw = try container.decode(String.self, forKey: .type)
            guard Self.typeAllowedValues.contains(typeRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArCustomHighlight.type: unknown enum value '\(typeRaw)'"
                    )
                )
            }
            type = typeRaw
            barcodeId = try container.decodeIfPresent(String.self, forKey: .barcodeId)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(type, forKey: .type)
            try container.encodeIfPresent(barcodeId, forKey: .barcodeId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["type"] = type
            if let barcodeId { dict["barcodeId"] = barcodeId }
            return dict
        }
    }

    /// Notifies the listener that the BarcodeCapture session was updated with a newly processed frame;
    /// the framework awaits a boolean reply before proceeding.
    struct BarcodeCaptureListenerDidUpdateSession: Codable {
        let session: String
        let frameId: String?
        let modeId: Int
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            frameId: String? = nil,
            modeId: Int,
            event: String
        ) {
            self.session = session
            self.frameId = frameId
            self.modeId = modeId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "frameId",
            "modeId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCaptureListener.didUpdateSession"]

        enum CodingKeys: String, CodingKey {
            case session
            case frameId
            case modeId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCaptureListenerDidUpdateSession: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            frameId = try container.decodeIfPresent(String.self, forKey: .frameId)
            modeId = try container.decode(Int.self, forKey: .modeId)
            guard modeId >= Int(Int32.min), modeId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCaptureListenerDidUpdateSession.modeId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCaptureListenerDidUpdateSession.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encodeIfPresent(frameId, forKey: .frameId)
            try container.encode(modeId, forKey: .modeId)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["frameId"] = frameId ?? NSNull()
            dict["modeId"] = modeId
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that BarcodeCapture scanned a barcode in the given session/frame; the
    /// framework awaits a boolean reply before proceeding.
    struct BarcodeCaptureListenerDidScan: Codable {
        let session: String
        let frameId: String?
        let modeId: Int
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            frameId: String? = nil,
            modeId: Int,
            event: String
        ) {
            self.session = session
            self.frameId = frameId
            self.modeId = modeId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "frameId",
            "modeId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCaptureListener.didScan"]

        enum CodingKeys: String, CodingKey {
            case session
            case frameId
            case modeId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCaptureListenerDidScan: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            frameId = try container.decodeIfPresent(String.self, forKey: .frameId)
            modeId = try container.decode(Int.self, forKey: .modeId)
            guard modeId >= Int(Int32.min), modeId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCaptureListenerDidScan.modeId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCaptureListenerDidScan.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encodeIfPresent(frameId, forKey: .frameId)
            try container.encode(modeId, forKey: .modeId)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["frameId"] = frameId ?? NSNull()
            dict["modeId"] = modeId
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that a frame was dispatched to the adaptive recognition service by a
    /// BarcodeCapture mode's auto-wired adaptive recognition service.
    struct BarcodeCaptureAdaptiveRecognitionListenerDispatchStarted: Codable {
        let modeId: Int
        let frameMetadata: AdaptiveRecognitionFrameMetadata
        let frameDataId: String
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            modeId: Int,
            frameMetadata: AdaptiveRecognitionFrameMetadata,
            frameDataId: String,
            event: String
        ) {
            self.modeId = modeId
            self.frameMetadata = frameMetadata
            self.frameDataId = frameDataId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "modeId",
            "frameMetadata",
            "frameDataId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = [
            "BarcodeCaptureAdaptiveRecognitionListener.dispatchStarted"
        ]

        enum CodingKeys: String, CodingKey {
            case modeId
            case frameMetadata
            case frameDataId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCaptureAdaptiveRecognitionListenerDispatchStarted: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            modeId = try container.decode(Int.self, forKey: .modeId)
            guard modeId >= Int(Int32.min), modeId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCaptureAdaptiveRecognitionListenerDispatchStarted.modeId: out of Int32 range"
                    )
                )
            }
            frameMetadata = try container.decode(AdaptiveRecognitionFrameMetadata.self, forKey: .frameMetadata)
            frameDataId = try container.decode(String.self, forKey: .frameDataId)
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCaptureAdaptiveRecognitionListenerDispatchStarted.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(modeId, forKey: .modeId)
            try container.encode(frameMetadata, forKey: .frameMetadata)
            try container.encode(frameDataId, forKey: .frameDataId)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["modeId"] = modeId
            dict["frameMetadata"] = frameMetadata.toDictionary()
            dict["frameDataId"] = frameDataId
            dict["event"] = event
            return dict
        }
    }

    /// Frame correlation metadata delivered with every AdaptiveRecognitionServiceListener callback,
    /// tying an asynchronously-delivered adaptive recognition outcome back to the scan moment that
    /// produced the dispatched frame.
    struct AdaptiveRecognitionFrameMetadata: Codable {
        let frameId: Int
        let barcodes: [String]

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            frameId: Int,
            barcodes: [String]
        ) {
            self.frameId = frameId
            self.barcodes = barcodes
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "frameId",
            "barcodes",
        ]

        enum CodingKeys: String, CodingKey {
            case frameId
            case barcodes
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "AdaptiveRecognitionFrameMetadata: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            frameId = try container.decode(Int.self, forKey: .frameId)
            guard frameId >= Int(Int32.min), frameId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "AdaptiveRecognitionFrameMetadata.frameId: out of Int32 range"
                    )
                )
            }
            barcodes = try container.decode([String].self, forKey: .barcodes)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(frameId, forKey: .frameId)
            try container.encode(barcodes, forKey: .barcodes)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["frameId"] = frameId
            dict["barcodes"] = barcodes
            return dict
        }
    }

    /// Notifies the listener that an adaptive recognition dispatch performed by a BarcodeCapture mode's
    /// auto-wired adaptive recognition service completed successfully.
    struct BarcodeCaptureAdaptiveRecognitionListenerResponse: Codable {
        let modeId: Int
        let frameMetadata: AdaptiveRecognitionFrameMetadata
        let response: String
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            modeId: Int,
            frameMetadata: AdaptiveRecognitionFrameMetadata,
            response: String,
            event: String
        ) {
            self.modeId = modeId
            self.frameMetadata = frameMetadata
            self.response = response
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "modeId",
            "frameMetadata",
            "response",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCaptureAdaptiveRecognitionListener.response"]

        enum CodingKeys: String, CodingKey {
            case modeId
            case frameMetadata
            case response
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCaptureAdaptiveRecognitionListenerResponse: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            modeId = try container.decode(Int.self, forKey: .modeId)
            guard modeId >= Int(Int32.min), modeId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCaptureAdaptiveRecognitionListenerResponse.modeId: out of Int32 range"
                    )
                )
            }
            frameMetadata = try container.decode(AdaptiveRecognitionFrameMetadata.self, forKey: .frameMetadata)
            response = try container.decode(String.self, forKey: .response)
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCaptureAdaptiveRecognitionListenerResponse.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(modeId, forKey: .modeId)
            try container.encode(frameMetadata, forKey: .frameMetadata)
            try container.encode(response, forKey: .response)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["modeId"] = modeId
            dict["frameMetadata"] = frameMetadata.toDictionary()
            dict["response"] = response
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that an adaptive recognition dispatch performed by a BarcodeCapture mode's
    /// auto-wired adaptive recognition service failed.
    struct BarcodeCaptureAdaptiveRecognitionListenerError: Codable {
        let modeId: Int
        let frameMetadata: AdaptiveRecognitionFrameMetadata
        let reason: String
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            modeId: Int,
            frameMetadata: AdaptiveRecognitionFrameMetadata,
            reason: String,
            event: String
        ) {
            self.modeId = modeId
            self.frameMetadata = frameMetadata
            self.reason = reason
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "modeId",
            "frameMetadata",
            "reason",
            "event",
        ]
        private static let reasonAllowedValues: Set<String> = ["unknown", "timeout"]
        private static let eventAllowedValues: Set<String> = ["BarcodeCaptureAdaptiveRecognitionListener.error"]

        enum CodingKeys: String, CodingKey {
            case modeId
            case frameMetadata
            case reason
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCaptureAdaptiveRecognitionListenerError: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            modeId = try container.decode(Int.self, forKey: .modeId)
            guard modeId >= Int(Int32.min), modeId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCaptureAdaptiveRecognitionListenerError.modeId: out of Int32 range"
                    )
                )
            }
            frameMetadata = try container.decode(AdaptiveRecognitionFrameMetadata.self, forKey: .frameMetadata)
            let reasonRaw = try container.decode(String.self, forKey: .reason)
            guard Self.reasonAllowedValues.contains(reasonRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCaptureAdaptiveRecognitionListenerError.reason: unknown enum value '\(reasonRaw)'"
                    )
                )
            }
            reason = reasonRaw
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCaptureAdaptiveRecognitionListenerError.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(modeId, forKey: .modeId)
            try container.encode(frameMetadata, forKey: .frameMetadata)
            try container.encode(reason, forKey: .reason)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["modeId"] = modeId
            dict["frameMetadata"] = frameMetadata.toDictionary()
            dict["reason"] = reason
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that BarcodeSelection updated the selected barcodes in the given
    /// session/frame; the framework awaits a boolean reply before proceeding.
    struct BarcodeSelectionListenerDidUpdateSelection: Codable {
        let session: String
        let frameId: String?
        let modeId: Int
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            frameId: String? = nil,
            modeId: Int,
            event: String
        ) {
            self.session = session
            self.frameId = frameId
            self.modeId = modeId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "frameId",
            "modeId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeSelectionListener.didUpdateSelection"]

        enum CodingKeys: String, CodingKey {
            case session
            case frameId
            case modeId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeSelectionListenerDidUpdateSelection: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            frameId = try container.decodeIfPresent(String.self, forKey: .frameId)
            modeId = try container.decode(Int.self, forKey: .modeId)
            guard modeId >= Int(Int32.min), modeId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeSelectionListenerDidUpdateSelection.modeId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeSelectionListenerDidUpdateSelection.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encodeIfPresent(frameId, forKey: .frameId)
            try container.encode(modeId, forKey: .modeId)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["frameId"] = frameId ?? NSNull()
            dict["modeId"] = modeId
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that the BarcodeSelection session was updated with a newly processed
    /// frame; the framework awaits a boolean reply before proceeding.
    struct BarcodeSelectionListenerDidUpdateSession: Codable {
        let session: String
        let frameId: String?
        let modeId: Int
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            frameId: String? = nil,
            modeId: Int,
            event: String
        ) {
            self.session = session
            self.frameId = frameId
            self.modeId = modeId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "frameId",
            "modeId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeSelectionListener.didUpdateSession"]

        enum CodingKeys: String, CodingKey {
            case session
            case frameId
            case modeId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeSelectionListenerDidUpdateSession: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            frameId = try container.decodeIfPresent(String.self, forKey: .frameId)
            modeId = try container.decode(Int.self, forKey: .modeId)
            guard modeId >= Int(Int32.min), modeId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeSelectionListenerDidUpdateSession.modeId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeSelectionListenerDidUpdateSession.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encodeIfPresent(frameId, forKey: .frameId)
            try container.encode(modeId, forKey: .modeId)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["frameId"] = frameId ?? NSNull()
            dict["modeId"] = modeId
            dict["event"] = event
            return dict
        }
    }

    /// Asks the aimed-barcode brush provider for the brush to use for a barcode. The native side emits
    /// this event once per barcode and does not wait for a reply: the barcode is drawn with a
    /// transparent brush until the bridge answers through the finish-brush callback, and a null brush
    /// in the answer keeps the default brush.
    struct BarcodeSelectionAimedBrushProviderBrushForBarcode: Codable {
        let barcode: String
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcode: String,
            event: String
        ) {
            self.barcode = barcode
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcode",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeSelectionAimedBrushProvider.brushForBarcode"]

        enum CodingKeys: String, CodingKey {
            case barcode
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeSelectionAimedBrushProviderBrushForBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcode = try container.decode(String.self, forKey: .barcode)
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeSelectionAimedBrushProviderBrushForBarcode.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcode, forKey: .barcode)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcode"] = barcode
            dict["event"] = event
            return dict
        }
    }

    /// Asks the tracked-barcode brush provider for the brush to use for a barcode. The native side
    /// emits this event once per barcode and does not wait for a reply: the barcode is drawn with a
    /// transparent brush until the bridge answers through the finish-brush callback, and a null brush
    /// in the answer keeps the default brush.
    struct BarcodeSelectionTrackedBrushProviderBrushForBarcode: Codable {
        let barcode: String
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcode: String,
            event: String
        ) {
            self.barcode = barcode
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcode",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeSelectionTrackedBrushProvider.brushForBarcode"]

        enum CodingKeys: String, CodingKey {
            case barcode
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeSelectionTrackedBrushProviderBrushForBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcode = try container.decode(String.self, forKey: .barcode)
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeSelectionTrackedBrushProviderBrushForBarcode.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcode, forKey: .barcode)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcode"] = barcode
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that the BarcodeBatch session was updated with a newly processed frame;
    /// the framework awaits a boolean reply before proceeding.
    struct BarcodeBatchListenerDidUpdateSession: Codable {
        let session: String
        let frameId: String?
        let modeId: Int
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            frameId: String? = nil,
            modeId: Int,
            event: String
        ) {
            self.session = session
            self.frameId = frameId
            self.modeId = modeId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "frameId",
            "modeId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeBatchListener.didUpdateSession"]

        enum CodingKeys: String, CodingKey {
            case session
            case frameId
            case modeId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeBatchListenerDidUpdateSession: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            frameId = try container.decodeIfPresent(String.self, forKey: .frameId)
            modeId = try container.decode(Int.self, forKey: .modeId)
            guard modeId >= Int(Int32.min), modeId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeBatchListenerDidUpdateSession.modeId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeBatchListenerDidUpdateSession.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encodeIfPresent(frameId, forKey: .frameId)
            try container.encode(modeId, forKey: .modeId)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["frameId"] = frameId ?? NSNull()
            dict["modeId"] = modeId
            dict["event"] = event
            return dict
        }
    }

    /// Asks the listener for the brush to use for a tracked barcode on the basic overlay; fire-and-
    /// forget, no reply is awaited.
    struct BarcodeBatchBasicOverlayListenerBrushForTrackedBarcode: Codable {
        let trackedBarcode: String
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            event: String
        ) {
            self.trackedBarcode = trackedBarcode
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeBatchBasicOverlayListener.brushForTrackedBarcode"]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeBatchBasicOverlayListenerBrushForTrackedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeBatchBasicOverlayListenerBrushForTrackedBarcode.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that the user tapped a tracked barcode on the basic overlay; fire-and-
    /// forget, no reply is awaited.
    struct BarcodeBatchBasicOverlayListenerDidTapTrackedBarcode: Codable {
        let trackedBarcode: String
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            event: String
        ) {
            self.trackedBarcode = trackedBarcode
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeBatchBasicOverlayListener.didTapTrackedBarcode"]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeBatchBasicOverlayListenerDidTapTrackedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeBatchBasicOverlayListenerDidTapTrackedBarcode.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that the user tapped a tracked barcode's widget on the advanced overlay;
    /// fire-and-forget, no reply is awaited. Sent as the full TrackedBarcode the first time a given
    /// identifier is seen, and as just the identifier plus its current location on every repeat ask
    /// (TrackedBarcodeFullPayloadGate).
    struct BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode: Codable {
        let trackedBarcode: String?
        let identifier: Int?
        let location: String?
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String? = nil,
            identifier: Int? = nil,
            location: String? = nil,
            event: String
        ) {
            self.trackedBarcode = trackedBarcode
            self.identifier = identifier
            self.location = location
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "identifier",
            "location",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = [
            "BarcodeBatchAdvancedOverlayListener.didTapViewForTrackedBarcode"
        ]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case identifier
            case location
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decodeIfPresent(String.self, forKey: .trackedBarcode)
            identifier = try container.decodeIfPresent(Int.self, forKey: .identifier)
            if let identifier {
                guard identifier >= Int(Int32.min), identifier <= Int(Int32.max) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode.identifier: out of Int32 range"
                        )
                    )
                }
            }
            location = try container.decodeIfPresent(String.self, forKey: .location)
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(trackedBarcode, forKey: .trackedBarcode)
            try container.encodeIfPresent(identifier, forKey: .identifier)
            try container.encodeIfPresent(location, forKey: .location)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let trackedBarcode { dict["trackedBarcode"] = trackedBarcode }
            if let identifier { dict["identifier"] = identifier }
            if let location { dict["location"] = location }
            dict["event"] = event
            return dict
        }
    }

    /// Asks the listener for the widget to use for a tracked barcode on the advanced overlay; fire-and-
    /// forget, no reply is awaited. Sent as the full TrackedBarcode the first time a given identifier
    /// is seen, and as just the identifier plus its current location on every repeat ask
    /// (TrackedBarcodeFullPayloadGate).
    struct BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode: Codable {
        let trackedBarcode: String?
        let identifier: Int?
        let location: String?
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String? = nil,
            identifier: Int? = nil,
            location: String? = nil,
            event: String
        ) {
            self.trackedBarcode = trackedBarcode
            self.identifier = identifier
            self.location = location
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "identifier",
            "location",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = [
            "BarcodeBatchAdvancedOverlayListener.viewForTrackedBarcode"
        ]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case identifier
            case location
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decodeIfPresent(String.self, forKey: .trackedBarcode)
            identifier = try container.decodeIfPresent(Int.self, forKey: .identifier)
            if let identifier {
                guard identifier >= Int(Int32.min), identifier <= Int(Int32.max) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode.identifier: out of Int32 range"
                        )
                    )
                }
            }
            location = try container.decodeIfPresent(String.self, forKey: .location)
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(trackedBarcode, forKey: .trackedBarcode)
            try container.encodeIfPresent(identifier, forKey: .identifier)
            try container.encodeIfPresent(location, forKey: .location)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let trackedBarcode { dict["trackedBarcode"] = trackedBarcode }
            if let identifier { dict["identifier"] = identifier }
            if let location { dict["location"] = location }
            dict["event"] = event
            return dict
        }
    }

    /// Asks the listener for the anchor to use for a tracked barcode's widget on the advanced overlay;
    /// fire-and-forget, no reply is awaited. Sent as the full TrackedBarcode the first time a given
    /// identifier is seen, and as just the identifier plus its current location on every repeat ask
    /// (TrackedBarcodeFullPayloadGate).
    struct BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode: Codable {
        let trackedBarcode: String?
        let identifier: Int?
        let location: String?
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String? = nil,
            identifier: Int? = nil,
            location: String? = nil,
            event: String
        ) {
            self.trackedBarcode = trackedBarcode
            self.identifier = identifier
            self.location = location
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "identifier",
            "location",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = [
            "BarcodeBatchAdvancedOverlayListener.anchorForTrackedBarcode"
        ]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case identifier
            case location
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decodeIfPresent(String.self, forKey: .trackedBarcode)
            identifier = try container.decodeIfPresent(Int.self, forKey: .identifier)
            if let identifier {
                guard identifier >= Int(Int32.min), identifier <= Int(Int32.max) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode.identifier: out of Int32 range"
                        )
                    )
                }
            }
            location = try container.decodeIfPresent(String.self, forKey: .location)
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(trackedBarcode, forKey: .trackedBarcode)
            try container.encodeIfPresent(identifier, forKey: .identifier)
            try container.encodeIfPresent(location, forKey: .location)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let trackedBarcode { dict["trackedBarcode"] = trackedBarcode }
            if let identifier { dict["identifier"] = identifier }
            if let location { dict["location"] = location }
            dict["event"] = event
            return dict
        }
    }

    /// Asks the listener for the offset to use for a tracked barcode's widget on the advanced overlay;
    /// fire-and-forget, no reply is awaited. Sent as the full TrackedBarcode the first time a given
    /// identifier is seen, and as just the identifier plus its current location on every repeat ask
    /// (TrackedBarcodeFullPayloadGate).
    struct BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode: Codable {
        let trackedBarcode: String?
        let identifier: Int?
        let location: String?
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String? = nil,
            identifier: Int? = nil,
            location: String? = nil,
            event: String
        ) {
            self.trackedBarcode = trackedBarcode
            self.identifier = identifier
            self.location = location
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "identifier",
            "location",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = [
            "BarcodeBatchAdvancedOverlayListener.offsetForTrackedBarcode"
        ]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case identifier
            case location
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decodeIfPresent(String.self, forKey: .trackedBarcode)
            identifier = try container.decodeIfPresent(Int.self, forKey: .identifier)
            if let identifier {
                guard identifier >= Int(Int32.min), identifier <= Int(Int32.max) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode.identifier: out of Int32 range"
                        )
                    )
                }
            }
            location = try container.decodeIfPresent(String.self, forKey: .location)
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(trackedBarcode, forKey: .trackedBarcode)
            try container.encodeIfPresent(identifier, forKey: .identifier)
            try container.encodeIfPresent(location, forKey: .location)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let trackedBarcode { dict["trackedBarcode"] = trackedBarcode }
            if let identifier { dict["identifier"] = identifier }
            if let location { dict["location"] = location }
            dict["event"] = event
            return dict
        }
    }

    /// Requests a brush from the listener for a barcode that has just been recognized and tracked in
    /// the viewfinder; the listener's reply (via setBrushForRecognizedBarcode) supplies the highlight
    /// brush to draw over it.
    struct BarcodeCountViewListenerBrushForRecognizedBarcode: Codable {
        let trackedBarcode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.trackedBarcode = trackedBarcode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewListener.brushForRecognizedBarcode"]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCountViewListenerBrushForRecognizedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountViewListenerBrushForRecognizedBarcode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerBrushForRecognizedBarcode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests a brush from the listener for a recognized barcode that is not part of the configured
    /// barcode list; the listener's reply supplies the highlight brush to draw over it.
    struct BarcodeCountViewListenerBrushForRecognizedBarcodeNotInList: Codable {
        let trackedBarcode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.trackedBarcode = trackedBarcode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = [
            "BarcodeCountViewListener.brushForRecognizedBarcodeNotInList"
        ]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCountViewListenerBrushForRecognizedBarcodeNotInList: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCountViewListenerBrushForRecognizedBarcodeNotInList.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerBrushForRecognizedBarcodeNotInList.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests a brush from the listener for a barcode that has been accepted (matched an item on the
    /// barcode list); the listener's reply supplies the highlight brush to draw over it.
    struct BarcodeCountViewListenerBrushForAcceptedBarcode: Codable {
        let trackedBarcode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.trackedBarcode = trackedBarcode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewListener.brushForAcceptedBarcode"]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCountViewListenerBrushForAcceptedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountViewListenerBrushForAcceptedBarcode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerBrushForAcceptedBarcode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests a brush from the listener for a barcode that has been rejected (failed to match an item
    /// on the barcode list); the listener's reply supplies the highlight brush to draw over it.
    struct BarcodeCountViewListenerBrushForRejectedBarcode: Codable {
        let trackedBarcode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.trackedBarcode = trackedBarcode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewListener.brushForRejectedBarcode"]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCountViewListenerBrushForRejectedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountViewListenerBrushForRejectedBarcode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerBrushForRejectedBarcode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests an icon from the listener for a barcode that has just been recognized and tracked in
    /// the viewfinder; the listener's reply (via setIconForRecognizedBarcode) supplies the icon to
    /// display over it.
    struct BarcodeCountViewListenerIconForRecognizedBarcode: Codable {
        let trackedBarcode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.trackedBarcode = trackedBarcode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewListener.iconForRecognizedBarcode"]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCountViewListenerIconForRecognizedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountViewListenerIconForRecognizedBarcode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerIconForRecognizedBarcode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests an icon from the listener for a recognized barcode that is not part of the configured
    /// barcode list; the listener's reply supplies the icon to display over it.
    struct BarcodeCountViewListenerIconForRecognizedBarcodeNotInList: Codable {
        let trackedBarcode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.trackedBarcode = trackedBarcode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = [
            "BarcodeCountViewListener.iconForRecognizedBarcodeNotInList"
        ]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCountViewListenerIconForRecognizedBarcodeNotInList: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCountViewListenerIconForRecognizedBarcodeNotInList.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerIconForRecognizedBarcodeNotInList.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests an icon from the listener for a barcode that has been accepted (matched an item on the
    /// barcode list); the listener's reply supplies the icon to display over it.
    struct BarcodeCountViewListenerIconForAcceptedBarcode: Codable {
        let trackedBarcode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.trackedBarcode = trackedBarcode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewListener.iconForAcceptedBarcode"]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCountViewListenerIconForAcceptedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountViewListenerIconForAcceptedBarcode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerIconForAcceptedBarcode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests an icon from the listener for a barcode that has been rejected (failed to match an item
    /// on the barcode list); the listener's reply supplies the icon to display over it.
    struct BarcodeCountViewListenerIconForRejectedBarcode: Codable {
        let trackedBarcode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.trackedBarcode = trackedBarcode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewListener.iconForRejectedBarcode"]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCountViewListenerIconForRejectedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountViewListenerIconForRejectedBarcode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerIconForRejectedBarcode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped a recognized, tracked barcode in the viewfinder.
    struct BarcodeCountViewListenerDidTapRecognizedBarcode: Codable {
        let trackedBarcode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.trackedBarcode = trackedBarcode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewListener.didTapRecognizedBarcode"]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCountViewListenerDidTapRecognizedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountViewListenerDidTapRecognizedBarcode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerDidTapRecognizedBarcode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped a barcode that is being filtered out of the count
    /// (excluded by the active filter settings). The barcode is carried under the same trackedBarcode
    /// key.
    struct BarcodeCountViewListenerDidTapFilteredBarcode: Codable {
        let trackedBarcode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.trackedBarcode = trackedBarcode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewListener.didTapFilteredBarcode"]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCountViewListenerDidTapFilteredBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountViewListenerDidTapFilteredBarcode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerDidTapFilteredBarcode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped a recognized barcode that is not part of the
    /// configured barcode list.
    struct BarcodeCountViewListenerDidTapRecognizedBarcodeNotInList: Codable {
        let trackedBarcode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.trackedBarcode = trackedBarcode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = [
            "BarcodeCountViewListener.didTapRecognizedBarcodeNotInList"
        ]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCountViewListenerDidTapRecognizedBarcodeNotInList: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCountViewListenerDidTapRecognizedBarcodeNotInList.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerDidTapRecognizedBarcodeNotInList.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped a barcode that has been accepted (matched an item on
    /// the barcode list).
    struct BarcodeCountViewListenerDidTapAcceptedBarcode: Codable {
        let trackedBarcode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.trackedBarcode = trackedBarcode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewListener.didTapAcceptedBarcode"]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCountViewListenerDidTapAcceptedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountViewListenerDidTapAcceptedBarcode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerDidTapAcceptedBarcode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped a barcode that has been rejected (failed to match an
    /// item on the barcode list).
    struct BarcodeCountViewListenerDidTapRejectedBarcode: Codable {
        let trackedBarcode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            trackedBarcode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.trackedBarcode = trackedBarcode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "trackedBarcode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewListener.didTapRejectedBarcode"]

        enum CodingKeys: String, CodingKey {
            case trackedBarcode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCountViewListenerDidTapRejectedBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            trackedBarcode = try container.decode(String.self, forKey: .trackedBarcode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountViewListenerDidTapRejectedBarcode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerDidTapRejectedBarcode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(trackedBarcode, forKey: .trackedBarcode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["trackedBarcode"] = trackedBarcode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that every item on the configured barcode capture list has been scanned
    /// and the count is complete.
    struct BarcodeCountViewListenerDidCompleteCaptureList: Codable {
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int,
            event: String? = nil
        ) {
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewListener.didCompleteCaptureList"]

        enum CodingKeys: String, CodingKey {
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCountViewListenerDidCompleteCaptureList: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountViewListenerDidCompleteCaptureList.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerDidCompleteCaptureList.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped a cluster of unrecognized or unclear barcodes in the
    /// viewfinder, carrying the barcodes that make up that cluster.
    struct BarcodeCountViewListenerDidTapCluster: Codable {
        let barcodes: [String]
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcodes: [String],
            viewId: Int,
            event: String? = nil
        ) {
            self.barcodes = barcodes
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcodes",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewListener.didTapCluster"]

        enum CodingKeys: String, CodingKey {
            case barcodes
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCountViewListenerDidTapCluster: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcodes = try container.decode([String].self, forKey: .barcodes)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountViewListenerDidTapCluster.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewListenerDidTapCluster.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcodes, forKey: .barcodes)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcodes"] = barcodes
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped the list button in the BarcodeCountView toolbar;
    /// fire-and-forget, no reply is awaited.
    struct BarcodeCountViewUiListenerOnListButtonTapped: Codable {
        let viewId: Int
        let snapshot: String?
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int,
            snapshot: String? = nil,
            event: String? = nil
        ) {
            self.viewId = viewId
            self.snapshot = snapshot
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId",
            "snapshot",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewUiListener.onListButtonTapped"]

        enum CodingKeys: String, CodingKey {
            case viewId
            case snapshot
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCountViewUiListenerOnListButtonTapped: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountViewUiListenerOnListButtonTapped.viewId: out of Int32 range"
                    )
                )
            }
            snapshot = try container.decodeIfPresent(String.self, forKey: .snapshot)
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewUiListenerOnListButtonTapped.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(snapshot, forKey: .snapshot)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            if let snapshot { dict["snapshot"] = snapshot }
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped the exit button in the BarcodeCountView toolbar;
    /// fire-and-forget, no reply is awaited.
    struct BarcodeCountViewUiListenerOnExitButtonTapped: Codable {
        let viewId: Int
        let snapshot: String?
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int,
            snapshot: String? = nil,
            event: String? = nil
        ) {
            self.viewId = viewId
            self.snapshot = snapshot
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId",
            "snapshot",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewUiListener.onExitButtonTapped"]

        enum CodingKeys: String, CodingKey {
            case viewId
            case snapshot
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCountViewUiListenerOnExitButtonTapped: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountViewUiListenerOnExitButtonTapped.viewId: out of Int32 range"
                    )
                )
            }
            snapshot = try container.decodeIfPresent(String.self, forKey: .snapshot)
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewUiListenerOnExitButtonTapped.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(snapshot, forKey: .snapshot)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            if let snapshot { dict["snapshot"] = snapshot }
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped the single scan button in the BarcodeCountView
    /// toolbar; fire-and-forget, no reply is awaited.
    struct BarcodeCountViewUiListenerOnSingleScanButtonTapped: Codable {
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int,
            event: String? = nil
        ) {
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountViewUiListener.onSingleScanButtonTapped"]

        enum CodingKeys: String, CodingKey {
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCountViewUiListenerOnSingleScanButtonTapped: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCountViewUiListenerOnSingleScanButtonTapped.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountViewUiListenerOnSingleScanButtonTapped.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests the listener's response to a new BarcodeCount scan in the given frame; the framework
    /// awaits a boolean reply before proceeding.
    struct BarcodeCountListenerOnScan: Codable {
        let session: String
        let frameId: String
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            frameId: String,
            viewId: Int
        ) {
            self.session = session
            self.frameId = frameId
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "frameId",
            "viewId",
        ]

        enum CodingKeys: String, CodingKey {
            case session
            case frameId
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCountListenerOnScan: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            frameId = try container.decode(String.self, forKey: .frameId)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountListenerOnScan.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encode(frameId, forKey: .frameId)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["frameId"] = frameId
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Requests the listener's response to an updated BarcodeCountSession in the given frame; the
    /// framework awaits a boolean reply before proceeding.
    struct BarcodeCountListenerDidUpdateSession: Codable {
        let session: String
        let frameId: String
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            frameId: String,
            viewId: Int
        ) {
            self.session = session
            self.frameId = frameId
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "frameId",
            "viewId",
        ]

        enum CodingKeys: String, CodingKey {
            case session
            case frameId
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCountListenerDidUpdateSession: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            frameId = try container.decode(String.self, forKey: .frameId)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountListenerDidUpdateSession.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encode(frameId, forKey: .frameId)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["frameId"] = frameId
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Notifies the listener that a frame was dispatched to the adaptive recognition service by a
    /// BarcodeCount view's auto-wired adaptive recognition service.
    struct BarcodeCountAdaptiveRecognitionListenerDispatchStarted: Codable {
        let viewId: Int
        let frameMetadata: AdaptiveRecognitionFrameMetadata
        let frameDataId: String
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int,
            frameMetadata: AdaptiveRecognitionFrameMetadata,
            frameDataId: String,
            event: String
        ) {
            self.viewId = viewId
            self.frameMetadata = frameMetadata
            self.frameDataId = frameDataId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId",
            "frameMetadata",
            "frameDataId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountAdaptiveRecognitionListener.dispatchStarted"]

        enum CodingKeys: String, CodingKey {
            case viewId
            case frameMetadata
            case frameDataId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCountAdaptiveRecognitionListenerDispatchStarted: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCountAdaptiveRecognitionListenerDispatchStarted.viewId: out of Int32 range"
                    )
                )
            }
            frameMetadata = try container.decode(AdaptiveRecognitionFrameMetadata.self, forKey: .frameMetadata)
            frameDataId = try container.decode(String.self, forKey: .frameDataId)
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCountAdaptiveRecognitionListenerDispatchStarted.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
            try container.encode(frameMetadata, forKey: .frameMetadata)
            try container.encode(frameDataId, forKey: .frameDataId)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            dict["frameMetadata"] = frameMetadata.toDictionary()
            dict["frameDataId"] = frameDataId
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that an adaptive recognition dispatch performed by a BarcodeCount view's
    /// auto-wired adaptive recognition service completed successfully.
    struct BarcodeCountAdaptiveRecognitionListenerResponse: Codable {
        let viewId: Int
        let frameMetadata: AdaptiveRecognitionFrameMetadata
        let response: String
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int,
            frameMetadata: AdaptiveRecognitionFrameMetadata,
            response: String,
            event: String
        ) {
            self.viewId = viewId
            self.frameMetadata = frameMetadata
            self.response = response
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId",
            "frameMetadata",
            "response",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountAdaptiveRecognitionListener.response"]

        enum CodingKeys: String, CodingKey {
            case viewId
            case frameMetadata
            case response
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCountAdaptiveRecognitionListenerResponse: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountAdaptiveRecognitionListenerResponse.viewId: out of Int32 range"
                    )
                )
            }
            frameMetadata = try container.decode(AdaptiveRecognitionFrameMetadata.self, forKey: .frameMetadata)
            response = try container.decode(String.self, forKey: .response)
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCountAdaptiveRecognitionListenerResponse.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
            try container.encode(frameMetadata, forKey: .frameMetadata)
            try container.encode(response, forKey: .response)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            dict["frameMetadata"] = frameMetadata.toDictionary()
            dict["response"] = response
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that an adaptive recognition dispatch performed by a BarcodeCount view's
    /// auto-wired adaptive recognition service failed.
    struct BarcodeCountAdaptiveRecognitionListenerError: Codable {
        let viewId: Int
        let frameMetadata: AdaptiveRecognitionFrameMetadata
        let reason: String
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int,
            frameMetadata: AdaptiveRecognitionFrameMetadata,
            reason: String,
            event: String
        ) {
            self.viewId = viewId
            self.frameMetadata = frameMetadata
            self.reason = reason
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId",
            "frameMetadata",
            "reason",
            "event",
        ]
        private static let reasonAllowedValues: Set<String> = ["unknown", "timeout"]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountAdaptiveRecognitionListener.error"]

        enum CodingKeys: String, CodingKey {
            case viewId
            case frameMetadata
            case reason
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCountAdaptiveRecognitionListenerError: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountAdaptiveRecognitionListenerError.viewId: out of Int32 range"
                    )
                )
            }
            frameMetadata = try container.decode(AdaptiveRecognitionFrameMetadata.self, forKey: .frameMetadata)
            let reasonRaw = try container.decode(String.self, forKey: .reason)
            guard Self.reasonAllowedValues.contains(reasonRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCountAdaptiveRecognitionListenerError.reason: unknown enum value '\(reasonRaw)'"
                    )
                )
            }
            reason = reasonRaw
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCountAdaptiveRecognitionListenerError.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
            try container.encode(frameMetadata, forKey: .frameMetadata)
            try container.encode(reason, forKey: .reason)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            dict["frameMetadata"] = frameMetadata.toDictionary()
            dict["reason"] = reason
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that the BarcodeCountCaptureListSession for the current capture list has
    /// been updated.
    struct BarcodeCountCaptureListListenerDidUpdateSession: Codable {
        let session: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.session = session
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountCaptureListListener.didUpdateSession"]

        enum CodingKeys: String, CodingKey {
            case session
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCountCaptureListListenerDidUpdateSession: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountCaptureListListenerDidUpdateSession.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountCaptureListListenerDidUpdateSession.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that all items in the current capture list have been captured, carrying
    /// the final BarcodeCountCaptureListSession.
    struct BarcodeCountCaptureListListenerDidCompleteCaptureList: Codable {
        let session: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.session = session
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountCaptureListListener.didCompleteCaptureList"]

        enum CodingKeys: String, CodingKey {
            case session
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeCountCaptureListListenerDidCompleteCaptureList: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeCountCaptureListListenerDidCompleteCaptureList.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountCaptureListListenerDidCompleteCaptureList.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests a transformation of the given raw barcode data; the framework awaits a reply supplying
    /// either a replacement string or null to leave the data unchanged.
    struct BarcodeDataTransformerTransformBarcodeData: Codable {
        let data: String
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            data: String,
            viewId: Int
        ) {
            self.data = data
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "data",
            "viewId",
        ]

        enum CodingKeys: String, CodingKey {
            case data
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeDataTransformerTransformBarcodeData: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            data = try container.decode(String.self, forKey: .data)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeDataTransformerTransformBarcodeData.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(data, forKey: .data)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["data"] = data
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Requests a status from the status provider for the barcodes currently tracked; the provider's
    /// reply, correlated by requestId, supplies the status to display for each of them.
    struct BarcodeCountStatusProviderOnStatusRequested: Codable {
        let barcodes: [String]
        let requestId: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcodes: [String],
            requestId: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.barcodes = barcodes
            self.requestId = requestId
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcodes",
            "requestId",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeCountStatusProvider.onStatusRequested"]

        enum CodingKeys: String, CodingKey {
            case barcodes
            case requestId
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeCountStatusProviderOnStatusRequested: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcodes = try container.decode([String].self, forKey: .barcodes)
            requestId = try container.decode(String.self, forKey: .requestId)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeCountStatusProviderOnStatusRequested.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeCountStatusProviderOnStatusRequested.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcodes, forKey: .barcodes)
            try container.encode(requestId, forKey: .requestId)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcodes"] = barcodes
            dict["requestId"] = requestId
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests the delegate's feedback for a scanned barcode; the framework awaits an optional
    /// serialized SparkScanBarcodeFeedback string reply before proceeding.
    struct SparkScanFeedbackDelegateFeedbackForBarcode: Codable {
        let barcode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.barcode = barcode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["SparkScanFeedbackDelegate.feedbackForBarcode"]

        enum CodingKeys: String, CodingKey {
            case barcode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "SparkScanFeedbackDelegateFeedbackForBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcode = try container.decode(String.self, forKey: .barcode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "SparkScanFeedbackDelegateFeedbackForBarcode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "SparkScanFeedbackDelegateFeedbackForBarcode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcode, forKey: .barcode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcode"] = barcode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests the delegate's feedback for a scanned item; the framework awaits an optional serialized
    /// SparkScanBarcodeFeedback string reply before proceeding.
    struct SparkScanFeedbackDelegateFeedbackForScannedItem: Codable {
        let scannedItem: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            scannedItem: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.scannedItem = scannedItem
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "scannedItem",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["SparkScanFeedbackDelegate.feedbackForScannedItem"]

        enum CodingKeys: String, CodingKey {
            case scannedItem
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "SparkScanFeedbackDelegateFeedbackForScannedItem: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            scannedItem = try container.decode(String.self, forKey: .scannedItem)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "SparkScanFeedbackDelegateFeedbackForScannedItem.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "SparkScanFeedbackDelegateFeedbackForScannedItem.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(scannedItem, forKey: .scannedItem)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["scannedItem"] = scannedItem
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped the barcode find button; fire-and-forget, no reply is
    /// awaited.
    struct SparkScanViewUiListenerBarcodeFindButtonTapped: Codable {
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int,
            event: String? = nil
        ) {
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["SparkScanViewUiListener.barcodeFindButtonTapped"]

        enum CodingKeys: String, CodingKey {
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "SparkScanViewUiListenerBarcodeFindButtonTapped: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "SparkScanViewUiListenerBarcodeFindButtonTapped.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "SparkScanViewUiListenerBarcodeFindButtonTapped.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped the barcode count button; fire-and-forget, no reply
    /// is awaited.
    struct SparkScanViewUiListenerBarcodeCountButtonTapped: Codable {
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int,
            event: String? = nil
        ) {
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["SparkScanViewUiListener.barcodeCountButtonTapped"]

        enum CodingKeys: String, CodingKey {
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "SparkScanViewUiListenerBarcodeCountButtonTapped: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "SparkScanViewUiListenerBarcodeCountButtonTapped.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "SparkScanViewUiListenerBarcodeCountButtonTapped.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped the label capture button; fire-and-forget, no reply
    /// is awaited.
    struct SparkScanViewUiListenerLabelCaptureButtonTapped: Codable {
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int,
            event: String? = nil
        ) {
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["SparkScanViewUiListener.labelCaptureButtonTapped"]

        enum CodingKeys: String, CodingKey {
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "SparkScanViewUiListenerLabelCaptureButtonTapped: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "SparkScanViewUiListenerLabelCaptureButtonTapped.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "SparkScanViewUiListenerLabelCaptureButtonTapped.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the SparkScanView's state changed; fire-and-forget, no reply is
    /// awaited.
    struct SparkScanViewUiListenerDidChangeViewState: Codable {
        let state: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            state: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.state = state
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "state",
            "viewId",
            "event",
        ]
        private static let stateAllowedValues: Set<String> = ["initial", "idle", "inactive", "active", "error"]
        private static let eventAllowedValues: Set<String> = ["SparkScanViewUiListener.didChangeViewState"]

        enum CodingKeys: String, CodingKey {
            case state
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "SparkScanViewUiListenerDidChangeViewState: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let stateRaw = try container.decode(String.self, forKey: .state)
            guard Self.stateAllowedValues.contains(stateRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "SparkScanViewUiListenerDidChangeViewState.state: unknown enum value '\(stateRaw)'"
                    )
                )
            }
            state = stateRaw
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "SparkScanViewUiListenerDidChangeViewState.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "SparkScanViewUiListenerDidChangeViewState.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(state, forKey: .state)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["state"] = state
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the SparkScan scanning mode changed; fire-and-forget, no reply is
    /// awaited.
    struct SparkScanViewUiListenerDidChangeScanningMode: Codable {
        let scanningMode: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            scanningMode: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.scanningMode = scanningMode
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "scanningMode",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["SparkScanViewUiListener.didChangeScanningMode"]

        enum CodingKeys: String, CodingKey {
            case scanningMode
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "SparkScanViewUiListenerDidChangeScanningMode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            scanningMode = try container.decode(String.self, forKey: .scanningMode)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "SparkScanViewUiListenerDidChangeScanningMode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "SparkScanViewUiListenerDidChangeScanningMode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(scanningMode, forKey: .scanningMode)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["scanningMode"] = scanningMode
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests the listener's response to an updated SparkScanSession in the given frame; the
    /// framework awaits a boolean reply before proceeding.
    struct SparkScanListenerDidUpdateSession: Codable {
        let session: String
        let frameId: String?
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            frameId: String? = nil,
            viewId: Int
        ) {
            self.session = session
            self.frameId = frameId
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "frameId",
            "viewId",
        ]

        enum CodingKeys: String, CodingKey {
            case session
            case frameId
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "SparkScanListenerDidUpdateSession: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            frameId = try container.decodeIfPresent(String.self, forKey: .frameId)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "SparkScanListenerDidUpdateSession.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encodeIfPresent(frameId, forKey: .frameId)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["frameId"] = frameId ?? NSNull()
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Requests the listener's response to a newly scanned barcode in the given SparkScanSession/frame;
    /// the framework awaits a boolean reply before proceeding.
    struct SparkScanListenerDidScan: Codable {
        let session: String
        let frameId: String?
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            frameId: String? = nil,
            viewId: Int
        ) {
            self.session = session
            self.frameId = frameId
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "frameId",
            "viewId",
        ]

        enum CodingKeys: String, CodingKey {
            case session
            case frameId
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "SparkScanListenerDidScan: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            frameId = try container.decodeIfPresent(String.self, forKey: .frameId)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "SparkScanListenerDidScan.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encodeIfPresent(frameId, forKey: .frameId)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["frameId"] = frameId ?? NSNull()
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Notifies the listener that the BarcodePickSession was updated; fire-and-forget, no reply is
    /// awaited.
    struct BarcodePickListenerDidUpdateSession: Codable {
        let session: String
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            viewId: Int
        ) {
            self.session = session
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "viewId",
        ]

        enum CodingKeys: String, CodingKey {
            case session
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodePickListenerDidUpdateSession: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodePickListenerDidUpdateSession.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Notifies the listener that the BarcodePickScanningSession has completed; fire-and-forget, no
    /// reply is awaited.
    struct BarcodePickScanningListenerDidCompleteScanningSession: Codable {
        let session: String
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            viewId: Int
        ) {
            self.session = session
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "viewId",
        ]

        enum CodingKeys: String, CodingKey {
            case session
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodePickScanningListenerDidCompleteScanningSession: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodePickScanningListenerDidCompleteScanningSession.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Notifies the listener that the BarcodePickScanningSession was updated; fire-and-forget, no reply
    /// is awaited.
    struct BarcodePickScanningListenerDidUpdateScanningSession: Codable {
        let session: String
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            viewId: Int
        ) {
            self.session = session
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "viewId",
        ]

        enum CodingKeys: String, CodingKey {
            case session
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodePickScanningListenerDidUpdateScanningSession: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodePickScanningListenerDidUpdateScanningSession.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Requests the listener's response to a pick action on an item; the framework awaits a boolean
    /// reply before proceeding.
    struct BarcodePickActionListenerDidPick: Codable {
        let itemData: String
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            itemData: String,
            viewId: Int
        ) {
            self.itemData = itemData
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "itemData",
            "viewId",
        ]

        enum CodingKeys: String, CodingKey {
            case itemData
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodePickActionListenerDidPick: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            itemData = try container.decode(String.self, forKey: .itemData)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodePickActionListenerDidPick.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(itemData, forKey: .itemData)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["itemData"] = itemData
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Requests the listener's response to an unpick action on an item; the framework awaits a boolean
    /// reply before proceeding.
    struct BarcodePickActionListenerDidUnpick: Codable {
        let itemData: String
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            itemData: String,
            viewId: Int
        ) {
            self.itemData = itemData
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "itemData",
            "viewId",
        ]

        enum CodingKeys: String, CodingKey {
            case itemData
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodePickActionListenerDidUnpick: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            itemData = try container.decode(String.self, forKey: .itemData)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodePickActionListenerDidUnpick.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(itemData, forKey: .itemData)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["itemData"] = itemData
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Notifies the listener that the BarcodePickView started scanning; fire-and-forget, no reply is
    /// awaited.
    struct BarcodePickViewListenerDidStartScanning: Codable {
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int
        ) {
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId"
        ]

        enum CodingKeys: String, CodingKey {
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodePickViewListenerDidStartScanning: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodePickViewListenerDidStartScanning.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Notifies the listener that the BarcodePickView froze scanning; fire-and-forget, no reply is
    /// awaited.
    struct BarcodePickViewListenerDidFreezeScanning: Codable {
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int
        ) {
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId"
        ]

        enum CodingKeys: String, CodingKey {
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodePickViewListenerDidFreezeScanning: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodePickViewListenerDidFreezeScanning.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Notifies the listener that the BarcodePickView paused scanning; fire-and-forget, no reply is
    /// awaited.
    struct BarcodePickViewListenerDidPauseScanning: Codable {
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int
        ) {
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId"
        ]

        enum CodingKeys: String, CodingKey {
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodePickViewListenerDidPauseScanning: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodePickViewListenerDidPauseScanning.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Notifies the listener that the BarcodePickView stopped scanning; fire-and-forget, no reply is
    /// awaited.
    struct BarcodePickViewListenerDidStopScanning: Codable {
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int
        ) {
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId"
        ]

        enum CodingKeys: String, CodingKey {
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodePickViewListenerDidStopScanning: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodePickViewListenerDidStopScanning.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Notifies the listener that the user tapped the finish button in the BarcodePickView toolbar;
    /// fire-and-forget, no reply is awaited.
    struct BarcodePickViewUiListenerDidTapFinishButton: Codable {
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int
        ) {
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId"
        ]

        enum CodingKeys: String, CodingKey {
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodePickViewUiListenerDidTapFinishButton: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodePickViewUiListenerDidTapFinishButton.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Requests the listener's mapping from raw item data to product identifiers; the framework awaits
    /// a reply before proceeding.
    struct BarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItems: Codable {
        let itemsData: [String]
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            itemsData: [String],
            viewId: Int
        ) {
            self.itemsData = itemsData
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "itemsData",
            "viewId",
        ]

        enum CodingKeys: String, CodingKey {
            case itemsData
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItems: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            itemsData = try container.decode([String].self, forKey: .itemsData)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodePickAsyncMapperProductProviderCallbackOnProductIdentifierForItems.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(itemsData, forKey: .itemsData)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["itemsData"] = itemsData
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Requests the listener's highlight style for the given request; the framework awaits a reply
    /// before proceeding.
    struct BarcodePickViewHighlightStyleAsyncProviderStyleForRequest: Codable {
        let requestId: Int
        let request: String
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            requestId: Int,
            request: String,
            viewId: Int
        ) {
            self.requestId = requestId
            self.request = request
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "requestId",
            "request",
            "viewId",
        ]

        enum CodingKeys: String, CodingKey {
            case requestId
            case request
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodePickViewHighlightStyleAsyncProviderStyleForRequest: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            requestId = try container.decode(Int.self, forKey: .requestId)
            guard requestId >= Int(Int32.min), requestId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodePickViewHighlightStyleAsyncProviderStyleForRequest.requestId: out of Int32 range"
                    )
                )
            }
            request = try container.decode(String.self, forKey: .request)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodePickViewHighlightStyleAsyncProviderStyleForRequest.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(requestId, forKey: .requestId)
            try container.encode(request, forKey: .request)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["requestId"] = requestId
            dict["request"] = request
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Requests the listener's custom view for the given highlight style request; the framework awaits
    /// a reply before proceeding.
    struct BarcodePickViewHighlightStyleCustomViewProviderViewForRequest: Codable {
        let requestId: Int
        let request: String
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            requestId: Int,
            request: String,
            viewId: Int
        ) {
            self.requestId = requestId
            self.request = request
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "requestId",
            "request",
            "viewId",
        ]

        enum CodingKeys: String, CodingKey {
            case requestId
            case request
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodePickViewHighlightStyleCustomViewProviderViewForRequest: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            requestId = try container.decode(Int.self, forKey: .requestId)
            guard requestId >= Int(Int32.min), requestId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodePickViewHighlightStyleCustomViewProviderViewForRequest.requestId: out of Int32 range"
                    )
                )
            }
            request = try container.decode(String.self, forKey: .request)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodePickViewHighlightStyleCustomViewProviderViewForRequest.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(requestId, forKey: .requestId)
            try container.encode(request, forKey: .request)
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["requestId"] = requestId
            dict["request"] = request
            dict["viewId"] = viewId
            return dict
        }
    }

    /// Notifies the listener that the BarcodeFind view's finish button was tapped, with the items found
    /// so far; no reply is awaited.
    struct BarcodeFindViewUiListenerOnFinishButtonTapped: Codable {
        let foundItems: [String]
        let viewId: Int
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            foundItems: [String],
            viewId: Int,
            event: String
        ) {
            self.foundItems = foundItems
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "foundItems",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeFindViewUiListener.onFinishButtonTapped"]

        enum CodingKeys: String, CodingKey {
            case foundItems
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeFindViewUiListenerOnFinishButtonTapped: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            foundItems = try container.decode([String].self, forKey: .foundItems)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeFindViewUiListenerOnFinishButtonTapped.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeFindViewUiListenerOnFinishButtonTapped.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(foundItems, forKey: .foundItems)
            try container.encode(viewId, forKey: .viewId)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["foundItems"] = foundItems
            dict["viewId"] = viewId
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that BarcodeFind search has started; no reply is awaited.
    struct BarcodeFindListenerOnSearchStarted: Codable {
        let viewId: Int
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            viewId: Int,
            event: String
        ) {
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeFindListener.onSearchStarted"]

        enum CodingKeys: String, CodingKey {
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeFindListenerOnSearchStarted: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeFindListenerOnSearchStarted.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeFindListenerOnSearchStarted.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(viewId, forKey: .viewId)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["viewId"] = viewId
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that BarcodeFind search has paused, with the items found so far; no reply
    /// is awaited.
    struct BarcodeFindListenerOnSearchPaused: Codable {
        let foundItems: [String]
        let viewId: Int
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            foundItems: [String],
            viewId: Int,
            event: String
        ) {
            self.foundItems = foundItems
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "foundItems",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeFindListener.onSearchPaused"]

        enum CodingKeys: String, CodingKey {
            case foundItems
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeFindListenerOnSearchPaused: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            foundItems = try container.decode([String].self, forKey: .foundItems)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeFindListenerOnSearchPaused.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeFindListenerOnSearchPaused.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(foundItems, forKey: .foundItems)
            try container.encode(viewId, forKey: .viewId)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["foundItems"] = foundItems
            dict["viewId"] = viewId
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that BarcodeFind search has stopped, with the items found so far; no reply
    /// is awaited.
    struct BarcodeFindListenerOnSearchStopped: Codable {
        let foundItems: [String]
        let viewId: Int
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            foundItems: [String],
            viewId: Int,
            event: String
        ) {
            self.foundItems = foundItems
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "foundItems",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeFindListener.onSearchStopped"]

        enum CodingKeys: String, CodingKey {
            case foundItems
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeFindListenerOnSearchStopped: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            foundItems = try container.decode([String].self, forKey: .foundItems)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeFindListenerOnSearchStopped.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeFindListenerOnSearchStopped.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(foundItems, forKey: .foundItems)
            try container.encode(viewId, forKey: .viewId)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["foundItems"] = foundItems
            dict["viewId"] = viewId
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that BarcodeFind updated its session; no reply is awaited.
    struct BarcodeFindListenerDidUpdateSession: Codable {
        let session: String
        let viewId: Int
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            viewId: Int,
            event: String
        ) {
            self.session = session
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeFindListener.didUpdateSession"]

        enum CodingKeys: String, CodingKey {
            case session
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeFindListenerDidUpdateSession: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeFindListenerDidUpdateSession.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeFindListenerDidUpdateSession.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            try container.encode(viewId, forKey: .viewId)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["viewId"] = viewId
            dict["event"] = event
            return dict
        }
    }

    /// Asks the barcode transformer to transform a barcode data string; the framework awaits a string
    /// (or null) reply before proceeding.
    struct BarcodeFindTransformerTransformBarcodeData: Codable {
        let data: String?
        let viewId: Int
        let event: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            data: String? = nil,
            viewId: Int,
            event: String
        ) {
            self.data = data
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "data",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeFindTransformer.transformBarcodeData"]

        enum CodingKeys: String, CodingKey {
            case data
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeFindTransformerTransformBarcodeData: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            guard container.contains(.data) else {
                throw DecodingError.keyNotFound(
                    CodingKeys.data,
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeFindTransformerTransformBarcodeData.data: missing required property"
                    )
                )
            }
            data = try container.decodeIfPresent(String.self, forKey: .data)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeFindTransformerTransformBarcodeData.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decode(String.self, forKey: .event)
            guard Self.eventAllowedValues.contains(eventRaw) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeFindTransformerTransformBarcodeData.event: unknown enum value '\(eventRaw)'"
                    )
                )
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            if let data {
                try container.encode(data, forKey: .data)
            } else {
                try container.encodeNil(forKey: .data)
            }
            try container.encode(viewId, forKey: .viewId)
            try container.encode(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["data"] = data ?? NSNull()
            dict["viewId"] = viewId
            dict["event"] = event
            return dict
        }
    }

    /// Notifies the listener that the user tapped the highlight view of a tracked barcode; fire-and-
    /// forget, no reply is awaited.
    struct BarcodeArViewUiListenerDidTapHighlightForBarcode: Codable {
        let barcode: String
        let barcodeId: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcode: String,
            barcodeId: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.barcode = barcode
            self.barcodeId = barcodeId
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcode",
            "barcodeId",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeArViewUiListener.didTapHighlightForBarcode"]

        enum CodingKeys: String, CodingKey {
            case barcode
            case barcodeId
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeArViewUiListenerDidTapHighlightForBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcode = try container.decode(String.self, forKey: .barcode)
            barcodeId = try container.decode(String.self, forKey: .barcodeId)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArViewUiListenerDidTapHighlightForBarcode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArViewUiListenerDidTapHighlightForBarcode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcode, forKey: .barcode)
            try container.encode(barcodeId, forKey: .barcodeId)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcode"] = barcode
            dict["barcodeId"] = barcodeId
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests an annotation for the given barcode; the provider's reply, correlated by barcodeId,
    /// supplies the annotation to display for it. Async callback: the finish call releases the native
    /// annotation-provider cache entry for this barcode.
    struct BarcodeArAnnotationProviderAnnotationForBarcode: Codable {
        let barcode: String
        let barcodeId: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcode: String,
            barcodeId: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.barcode = barcode
            self.barcodeId = barcodeId
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcode",
            "barcodeId",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeArAnnotationProvider.annotationForBarcode"]

        enum CodingKeys: String, CodingKey {
            case barcode
            case barcodeId
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeArAnnotationProviderAnnotationForBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcode = try container.decode(String.self, forKey: .barcode)
            barcodeId = try container.decode(String.self, forKey: .barcodeId)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArAnnotationProviderAnnotationForBarcode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArAnnotationProviderAnnotationForBarcode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcode, forKey: .barcode)
            try container.encode(barcodeId, forKey: .barcodeId)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcode"] = barcode
            dict["barcodeId"] = barcodeId
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped one of an info annotation's right icons; fire-and-
    /// forget, no reply is awaited.
    struct BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon: Codable {
        let barcodeId: String
        let componentIndex: Int
        let viewId: Int
        let responsiveAnnotationType: String?
        let responsiveAnnotationThreshold: Double?
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcodeId: String,
            componentIndex: Int,
            viewId: Int,
            responsiveAnnotationType: String? = nil,
            responsiveAnnotationThreshold: Double? = nil,
            event: String? = nil
        ) {
            self.barcodeId = barcodeId
            self.componentIndex = componentIndex
            self.viewId = viewId
            self.responsiveAnnotationType = responsiveAnnotationType
            self.responsiveAnnotationThreshold = responsiveAnnotationThreshold
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcodeId",
            "componentIndex",
            "viewId",
            "responsiveAnnotationType",
            "responsiveAnnotationThreshold",
            "event",
        ]
        private static let responsiveAnnotationTypeAllowedValues: Set<String> = ["closeUp", "farAway"]
        private static let eventAllowedValues: Set<String> = [
            "BarcodeArInfoAnnotationListener.didTapInfoAnnotationRightIcon"
        ]

        enum CodingKeys: String, CodingKey {
            case barcodeId
            case componentIndex
            case viewId
            case responsiveAnnotationType
            case responsiveAnnotationThreshold
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcodeId = try container.decode(String.self, forKey: .barcodeId)
            componentIndex = try container.decode(Int.self, forKey: .componentIndex)
            guard componentIndex >= Int(Int32.min), componentIndex <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.componentIndex: out of Int32 range"
                    )
                )
            }
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.viewId: out of Int32 range"
                    )
                )
            }
            let responsiveAnnotationTypeRaw = try container.decodeIfPresent(
                String.self,
                forKey: .responsiveAnnotationType
            )
            if let responsiveAnnotationTypeRaw {
                guard Self.responsiveAnnotationTypeAllowedValues.contains(responsiveAnnotationTypeRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.responsiveAnnotationType: unknown enum value '\(responsiveAnnotationTypeRaw)'"
                        )
                    )
                }
            }
            responsiveAnnotationType = responsiveAnnotationTypeRaw
            responsiveAnnotationThreshold = try container.decodeIfPresent(
                Double.self,
                forKey: .responsiveAnnotationThreshold
            )
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcodeId, forKey: .barcodeId)
            try container.encode(componentIndex, forKey: .componentIndex)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(responsiveAnnotationType, forKey: .responsiveAnnotationType)
            try container.encodeIfPresent(responsiveAnnotationThreshold, forKey: .responsiveAnnotationThreshold)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcodeId"] = barcodeId
            dict["componentIndex"] = componentIndex
            dict["viewId"] = viewId
            if let responsiveAnnotationType { dict["responsiveAnnotationType"] = responsiveAnnotationType }
            if let responsiveAnnotationThreshold {
                dict["responsiveAnnotationThreshold"] = responsiveAnnotationThreshold
            }
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped one of an info annotation's left icons; fire-and-
    /// forget, no reply is awaited.
    struct BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon: Codable {
        let barcodeId: String
        let componentIndex: Int
        let viewId: Int
        let responsiveAnnotationType: String?
        let responsiveAnnotationThreshold: Double?
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcodeId: String,
            componentIndex: Int,
            viewId: Int,
            responsiveAnnotationType: String? = nil,
            responsiveAnnotationThreshold: Double? = nil,
            event: String? = nil
        ) {
            self.barcodeId = barcodeId
            self.componentIndex = componentIndex
            self.viewId = viewId
            self.responsiveAnnotationType = responsiveAnnotationType
            self.responsiveAnnotationThreshold = responsiveAnnotationThreshold
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcodeId",
            "componentIndex",
            "viewId",
            "responsiveAnnotationType",
            "responsiveAnnotationThreshold",
            "event",
        ]
        private static let responsiveAnnotationTypeAllowedValues: Set<String> = ["closeUp", "farAway"]
        private static let eventAllowedValues: Set<String> = [
            "BarcodeArInfoAnnotationListener.didTapInfoAnnotationLeftIcon"
        ]

        enum CodingKeys: String, CodingKey {
            case barcodeId
            case componentIndex
            case viewId
            case responsiveAnnotationType
            case responsiveAnnotationThreshold
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcodeId = try container.decode(String.self, forKey: .barcodeId)
            componentIndex = try container.decode(Int.self, forKey: .componentIndex)
            guard componentIndex >= Int(Int32.min), componentIndex <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.componentIndex: out of Int32 range"
                    )
                )
            }
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.viewId: out of Int32 range"
                    )
                )
            }
            let responsiveAnnotationTypeRaw = try container.decodeIfPresent(
                String.self,
                forKey: .responsiveAnnotationType
            )
            if let responsiveAnnotationTypeRaw {
                guard Self.responsiveAnnotationTypeAllowedValues.contains(responsiveAnnotationTypeRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.responsiveAnnotationType: unknown enum value '\(responsiveAnnotationTypeRaw)'"
                        )
                    )
                }
            }
            responsiveAnnotationType = responsiveAnnotationTypeRaw
            responsiveAnnotationThreshold = try container.decodeIfPresent(
                Double.self,
                forKey: .responsiveAnnotationThreshold
            )
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcodeId, forKey: .barcodeId)
            try container.encode(componentIndex, forKey: .componentIndex)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(responsiveAnnotationType, forKey: .responsiveAnnotationType)
            try container.encodeIfPresent(responsiveAnnotationThreshold, forKey: .responsiveAnnotationThreshold)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcodeId"] = barcodeId
            dict["componentIndex"] = componentIndex
            dict["viewId"] = viewId
            if let responsiveAnnotationType { dict["responsiveAnnotationType"] = responsiveAnnotationType }
            if let responsiveAnnotationThreshold {
                dict["responsiveAnnotationThreshold"] = responsiveAnnotationThreshold
            }
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped an info annotation's icon; fire-and-forget, no reply
    /// is awaited.
    struct BarcodeArInfoAnnotationListenerDidTapInfoAnnotation: Codable {
        let barcodeId: String
        let viewId: Int
        let responsiveAnnotationType: String?
        let responsiveAnnotationThreshold: Double?
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcodeId: String,
            viewId: Int,
            responsiveAnnotationType: String? = nil,
            responsiveAnnotationThreshold: Double? = nil,
            event: String? = nil
        ) {
            self.barcodeId = barcodeId
            self.viewId = viewId
            self.responsiveAnnotationType = responsiveAnnotationType
            self.responsiveAnnotationThreshold = responsiveAnnotationThreshold
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcodeId",
            "viewId",
            "responsiveAnnotationType",
            "responsiveAnnotationThreshold",
            "event",
        ]
        private static let responsiveAnnotationTypeAllowedValues: Set<String> = ["closeUp", "farAway"]
        private static let eventAllowedValues: Set<String> = ["BarcodeArInfoAnnotationListener.didTapInfoAnnotation"]

        enum CodingKeys: String, CodingKey {
            case barcodeId
            case viewId
            case responsiveAnnotationType
            case responsiveAnnotationThreshold
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeArInfoAnnotationListenerDidTapInfoAnnotation: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcodeId = try container.decode(String.self, forKey: .barcodeId)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.viewId: out of Int32 range"
                    )
                )
            }
            let responsiveAnnotationTypeRaw = try container.decodeIfPresent(
                String.self,
                forKey: .responsiveAnnotationType
            )
            if let responsiveAnnotationTypeRaw {
                guard Self.responsiveAnnotationTypeAllowedValues.contains(responsiveAnnotationTypeRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.responsiveAnnotationType: unknown enum value '\(responsiveAnnotationTypeRaw)'"
                        )
                    )
                }
            }
            responsiveAnnotationType = responsiveAnnotationTypeRaw
            responsiveAnnotationThreshold = try container.decodeIfPresent(
                Double.self,
                forKey: .responsiveAnnotationThreshold
            )
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArInfoAnnotationListenerDidTapInfoAnnotation.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcodeId, forKey: .barcodeId)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(responsiveAnnotationType, forKey: .responsiveAnnotationType)
            try container.encodeIfPresent(responsiveAnnotationThreshold, forKey: .responsiveAnnotationThreshold)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcodeId"] = barcodeId
            dict["viewId"] = viewId
            if let responsiveAnnotationType { dict["responsiveAnnotationType"] = responsiveAnnotationType }
            if let responsiveAnnotationThreshold {
                dict["responsiveAnnotationThreshold"] = responsiveAnnotationThreshold
            }
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped an info annotation's header; fire-and-forget, no
    /// reply is awaited.
    struct BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader: Codable {
        let barcodeId: String
        let viewId: Int
        let responsiveAnnotationType: String?
        let responsiveAnnotationThreshold: Double?
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcodeId: String,
            viewId: Int,
            responsiveAnnotationType: String? = nil,
            responsiveAnnotationThreshold: Double? = nil,
            event: String? = nil
        ) {
            self.barcodeId = barcodeId
            self.viewId = viewId
            self.responsiveAnnotationType = responsiveAnnotationType
            self.responsiveAnnotationThreshold = responsiveAnnotationThreshold
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcodeId",
            "viewId",
            "responsiveAnnotationType",
            "responsiveAnnotationThreshold",
            "event",
        ]
        private static let responsiveAnnotationTypeAllowedValues: Set<String> = ["closeUp", "farAway"]
        private static let eventAllowedValues: Set<String> = [
            "BarcodeArInfoAnnotationListener.didTapInfoAnnotationHeader"
        ]

        enum CodingKeys: String, CodingKey {
            case barcodeId
            case viewId
            case responsiveAnnotationType
            case responsiveAnnotationThreshold
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcodeId = try container.decode(String.self, forKey: .barcodeId)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.viewId: out of Int32 range"
                    )
                )
            }
            let responsiveAnnotationTypeRaw = try container.decodeIfPresent(
                String.self,
                forKey: .responsiveAnnotationType
            )
            if let responsiveAnnotationTypeRaw {
                guard Self.responsiveAnnotationTypeAllowedValues.contains(responsiveAnnotationTypeRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.responsiveAnnotationType: unknown enum value '\(responsiveAnnotationTypeRaw)'"
                        )
                    )
                }
            }
            responsiveAnnotationType = responsiveAnnotationTypeRaw
            responsiveAnnotationThreshold = try container.decodeIfPresent(
                Double.self,
                forKey: .responsiveAnnotationThreshold
            )
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcodeId, forKey: .barcodeId)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(responsiveAnnotationType, forKey: .responsiveAnnotationType)
            try container.encodeIfPresent(responsiveAnnotationThreshold, forKey: .responsiveAnnotationThreshold)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcodeId"] = barcodeId
            dict["viewId"] = viewId
            if let responsiveAnnotationType { dict["responsiveAnnotationType"] = responsiveAnnotationType }
            if let responsiveAnnotationThreshold {
                dict["responsiveAnnotationThreshold"] = responsiveAnnotationThreshold
            }
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped an info annotation's footer; fire-and-forget, no
    /// reply is awaited.
    struct BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter: Codable {
        let barcodeId: String
        let viewId: Int
        let responsiveAnnotationType: String?
        let responsiveAnnotationThreshold: Double?
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcodeId: String,
            viewId: Int,
            responsiveAnnotationType: String? = nil,
            responsiveAnnotationThreshold: Double? = nil,
            event: String? = nil
        ) {
            self.barcodeId = barcodeId
            self.viewId = viewId
            self.responsiveAnnotationType = responsiveAnnotationType
            self.responsiveAnnotationThreshold = responsiveAnnotationThreshold
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcodeId",
            "viewId",
            "responsiveAnnotationType",
            "responsiveAnnotationThreshold",
            "event",
        ]
        private static let responsiveAnnotationTypeAllowedValues: Set<String> = ["closeUp", "farAway"]
        private static let eventAllowedValues: Set<String> = [
            "BarcodeArInfoAnnotationListener.didTapInfoAnnotationFooter"
        ]

        enum CodingKeys: String, CodingKey {
            case barcodeId
            case viewId
            case responsiveAnnotationType
            case responsiveAnnotationThreshold
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcodeId = try container.decode(String.self, forKey: .barcodeId)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.viewId: out of Int32 range"
                    )
                )
            }
            let responsiveAnnotationTypeRaw = try container.decodeIfPresent(
                String.self,
                forKey: .responsiveAnnotationType
            )
            if let responsiveAnnotationTypeRaw {
                guard Self.responsiveAnnotationTypeAllowedValues.contains(responsiveAnnotationTypeRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.responsiveAnnotationType: unknown enum value '\(responsiveAnnotationTypeRaw)'"
                        )
                    )
                }
            }
            responsiveAnnotationType = responsiveAnnotationTypeRaw
            responsiveAnnotationThreshold = try container.decodeIfPresent(
                Double.self,
                forKey: .responsiveAnnotationThreshold
            )
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcodeId, forKey: .barcodeId)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(responsiveAnnotationType, forKey: .responsiveAnnotationType)
            try container.encodeIfPresent(responsiveAnnotationThreshold, forKey: .responsiveAnnotationThreshold)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcodeId"] = barcodeId
            dict["viewId"] = viewId
            if let responsiveAnnotationType { dict["responsiveAnnotationType"] = responsiveAnnotationType }
            if let responsiveAnnotationThreshold {
                dict["responsiveAnnotationThreshold"] = responsiveAnnotationThreshold
            }
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped a popover annotation; fire-and-forget, no reply is
    /// awaited.
    struct BarcodeArPopoverAnnotationListenerDidTapPopover: Codable {
        let barcodeId: String
        let viewId: Int
        let responsiveAnnotationType: String?
        let responsiveAnnotationThreshold: Double?
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcodeId: String,
            viewId: Int,
            responsiveAnnotationType: String? = nil,
            responsiveAnnotationThreshold: Double? = nil,
            event: String? = nil
        ) {
            self.barcodeId = barcodeId
            self.viewId = viewId
            self.responsiveAnnotationType = responsiveAnnotationType
            self.responsiveAnnotationThreshold = responsiveAnnotationThreshold
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcodeId",
            "viewId",
            "responsiveAnnotationType",
            "responsiveAnnotationThreshold",
            "event",
        ]
        private static let responsiveAnnotationTypeAllowedValues: Set<String> = ["closeUp", "farAway"]
        private static let eventAllowedValues: Set<String> = ["BarcodeArPopoverAnnotationListener.didTapPopover"]

        enum CodingKeys: String, CodingKey {
            case barcodeId
            case viewId
            case responsiveAnnotationType
            case responsiveAnnotationThreshold
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeArPopoverAnnotationListenerDidTapPopover: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcodeId = try container.decode(String.self, forKey: .barcodeId)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArPopoverAnnotationListenerDidTapPopover.viewId: out of Int32 range"
                    )
                )
            }
            let responsiveAnnotationTypeRaw = try container.decodeIfPresent(
                String.self,
                forKey: .responsiveAnnotationType
            )
            if let responsiveAnnotationTypeRaw {
                guard Self.responsiveAnnotationTypeAllowedValues.contains(responsiveAnnotationTypeRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArPopoverAnnotationListenerDidTapPopover.responsiveAnnotationType: unknown enum value '\(responsiveAnnotationTypeRaw)'"
                        )
                    )
                }
            }
            responsiveAnnotationType = responsiveAnnotationTypeRaw
            responsiveAnnotationThreshold = try container.decodeIfPresent(
                Double.self,
                forKey: .responsiveAnnotationThreshold
            )
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArPopoverAnnotationListenerDidTapPopover.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcodeId, forKey: .barcodeId)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(responsiveAnnotationType, forKey: .responsiveAnnotationType)
            try container.encodeIfPresent(responsiveAnnotationThreshold, forKey: .responsiveAnnotationThreshold)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcodeId"] = barcodeId
            dict["viewId"] = viewId
            if let responsiveAnnotationType { dict["responsiveAnnotationType"] = responsiveAnnotationType }
            if let responsiveAnnotationThreshold {
                dict["responsiveAnnotationThreshold"] = responsiveAnnotationThreshold
            }
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Notifies the listener that the user tapped a button in a popover annotation; fire-and-forget, no
    /// reply is awaited.
    struct BarcodeArPopoverAnnotationListenerDidTapPopoverButton: Codable {
        let barcodeId: String
        let buttonIndex: Int
        let viewId: Int
        let responsiveAnnotationType: String?
        let responsiveAnnotationThreshold: Double?
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcodeId: String,
            buttonIndex: Int,
            viewId: Int,
            responsiveAnnotationType: String? = nil,
            responsiveAnnotationThreshold: Double? = nil,
            event: String? = nil
        ) {
            self.barcodeId = barcodeId
            self.buttonIndex = buttonIndex
            self.viewId = viewId
            self.responsiveAnnotationType = responsiveAnnotationType
            self.responsiveAnnotationThreshold = responsiveAnnotationThreshold
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcodeId",
            "buttonIndex",
            "viewId",
            "responsiveAnnotationType",
            "responsiveAnnotationThreshold",
            "event",
        ]
        private static let responsiveAnnotationTypeAllowedValues: Set<String> = ["closeUp", "farAway"]
        private static let eventAllowedValues: Set<String> = ["BarcodeArPopoverAnnotationListener.didTapPopoverButton"]

        enum CodingKeys: String, CodingKey {
            case barcodeId
            case buttonIndex
            case viewId
            case responsiveAnnotationType
            case responsiveAnnotationThreshold
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message:
                            "BarcodeArPopoverAnnotationListenerDidTapPopoverButton: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcodeId = try container.decode(String.self, forKey: .barcodeId)
            buttonIndex = try container.decode(Int.self, forKey: .buttonIndex)
            guard buttonIndex >= Int(Int32.min), buttonIndex <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeArPopoverAnnotationListenerDidTapPopoverButton.buttonIndex: out of Int32 range"
                    )
                )
            }
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "BarcodeArPopoverAnnotationListenerDidTapPopoverButton.viewId: out of Int32 range"
                    )
                )
            }
            let responsiveAnnotationTypeRaw = try container.decodeIfPresent(
                String.self,
                forKey: .responsiveAnnotationType
            )
            if let responsiveAnnotationTypeRaw {
                guard Self.responsiveAnnotationTypeAllowedValues.contains(responsiveAnnotationTypeRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArPopoverAnnotationListenerDidTapPopoverButton.responsiveAnnotationType: unknown enum value '\(responsiveAnnotationTypeRaw)'"
                        )
                    )
                }
            }
            responsiveAnnotationType = responsiveAnnotationTypeRaw
            responsiveAnnotationThreshold = try container.decodeIfPresent(
                Double.self,
                forKey: .responsiveAnnotationThreshold
            )
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArPopoverAnnotationListenerDidTapPopoverButton.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcodeId, forKey: .barcodeId)
            try container.encode(buttonIndex, forKey: .buttonIndex)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(responsiveAnnotationType, forKey: .responsiveAnnotationType)
            try container.encodeIfPresent(responsiveAnnotationThreshold, forKey: .responsiveAnnotationThreshold)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcodeId"] = barcodeId
            dict["buttonIndex"] = buttonIndex
            dict["viewId"] = viewId
            if let responsiveAnnotationType { dict["responsiveAnnotationType"] = responsiveAnnotationType }
            if let responsiveAnnotationThreshold {
                dict["responsiveAnnotationThreshold"] = responsiveAnnotationThreshold
            }
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests a highlight for the given barcode; the provider's reply, correlated by barcodeId,
    /// supplies the highlight to display for it. Async callback: the finish call releases the native
    /// highlight-provider cache entry for this barcode.
    struct BarcodeArHighlightProviderHighlightForBarcode: Codable {
        let barcode: String
        let barcodeId: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcode: String,
            barcodeId: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.barcode = barcode
            self.barcodeId = barcodeId
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcode",
            "barcodeId",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeArHighlightProvider.highlightForBarcode"]

        enum CodingKeys: String, CodingKey {
            case barcode
            case barcodeId
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArHighlightProviderHighlightForBarcode: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcode = try container.decode(String.self, forKey: .barcode)
            barcodeId = try container.decode(String.self, forKey: .barcodeId)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArHighlightProviderHighlightForBarcode.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription:
                                "BarcodeArHighlightProviderHighlightForBarcode.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcode, forKey: .barcode)
            try container.encode(barcodeId, forKey: .barcodeId)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcode"] = barcode
            dict["barcodeId"] = barcodeId
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Signals that the framework layer dropped its cached augmentations for a barcode that stopped
    /// being tracked, so the script layer can release the highlight, annotation and their property-
    /// change listeners for it.
    struct BarcodeArAugmentationsEvicted: Codable {
        let barcodeId: String
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcodeId: String,
            viewId: Int,
            event: String? = nil
        ) {
            self.barcodeId = barcodeId
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcodeId",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeArAugmentations.evicted"]

        enum CodingKeys: String, CodingKey {
            case barcodeId
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArAugmentationsEvicted: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcodeId = try container.decode(String.self, forKey: .barcodeId)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArAugmentationsEvicted.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription: "BarcodeArAugmentationsEvicted.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcodeId, forKey: .barcodeId)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcodeId"] = barcodeId
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    /// Requests the filter's decision on which of the currently tracked barcodes to keep in the given
    /// frame; the framework awaits a reply listing the retained barcode identifiers before proceeding.
    struct BarcodeArFilterFilterBarcodes: Codable {
        let barcodes: [BarcodeArFilterFilterBarcodesBarcodesItem]
        let viewId: Int
        let event: String?

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcodes: [BarcodeArFilterFilterBarcodesBarcodesItem],
            viewId: Int,
            event: String? = nil
        ) {
            self.barcodes = barcodes
            self.viewId = viewId
            self.event = event
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcodes",
            "viewId",
            "event",
        ]
        private static let eventAllowedValues: Set<String> = ["BarcodeArFilter.filterBarcodes"]

        enum CodingKeys: String, CodingKey {
            case barcodes
            case viewId
            case event
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArFilterFilterBarcodes: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcodes = try container.decode([BarcodeArFilterFilterBarcodesBarcodesItem].self, forKey: .barcodes)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArFilterFilterBarcodes.viewId: out of Int32 range"
                    )
                )
            }
            let eventRaw = try container.decodeIfPresent(String.self, forKey: .event)
            if let eventRaw {
                guard Self.eventAllowedValues.contains(eventRaw) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription: "BarcodeArFilterFilterBarcodes.event: unknown enum value '\(eventRaw)'"
                        )
                    )
                }
            }
            event = eventRaw
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcodes, forKey: .barcodes)
            try container.encode(viewId, forKey: .viewId)
            try container.encodeIfPresent(event, forKey: .event)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcodes"] = barcodes.map { $0.toDictionary() }
            dict["viewId"] = viewId
            if let event { dict["event"] = event }
            return dict
        }
    }

    struct BarcodeArFilterFilterBarcodesBarcodesItem: Codable {
        let barcode: String
        let barcodeId: String

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            barcode: String,
            barcodeId: String
        ) {
            self.barcode = barcode
            self.barcodeId = barcodeId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "barcode",
            "barcodeId",
        ]

        enum CodingKeys: String, CodingKey {
            case barcode
            case barcodeId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArFilterFilterBarcodesBarcodesItem: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            barcode = try container.decode(String.self, forKey: .barcode)
            barcodeId = try container.decode(String.self, forKey: .barcodeId)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(barcode, forKey: .barcode)
            try container.encode(barcodeId, forKey: .barcodeId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["barcode"] = barcode
            dict["barcodeId"] = barcodeId
            return dict
        }
    }

    /// Requests the listener's response to an updated BarcodeArSession in the given frame; the
    /// framework awaits a boolean reply before proceeding.
    struct BarcodeArListenerDidUpdateSession: Codable {
        let session: String
        let frameId: String?
        let viewId: Int

        // Explicit memberwise init -- defining `init(from decoder:)` below suppresses Swift's
        // synthesized memberwise initializer, but emit sites need to build these payloads (not
        // just decode them), so both must coexist.
        init(
            session: String,
            frameId: String? = nil,
            viewId: Int
        ) {
            self.session = session
            self.frameId = frameId
            self.viewId = viewId
        }

        // Built once per type rather than per decode -- see the per-property
        // `AllowedValues` sets below for the same rationale.
        private static let allowedKeys: Set<String> = [
            "session",
            "frameId",
            "viewId",
        ]

        enum CodingKeys: String, CodingKey {
            case session
            case frameId
            case viewId
        }

        init(from decoder: Decoder) throws {
            let anyContainer = try decoder.container(keyedBy: AnyCodingKey.self)
            for key in anyContainer.allKeys {
                guard Self.allowedKeys.contains(key.stringValue) else {
                    throw UnknownPropertyError(
                        message: "BarcodeArListenerDidUpdateSession: unknown property '\(key.stringValue)'"
                    )
                }
            }
            let container = try decoder.container(keyedBy: CodingKeys.self)
            session = try container.decode(String.self, forKey: .session)
            guard container.contains(.frameId) else {
                throw DecodingError.keyNotFound(
                    CodingKeys.frameId,
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArListenerDidUpdateSession.frameId: missing required property"
                    )
                )
            }
            frameId = try container.decodeIfPresent(String.self, forKey: .frameId)
            viewId = try container.decode(Int.self, forKey: .viewId)
            guard viewId >= Int(Int32.min), viewId <= Int(Int32.max) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "BarcodeArListenerDidUpdateSession.viewId: out of Int32 range"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(session, forKey: .session)
            if let frameId {
                try container.encode(frameId, forKey: .frameId)
            } else {
                try container.encodeNil(forKey: .frameId)
            }
            try container.encode(viewId, forKey: .viewId)
        }

        // Dictionary projection for `Event.emit(on:payload: [String: Any])`
        // (frameworks/shared/ios/.../Event/Event.swift) -- a NULLABLE property keeps
        // its key, written as NSNull when nil: omitting it changed the emitted bytes
        // for payloads that previously rode through as raw JSON (SDC-33900), and a
        // strict parser accepts an explicit null but throws on a missing key
        // (SDC-33544). A non-nullable optional is omitted when nil, because the
        // decoder rejects an explicit null for it.
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            dict["session"] = session
            dict["frameId"] = frameId ?? NSNull()
            dict["viewId"] = viewId
            return dict
        }
    }
}
