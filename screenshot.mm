//
//  screenshot.mm
//  FreeForm
//
//  Created by Lucas Futch on 8/9/17.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

extern "C" {
    
    void ScreenShotFunction() {
        
        NSString *fileName = @"Picture.png";
        
        NSURL* documentFolder = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        
        NSString *documentFolderPath = documentFolder.path;
        NSString *filePath = [documentFolderPath stringByAppendingPathComponent:fileName];
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        
        if (fileExists) {
            UIImage* image = [[UIImage alloc] initWithContentsOfFile:filePath];
            
            
            /// UI popup message
            //////
            
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"alertTitle"
                                                  message:@"alertMessage"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"OK action");
                                       }];
            
           
            [alertController addAction:okAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            /////
            
            /// Border making by editing image
            ///////////////////////
            
            UIView *blackBG = [[UIView alloc] initWithFrame:CGRectMake(0,0,100,100)];
            blackBG.backgroundColor = [UIColor blackColor];
            UIImageView *myPicture = [[UIImageView alloc] initWithImage:
                                      image];
            
            int borderWidth = 100;
            
            myPicture.frame = CGRectMake(borderWidth,
                                         borderWidth,
                                         blackBG.frame.size.width-borderWidth*2,
                                         blackBG.frame.size.height-borderWidth*2);
            
            [blackBG addSubview: myPicture];
            
            UIImage *newImage = myPicture.image;
            
            ///////////////////////
            
            UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
            printf("Screenshot was successfuly saved to camera roll! ");
        }
        else {
            printf("Screenshot was not found :( ");
        }
    }
    
    void VideoShotFunction() {
        
        printf("Inside VideoShotFunction. ");
        
//        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(video)) {
//            UISaveVideoAtPathToSavedPhotosAlbum(video, nil, nil, nil);
//        }
        
        
        
    }
}

