/*
 Copyright (C) 2012 Stig Brautaset. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
   to endorse or promote products derived from this software without specific
   prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "SBEloRatingTests.h"
#import "ScoreKit.h"

#define RA 1600
#define RB 1400
#define EPSILON 0.001

@implementation SBEloRatingTests

- (void)setUp
{
    [super setUp];
    elo = [[SBEloRating alloc] initWithStrategy:[[SBDefaultKFactorStrategy alloc] init]];
}

- (void)tearDown
{
    elo = nil;
    [super tearDown];
}

- (void)testInitialRating
{
    STAssertEquals([elo initialRating], 1200u, nil);
}

- (void)testExpected
{
    STAssertEqualsWithAccuracy([elo expectedScoreForPlayerRating:RA againstOpponentRating:RB], 0.76, EPSILON, nil);
    STAssertEqualsWithAccuracy([elo expectedScoreForPlayerRating:RA againstOpponentRating:RA], 0.5, EPSILON, nil);
    STAssertEqualsWithAccuracy([elo expectedScoreForPlayerRating:RB againstOpponentRating:RB], 0.5, EPSILON, nil);
    STAssertEqualsWithAccuracy([elo expectedScoreForPlayerRating:RB againstOpponentRating:RA], 0.24, EPSILON, nil);
}

- (void)testAdjustment
{
    STAssertEquals([elo adjustedRatingForPlayerWithCompletedGames:0 andRating:RA scoring:1.0 againstOpponentRating:RA ], 1616u, nil);
    STAssertEquals([elo adjustedRatingForPlayerWithCompletedGames:0 andRating:RA scoring:0.5 againstOpponentRating:RA ], 1600u, nil);
    STAssertEquals([elo adjustedRatingForPlayerWithCompletedGames:0 andRating:RA scoring:0.0 againstOpponentRating:RA ], 1584u, nil);

    STAssertEquals([elo adjustedRatingForPlayerWithCompletedGames:0 andRating:RA scoring:1.0 againstOpponentRating:RB ], 1607u, nil);
    STAssertEquals([elo adjustedRatingForPlayerWithCompletedGames:0 andRating:RA scoring:0.5 againstOpponentRating:RB ], 1591u, nil);
    STAssertEquals([elo adjustedRatingForPlayerWithCompletedGames:0 andRating:RA scoring:0.0 againstOpponentRating:RB ], 1575u, nil);

    STAssertEquals([elo adjustedRatingForPlayerWithCompletedGames:0 andRating:RB scoring:1.0 againstOpponentRating:RA ], 1424u, nil);
    STAssertEquals([elo adjustedRatingForPlayerWithCompletedGames:0 andRating:RB scoring:0.5 againstOpponentRating:RA ], 1408u, nil);
    STAssertEquals([elo adjustedRatingForPlayerWithCompletedGames:0 andRating:RB scoring:0.0 againstOpponentRating:RA ], 1392u, nil);
}


@end
