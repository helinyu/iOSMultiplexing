//
//  NSMutableData+Helper.m
//  guimiquan
//
//  Created by Chen Rui on 12/1/14.
//  Copyright (c) 2014 Vanchu. All rights reserved.
//

#import "NSMutableData+Helper.h"

@implementation NSMutableData (Helper)

- (void)writeUInt8:(uint8_t)data {
	[self appendBytes:(const void*)&data length:sizeof(data)];
}

- (void)writeUInt16:(uint16_t)data {
	data = htons(data);
	[self appendBytes:(const void*)&data length:sizeof(data)];
}

- (void)writeUInt32:(uint32_t)data {
	data = htonl(data);
	[self appendBytes:(const void*)&data length:sizeof(data)];
}

- (void)writeData:(NSData *)data {
	[self appendData:data];
}

- (uint8_t)peekUInt8 {
	return [self peekUInt8WithOffset:0];
}

- (uint8_t)peekUInt8WithOffset:(NSUInteger)offset {
	if (self.length >= (sizeof(uint8_t) + offset)) {
		return *((uint8_t*)(self.bytes) + offset);
	}
	return 0;
}

- (uint16_t)peekUInt16 {
	return [self peekUInt16WithOffset:0];
}

- (uint16_t)peekUInt16WithOffset:(NSUInteger)offset {
	if (self.length >= (sizeof(uint16_t) + offset)) {
		return ntohs(*((uint16_t*)((uint8_t*)self.bytes + offset)));
	}
	return 0;
}

- (uint32_t)peekUInt32 {
	if (self.length >= sizeof(uint32_t)) {
		return ntohl(*((uint32_t*)(self.bytes)));
	}
	return 0;
}

- (uint32_t)peekUInt32WithOffset:(NSUInteger)offset {
	if (self.length >= (sizeof(uint32_t) + offset)) {
		return ntohl(*((uint32_t*)((uint8_t*)self.bytes + offset)));
	}
	return 0;
}

- (NSData *)peekData:(NSUInteger)length {
	return [self peekData:0 withOffset:length];
}

- (NSData *)peekData:(NSUInteger)length withOffset:(NSUInteger)offset {
	if (self.length >= length + offset) {
		return [self subdataWithRange:NSMakeRange(offset, length)];
	}
	return nil;
}

- (uint8_t)readUInt8 {
	if (self.length >= sizeof(uint8_t)) {
		uint8_t data = [self peekUInt8];
		[self replaceBytesInRange:NSMakeRange(0, sizeof(uint8_t)) withBytes:NULL length:0];
		return data;
	}
	return 0;
}

- (uint16_t)readUInt16 {
	if (self.length >= sizeof(uint16_t)) {
		uint16_t data = [self peekUInt16];
		[self replaceBytesInRange:NSMakeRange(0, sizeof(uint16_t)) withBytes:NULL length:0];
		return data;
	}
	return 0;
}

- (uint32_t)readUInt32 {
	if (self.length >= sizeof(uint32_t)) {
		uint32_t data = [self peekUInt32];
		[self replaceBytesInRange:NSMakeRange(0, sizeof(uint32_t)) withBytes:NULL length:0];
		return data;
	}
	return 0;
}

- (NSData *)readData:(NSUInteger)length {
	if (self.length >= length) {
		NSData *data = [self peekData:length];
		[self replaceBytesInRange:NSMakeRange(0, length) withBytes:NULL length:0];
		return data;
	}
	return nil;
}

@end