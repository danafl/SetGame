//
//  CardMatchingGame.h
//  MadterCard2
//
//  Created by Dana Fleischer on 23/08/2016.
//  Copyright © 2016 Dana Fleischer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

//new init that supports the opption of both 2 or 3 match modes
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
                     withPlayMode:(NSInteger)playMode;

- (void)chooseCardAtIndex:(NSUInteger) index;

- (Card *)cardAtIndex:(NSUInteger) index;

@property (readonly,nonatomic) NSInteger score;

@property (nonatomic) NSInteger playMode;

//information about the last choice made in the game
@property (strong, nonatomic) NSMutableArray *lastChosenCards;

@property (nonatomic) NSInteger scoreChange;

@property (nonatomic) BOOL lastChoiceMatched;


@end
