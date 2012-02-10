#import "Kiwi.h"

#import "SRCollection.h"
#import "SRCollection+Private.h"
#import "SRField.h"
#import "SRStringField.h"
#import "RKObjectMapping.h"
#import "SREntry.h"
#import "SRObjectManager.h"

SPEC_BEGIN(SRCollectionSpec)

describe(@"Methods", ^{
    __block SRCollection *collection = nil;
    
    beforeEach(^{ 
        SRField *field1 = [SRStringField new];
        field1.identifier = @"name";
        field1.name = @"Name";
        
        collection = [SRCollection new];
        collection.mUrl = @"http://api.storageroomapp.com/accounts/123/collections/456";
        collection.fields = [NSArray arrayWithObjects:field1, nil];
        collection.entryType = @"CollectionSpec";
    });
    
    describe(@"Configuration", ^{
        it(@"should have superclass", ^{
            [[collection should] beKindOfClass:[SRModel class]]; 
        });
        
        it(@"should have attributes", ^{            
            for (NSString *attribute in [SRCollection propertyNames]) {
                SEL selector = NSSelectorFromString(attribute);
                [[collection should] respondToSelector:selector];
            }
        });
    });
    
    describe(@"objectKeyPath", ^{
        it(@"should be set", ^{
            [[[SRCollection objectKeyPath] should] equal:@"collection"]; 
        });
    });
  
    describe(@"entryObjectMappingForAutoGeneratedClass", ^{
        it(@"should return object mapping", ^{
            RKObjectMapping *objectMapping = [collection entryObjectMappingForAutoGeneratedClass];
            [[[objectMapping objectClass] should] equal:[collection autoGeneratedEntryClass]];
             
            RKObjectAttributeMapping *nameMapping = [[objectMapping attributeMappings] objectAtIndex:0];
            [[nameMapping.sourceKeyPath should] equal:@"name"];
            [[nameMapping.destinationKeyPath should] equal:@"name"];
            
            RKObjectAttributeMapping *metaMapping = [[objectMapping attributeMappings] objectAtIndex:1];
            [[metaMapping.sourceKeyPath should] equal:@"m_type"];
            [[metaMapping.destinationKeyPath should] equal:@"mType"];
        });
    });
    
    describe(@"autoGeneratedEntryClass", ^{
        it(@"should return configured class", ^{
            Class generatedClass = [collection autoGeneratedEntryClass];
            [[NSStringFromClass(generatedClass) should] equal:[collection autoGeneratedEntryClassName]];
            [[[generatedClass superclass] should] equal:[SREntry class]];
            [[[generatedClass collection] should] equal:collection];
            
            id object = [generatedClass new];
            [object setName:@"testName"];
            [[[object name] should] equal:@"testName"];
            
            [object setMType:@"test"];
            [[[object mType] should] equal:@"test"];
            
            [object release];
        });
    });
    
    describe(@"autoGeneratedEntryClassName", ^{
        it(@"should return name", ^{
            [[[collection autoGeneratedEntryClassName] should] equal:@"SREntryClass_456"]; 
        });
    });
    
    describe(@"createAndRegisterEntryClass", ^{
        it(@"should register class", ^{
            [collection createAndRegisterEntryClass];

            [[[SRObjectManager entryObjectMappings] objectForKey:@"CollectionSpec"] shouldNotBeNil];
        });
    });
    
});

SPEC_END