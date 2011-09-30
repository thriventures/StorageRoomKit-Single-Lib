//
//  SRCollection+Private.h
//  StorageRoomKit
//
//  Created by Sascha Konietzke on 8/10/11.
//  Copyright 2011 Thriventures. All rights reserved.
//


@interface SRCollection (SRPrivate)

- (RKObjectMapping *)entryObjectMappingForClass:(Class)aClass;
- (RKObjectMapping *)entryObjectMappingForAutoGeneratedClass;
- (NSString *)autoGeneratedEntryClassName;
- (Class)autoGeneratedEntryClass;

@end