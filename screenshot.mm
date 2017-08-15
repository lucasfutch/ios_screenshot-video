//
//  screenshot.mm
//  25DaysOfChristmas
//
//  Created by Lucas Futch on 8/9/17.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#include "ASScreenRecorder.h"

extern "C" {
    
    void ScreenShotFunction() {
        
        // Search for this filename in documents folder
        NSString *fileName = @"Picture.png";
    
        NSURL* documentFolder = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        
        NSString *documentFolderPath = documentFolder.path;
        NSString *filePath = [documentFolderPath stringByAppendingPathComponent:fileName];
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        
        if (fileExists) {
            UIImage* image = [[UIImage alloc] initWithContentsOfFile:filePath];
            
            
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            printf("Screenshot was successfuly saved to camera roll! ");
        }
        else {
            printf("Screenshot was not found :( ");
        }
    }
    
    void VideoShotFunction() {
        
        printf("Inside VideoShotFunction. ");
        
        ASScreenRecorder *recorder = [ASScreenRecorder sharedInstance];
        
        if (recorder.isRecording) {
            [recorder stopRecordingWithCompletion:^{
                NSLog(@"Finished recording");
            }];
        } else {
            [recorder startRecording];
            NSLog(@"Start recording");
        }
        
        
        
    }
}

