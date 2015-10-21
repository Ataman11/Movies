//
//  MoviesTests.m
//  MoviesTests
//
//  Created by Matador on 2015-10-19.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AVGMovie.h"
#import "AVGItunesAPIResponseParser.h"
#import "AVGItunesAPI.h"
#import "AVGMoviesDataController.h"

@interface MoviesTests : XCTestCase

@end

@implementation MoviesTests

- (void)setUp {
    [super setUp];
    
}

- (void)tearDown {
    
    [super tearDown];
}

- (NSDictionary *)validMockRepsonse {
    return @{ @"resultCount" : @5,
    @"results": @[
    @{@"wrapperType":@"track", @"kind":@"feature-movie", @"collectionId":@343647202, @"trackId":@271469518, @"artistName":@"Larry Wachowski & Andy Wachowski", @"collectionName":@"4 Film Favorites: The Matrix / V for Vendetta / Constantine / Blade", @"trackName":@"The Matrix", @"collectionCensoredName":@"4 Film Favorites: The Matrix / V for Vendetta / Constantine / Blade", @"trackCensoredName":@"The Matrix", @"collectionArtistId":@199257486, @"collectionArtistViewUrl":@"https://itunes.apple.com/us/artist/warner-bros.-entertainment/id199257486?uo=4", @"collectionViewUrl":@"https://itunes.apple.com/us/movie/the-matrix/id271469518?uo=4", @"trackViewUrl":@"https://itunes.apple.com/us/movie/the-matrix/id271469518?uo=4", @"previewUrl":@"http://a295.v.phobos.apple.com/us/r1000/153/Video7/v4/29/5a/8a/295a8ab2-81db-471d-210c-b70ac770e58b/mzvf_3460590593288106358.640x480.h264lc.D2.p.m4v", @"artworkUrl30":@"http://is1.mzstatic.com/image/thumb/Video4/v4/1e/25/df/1e25dfc5-9601-65e1-5421-e7aac6b69bd4/pr_source.lsr/30x30bb-85.jpg", @"artworkUrl60":@"http://is3.mzstatic.com/image/thumb/Video4/v4/1e/25/df/1e25dfc5-9601-65e1-5421-e7aac6b69bd4/pr_source.lsr/60x60bb-85.jpg", @"artworkUrl100":@"http://is4.mzstatic.com/image/thumb/Video4/v4/1e/25/df/1e25dfc5-9601-65e1-5421-e7aac6b69bd4/pr_source.lsr/100x100bb-85.jpg", @"collectionPrice":@9.99, @"trackPrice":@9.99, @"trackRentalPrice":@2.99000, @"collectionHdPrice":@14.99000, @"trackHdPrice":@14.99000, @"trackHdRentalPrice":@3.99000, @"releaseDate":@"1999-03-31T08:00:00Z", @"collectionExplicitness":@"notExplicit", @"trackExplicitness":@"notExplicit", @"discCount":@1, @"discNumber":@1, @"trackCount":@4, @"trackNumber":@1, @"trackTimeMillis":@8178720, @"country":@"USA", @"currency":@"USD", @"primaryGenreName":@"Sci-Fi & Fantasy", @"contentAdvisoryRating":@"R",
        @"longDescription":@"Breaking box office records as the biggest Easter opening ever, this special effects-driven tale follows Keanu Reeves (\"Speed,\" \"Devil's Advocate\") and Oscar, Golden Globe and Emmy-nominee Laurence Fishburne (\"What's Love Got to Do with It?\") on an explosive futuristic sci-fi adventure about a man who comes to believe that his everyday world is the product of a complex computer-driven digital matrix that feeds on humans. In his dangerous quest to find out the truth, he must figure out who is real and who he can trust. From the producer of the top boxoffice franchise, \"Lethal Weapon.\"", @"radioStationUrl":@"https://itunes.apple.com/station/idra.271469518"},
    @{@"wrapperType":@"track", @"kind":@"feature-movie", @"collectionId":@426284587, @"trackId":@283218560, @"artistName":@"Andy Wachowski", @"collectionName":@"Matrix Collection", @"trackName":@"The Matrix Reloaded", @"collectionCensoredName":@"Matrix Collection", @"trackCensoredName":@"The Matrix Reloaded", @"collectionArtistId":@199257486, @"collectionArtistViewUrl":@"https://itunes.apple.com/us/artist/warner-bros.-entertainment/id199257486?uo=4", @"collectionViewUrl":@"https://itunes.apple.com/us/movie/the-matrix-reloaded/id283218560?uo=4", @"trackViewUrl":@"https://itunes.apple.com/us/movie/the-matrix-reloaded/id283218560?uo=4", @"previewUrl":@"http://a705.v.phobos.apple.com/us/r1000/034/Video/c8/b3/9e/mzm.crvvzdgt..640x358.h264lc.d2.p.m4v", @"artworkUrl30":@"http://is1.mzstatic.com/image/thumb/Video6/v4/23/ef/46/23ef461f-6e55-fff4-75db-48d4951121d5/pr_source.lsr/30x30bb-85.jpg", @"artworkUrl60":@"http://is3.mzstatic.com/image/thumb/Video6/v4/23/ef/46/23ef461f-6e55-fff4-75db-48d4951121d5/pr_source.lsr/60x60bb-85.jpg", @"artworkUrl100":@"http://is4.mzstatic.com/image/thumb/Video6/v4/23/ef/46/23ef461f-6e55-fff4-75db-48d4951121d5/pr_source.lsr/100x100bb-85.jpg", @"collectionPrice":@9.99, @"trackPrice":@9.99, @"trackRentalPrice":@2.99000, @"collectionHdPrice":@14.99000, @"trackHdPrice":@14.99000, @"trackHdRentalPrice":@3.99000, @"releaseDate":@"2003-05-22T07:00:00Z", @"collectionExplicitness":@"notExplicit", @"trackExplicitness":@"notExplicit", @"discCount":@1, @"discNumber":@1, @"trackCount":@3, @"trackNumber":@2, @"trackTimeMillis":@8294752, @"country":@"USA", @"currency":@"USD", @"primaryGenreName":@"Action & Adventure", @"contentAdvisoryRating":@"R",
        @"longDescription":@"Neo, Morpheus, Trinity and the evil Agent Smith are back, and the battle for the human race continues! Written and directed by the acclaimed Wachowski brothers and from action producer Joel Silver (\"Swordfish,\" the \"Lethal Weapon\" and \"Die Hard\" series), this is the highly anticipated sequel to the runaway box-office smash hit ($171+ million) and record-selling DVD \"The Matrix.\" Starring Keanu Reeves (\"Hard Ball,\" \"The Devil's Advocate\"), Oscar-nominated Laurence Fishburne (\"Biker Boyz,\" \"What's Love Got to Do With It\"), Carrie-Anne Moss (\"Chocolat,\" \"Memento\"), Hugo Weaving (\"The Lord of the Rings 1 & 2\"), Jada Pinkett Smith (\"Ali,\" \"Scream 2\"), Monica Bellucci (\"Tears of the Sun,\" \"Malena\") and Nona M. Gaye (\"Ali\").", @"radioStationUrl":@"https://itunes.apple.com/station/idra.283218560"},
    @{@"wrapperType":@"track", @"kind":@"feature-movie", @"collectionId":@426284587, @"trackId":@271469065, @"artistName":@"Andy Wachowski", @"collectionName":@"Matrix Collection", @"trackName":@"The Matrix Revolutions", @"collectionCensoredName":@"Matrix Collection", @"trackCensoredName":@"The Matrix Revolutions", @"collectionArtistId":@199257486, @"collectionArtistViewUrl":@"https://itunes.apple.com/us/artist/warner-bros.-entertainment/id199257486?uo=4", @"collectionViewUrl":@"https://itunes.apple.com/us/movie/the-matrix-revolutions/id271469065?uo=4", @"trackViewUrl":@"https://itunes.apple.com/us/movie/the-matrix-revolutions/id271469065?uo=4", @"previewUrl":@"http://a1990.v.phobos.apple.com/us/r1000/039/Video/fe/1e/dd/mzm.sdwsyxun..640x356.h264lc.d2.p.m4v", @"artworkUrl30":@"http://is1.mzstatic.com/image/thumb/Video69/v4/ba/07/ed/ba07edd7-3214-fe04-af04-62f0a03b1150/pr_source.lsr/30x30bb-85.jpg", @"artworkUrl60":@"http://is1.mzstatic.com/image/thumb/Video69/v4/ba/07/ed/ba07edd7-3214-fe04-af04-62f0a03b1150/pr_source.lsr/60x60bb-85.jpg", @"artworkUrl100":@"http://is1.mzstatic.com/image/thumb/Video69/v4/ba/07/ed/ba07edd7-3214-fe04-af04-62f0a03b1150/pr_source.lsr/100x100bb-85.jpg", @"collectionPrice":@9.99, @"trackPrice":@9.99, @"trackRentalPrice":@2.99000, @"collectionHdPrice":@14.99000, @"trackHdPrice":@14.99000, @"trackHdRentalPrice":@3.99000, @"releaseDate":@"2003-11-05T08:00:00Z", @"collectionExplicitness":@"notExplicit", @"trackExplicitness":@"notExplicit", @"discCount":@1, @"discNumber":@1, @"trackCount":@3, @"trackNumber":@3, @"trackTimeMillis":@7758017, @"country":@"USA", @"currency":@"USD", @"primaryGenreName":@"Sci-Fi & Fantasy", @"contentAdvisoryRating":@"R", @"shortDescription":@"Provocative Futuristic Action Thriller. The Matrix Revolutions marks the final explosive chapter in",
        @"longDescription":@"Everything that has a beginning has an end.\r\n\r\nIn this explosive final chapter of the Matrix trilogy, Neo, Morpheus and Trinity battle to defend Zion, the last real-world city, against the onslaught of the machines that have enslaved the human race. And, now as Neo learns more about his heroic powers--including the ability to see the codes of things and the people, he faces the consequences of the choice made in The Matrix Reloaded.", @"radioStationUrl":@"https://itunes.apple.com/station/idra.271469065"},
    @{@"wrapperType":@"track", @"kind":@"feature-movie", @"trackId":@282591575, @"artistName":@"Josh Oreck", @"trackName":@"The Matrix: Revisited", @"trackCensoredName":@"The Matrix: Revisited", @"trackViewUrl":@"https://itunes.apple.com/us/movie/the-matrix-revisited/id282591575?uo=4", @"previewUrl":@"http://a907.v.phobos.apple.com/us/r1000/025/Video/f6/eb/b7/mzm.gopxihmf..640x480.h264lc.D2.p.m4v", @"artworkUrl30":@"http://is5.mzstatic.com/image/thumb/Features/2c/26/ae/dj.xnfweyml.jpg/30x30bb-85.jpg", @"artworkUrl60":@"http://is2.mzstatic.com/image/thumb/Features/2c/26/ae/dj.xnfweyml.jpg/60x60bb-85.jpg", @"artworkUrl100":@"http://is4.mzstatic.com/image/thumb/Features/2c/26/ae/dj.xnfweyml.jpg/100x100bb-85.jpg", @"collectionPrice":@9.99, @"trackPrice":@9.99, @"trackRentalPrice":@2.99000, @"releaseDate":@"2014-09-01T07:00:00Z", @"collectionExplicitness":@"notExplicit", @"trackExplicitness":@"notExplicit", @"trackTimeMillis":@7375775, @"country":@"USA", @"currency":@"USD", @"primaryGenreName":@"Documentary", @"contentAdvisoryRating":@"NR",
        @"longDescription":@"Been in The Matrix? Now take the next leap of understanding with The Matrix Revisited. An exciting and mind-expanding look at the making of \"The Matrix\" from conception to box-office phenomenon! Experience the nuts and bolts in an in-depth exploration of the filmmaking process; get a sneak peek on location of the upcoming sequel and never-before-seen footage from the original movie; exclusive reflections by those who lived it and much more! The Matrix Revisited is the who, what, where, when and wow of a phenomenon that has just begun.", @"radioStationUrl":@"https://itunes.apple.com/station/idra.282591575"},
    @{@"wrapperType":@"track", @"kind":@"feature-movie", @"trackId":@984125100, @"artistName":@"Robert Vernon", @"trackName":@"Adventures in Odyssey: Escape from the Forbidden Matrix", @"trackCensoredName":@"Adventures in Odyssey: Escape from the Forbidden Matrix", @"trackViewUrl":@"https://itunes.apple.com/us/movie/adventures-in-odyssey-escape/id984125100?uo=4", @"previewUrl":@"http://a746.v.phobos.apple.com/us/r1000/135/Video2/v4/71/b6/28/71b628fd-fd7e-0dda-0549-ba4cae8abf72/mzvf_4527826204544693256.640x480.h264lc.D2.p.m4v", @"artworkUrl30":@"http://is5.mzstatic.com/image/thumb/Video3/v4/78/9d/f1/789df180-b402-c34e-439f-fc6231b8bd4f/FOTF_AIOESCAPEMATRIX.jpg/30x30bb-85.jpg", @"artworkUrl60":@"http://is2.mzstatic.com/image/thumb/Video3/v4/78/9d/f1/789df180-b402-c34e-439f-fc6231b8bd4f/FOTF_AIOESCAPEMATRIX.jpg/60x60bb-85.jpg", @"artworkUrl100":@"http://is1.mzstatic.com/image/thumb/Video3/v4/78/9d/f1/789df180-b402-c34e-439f-fc6231b8bd4f/FOTF_AIOESCAPEMATRIX.jpg/100x100bb-85.jpg", @"collectionPrice":@1.99, @"trackPrice":@1.99, @"collectionHdPrice":@2.99000, @"trackHdPrice":@2.99000, @"releaseDate":@"2013-01-01T08:00:00Z", @"collectionExplicitness":@"notExplicit", @"trackExplicitness":@"notExplicit", @"trackTimeMillis":@1702435, @"country":@"USA", @"currency":@"USD", @"primaryGenreName":@"Kids & Family", @"contentAdvisoryRating":@"NR", @"shortDescription":@"Is it “game over” for Dylan? Dylan can’t get enough of the action-packed video game Insectoids. When",
        @"longDescription":@"Is it “game over” for Dylan? Dylan can’t get enough of the action-packed video game Insectoids. When he and his friend Sal get the chance to play Insectoids “for real” in the virtual-reality Room of Consequence, they enter the dangerous “forbidden matrix” and may never escape! Join Dylan and Sal as they learn the dangers of wasting time and discover what’s really important in life.", @"radioStationUrl":@"https://itunes.apple.com/station/idra.984125100"}]
              };
}

- (NSDictionary *)validSingleMockResponse {
    return @{@"wrapperType":@"track", @"kind":@"feature-movie", @"collectionId":@343647202, @"trackId":@271469518, @"artistName":@"Larry Wachowski & Andy Wachowski", @"collectionName":@"4 Film Favorites: The Matrix / V for Vendetta / Constantine / Blade", @"trackName":@"The Matrix", @"collectionCensoredName":@"4 Film Favorites: The Matrix / V for Vendetta / Constantine / Blade", @"trackCensoredName":@"The Matrix", @"collectionArtistId":@199257486, @"collectionArtistViewUrl":@"https://itunes.apple.com/us/artist/warner-bros.-entertainment/id199257486?uo=4", @"collectionViewUrl":@"https://itunes.apple.com/us/movie/the-matrix/id271469518?uo=4", @"trackViewUrl":@"https://itunes.apple.com/us/movie/the-matrix/id271469518?uo=4", @"previewUrl":@"http://a295.v.phobos.apple.com/us/r1000/153/Video7/v4/29/5a/8a/295a8ab2-81db-471d-210c-b70ac770e58b/mzvf_3460590593288106358.640x480.h264lc.D2.p.m4v", @"artworkUrl30":@"http://is1.mzstatic.com/image/thumb/Video4/v4/1e/25/df/1e25dfc5-9601-65e1-5421-e7aac6b69bd4/pr_source.lsr/30x30bb-85.jpg", @"artworkUrl60":@"http://is3.mzstatic.com/image/thumb/Video4/v4/1e/25/df/1e25dfc5-9601-65e1-5421-e7aac6b69bd4/pr_source.lsr/60x60bb-85.jpg", @"artworkUrl100":@"http://is4.mzstatic.com/image/thumb/Video4/v4/1e/25/df/1e25dfc5-9601-65e1-5421-e7aac6b69bd4/pr_source.lsr/100x100bb-85.jpg", @"collectionPrice":@9.99, @"trackPrice":@9.99, @"trackRentalPrice":@2.99000, @"collectionHdPrice":@14.99000, @"trackHdPrice":@14.99000, @"trackHdRentalPrice":@3.99000, @"releaseDate":@"1999-03-31T08:00:00Z", @"collectionExplicitness":@"notExplicit", @"trackExplicitness":@"notExplicit", @"discCount":@1, @"discNumber":@1, @"trackCount":@4, @"trackNumber":@1, @"trackTimeMillis":@8178720, @"country":@"USA", @"currency":@"USD", @"primaryGenreName":@"Sci-Fi & Fantasy", @"contentAdvisoryRating":@"R",
             @"longDescription":@"Breaking box office records as the biggest Easter opening ever, this special effects-driven tale follows Keanu Reeves (\"Speed,\" \"Devil's Advocate\") and Oscar, Golden Globe and Emmy-nominee Laurence Fishburne (\"What's Love Got to Do with It?\") on an explosive futuristic sci-fi adventure about a man who comes to believe that his everyday world is the product of a complex computer-driven digital matrix that feeds on humans. In his dangerous quest to find out the truth, he must figure out who is real and who he can trust. From the producer of the top boxoffice franchise, \"Lethal Weapon.\"", @"radioStationUrl":@"https://itunes.apple.com/station/idra.271469518"};
}

- (NSDictionary *)invalidSingleMockResponse {
    return @{@"wrapperType":@"track", @"kind":@"feature-movie", @"collectionId":@343647202, @"trackId":@"271469518", @"artistName":@"Larry Wachowski & Andy Wachowski", @"collectionName":@"4 Film Favorites: The Matrix / V for Vendetta / Constantine / Blade", @"trackName":@"The Matrix", @"collectionCensoredName":@"4 Film Favorites: The Matrix / V for Vendetta / Constantine / Blade", @"trackCensoredName":@"The Matrix", @"collectionArtistId":@199257486, @"collectionArtistViewUrl":@"https://itunes.apple.com/us/artist/warner-bros.-entertainment/id199257486?uo=4", @"collectionViewUrl":@"https://itunes.apple.com/us/movie/the-matrix/id271469518?uo=4", @"trackViewUrl":@"https://itunes.apple.com/us/movie/the-matrix/id271469518?uo=4", @"previewUrl":@"http://a295.v.phobos.apple.com/us/r1000/153/Video7/v4/29/5a/8a/295a8ab2-81db-471d-210c-b70ac770e58b/mzvf_3460590593288106358.640x480.h264lc.D2.p.m4v", @"artworkUrl30":@"http://is1.mzstatic.com/image/thumb/Video4/v4/1e/25/df/1e25dfc5-9601-65e1-5421-e7aac6b69bd4/pr_source.lsr/30x30bb-85.jpg", @"artworkUrl60":@"http://is3.mzstatic.com/image/thumb/Video4/v4/1e/25/df/1e25dfc5-9601-65e1-5421-e7aac6b69bd4/pr_source.lsr/60x60bb-85.jpg", @"artworkUrl100":@"http://is4.mzstatic.com/image/thumb/Video4/v4/1e/25/df/1e25dfc5-9601-65e1-5421-e7aac6b69bd4/pr_source.lsr/100x100bb-85.jpg", @"collectionPrice":@9.99, @"trackPrice":@9.99, @"trackRentalPrice":@2.99000, @"collectionHdPrice":@14.99000, @"trackHdPrice":@14.99000, @"trackHdRentalPrice":@3.99000, @"releaseDate":@"1999-03-31T08:00:00Z", @"collectionExplicitness":@"notExplicit", @"trackExplicitness":@"notExplicit", @"discCount":@1, @"discNumber":@1, @"trackCount":@4, @"trackNumber":@1, @"trackTimeMillis":@8178720, @"country":@"USA", @"currency":@"USD", @"primaryGenreName":@"Sci-Fi & Fantasy", @"contentAdvisoryRating":@"R",
      @"longDescription":@"Breaking box office records as the biggest Easter opening ever, this special effects-driven tale follows Keanu Reeves (\"Speed,\" \"Devil's Advocate\") and Oscar, Golden Globe and Emmy-nominee Laurence Fishburne (\"What's Love Got to Do with It?\") on an explosive futuristic sci-fi adventure about a man who comes to believe that his everyday world is the product of a complex computer-driven digital matrix that feeds on humans. In his dangerous quest to find out the truth, he must figure out who is real and who he can trust. From the producer of the top boxoffice franchise, \"Lethal Weapon.\"", @"radioStationUrl":@"https://itunes.apple.com/station/idra.271469518"};
}

- (NSArray *)validMockResults {
    return [[self validMockRepsonse] objectForKey:@"results"];
}

- (NSDate *)dateForString:(NSString *)timeString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDate *date = [formatter dateFromString:timeString];
    return date;
}

#pragma mark - AVGItunesAPIResponseParser Tests

- (void)testParseMoviesFromValidResults {
    NSArray *movies = [AVGItunesAPIResponseParser moviesFromResponses:[self validMockResults]];
    XCTAssertEqual(movies.count, 5, @"Number of movies doesnt much response");
    for (AVGMovie *movie in movies) {
        XCTAssertTrue([movie isKindOfClass:[NSManagedObject class]], @"Incorrect class returned from parser");
    }
    
}

- (void)testParserHandlesNilResults {
    NSArray *movies = [AVGItunesAPIResponseParser moviesFromResponses:nil];
    XCTAssertEqual(movies.count, 0, @"Number of movies doesnt much response");
}

- (void)testMovieObjectFromValidSingleReponse {
    AVGMovie *movie = [AVGItunesAPIResponseParser movieFromResponse:[self validSingleMockResponse]];
    XCTAssertNotEqual(movie, nil, @"Movie object was not reurned rom parser");
    XCTAssertTrue([movie isKindOfClass:[NSManagedObject class]], @"Incorrect class returned from parser");
    XCTAssertTrue([movie.trackId isEqualToNumber:@271469518], @"Incorrect track Id returned from parser");
    XCTAssertEqual(movie.trackName, @"The Matrix", @"Incorrect track name returned from parser");
    XCTAssertEqual(movie.artistName, @"Larry Wachowski & Andy Wachowski", @"Incorrect track name returned from parser");
    XCTAssertEqual(movie.longDescription, @"Breaking box office records as the biggest Easter opening ever, this special effects-driven tale follows Keanu Reeves (\"Speed,\" \"Devil's Advocate\") and Oscar, Golden Globe and Emmy-nominee Laurence Fishburne (\"What's Love Got to Do with It?\") on an explosive futuristic sci-fi adventure about a man who comes to believe that his everyday world is the product of a complex computer-driven digital matrix that feeds on humans. In his dangerous quest to find out the truth, he must figure out who is real and who he can trust. From the producer of the top boxoffice franchise, \"Lethal Weapon.\"", @"Incorrect track name returned from parser");
    
    NSDate *date = [self dateForString:@"1999-03-31T08:00:00Z"];
    XCTAssertEqual([movie.releaseDate compare:date], NSOrderedSame, @"Incorrect release date returned from parser");
    
    XCTAssertEqual(movie.artworkUrl, @"http://is4.mzstatic.com/image/thumb/Video4/v4/1e/25/df/1e25dfc5-9601-65e1-5421-e7aac6b69bd4/pr_source.lsr/100x100bb-85.jpg", @"Incorrect artwork url returned from parser");

    XCTAssertEqual(movie.previewUrl, @"http://a295.v.phobos.apple.com/us/r1000/153/Video7/v4/29/5a/8a/295a8ab2-81db-471d-210c-b70ac770e58b/mzvf_3460590593288106358.640x480.h264lc.D2.p.m4v", @"Incorrect preview url returned from parser");
    
    XCTAssertEqual(movie.favorite, nil, @"Incorrect initial favorite state returned from parser");
}

- (void)testNilObjectFromInvalidSingleResponse {
    AVGMovie *movie = [AVGItunesAPIResponseParser movieFromResponse:[self invalidSingleMockResponse]];
    NSAssert(movie == nil, @"Movie object should not be reurned from parser using invalid response");
}

#pragma mark - AVGItunesAPI Tests

- (void)testItunesAPIWithSomeResults {
    XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    [AVGItunesAPI getMoviesForSearchTerm:@"Matrix" completion:^(NSArray *movies, NSError *error) {
        XCTAssertTrue([movies isKindOfClass:[NSArray class]], @"Array should be returend from api call");
        XCTAssertTrue(movies.count > 0, @"Array should be returend from api call");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
}

- (void)testItunesAPIWithNoResults {
    XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    [AVGItunesAPI getMoviesForSearchTerm:@"Matrixfgdsgfsdf dsfhsdhsgfh" completion:^(NSArray *movies, NSError *error) {
        XCTAssertEqual(movies, nil, @"Nil should be returend from api call with given search parameter");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
}

#pragma mark - AVGMoviesDataController Tests

- (void)testDataControllerIsSIngleton {
    AVGMoviesDataController *controller1 = [AVGMoviesDataController sharedInstance];
    AVGMoviesDataController *controller2 = [AVGMoviesDataController sharedInstance];
    XCTAssertEqual(controller1, controller2, @"AVGMoviesDataController should be a singleton class");
}

- (void)testDataControllerIsUpdatedAfterApiCall {
    [[AVGMoviesDataController sharedInstance].managedObjectContext deletedObjects];
    [[AVGMoviesDataController sharedInstance].managedObjectContext save:nil];
    
    XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    [AVGItunesAPI getMoviesForSearchTerm:@"Matrix" completion:^(NSArray *movies, NSError *error) {
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[AVGMovie entityName]];
        NSArray *moviesArray = [[AVGMoviesDataController sharedInstance].managedObjectContext executeFetchRequest:request error:nil];
        XCTAssertTrue(moviesArray.count > 0, @"Non empty array should be returend from data controller");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
}

- (void)testDataControllerCanFindTrackById {
    [[AVGMoviesDataController sharedInstance].managedObjectContext deletedObjects];
    [[AVGMoviesDataController sharedInstance].managedObjectContext save:nil];
    
    XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    [AVGItunesAPI getMoviesForSearchTerm:@"Matrix" completion:^(NSArray *movies, NSError *error) {
        AVGMovie *movie = [[AVGMoviesDataController sharedInstance] movieWithTrackId:@271469518];
        XCTAssertNotNil(movie, @"Non empty array should be returend from data controller");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
}

@end
