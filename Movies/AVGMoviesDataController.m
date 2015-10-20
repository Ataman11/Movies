//
//  AVGMoviesDataController.m
//  Movies
//
//  Created by Matador on 2015-10-20.
//  Copyright © 2015 Artem Goryaev. All rights reserved.
//

#import "AVGMoviesDataController.h"


@interface AVGMoviesDataController ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation AVGMoviesDataController

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    __strong static id _sharedObject = nil;
    dispatch_once(&once, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    [self initializeCoreDataStack];
    
    return self;
}

- (void)initializeCoreDataStack {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"movies" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(mom != nil, @"Error initializing Managed Object Model");
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    moc.persistentStoreCoordinator = psc;
    self.managedObjectContext = moc;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"movies.sqlite"];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSError *error = nil;
        NSPersistentStoreCoordinator *psc = [[self managedObjectContext] persistentStoreCoordinator];
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
    });
}

- (AVGMovie *)movieWithTrackId:(NSString *)trackId {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[AVGMovie entityName]];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K == %@", NSStringFromSelector(@selector(trackId)), trackId];
    NSArray *fetchedResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    AVGMovie *movie = (AVGMovie *)fetchedResults.firstObject;

    return movie;
}

@end
