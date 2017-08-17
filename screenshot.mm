//
//  screenshot.mm
//  25DaysOfChristmas
//
//  Created by Lucas Futch on 8/9/17.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

extern "C" {
    
    void ScreenShotFunction(int pictureNumber) {

        // Search for the most recent filename in documents folder
        NSString *fileName = @"Picture.png";
    
        NSURL* documentFolder = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSString *documentFolderPath = documentFolder.path;
        
        NSString *filePath;
        
        for (int i = 0; i < 10; i++){
             filePath = [documentFolderPath stringByAppendingPathComponent:fileName];
        }
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        
        if (fileExists) {
            printf("Saving image to Camera Roll");
            UIImage* image = [[UIImage alloc] initWithContentsOfFile:filePath];
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            
        }
        else {
            printf("Screenshot was not found :( ");
        }
    
    }
}

