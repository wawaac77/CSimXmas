//
//  Macros.h
//  CSimXmas
//
//  Created by Alice Jin on 19/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

/** Screen Height */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** Screen Width */
#define ScreenW [UIScreen mainScreen].bounds.size.width
/** Screen Bounds */
#define ScreenBounds [UIScreen mainScreen].bounds
/** Weak Reference */
#define WEAKSELF __weak typeof(self) weakSelf = self;

/*****************  Fit Screen  ******************/
#define iphonex (ScreenH == 812)
#define iphone8p (ScreenH == 736)
#define iphone8 (ScreenH == 667)
#define iphone7p (ScreenH == 736)
#define iphone7 (ScreenH == 667)
#define iphone6p (ScreenH == 736)
#define iphone6 (ScreenH == 667)
#define iphone5 (ScreenH == 568)
#define iphone4 (ScreenH == 480)

/*****************  API  ******************/
#define LAB_API @"https://uat.clubsim.com.hk/clsmw/api/"
#define PRD_API @"https://www.theclub.com.hk/clsmw/api/"


#endif /* Macros_h */
