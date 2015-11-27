//
//  PhotoCell.m
//  YXPhotoGallery
//
//  Created by 郑雨鑫 on 15/11/27.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *PhotoView;

@end

@implementation PhotoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setPhotoName:(NSString *)photoName
{
    _photoName=[photoName copy];
    
    self.PhotoView.image=[UIImage imageNamed:photoName];
}



@end
