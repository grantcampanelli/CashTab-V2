//
//  NSManagedObject.generated.swift
//
//  This code was generated by AlecrimCoreData code generator tool.
//
//  Changes to this file may cause incorrect behavior and will be lost if
//  the code is regenerated.
//

import Foundation
import CoreData

import AlecrimCoreData

// MARK: - NSManagedObject properties

extension NSManagedObject {

    @NSManaged public var category: String?
    @NSManaged public var cost: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var desc: String?
    @NSManaged public var location: String?
    @NSManaged public var paymentMethod: String?
    @NSManaged public var title: String?
    @NSManaged public var vendor: String?

}

// MARK: - NSManagedObject query attributes

extension NSManagedObject {

    public static let category = AlecrimCoreData.NullableAttribute<String>("category")
    public static let cost = AlecrimCoreData.NullableAttribute<String>("cost")
    public static let date = AlecrimCoreData.NullableAttribute<NSDate>("date")
    public static let desc = AlecrimCoreData.NullableAttribute<String>("desc")
    public static let location = AlecrimCoreData.NullableAttribute<String>("location")
    public static let paymentMethod = AlecrimCoreData.NullableAttribute<String>("paymentMethod")
    public static let title = AlecrimCoreData.NullableAttribute<String>("title")
    public static let vendor = AlecrimCoreData.NullableAttribute<String>("vendor")

}

// MARK: - AttributeType extensions

extension AlecrimCoreData.AttributeType where Self.ValueType: NSManagedObject {

    public var category: AlecrimCoreData.NullableAttribute<String> { return AlecrimCoreData.NullableAttribute<String>("category", self) }
    public var cost: AlecrimCoreData.NullableAttribute<String> { return AlecrimCoreData.NullableAttribute<String>("cost", self) }
    public var date: AlecrimCoreData.NullableAttribute<NSDate> { return AlecrimCoreData.NullableAttribute<NSDate>("date", self) }
    public var desc: AlecrimCoreData.NullableAttribute<String> { return AlecrimCoreData.NullableAttribute<String>("desc", self) }
    public var location: AlecrimCoreData.NullableAttribute<String> { return AlecrimCoreData.NullableAttribute<String>("location", self) }
    public var paymentMethod: AlecrimCoreData.NullableAttribute<String> { return AlecrimCoreData.NullableAttribute<String>("paymentMethod", self) }
    public var title: AlecrimCoreData.NullableAttribute<String> { return AlecrimCoreData.NullableAttribute<String>("title", self) }
    public var vendor: AlecrimCoreData.NullableAttribute<String> { return AlecrimCoreData.NullableAttribute<String>("vendor", self) }

}

// MARK: - DataContext extensions

extension DataContext {

    public var transactions: AlecrimCoreData.Table<NSManagedObject> { return AlecrimCoreData.Table<NSManagedObject>(dataContext: self) }

}

