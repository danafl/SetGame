//
//  ViewController.m
//  MadterCard2
//
//  Created by Dana Fleischer on 23/08/2016.
//  Copyright © 2016 Dana Fleischer. All rights reserved.
//


#import "ViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"



@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) NSMutableAttributedString *historyLog;


@end


@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if([segue.identifier isEqualToString:@"ShowHistory"]) {
    if([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
      HistoryViewController *historyController =
      (HistoryViewController *)segue.destinationViewController;
      historyController.historyText = self.historyLog;
      NSLog(@"%@", self.historyLog);
    }
  }
}

- (NSMutableAttributedString *)historyLog {
  if(!_historyLog) {
    _historyLog = [[NSMutableAttributedString alloc]init];
  }
  return _historyLog;
}

- (CardMatchingGame *)game{
  if(!_game)
  {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]
                                           withPlayMode:[self getPlayMode]];

  }
  return _game;
}

//abstract
- (Deck *)createDeck
{
  return nil;
}

- (IBAction)touchCArdButton:(UIButton *)sender {
  NSInteger cardIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:cardIndex];
  [self updateUI];
  //update result message
  self.resultLabel.attributedText = [self createResultMessage];
}

// will reset the state of the game
- (IBAction)touchResetButton:(UIButton *)sender {
  //redeal the cards
  self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                usingDeck:[self createDeck]
                                             withPlayMode:[self getPlayMode]];

  [self updateUI];


  self.resultLabel.attributedText= [[NSMutableAttributedString alloc]initWithString:@""];
  self.historyLog = [[NSMutableAttributedString alloc]initWithString:@""];

}


- (void)updateUI
{
  for(UIButton *cardButton in self.cardButtons)
  {
    NSInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardIndex];
    [self updateCardButtonTitle:cardButton byCard:card];
    [cardButton setBackgroundImage:[self backgroundImageCard:card] forState:UIControlStateNormal];
    [self markCard:cardButton ifSelected:card];
    cardButton.enabled = !card.isMatched;
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];

}

//abstract - used only in setCard
- (void) markCard:(UIButton *)cardButton ifSelected:(Card *)card {

}

//abstract
- (void)updateCardButtonTitle:(UIButton *)cardButton byCard:(Card *)card{

}

//abstract
- (UIImage *)backgroundImageCard:(Card *)card
{
  return nil;
}

//abstract
- (NSInteger)getPlayMode
{
  return 0;
}


- (NSMutableAttributedString *)createResultMessage {

  NSMutableAttributedString *cardsNames = [self addContents:self.game.lastChosenCards];

  if([self.game.lastChosenCards count] == self.game.playMode)
  {
    NSString *messageString = nil;
    if(self.game.lastChoiceMatched)
    {
      messageString = [NSString stringWithFormat:@" match for %ld points.\n",self.game.scoreChange];
    }else{
      messageString = [NSString stringWithFormat:@" don't match! %ld point penalty.\n",
                       self.game.scoreChange];
    }
    
    NSMutableAttributedString *finalMessage = [cardsNames mutableCopy];
    [finalMessage appendAttributedString:[[NSMutableAttributedString alloc]
                                          initWithString:messageString]];
    [self.historyLog appendAttributedString:finalMessage];
    return finalMessage;

  }else{
    return cardsNames;
  }
}

//abstract
-(NSMutableAttributedString *)addContents:(NSArray *)cards {
  return nil;
}

@end

