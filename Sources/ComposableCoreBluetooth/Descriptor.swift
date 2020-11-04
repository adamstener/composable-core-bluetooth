//
//  Descriptor.swift
//  ComposableCoreBluetooth
//
//  Created by Philipp Gabriel on 15.07.20.
//  Copyright © 2020 Philipp Gabriel. All rights reserved.
//

import Foundation
import CoreBluetooth

public struct Descriptor: Equatable {
    
    let rawValue: CBDescriptor?
    public let identifier: CBUUID
    public let value: DescriptorType?
    
    init(from descriptor: CBDescriptor) {
        rawValue = descriptor
        identifier = descriptor.uuid
        
        switch descriptor.uuid.uuidString {
        case CBUUIDCharacteristicExtendedPropertiesString:
            value = .characteristicExtendedProperties(descriptor.value as? NSNumber)
        case CBUUIDCharacteristicUserDescriptionString:
            value = .characteristicUserDescription(descriptor.value as? String)
        case CBUUIDClientCharacteristicConfigurationString:
            value = .clientCharacteristicConfiguration(descriptor.value as? NSNumber)
        case CBUUIDServerCharacteristicConfigurationString:
            value = .serverCharacteristicConfiguration(descriptor.value as? NSNumber)
        case CBUUIDCharacteristicFormatString:
            value = .characteristicFormat(descriptor.value as? Data)
        case CBUUIDCharacteristicAggregateFormatString:
            value = .characteristicAggregateFormat(descriptor.value as? Data)
        default:
            value = nil
        }
    }
    
    init(identifier: CBUUID, value: DescriptorType?) {
        rawValue = nil
        self.identifier = identifier
        self.value = value
    }
}

extension Descriptor {
    
    public enum DescriptorType: Equatable {
        case characteristicExtendedProperties(NSNumber?)
        case characteristicUserDescription(String?)
        case clientCharacteristicConfiguration(NSNumber?)
        case serverCharacteristicConfiguration(NSNumber?)
        case characteristicFormat(Data?)
        case characteristicAggregateFormat(Data?)
        
        var associatedValue: Any? {
            switch self {
            case .characteristicExtendedProperties(let number): return number
            case .characteristicUserDescription(let string): return string
            case .clientCharacteristicConfiguration(let number): return number
            case .serverCharacteristicConfiguration(let number): return number
            case .characteristicFormat(let data): return data
            case .characteristicAggregateFormat(let data): return data
            }
        }
    }
}

extension Descriptor {
    
    public static func mock(identifier: CBUUID, value: DescriptorType?) -> Self {
        return Descriptor(identifier: identifier, value: value)
    }
}