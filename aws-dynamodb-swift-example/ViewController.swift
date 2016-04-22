//
//  ViewController.swift
//  aws-dynamodb-swift-example
//
//  Created by Jose Deras on 4/22/16.
//  Copyright © 2016 Jose Deras. All rights reserved.
//

import UIKit
import AWSDynamoDB
import AWSCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //insert values
        insertValues()
        
        //get values
        getQuery()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertValues(){
        
        //static values
         let newBook = DDBTableRow.self()
        newBook.ISBN = "33334"
        newBook.Author = "Jose Deras"
        newBook.Title = "Book Title"

        //or get values from text fields
//        let newBook = DDBTableRow.self()
//        newBook.ISBN = self.isbnField.text
//        newBook.Title = self.titleField.text
//        newBook.Author = self.authorField.text
        
        
        //saving it
        let insertValues = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        insertValues.save(newBook) .continueWithBlock({ (task: AWSTask!) -> AnyObject! in
            if ((task.error) != nil) {
                NSLog("Failed")
                print("Error: \(task.error)")
            }
            if ((task.result) != nil){
                NSLog("Something happened")
            }
            return nil
        })
    }
    
    func getQuery(){
        //performing a query
        
        //first create expression
        let queryExpression = AWSDynamoDBQueryExpression()
        
        //second define the index name
        queryExpression.indexName = "Author-index"
        
        //3rd hashes
        queryExpression.hashKeyAttribute = "Author"
        queryExpression.hashKeyValues = ("Jose Deras")
        
        
        //putting it all together
        let dynamoDBObjectMapper2 = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        
        
        dynamoDBObjectMapper2.query(DDBTableRow.self, expression: queryExpression) .continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
            if (task.error == nil) {
                if (task.result != nil) {
                    NSLog("Somthing happened")
                    //starting the output of data
                    let tableRow = task.result as! AWSDynamoDBPaginatedOutput
                    for (items) in tableRow.items {
                        print("\(items.ISBN)")
                        print("\(items.Title)")
                        print("\(items.Author)")
                    }
                }
            }
            else {
                print("Error: \(task.error)")
                
            }
            return nil
        })
        
        
    }

}

