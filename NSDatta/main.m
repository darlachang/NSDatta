//
//  main.m
//  NSDatta
//
//  Created by Ming-Han Chang on 2016/4/14.
//  Copyright © 2016年 Ming-Han Chang. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSFileManager *fm, *fm2, *fm3;
        NSData *fileData;
        NSString *dirName = @"testdir";
        NSString *path, *path2;
        NSDirectoryEnumerator *dirEnum;
        NSArray *dirArray;
        
        fm = [NSFileManager defaultManager];
        
        //read the file newfiles
        fileData = [fm contentsAtPath: @"newfile2"];
        
        if (fileData == nil)
        {NSLog(@"File read failed");
            return 1;
        }
        //write the data to newfile3
        if ([fm createFileAtPath: @"newfile3" contents: fileData attributes: nil] == NO)
        {
            NSLog(@"couldn't create the copy");
            return 2;
        }
        
        NSLog(@"files copy was sucessful");
        
        
        //Need to create an instance of the file manager
        fm2 = [NSFileManager defaultManager];
        
        //Get current directory
        path = [fm2 currentDirectoryPath];
        NSLog(@"Current directory path is %@", path);
        
        //Create a new directory
        if ([fm2 createDirectoryAtPath: dirName withIntermediateDirectories: YES attributes: nil error:NULL] == NO)
        {
            NSLog(@"Couldn't create directory");
            return 1;
        }
        
        //Rename the new directory
        if ([fm2 moveItemAtPath:dirName toPath: @"newdir" error:NULL] == NO){
            NSLog(@"Directory rename filed");
            return 2;
        }
        
        //Change directory into the new directory
        if ([fm2 changeCurrentDirectoryPath: @"newdir"] == NO){
            NSLog(@"Change directory failed");
            return 3;
        }
        
        //Now get and display current workng directory
        path = [fm2 currentDirectoryPath];
        NSLog(@"Current directory path is %@", path);
        
        NSLog(@"All operations were successful");
        
        
        //Enumerate the contents of a directory
        
        //Need to create an instance of the file manager
        fm3 = [NSFileManager defaultManager];
        
        //Get current working directory path
        path2 = [fm currentDirectoryPath];
        
        //Enumerate the directory
        dirEnum = [fm3 enumeratorAtPath: path2];
        NSLog(@"Contents of %@", path2);
        while ((path2 == [dirEnum nextObject]) != nil)
        {
            NSLog(@"%@", path2);
        }
        
        //another way to enumerate a directory
        dirArray = [fm contentsOfDirectoryAtPath:[fm currentDirectoryPath] error: NULL];
        
        NSLog(@"Contents using contentsOfDirectoryAtPath: error");
        
        for (path2 in dirArray)
            NSLog(@"%@", path2);
    }
    return 0;
}
