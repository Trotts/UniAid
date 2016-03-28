{\rtf1\ansi\ansicpg1252\cocoartf1404\cocoasubrtf460
{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red0\green116\blue0;\red170\green13\blue145;\red92\green38\blue153;
\red46\green13\blue110;\red63\green110\blue116;\red38\green71\blue75;\red196\green26\blue22;\red28\green0\blue207;
}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab529
\pard\tx529\pardeftab529\pardirnatural\partightenfactor0

\f0\fs22 \cf2 \CocoaLigature0 //\
//  CourseDetailsView.swift\
//  UniAid\
//\
//  Created by Loai L. Felemban on 2016-03-18.\
//  Copyright \'a9 2016 igor epshtein. All rights reserved.\
//\
\cf0 \
\cf3 import\cf0  Foundation\
\cf3 import\cf0  UIKit\
\cf3 import\cf0  CoreData\
\
\
\cf3 class\cf0  CDView: \cf4 UIViewController\cf0 , \cf4 UITableViewDataSource\cf0 , \cf4 UITableViewDelegate\cf0 \{\
  \
  \
  \cf3 @IBOutlet\cf0  \cf3 var\cf0  open: \cf4 UIBarButtonItem\cf0 !\
  \cf3 @IBOutlet\cf0  \cf3 weak\cf0  \cf3 var\cf0  details: \cf4 UITableView\cf0 !\
  \
  \cf3 var\cf0  courseVar = [\cf4 String\cf0 ]()\
\
  \cf3 override\cf0  \cf3 func\cf0  viewDidLoad() \{\
    \cf3 super\cf0 .\cf5 viewDidLoad\cf0 ()\
    \
    \cf6 open\cf0 .\cf4 target\cf0  = \cf3 self\cf0 .\cf7 revealViewController\cf0 ()\
    \cf6 open\cf0 .\cf4 action\cf0  = \cf4 Selector\cf0 (\cf8 "revealToggle:"\cf0 )\
    \
    \cf3 self\cf0 .\cf4 view\cf0 .\cf5 addGestureRecognizer\cf0 (\cf3 self\cf0 .\cf7 revealViewController\cf0 ().\cf7 panGestureRecognizer\cf0 ())\
  \
    \cf6 details\cf0 .\cf4 delegate\cf0  = \cf3 self\cf0 \
    \cf6 details\cf0 .\cf4 dataSource\cf0  = \cf3 self\cf0 \
    \
    \cf6 courseVar\cf0  = [\cf8 "Name"\cf0 , \cf8 "Number"\cf0 , \cf8 "Inst. Name"\cf0 , \cf8 "Inst. Email"\cf0 , \cf8 "Schedule"\cf0 , \cf8 "Location"\cf0 ]\
   \cf7 displayCourse\cf0 ()\
  \}\
  \
  \cf3 override\cf0  \cf3 func\cf0  didReceiveMemoryWarning() \{\
      \cf3 super\cf0 .\cf5 didReceiveMemoryWarning\cf0 ()\
      \cf2 // Dispose of any resources that can be recreated.\
\cf0   \}\
\
  \cf3 func\cf0  tableView(tableView: \cf4 UITableView\cf0 , numberOfRowsInSection section: \cf4 Int\cf0 ) -> \cf4 Int\cf0  \{\
      \cf3 return\cf0  \cf6 courseVar\cf0 .\cf4 count\cf0 \
  \}\
  \
  \cf3 func\cf0  tableView(tableView: \cf4 UITableView\cf0 , cellForRowAtIndexPath indexPath: \cf4 NSIndexPath\cf0 ) -> \cf4 UITableViewCell\cf0  \{\
    \cf3 let\cf0  cell = tableView.\cf5 dequeueReusableCellWithIdentifier\cf0 (\cf6 courseVar\cf0 [indexPath.\cf4 row\cf0 ], forIndexPath: indexPath) \cf3 as\cf0  \cf4 UITableViewCell\cf0 \
        cell.\cf4 textLabel\cf0 ?.\cf4 text\cf0  = \cf6 courseVar\cf0 [indexPath.\cf4 row\cf0 ]\
        \cf3 return\cf0  cell\
  \}\
    \
    \cf3 func\cf0  displayCourse()\{\
        \
        \cf2 //we will use appDelegate to connect to our core data\
\cf0         \cf2 //this is the default app delegate\
\cf0         \cf3 let\cf0  appDel: \cf6 AppDelegate\cf0  = \cf4 UIApplication\cf0 .\cf5 sharedApplication\cf0 ().\cf4 delegate\cf0  \cf3 as\cf0 ! \cf6 AppDelegate\cf0 \
        \
        \cf2 //create a context\
\cf0         \cf2 //a handler for us to be able to access the database\
\cf0         \cf3 let\cf0  context: \cf4 NSManagedObjectContext\cf0  = appDel.\cf6 managedObjectContext\cf0 \
        \
        \cf2 //add user to db\
\cf0         \cf2 //first we need to describe our entity that we would want to enter our user to\
\cf0         \cf3 var\cf0  newCourse = \cf4 NSEntityDescription\cf0 .\cf5 insertNewObjectForEntityForName\cf0 (\cf8 "Course"\cf0 , inManagedObjectContext: context)\
\
        \
        \cf2 //retrive data\
\cf0         \cf2 //do that by creating a request\
\cf0         \cf3 let\cf0  request = \cf4 NSFetchRequest\cf0 (entityName: \cf8 "Course"\cf0 )\
        \
        \cf2 //u need this to actually return the data itself and not just info about it\
\cf0         request.\cf4 returnsObjectsAsFaults\cf0  = \cf3 false\cf0 \
        \
        \cf3 do\cf0  \{\
            \cf2 //now we need a var to store data that we get back from it\
\cf0             \cf3 let\cf0  results = \cf3 try\cf0  context.\cf5 executeFetchRequest\cf0 (request)\
            \
            \
            \cf3 if\cf0  results.\cf4 count\cf0  > \cf9 0\cf0  \{\
                \cf5 print\cf0 (\cf8 "Course Details"\cf0 )\
                \cf5 print\cf0 (results.\cf4 count\cf0 )\
                \
                \cf2 //by defualt results will contain ... therefore cast it\
\cf0                 \cf3 for\cf0  result \cf3 in\cf0  results \cf3 as\cf0 ! [\cf4 NSManagedObject\cf0 ] \{\
                    \
                    \cf6 courseVar\cf0 [\cf9 1\cf0 ] = \cf8 "amr"\cf0 \
                    \cf2 //now we can access the info\
\cf0                     \
                    \
                    \cf5 print\cf0 (\cf8 "Found ya loai"\cf0 )\
                    \
                    \
                    \
                    \
                    \
                    \
                \}\
            \}\
            \
        \}\
        \cf3 catch\cf0  \{\
            \cf5 print\cf0 (\cf8 "error fetch failed "\cf0 )\
        \}\
        \
        \
\
        \
        \
        \
        \
        \
    \}\
    \
\
\}}