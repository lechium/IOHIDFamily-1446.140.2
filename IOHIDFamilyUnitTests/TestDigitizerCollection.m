//
//  TestDigitizerCollection.m
//  IOHIDFamily
//
//  Created by YG on 10/25/16.
//
//

#import  <XCTest/XCTest.h>
#include "IOHIDUnitTestUtility.h"
#import  "IOHIDEventSystemTestController.h"
#import  "IOHIDUserDeviceTestController.h"
#import  "IOHIDEventDriverTestCase.h"
static int count = 0;
#define FINGER_COLLECTION \
    0x09, 0x22,                               /*   Usage (Finger)                                           */\
    0xA1, 0x02,                               /*   Collection (Logical)                                     */\
    0x05, 0x0D,                               /*     Usage Page (Digitizer)                                 */\
    0x09, 0x38,                               /*     Usage (Transducer Index)                               */\
    0x75, 0x04,                               /*     Report Size............. (4)                           */\
    0x95, 0x01,                               /*     Report Count............ (1)                           */\
    0x81, 0x02,                               /*     Input...................(Data, Variable, Absolute)     */\
    0x09, 0x33,                               /*     Usage (Touch)                                          */\
    0x15, 0x00,                               /*     Logical Minimum......... (0)                           */\
    0x25, 0x01,                               /*     Logical Maximum......... (1)                           */\
    0x75, 0x01,                               /*     Report Size............. (1)                           */\
    0x95, 0x01,                               /*     Report Count............ (1)                           */\
    0x81, 0x02,                               /*     Input...................(Data, Variable, Absolute)     */\
    0x09, 0x32,                               /*     Usage (In Range)                                       */\
    0x15, 0x00,                               /*     Logical Minimum......... (0)                           */\
    0x25, 0x01,                               /*     Logical Maximum......... (1)                           */\
    0x75, 0x01,                               /*     Report Size............. (1)                           */\
    0x95, 0x01,                               /*     Report Count............ (1)                           */\
    0x81, 0x02,                               /*     Input...................(Data, Variable, Absolute)     */\
    0x75, 0x02,                               /*     Report Size............. (2)                           */\
    0x95, 0x01,                               /*     Report Count............ (1)                           */\
    0x81, 0x01,                               /*     Input...................(Constant)                     */\
    0x05, 0x01,                               /*     Usage Page (Generic Desktop)                           */\
    0x09, 0x30,                               /*     Usage (X)                                              */\
    0x15, 0x00,                               /*     Logical Minimum......... (0)                           */\
    0x26, 0xFF, 0x7F,                         /*     Logical Maximum......... (32767)                       */\
    0x75, 0x10,                               /*     Report Size............. (16)                          */\
    0x95, 0x01,                               /*     Report Count............ (1)                           */\
    0x81, 0x02,                               /*     Input...................(Data, Variable, Absolute)     */\
    0x09, 0x31,                               /*     Usage (Y)                                              */\
    0x15, 0x00,                               /*     Logical Minimum......... (0)                           */\
    0x25, 0x7F,                               /*     Logical Maximum......... (127)                         */\
    0x75, 0x08,                               /*     Report Size............. (8)                           */\
    0x95, 0x01,                               /*     Report Count............ (1)                           */\
    0x81, 0x02,                               /*     Input...................(Data, Variable, Absolute)     */\
    0xC0,                                     /*   End Collection                                           */

static uint8_t descriptor[] = {
    0x05, 0x0d,                               // Usage Page (Digitizer)
    0x09, 0x05,                               // Usage (Touch Pad) 
    0xA1, 0x01,                               // Collection (Application) 
    0x05, 0x0D,                               //   Usage Page (Digitizer) 
    FINGER_COLLECTION
    FINGER_COLLECTION
    FINGER_COLLECTION
    FINGER_COLLECTION
    FINGER_COLLECTION
    FINGER_COLLECTION
    FINGER_COLLECTION
    FINGER_COLLECTION
    FINGER_COLLECTION
    FINGER_COLLECTION
    0x06, 0x00, 0xFF,                         //   Usage Page (65280)
    0x09, 0x23,                               //   Usage 35 (0x23) 
    0xA1, 0x00,                               //   Collection (Physical) 
    0x09, 0x01,                               //     Usage 1 (0x1)
    0x06, 0x11, 0xFF,                         //     Usage Page (65297) 
    0x95, 0x01,                               //     Report Count............ (1)  
    0x75, 0x40,                               //     Report Size............. (64)  
    0x81, 0x02,                               //     Input...................(Data, Variable, Absolute) 
    0xC0,                                     //   End Collection  
    0x06, 0x00, 0xFF,                         //   Usage Page (65280) 
    0x09, 0x16,                               //   Usage 22 (0x16) 
    0xA1, 0x01,                               //   Collection (Application) 
    0xC0,                                     //   End Collection  
    0xC0                                      // End Collection  
};

#define kDigitizerReportByteLength 48

uint8_t reports [][kDigitizerReportByteLength] = {
{0x32, 0xe1, 0x40, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x90, 0xde, 0x34, 0x51, 0xc9, 0x01, 0x00, 0x00},
{0x32, 0xe1, 0x40, 0x3f, 0x35, 0xbd, 0x37, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfa, 0x5c, 0x47, 0x51, 0xc9, 0x01, 0x00, 0x00}, 
{0x32, 0xe1, 0x40, 0x3f, 0x35, 0xbd, 0x37, 0x3f, 0x38, 0x98, 0x2e, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2c, 0x60, 0x51, 0xc9, 0x01, 0x00, 0x00}, 
{0x22, 0xe1, 0x40, 0x3f, 0x35, 0xbd, 0x37, 0x3f, 0x38, 0x98, 0x2e, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2f, 0x65, 0x66, 0x51, 0xc9, 0x01, 0x00, 0x00}, 
{0x02, 0xe1, 0x40, 0x3f, 0x25, 0xbd, 0x37, 0x3f, 0x38, 0x98, 0x2e, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x8b, 0x7e, 0x6c, 0x51, 0xc9, 0x01, 0x00, 0x00}, 
{0x05, 0xbd, 0x37, 0x3f, 0x38, 0x98, 0x2e, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x88, 0x72, 0x51, 0xc9, 0x01, 0x00, 0x00}, 
{0x32, 0x2d, 0x41, 0x3f, 0x08, 0x98, 0x2e, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x58, 0xd4, 0x7e, 0x51, 0xc9, 0x01, 0x00, 0x00}, 
{0x32, 0x2d, 0x41, 0x3f, 0x35, 0xcc, 0x37, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5f, 0x6f, 0x91, 0x51, 0xc9, 0x01, 0x00, 0x00}, 
{0x02, 0x2d, 0x41, 0x3f, 0x35, 0xcc, 0x37, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1e, 0xe2, 0xa3, 0x51, 0xc9, 0x01, 0x00, 0x00}, 
{0x05, 0xcc, 0x37, 0x3f, 0x38, 0x11, 0x2f, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x89, 0x15, 0xaa, 0x51, 0xc9, 0x01, 0x00, 0x00}, 
{0x08, 0x11, 0x2f, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfa, 0x95, 0xc2, 0x51, 0xc9, 0x01, 0x00, 0x00}, 
{0x32, 0x3c, 0x41, 0x3f, 0x35, 0xae, 0x37, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x61, 0x24, 0xcf, 0x51, 0xc9, 0x01, 0x00, 0x00}, 
{0x02, 0x3c, 0x41, 0x3f, 0x35, 0xae, 0x37, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xce, 0x6f, 0xdb, 0x51, 0xc9, 0x01, 0x00, 0x00}, 
{0x25, 0xae, 0x37, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0x96, 0xe1, 0x51, 0xc9, 0x01, 0x00, 0x00}, 
{0x05, 0xae, 0x37, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0b, 0xab, 0xe7, 0x51, 0xc9, 0x01, 0x00, 0x00},
{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0b, 0xab, 0xe7, 0x51, 0xc9, 0x01, 0x00, 0x00}
};

   // 1st report : Valid Transducer Index 2 , Touch , Inrange
   // 2nd report : Valid Transducer Index 2, Touch , Inrange
   // 3rd report : Valid Transducer Index 2 Touch , Inrange
   // 4th report : Valid Transducer Index 2 (Untouch, InRange)
   // 5th report : Valid Transducer Index 2 (Untouch, OutRange) -> Miss
   // 6th report : Valid Transducer Index  -> Miss
   // 7th report : Valid Transducer Index 2 (touch, InRange) ,
   // 8th report : Valid Transducer Index 2 (touch, InRange) ,
   // 9th report : Valid Transducer Index 2 (untouch, OutRange) ,
   // 10th report : Valid Transducer Index  -> Miss
   // 11th report : Valid Transducer Index -> Miss
   // 12th report : Valid Transducer Index 2 (touch, InRange) ,
   // 13th report : Valid Transducer Index 2 (Untouch, OutRange) ,
   // 14th report : Valid Transducer Index 5(Untouch,InRange)
   // 15th report : Valid Transducer Index -> Miss
   // 16th report :  -> Miss


@interface TestDigitizerCollection : IOHIDEventDriverTestCase

@property XCTestExpectation                 * testEventExpectation;

@end

@implementation TestDigitizerCollection

- (void)setUp {

    self.testEventExpectation = [[XCTestExpectation alloc] initWithDescription:@"Expectation: events"];
    
    self.testEventExpectation.expectedFulfillmentCount = 10;
    
    self.hidDeviceDescriptor = [NSData dataWithBytes:descriptor length:sizeof(descriptor)];

    [super setUp];
}

- (void)tearDown {
  
    [super tearDown];
}

- (void)testDigitizerCollection {

    IOReturn status;

    XCTWaiterResult result;

    HIDXCTAssertWithParameters (RETURN_FROM_TEST | COLLECT_LOGARCHIVE, self.eventSystem != NULL);
    
    HIDXCTAssertWithParameters (RETURN_FROM_TEST | COLLECT_LOGARCHIVE, self.userDevice != NULL, "User device description: %@", self.userDeviceDescription);
    
    result = [XCTWaiter waitForExpectations:@[self.testServiceExpectation] timeout:10];
    HIDXCTAssertWithParameters ( RETURN_FROM_TEST | COLLECT_TAILSPIN | COLLECT_IOREG,
                                result == XCTWaiterResultCompleted,
                                "result:%d %@",
                                (int)result,
                                self.testServiceExpectation);

    
    for (NSUInteger index = 0; index < sizeof(reports) / kDigitizerReportByteLength; index++) {
        status = IOHIDUserDeviceHandleReport(self.userDevice, (uint8_t *)&(reports[index][0]), kDigitizerReportByteLength);
        HIDXCTAssertWithParameters ( RETURN_FROM_TEST | COLLECT_HIDUTIL | COLLECT_IOREG | COLLECT_LOGARCHIVE,
                                    status == kIOReturnSuccess,
                                    "IOHIDUserDeviceHandleReport:0x%x",
                                    status);
    }

    result = [XCTWaiter waitForExpectations:@[self.testEventExpectation] timeout:10];
    HIDXCTAssertWithParameters ( RETURN_FROM_TEST | COLLECT_TAILSPIN | COLLECT_IOREG,
                                result == XCTWaiterResultCompleted,
                                "result:%d %@",
                                (int)result,
                                self.testEventExpectation);

    
    NSArray *events = self.events;
    
    NSInteger touchState [11];
    memset (touchState, 0, sizeof(touchState));
    for (NSUInteger eventIndex = 0 ; eventIndex < events.count ; ++eventIndex) {
        NSInteger curTouchState [11];
        memset (curTouchState, 0, sizeof(touchState));
        IOHIDEventRef event = (__bridge IOHIDEventRef)(events[eventIndex]);
        NSArray* children = (NSArray*)IOHIDEventGetChildren (event);
        for (NSUInteger childIndex = 0 ; childIndex < children.count ; ++childIndex) {
            IOHIDEventRef child = (__bridge IOHIDEventRef)children[childIndex];
            CFIndex transducerIndex = IOHIDEventGetIntegerValue(child, kIOHIDEventFieldDigitizerIndex);
            XCTAssertTrue(transducerIndex <= 10, "Transducer index out of range! Event index:%ld, Transducer index:%ld", (unsigned long)eventIndex, transducerIndex);
            CFIndex transducerTouch = IOHIDEventGetIntegerValue(child, kIOHIDEventFieldDigitizerTouch);
            curTouchState[transducerIndex] = transducerTouch + 1;
        }
        //
        // Basic logic is track transition from touch to not present
        //
        for (NSUInteger transducerIndex = 0; transducerIndex < sizeof(touchState); ++transducerIndex) {
            XCTAssertFalse(touchState[transducerIndex] == 2 && curTouchState[transducerIndex] == 0, "Transducer touch lost! Event index:%ld, Transducer index:%ld", (unsigned long)eventIndex, (unsigned long)transducerIndex);
        }
        memcpy(touchState, curTouchState, sizeof (touchState));
    }
}

-(void) handleEvent: (IOHIDEventRef) event fromService:(IOHIDServiceClientRef __unused) service
{
    NSLog(@"Event (%d):%@", ++count,event);
    
    [super handleEvent:event fromService:service];
    
    if (IOHIDEventGetType(event) == kIOHIDEventTypeDigitizer) {
        [self.testEventExpectation fulfill];
    }
}

-(NSDictionary *)  userDeviceDescription
{
    NSDictionary * description = [super userDeviceDescription];
    
    NSMutableDictionary * newDescription = [[NSMutableDictionary alloc] initWithDictionary:description];
    
    newDescription[@"Hidden"] = @(YES);
    
    return newDescription;
}

@end
