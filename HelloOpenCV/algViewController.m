//
//  algViewController.m
//  HelloOpenCV
//
//  Created by Taikun Liu on 3/11/14.
//  Copyright (c) 2014 Taikun Liu. All rights reserved.
//

#import "algViewController.h"
#import "opencv2/highgui/ios.h"
@interface algViewController ()

@end

@implementation algViewController
using namespace cv;
@synthesize IViewer1;
@synthesize IViewer2;
@synthesize IViewer3;

- (void)viewDidLoad
{
    [super viewDidLoad];
    std::vector<cv::Rect> found1;
    std::vector<cv::Rect> found2;

	// Do any additional setup after loading the view, typically from a nib.
    image1 = [UIImage imageNamed:@"0.jpg"];
   // if (image1 != nil)
     //   IViewer1.image=image1;
    cv::Mat cvImage;
    UIImageToMat(image1, cvImage);
    cvtColor(cvImage , cvImage , CV_RGBA2RGB);
    if (!cvImage.empty())
    {
        cv::HOGDescriptor hog;
        hog.setSVMDetector(cv::HOGDescriptor::getDefaultPeopleDetector());
        hog.detectMultiScale(cvImage, found1, 0.2, cv::Size(8,8), cv::Size(32,32), 1.05, 2);
        for(int i=0;i<found1.size();i++){
            cv::Rect r=found1[i];
            rectangle(cvImage, r.tl(), r.br(), cv::Scalar(0,255,0),3);
        }
        IViewer1.image=MatToUIImage(cvImage);
    }
    
    ////image2
    image2 = [UIImage imageNamed:@"1.jpg"];
   // if (image2 != nil)
     //   IViewer2.image=image2;
    //cv::Mat cvImage2;
    UIImageToMat(image2, cvImage);
    cvtColor(cvImage , cvImage , CV_RGBA2RGB);
    if (!cvImage.empty())
    {
        //printf();
        cv::HOGDescriptor hog;
        hog.setSVMDetector(cv::HOGDescriptor::getDefaultPeopleDetector());
        hog.detectMultiScale(cvImage, found2, 0.2, cv::Size(8,8), cv::Size(32,32), 1.05, 2);
        for(int i=0;i<found2.size();i++){
            cv::Rect r=found2[i];
            rectangle(cvImage, r.tl(), r.br(), cv::Scalar(0,255,0),3);
        }
        IViewer2.image=MatToUIImage(cvImage);
    }
    cvImage.release();
    cv::Mat cvImage1;
    UIImageToMat(image1, cvImage1);
    cv::Mat cvImage2;
    UIImageToMat(image2, cvImage2);
    NSLog(@"image size is w1 %d h1 %d w2 %d h2 %d",cvImage1.cols,cvImage1.rows,cvImage2.cols,cvImage2.rows);
    //several steps
    //1. compute homography
    //2. find rectangles that are not intersects
    //3. copy images.
    for (int i=0;i<found1.size();i++)
    {
        cv:: Rect r1=found1[i];
        /*cv::Point tl=r1.tl();
        cv::Point br=r1.br();
        double cx1=(tl.x+br.x)/2.0;
        double cy1=(tl.y+br.y)/2.0;
        int w1=(br.x-tl.x);
        int h1=(br.y-tl.y);*/
       // printf("rectangle i is %d x is %d y is %d w is %f h is %f\n",i,cx1,cy1,w1,h1);
        for(int j=0;j<found2.size();j++)
        {
            cv::Rect r2=found2[j];
          /*  cv:: Rect r2=found2[j];
            cv::Point tl2=r2.tl();
            cv::Point br2=r2.br();
            double cx2=(tl2.x+br2.x)/(double)2;
            double cy2=(tl2.y+br2.y)/2.0;
            int w2=(br2.x-tl2.x);
            int h2=(br2.y-tl2.y);
            double xdiff=fabs(cx1-cx2);
            double ydiff=fabs(cy1-cy2);
            NSLog(@"rectangle j is %d x is %f y is %f w is %d h is %d\n brx is %d and bry is %d \n",j,cx2,cy2,w2,h2,br2.x,br2.y);

            if(xdiff>=(w1+w2)/2 || ydiff >=(h1+h2)/2)//The two rectangles do not intersect*/
            cv::Rect inter=r1&r2;
            if(inter.width==0)
            {
                //copy content from img2 to img1
                NSLog(@"rectangle i is %d tx is %f ty is %f w is %d h is %d\n bx is %d and by is %d \n",i,r2.tl().x,r2.tl().y,r2.width,r2.height,r2.br().x,r2.br().y);
                cvImage2(r1).copyTo(cvImage1(r1));
                
            }
        }
    }
    cvImage2.release();
    IViewer3.image=MatToUIImage(cvImage1);
    
      /*  cv::Mat gray;
        // Convert the image to grayscale
        cv::cvtColor(cvImage, gray, CV_RGBA2GRAY);
        // Apply Gaussian filter to remove small edges
        cv::GaussianBlur(gray, gray,
                         cv::Size(5, 5), 1.2, 1.2);
        // Calculate edges with Canny
        cv::Mat edges;
        cv::Canny(gray, edges, 0, 50);
        // Fill image with white color
        cvImage.setTo(cv::Scalar::all(255));
        // Change color on edges
        cvImage.setTo(cv::Scalar(0, 128, 255, 255), edges);
        // Convert cv::Mat to UIImage* and show the resulting image
        IViewer.image = MatToUIImage(cvImage);*/
    
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
