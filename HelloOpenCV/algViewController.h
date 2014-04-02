//
//  algViewController.h
//  HelloOpenCV
//
//  Created by Taikun Liu on 3/11/14.
//  Copyright (c) 2014 Taikun Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface algViewController : UIViewController{
    UIImage* image1;
    UIImage* image2;
    UIImage* image3;
}
@property (weak, nonatomic) IBOutlet UIImageView *IViewer1;
@property (weak, nonatomic) IBOutlet UIImageView *IViewer2;
@property (weak, nonatomic) IBOutlet UIImageView *IViewer3;

@end
