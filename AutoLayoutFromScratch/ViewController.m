//
//  ViewController.m
//  AutoLayoutFromScratch
//
//  Created by mar Jinn on 12/24/14.
//  Copyright (c) 2014 mar Jinn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property UIButton* button;

@property UITextField* textFieldEmail;
@property UITextField* textFieldConfirmEmail;
@property UIButton* registerButton;


//Cross View Constraints
@property UIView* topGreyView;
@property UIButton* topButton;
@property UIView* bottomGreyView;
@property UIButton* bottomButton;

@end

////EMAIL txt Field
__unused NSString* const kEmailTextFieldHorizontal = \
@"H:|-[_textFieldEmail]-|";
//
__unused NSString* const kEmailTextFieldVertical = \
@"V:|-(==64)-[_textFieldEmail]";
//
//ConfirmEmail
__unused NSString* const kConfirmEmailHorizontal = \
@"H:|-[_textFieldConfirmEmail]-|";

__unused NSString* const kConfirmEmailVertical =
@"V:[_textFieldEmail]-[_textFieldConfirmEmail]";

//registerbutton
__unused NSString* const kRegisterButtonVertical =
@"V:[_textFieldConfirmEmail]-[_registerButton]";


__unused NSString* const kRegisterButtonHorizontal =
@"H:|-[_registerButton]-|";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self createAndAddAButtonCenteredUsingConstriants];
//    
//    [self constructUIComponents];
//    
//    [self addComponentsToview:[self view]];
//    
//    [[self view] addConstraints:[self constriants]];
    
    
 //   [self createAndAddAButtonCenteredUsingConstriantsUsingVFL];
    
    
    [self createGrayViews];
    [self createButtons];
    
    [self applyConstraintsToTopGrayView];
    
    [self applyConstraintsToButtonOnTopOfGrayView];
    
    [self applyConstraintsToBottomGrayView];
    
    [self applyConstraintsToButtonOnBottomOfGrayView];
    
   }


#pragma mark CrossViewConstriants
-(UIView*)newGrayView
{
    UIView* result = nil;
    result = [UIView new];
    
    [result setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [result setBackgroundColor:[UIColor lightGrayColor]];
    
    [[self view] addSubview:result];
    
    return result;
}

-(void)createGrayViews
{
    [self setTopGreyView:[self newGrayView]];
    
    [self setBottomGreyView:[self newGrayView]];
}

-(UIButton*) newButtonPlacedOnView:(UIView*)paramView
{
    UIButton* tmpButton = nil;
    tmpButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [tmpButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [tmpButton setTitle:@"Button" forState:UIControlStateNormal];
    
    [tmpButton setBackgroundColor:[UIColor orangeColor]];
    
    [paramView addSubview:tmpButton];
    
    return tmpButton;
}

-(void)createButtons
{
    [self setTopButton:[self newButtonPlacedOnView:[self topGreyView]]];
    
    [self setBottomButton:[self newButtonPlacedOnView:[self bottomGreyView]]];
}

//Configue top gray view
//height 100
//width screenwidth with default padding
//top normal padding
//botom nothing

-(void)applyConstraintsToTopGrayView
{
    NSDictionary* views = nil;
    views = NSDictionaryOfVariableBindings(_topGreyView);
    
    NSMutableArray* constriants = nil;
    constriants = [NSMutableArray array];
    
    //horizontalConst
    NSString* const kHorizontalConstriant = @"H:|-[_topGreyView]-|";
    //vertical Const
    NSString* const kVerticalConstriant = @"V:|-(==navbarPadding)-[_topGreyView(==height)]";
    
    //hori
    NSArray* horizontalConstriants = nil;
    horizontalConstriants =
    [NSLayoutConstraint constraintsWithVisualFormat:kHorizontalConstriant
                                            options:0
                                            metrics:nil
                                              views:views];
    
    //verti
    NSArray* verticalConstraints = nil;
    verticalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:kVerticalConstriant
                                            options:0
                                            metrics:@{@"height" : @100,
                                                      @"navbarPadding" : @64
                                                      }
                                              views:views];
    
    [constriants addObjectsFromArray:horizontalConstriants];
    [constriants addObjectsFromArray:verticalConstraints];
    
    [[[self topGreyView] superview] addConstraints:constriants];
    
}

//configure button on top grey view
/*
 1. top - vertical center of top grey view
 2. left - stndard distance
 3. height/width based on content
 4. right - not specified
 5. bottom - not specified
 */
-(void)applyConstraintsToButtonOnTopOfGrayView
{
    NSDictionary* views = nil;
    views = NSDictionaryOfVariableBindings(_topButton,_topGreyView);
    
    NSMutableArray* constriants = nil;
    constriants = [NSMutableArray array];
    
    //horizontalConst
    NSString* const kHorizontalConstriant = @"H:|-[_topButton]";
    //vertical Const
    //NSString* const kVerticalConstriant = @"V:[_topGreyView]-(<=1)-[_topButton]";
    
    //hori
    NSArray* horizontalConstriants = nil;
    horizontalConstriants =
    [NSLayoutConstraint constraintsWithVisualFormat:kHorizontalConstriant
                                            options:0
                                            metrics:nil
                                              views:views];
    
    //verti
//    NSArray* verticalConstraints = nil;
//    verticalConstraints =
//    [NSLayoutConstraint constraintsWithVisualFormat:kVerticalConstriant
//                                            options:NSLayoutFormatAlignAllCenterX
//                                            metrics:nil
//                                              views:views];
    
    NSLayoutConstraint* verticalConstraint = nil;
    verticalConstraint =
    [NSLayoutConstraint constraintWithItem:[self topButton]
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:[self topGreyView]
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0f
                                  constant:0.0f];
    
    [constriants addObjectsFromArray:horizontalConstriants];
    //[constriants addObjectsFromArray:verticalConstraints];
    [constriants addObject:verticalConstraint];
    
    [[[self topButton] superview] addConstraints:constriants];
    
}

//Configure Bottom gray view
/*
 1. left - standard
 2. right - standard
 3. height /width - 100 / not specified
 4. top - stndard wrt to topview
 5. botton - not specified
 */

-(void)applyConstraintsToBottomGrayView
{
    NSDictionary* views = nil;
    views = NSDictionaryOfVariableBindings(_bottomGreyView,_topGreyView);
    
    NSMutableArray* constriants = nil;
    constriants = [NSMutableArray array];
    
    //horizontalConst
    NSString* const kHorizontalConstriant = @"H:|-[_bottomGreyView]-|";
    //vertical Const
    NSString* const kVerticalConstriant = @"V:|-(==navbarPadding)-[_topGreyView]-[_bottomGreyView(==height)]";
    /*
     0r
     NSString* const kVerticalConstriant = @"V:[_topGreyView]-[_bottomGreyView(==height)]";
     
     as constraint for top view has already been added
     
     */
    
    
    //hori
    NSArray* horizontalConstriants = nil;
    horizontalConstriants =
    [NSLayoutConstraint constraintsWithVisualFormat:kHorizontalConstriant
                                            options:0
                                            metrics:nil
                                              views:views];
    
    //verti
    NSArray* verticalConstraints = nil;
    verticalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:kVerticalConstriant
                                            options:0
                                            metrics:@{@"height" : @100,
                                                      @"navbarPadding" : @64
                                                      
                                                      }
                                              views:views];
    
    [constriants addObjectsFromArray:horizontalConstriants];
    [constriants addObjectsFromArray:verticalConstraints];
    
    [[[self bottomGreyView] superview] addConstraints:constriants];
    
}

//configure button on bottom grey view
/*
 1. top - vertical center of bottom grey view
 2. left - aligned with right side of top button
 3. height/width based on content
 4. right - not specified
 5. bottom - not specified
 */
-(void)applyConstraintsToButtonOnBottomOfGrayView
{
    NSDictionary* views = nil;
    views = NSDictionaryOfVariableBindings(_topButton,_bottomButton);
    
    NSMutableArray* constriants = nil;
    constriants = [NSMutableArray array];
    
    //horizontalConst
    NSString* const kHorizontalConstriant = @"H:[_topButton]-[_bottomButton]";
    //vertical Const
    //NSString* const kVerticalConstriant = @"V:[_topGreyView]-(<=1)-[_topButton]";
    
    //hori
    NSArray* horizontalConstriants = nil;
    horizontalConstriants =
    [NSLayoutConstraint constraintsWithVisualFormat:kHorizontalConstriant
                                            options:0
                                            metrics:nil
                                              views:views];
    
    //verti
    //    NSArray* verticalConstraints = nil;
    //    verticalConstraints =
    //    [NSLayoutConstraint constraintsWithVisualFormat:kVerticalConstriant
    //                                            options:NSLayoutFormatAlignAllCenterX
    //                                            metrics:nil
    //                                              views:views];
    
    NSLayoutConstraint* verticalConstraint = nil;
    verticalConstraint =
    [NSLayoutConstraint constraintWithItem:[self bottomButton]
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:[self bottomGreyView]
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0f
                                  constant:0.0f];
    //horizontal constriant is specified with a view that does not share the same superview
    //bottombuttons superviews superview is the same as that of topbuttons superviews superview
    
    [[[[self bottomButton] superview] superview] addConstraints:horizontalConstriants];
    
    //[constriants addObjectsFromArray:verticalConstraints];
    [constriants addObject:verticalConstraint];
    
    [[[self bottomButton] superview] addConstraints:constriants];
    
}


-(void)createAndAddAButtonCenteredUsingConstriants
{
    UIButton* demoButton = nil;
    demoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    //makes button look only for constraints we set not its autosizing masks
    [demoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //title
    [demoButton setTitle:@"Button" forState:UIControlStateNormal];
    
    [demoButton setBackgroundColor:[UIColor blackColor]];
    
    [self setButton:demoButton];
    demoButton =nil;
    
    [[self view] addSubview:[self button]];
    
    //Superview
    UIView* superview = nil;
    superview = [[self button] superview];
    
    //set the constraint X
    NSLayoutConstraint* centerXConstriant = nil;
    centerXConstriant =
    [NSLayoutConstraint constraintWithItem:[self button]
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:superview
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0f constant:0.0f];
    
    
    //set the constraint Y
    NSLayoutConstraint* centerYConstraint = nil;
    centerYConstraint =
    [NSLayoutConstraint constraintWithItem:[self button]
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:superview
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0f constant:0.0f];
    
    [superview addConstraints:@[centerXConstriant,centerYConstraint]];
}

-(void)createAndAddAButtonCenteredUsingConstriantsUsingVFL
{
    UIButton* demoButton = nil;
    demoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    //makes button look only for constraints we set not its autosizing masks
    [demoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //title
    [demoButton setTitle:@"Button" forState:UIControlStateNormal];
    
    [demoButton setBackgroundColor:[UIColor blackColor]];
    
    [self setButton:demoButton];
    demoButton =nil;
    
    [[self view] addSubview:[self button]];
    
    //Superview
    UIView* superview = nil;
    superview = [[self button] superview];
    
    //set the constraint X
    NSArray* centerXConstraints = nil;
    centerXConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:[superview]-(<=1)-[_button]"
                                            options:NSLayoutFormatAlignAllCenterY
                                            metrics:nil
                                              views:NSDictionaryOfVariableBindings(_button,superview)];
    
    
    //set the constraint Y
    NSArray* centerYConstraints = nil;
    centerYConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:[superview]-(<=1)-[_button]"
                                            options:NSLayoutFormatAlignAllCenterX
                                            metrics:nil
                                              views:NSDictionaryOfVariableBindings(_button,superview)];

    
    
    NSMutableArray* arrayOfConstraints = nil;
    arrayOfConstraints = [NSMutableArray array];
    
    [arrayOfConstraints addObjectsFromArray:centerXConstraints];
    [arrayOfConstraints addObjectsFromArray:centerYConstraints];
    
    [superview addConstraints:arrayOfConstraints];
}





/*
 VISUAL FORMAT LANGUAGE
 
 The button has to maintain 100 points on each side from its superview’s edges.
 
 H:|-100-[_button]-100-|
 
 
 
 The button has to have a left distance of less than or equal to 100 points from the left edge of its superview. It also has to have a width that is greater than or equal to 50 points and has to stay 100 points or less away from the right edge of its superview.
 
 H:|-(<=100)-[_button(>=50)]-(<=100)-|
 
 
 
 The button has to keep a standard left distance from the left edge of its superview (stan‐ dard distances are defined by Apple) and has to have a width of at least 100 and at most 200 points.
 
 H:|-[_button(>=100,<=200)]
 
 
 As you can see, the formatting might take you some time to get used to. However, once you get the hang of the basics of it, it will slowly start to make sense. The same rules apply for vertical alignment, which uses the V: orientation specifier. For instance:
 
 V:[_button]-(>=100)-|
 
 */
-(void)createVFL
{
    /*
    We have
     1. EMail text Field
     2. Confirm Email TextField
     3. RegisterButton
     
    */
    
    
    //EMAIL txt Field
    __unused NSString* const kEmailTextFieldHorizontal = \
    @"H:|-[_textFieldEmail]-|";
    
    __unused NSString* const kEmailTextFieldVertical = \
    @"V:|-[_textFieldEmail]-|";
    
//    //ConfirmEmail
//    __unused NSString* const kConfirmEmailHorizontal = \
//    @"H:|-[_textFieldConfirmEmail]-|";
//    
//    __unused NSString* const kConfirmEmailVertical =
//    @"V:[_textFieldEmail]-[_textFieldConfirmEmail]";

   __unused NSString *const kConfirmEmailHorizontal =
    @"H:|-[_textFieldConfirmEmail]-|";
    
   __unused NSString *const kConfirmEmailVertical = @"V:[_textFieldEmail]-[_textFieldConfirmEmail]";
    
    //registerbutton
    __unused NSString* const kRegisterButtonVertical =
    @"V:[_textFieldConfirmEmail]-[_registerButton]";
    
}


-(UITextField*)textFieldWithPlaceHolder:(NSString*) placeHolder
{
    UITextField* result = nil;
    result = [UITextField new];
    
    //set
    [result setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [result setBorderStyle:UITextBorderStyleRoundedRect];
    
    [result setPlaceholder:placeHolder];
    
    return result;
}


-(void)constructUIComponents
{
    self.textFieldEmail = [self textFieldWithPlaceHolder:@"Email"];
    
    self.textFieldConfirmEmail =
    [self textFieldWithPlaceHolder:@"Confirm Email"];
    
    UIButton* demoButton = nil;
    demoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    //makes button look only for constraints we set not its autosizing masks
    [demoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //title
    [demoButton setTitle:@"Register" forState:UIControlStateNormal];
    
    [demoButton setBackgroundColor:[UIColor blackColor]];
    
    [self setRegisterButton:demoButton];
    demoButton =nil;

}

-(void)addComponentsToview:(UIView*)paramView
{
    [paramView addSubview:[self textFieldEmail]];
    
        [paramView addSubview:[self textFieldConfirmEmail]];
    
        [paramView addSubview:[self registerButton]];
}

-(NSArray*)emailTextFieldConstraints
{
    NSMutableArray* result = nil;
    result = [NSMutableArray array];
    
    NSDictionary* viewsDictionary = nil;
    viewsDictionary = NSDictionaryOfVariableBindings(_textFieldEmail);
    
    NSArray* arrayOfConstriantsFromVFLHorizontal = nil;
    arrayOfConstriantsFromVFLHorizontal =
    [NSLayoutConstraint constraintsWithVisualFormat:kEmailTextFieldHorizontal
                                            options:0
                                            metrics:nil
                                              views:viewsDictionary];
    
    NSArray* arrayOfConstriantsFromVFLVertical = nil;
    arrayOfConstriantsFromVFLVertical =
    [NSLayoutConstraint constraintsWithVisualFormat:kEmailTextFieldVertical
                                            options:0
                                            metrics:nil
                                              views:viewsDictionary];
    
    [result addObjectsFromArray:arrayOfConstriantsFromVFLHorizontal];
    [result addObjectsFromArray:arrayOfConstriantsFromVFLVertical];
    
    return [NSArray arrayWithArray:result];
    
}

-(NSArray*)confirmEmailTextFieldConstraints
{
    NSMutableArray* result = nil;
    result = [NSMutableArray array];
    
    NSDictionary* viewsDictionary = nil;
    viewsDictionary = NSDictionaryOfVariableBindings(_textFieldConfirmEmail,_textFieldEmail);
    
    NSArray* arrayOfConstriantsFromVFLHorizontal = nil;
    arrayOfConstriantsFromVFLHorizontal =
    [NSLayoutConstraint constraintsWithVisualFormat:kConfirmEmailHorizontal
                                            options:0
                                            metrics:nil
                                              views:viewsDictionary];
    
    NSArray* arrayOfConstriantsFromVFLVertical = nil;
    arrayOfConstriantsFromVFLVertical =
    [NSLayoutConstraint constraintsWithVisualFormat:kConfirmEmailVertical
                                            options:0
                                            metrics:nil
                                              views:viewsDictionary];
    
    [result addObjectsFromArray:arrayOfConstriantsFromVFLHorizontal];
    [result addObjectsFromArray:arrayOfConstriantsFromVFLVertical];
    
    return [NSArray arrayWithArray:result];
    
}

-(NSArray*)registerButtonConstraints
{
    NSMutableArray* result = nil;
    result = [NSMutableArray array];
    
    NSDictionary* viewsDictionary = nil;
    viewsDictionary = NSDictionaryOfVariableBindings(_registerButton,_textFieldConfirmEmail);
    
    NSArray* arrayOfConstriantsFromVFLHorizontal = nil;
    arrayOfConstriantsFromVFLHorizontal =
    [NSLayoutConstraint constraintsWithVisualFormat:kConfirmEmailHorizontal
                                            options:0
                                            metrics:nil
                                              views:viewsDictionary];
    
    
    NSLayoutConstraint* registerButtonHorizontalConstraint = nil;
    registerButtonHorizontalConstraint =
    [NSLayoutConstraint constraintWithItem:self.registerButton
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.registerButton.superview
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0f
                                  constant:0.0f];
    
    NSArray* arrayOfConstriantsFromVFLVertical = nil;
    arrayOfConstriantsFromVFLVertical =
    [NSLayoutConstraint constraintsWithVisualFormat:kRegisterButtonVertical
                                            options:0
                                            metrics:nil
                                              views:viewsDictionary];
    
    //[result addObject:registerButtonHorizontalConstraint];
    [result addObjectsFromArray:arrayOfConstriantsFromVFLHorizontal];
    [result addObjectsFromArray:arrayOfConstriantsFromVFLVertical];
    
    return [NSArray arrayWithArray:result];
    
}

-(NSArray*)constriants
{
    NSMutableArray* result = nil;
    result = [NSMutableArray array];
    
    [result addObjectsFromArray:[self emailTextFieldConstraints]];
    
    [result addObjectsFromArray:[self confirmEmailTextFieldConstraints]];
    
    [result addObjectsFromArray:[self registerButtonConstraints]];
    
    return [NSArray arrayWithArray:result];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
   
}


/*
 Autolayout Equations?
 
 Apple noticed that a lot of the positioning of UI components can be solved with a simple formula:
 
 object1.property1 = (object2.property2 * multiplier) + constant value
 
 
 For instance, using this formula, I could simply center a button on its superview like so:
 
 button.center.x = (button.superview.center.x * 1) + 0
 button.center.y = (button.superview.center.y * 1) + 0
 
 
 constraint for object1
  NSLayoutConstraint constraintWithItem:object1 attribute:(NSLayoutAttribute) relatedBy:(NSLayoutRelation) toItem:object2 attribute:(NSLayoutAttribute) multiplier:(CGFloat)multiplier constant:(CGFloat)constant value
 
 
 if object2 is object1 s superview constraint will be added to object2
 
 */
@end
