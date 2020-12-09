//
//  ActivityStruct.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import Foundation

struct RecData: Decodable, Hashable {
    var data: [ParkStruct]
}

struct ParkStruct: Decodable, Hashable {
    var parkCode: String
    var url: String
    var fullName: String
    var description: String
    var latitude: String
    var longitude: String
    var activities: [ActivityStruct]
    var states: String
    var images: [ImageStruct]
    var entranceFees: [EntranceFeeStruct]
}
/*
 {
   "total": "497",
   "limit": "1",
   "start": "0",
   "data": [
     {
       "id": "77E0D7F0-1942-494A-ACE2-9004D2BDC59E",
       "url": "https://www.nps.gov/abli/index.htm",
       "fullName": "Abraham Lincoln Birthplace National Historical Park",
       "parkCode": "abli",
       "description": "For over a century people from around the world have come to rural Central Kentucky to honor the humble beginnings of our 16th president, Abraham Lincoln. His early life on Kentucky's frontier shaped his character and prepared him to lead the nation through Civil War. The country's first memorial to Lincoln, built with donations from young and old, enshrines the symbolic birthplace cabin.",
       "latitude": "37.5858662",
       "longitude": "-85.67330523",
       "latLong": "lat:37.5858662, long:-85.67330523",
       "activities": [
         {
           "id": "13A57703-BB1A-41A2-94B8-53B692EB7238",
           "name": "Astronomy"
         },
         {
           "id": "D37A0003-8317-4F04-8FB0-4CF0A272E195",
           "name": "Stargazing"
         },
         {
           "id": "1DFACD97-1B9C-4F5A-80F2-05593604799E",
           "name": "Food"
         },
         {
           "id": "C6D3230A-2CEA-4AFE-BFF3-DC1E2C2C4BB4",
           "name": "Picnicking"
         },
         {
           "id": "DF4A35E0-7983-4A3E-BC47-F37B872B0F25",
           "name": "Junior Ranger Program"
         },
         {
           "id": "0B685688-3405-4E2A-ABBA-E3069492EC50",
           "name": "Wildlife Watching"
         },
         {
           "id": "5A2C91D1-50EC-4B24-8BED-A2E11A1892DF",
           "name": "Birdwatching"
         },
         {
           "id": "24380E3F-AD9D-4E38-BF13-C8EEB21893E7",
           "name": "Shopping"
         },
         {
           "id": "467DC8B8-0B7D-436D-A026-80A22358F615",
           "name": "Bookstore and Park Store"
         },
         {
           "id": "43800AD1-D439-40F3-AAB3-9FB651FE45BB",
           "name": "Gift Shop and Souvenirs"
         }
       ],
       "topics": [
         {
           "id": "D10852A3-443C-4743-A5FA-6DD6D2A054B3",
           "name": "Birthplace"
         },
         {
           "id": "F669BC40-BDC4-41C0-9ACE-B2CD25373045",
           "name": "Presidents"
         },
         {
           "id": "0D00073E-18C3-46E5-8727-2F87B112DDC6",
           "name": "Animals"
         },
         {
           "id": "957EF2BD-AC6C-4B7B-BD9A-87593ADC6691",
           "name": "Birds"
         },
         {
           "id": "E25F3456-43ED-45DD-93BC-057F9B944F7A",
           "name": "Caves, Caverns and Karst"
         },
         {
           "id": "F0F97E32-2F29-41B4-AF98-9FBE8DAB36B1",
           "name": "Geology"
         },
         {
           "id": "4BE01DC5-52E6-4F18-8C9A-B22D65965F6D",
           "name": "Groundwater"
         },
         {
           "id": "0E1A04CC-EB51-4F18-93D4-EC0B0B4EC1E3",
           "name": "Freshwater Springs"
         },
         {
           "id": "A7359FC4-DAD8-45F5-AF15-7FF62F816ED3",
           "name": "Night Sky"
         }
       ],
       "states": "KY",
       "contacts": {
         "phoneNumbers": [
           {
             "phoneNumber": "2703583137",
             "description": "",
             "extension": "",
             "type": "Voice"
           },
           {
             "phoneNumber": "2703583874",
             "description": "",
             "extension": "",
             "type": "Fax"
           }
         ],
         "emailAddresses": [
           {
             "description": "",
             "emailAddress": "ABLI_Administration@nps.gov"
           }
         ]
       },
       "entranceFees": [
         {
           "cost": "0.00",
           "description": "There is no fee associated with visiting either unit of the park.",
           "title": "Fee Free Park"
         }
       ],
       "entrancePasses": [],
       "fees": [],
       "directionsInfo": "The Birthplace Unit of the park is located approximately 2 miles south of the town of Hodgenville on U.S. Highway 31E South. The Boyhood Home Unit at Knob Creek is located approximately 10 miles northeast of the Birthplace Unit of the park.",
       "directionsUrl": "http://www.nps.gov/abli/planyourvisit/directions.htm",
       "operatingHours": [
         {
           "exceptions": [
             {
               "exceptionHours": {},
               "startDate": "2020-01-01",
               "name": "Park is Closed",
               "endDate": "2020-01-01"
             },
             {
               "exceptionHours": {},
               "startDate": "2020-11-26",
               "name": "Park is Closed",
               "endDate": "2020-11-26"
             },
             {
               "exceptionHours": {},
               "startDate": "2020-12-25",
               "name": "Park is Closed",
               "endDate": "2020-12-25"
             }
           ],
           "description": "The Memorial Building is open 9:00 am - 4:30 pm eastern time with a limited viewing area.  The Visitor Center and grounds of the Birthplace Unit are open 9:00 am - 5:00 pm eastern time with one-way traffic flow and social distancing.\n\n\nThe Boyhood Home Unit at Knob Creek will be closed August 3, 2020, to July 31, 2021, due to the Lincoln Tavern Rehabilitation Project.",
           "standardHours": {
             "wednesday": "9:00AM - 5:00PM",
             "monday": "9:00AM - 5:00PM",
             "thursday": "9:00AM - 5:00PM",
             "sunday": "9:00AM - 5:00PM",
             "tuesday": "9:00AM - 5:00PM",
             "friday": "9:00AM - 5:00PM",
             "saturday": "9:00AM - 5:00PM"
           },
           "name": "Abraham Lincoln Birthplace National Historical Park"
         }
       ],
       "addresses": [
         {
           "postalCode": "42748",
           "city": "Hodgenville",
           "stateCode": "KY",
           "line1": "2995 Lincoln Farm Road",
           "type": "Physical",
           "line3": "",
           "line2": ""
         },
         {
           "postalCode": "42748",
           "city": "Hodgenville",
           "stateCode": "KY",
           "line1": "2995 Lincoln Farm Road",
           "type": "Mailing",
           "line3": "",
           "line2": ""
         }
       ],
       "images": [
         {
           "credit": "NPS Photo",
           "title": "The Memorial Building with fall colors",
           "altText": "The Memorial Building surrounded by fall colors",
           "caption": "Over 200,000 people a year come to walk up the steps of the Memorial Building to visit the site where Abraham Lincoln was born",
           "url": "https://www.nps.gov/common/uploads/structured_data/3C861078-1DD8-B71B-0B774A242EF6A706.jpg"
         },
         {
           "credit": "NPS Photo",
           "title": "The Memorial Building",
           "altText": "The first memorial erected to honor Abraham Lincoln",
           "caption": "The Memorial Building constructed on the traditional site of the birth of Abraham Lincoln.",
           "url": "https://www.nps.gov/common/uploads/structured_data/3C861263-1DD8-B71B-0B71EF9B95F9644F.jpg"
         },
         {
           "credit": "NPS Photo",
           "title": "The Symbolic Birth Cabin of Abraham Lincoln",
           "altText": "The symbolic birth cabin on the traditional site of the birth of Abraham Lincoln.",
           "caption": "The symbolic birth cabin of Abraham Lincoln.",
           "url": "https://www.nps.gov/common/uploads/structured_data/3C86137D-1DD8-B71B-0B978BACD7EBAEF1.jpg"
         },
         {
           "credit": "NPS Photo",
           "title": "Statue of the Lincoln Family in the Visitor Center",
           "altText": "Statue of the Lincoln family in the park's Visitor Center",
           "caption": "Visitors to the park can view the statue of the Lincoln family.",
           "url": "https://www.nps.gov/common/uploads/structured_data/3C8614D1-1DD8-B71B-0B1AF72CA452B051.jpg"
         }
       ],
       "weatherInfo": "There are four distinct seasons in Central Kentucky. However, temperature and weather conditions can vary widely within those seasons. Spring and Fall are generally pleasant with frequent rain showers. Summer is usually hot and humid. Winter is moderately cold with mixed precipitation.",
       "name": "Abraham Lincoln Birthplace",
       "designation": "National Historical Park",
       "lastIndexedDate": ""
     }
   ]
 }
 */

struct ImageStruct: Decodable, Hashable {
    var credit: String
    var title: String
    var caption: String
    var url: String
}
/*
 {
   "credit": "NPS Photo",
   "title": "The Memorial Building with fall colors",
   "altText": "The Memorial Building surrounded by fall colors",
   "caption": "Over 200,000 people a year come to walk up the steps of the Memorial Building to visit the site where Abraham Lincoln was born",
   "url": "https://www.nps.gov/common/uploads/structured_data/3C861078-1DD8-B71B-0B774A242EF6A706.jpg"
 },
 */

struct ActivityStruct: Decodable, Hashable {
    
    var id: String
    var name: String
    
}
/*
 {
   "id": "7CE6E935-F839-4FEC-A63E-052B1DEF39D2",
   "name": "Biking"
 },
 */

struct EntranceFeeStruct: Decodable, Hashable {
    var cost: String
    var description: String
    var title: String
}

/*
 {
   "cost": "0.00",
   "description": "There is no fee associated with visiting either unit of the park.",
   "title": "Fee Free Park"
 }
 */
