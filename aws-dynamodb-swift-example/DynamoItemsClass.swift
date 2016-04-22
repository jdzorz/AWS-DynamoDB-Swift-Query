//
//  DynamoItemsClass.swift
//  aws-dynamodb-swift-example
//
//  Created by Jose Deras on 4/22/16.
//  Copyright © 2016 Jose Deras. All rights reserved.
//

import UIKit
import AWSCore
import AWSDynamoDB

class DDBTableRow :AWSDynamoDBObjectModel ,AWSDynamoDBModeling  {
    
    var ISBN:String?
    var Title:String?
    var Author:String?
    

    
    class func dynamoDBTableName() -> String! {
        return "Books"
    }
    
    

    class func hashKeyAttribute() -> String! {
        return "ISBN"
    }
    
    
    
    class func ignoreAttributes() -> Array<AnyObject>! {
        return nil
    }
    
   
    override func isEqual(object: AnyObject?) -> Bool {
        return super.isEqual(object)
    }
    
    override func `self`() -> Self {
        return self
    }
}