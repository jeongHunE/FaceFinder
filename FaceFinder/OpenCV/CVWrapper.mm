//
//  CVWrapper.m
//  FaceFinder
//
//  Created by 이정훈 on 5/25/24.
//

#import "CVWrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

using namespace std;
using namespace cv;

@implementation CVWrapper

#pragma mark - Convert to grayscale
+ (UIImage *) convertToGrayScale: (UIImage *) image {    //Objc에서 static 메서드 선언시 +로 표시
    Mat imageMat;    //cv::Mat 타입의 변수 설정 (cv::Mat 타입은 OpenCV에서 이미지 픽셀 데이터를 행렬 형태로 저장)

    //UIImage를 Mat 타입으로 변환
    UIImageToMat(image, imageMat);

    //이미 grayscale의 이미지라면 그대로 반환
    if (imageMat.channels() == 1) {
        return image;
    }

    Mat grayMat;
    cvtColor(imageMat, grayMat, cv::COLOR_BGR2GRAY);

    return MatToUIImage(grayMat);
}

#pragma mark - Draw Rectange to region of Interests(Person Face)
+ (UIImage *) drawRectangleTo: (UIImage *) image {
    Mat imageMat;
    UIImageToMat(image, imageMat);
    
    Mat grayMat;
    cvtColor(imageMat, grayMat, COLOR_BGR2GRAY);
    
    //캐스케이드 분류기
    CascadeClassifier classifier;
    //main Bundle은 애플리케이션의 리소스가 포함된 디렉토리를 말함
    const NSString* cascadePath = [[NSBundle mainBundle]
                                   pathForResource:@"haarcascade_frontalface_default"
                                   ofType:@"xml"];    //파일 경로와 파일 타입에 대한 정보
    classifier.load([cascadePath UTF8String]);    //cascasePath를 UTF8로 인코딩하여 가져옴
    
    vector<cv::Rect> faceDetections;    //검출한 객체를 저장할 vector
    const double scaleFactor = 1.1;    //영상 축소 비율
    const int minNeighbors = 2;    //최종 얼굴로 인식하기 위해 필요한 이웃 수
    const cv::Size minimumSize(300, 300);    //최소 객체 사이즈
    
    classifier.detectMultiScale(grayMat,
                                faceDetections,
                                scaleFactor,
                                minNeighbors,
                                0,
                                minimumSize);
    
    if (faceDetections.size() < 1) {
        return image;
    }
    
    for (auto &face : faceDetections) {
        const cv::Point start = cv::Point(face.x, face.y);
        const cv::Point end = start + cv::Point(face.width, face.height);
        const cv::Scalar color = cv::Scalar(0, 255, 255);
        
        cv::rectangle(imageMat, start, end, color, 10);
    }
    
    return MatToUIImage(imageMat);
    
}

@end
