//
//  NSMutableData+Helper.h
//  guimiquan
//
//  Created by Chen Rui on 12/1/14.
//  Copyright (c) 2014 Vanchu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableData (Helper)
- (void)writeUInt8:(uint8_t)data;
- (void)writeUInt16:(uint16_t)data;
- (void)writeUInt32:(uint32_t)data;
- (void)writeData:(NSData *)data;

- (uint8_t)peekUInt8;
- (uint8_t)peekUInt8WithOffset:(NSUInteger)offset;
- (uint16_t)peekUInt16;
- (uint16_t)peekUInt16WithOffset:(NSUInteger)offset;
- (uint32_t)peekUInt32;
- (uint32_t)peekUInt32WithOffset:(NSUInteger)offset;
- (NSData *)peekData:(NSUInteger)length;
- (NSData *)peekData:(NSUInteger)length withOffset:(NSUInteger)offset;

- (uint8_t)readUInt8;
- (uint16_t)readUInt16;
- (uint32_t)readUInt32;
- (NSData *)readData:(NSUInteger)length;
@end
