App Engine Java Application
Copyright (C) 2010-2012 Google Inc.

#http://notional-buffer-748.appspot.com/

#What you can do
The training diary supports both discussions, message sending, store workout sessions and create future workouts based with locations and post messages on twitter.   

##Workouts
Add workout excersises which you have done the last days, you can also upload a file to the session. The file may contain
whatever you want, it may contain the full session or a document with tips for the next excersise.

##Discussions
You can discuss different topics with other people, and get an idea on how they think about different things.

##Messages
You can send messages back and forth between users, you will only need the other persons username to send him/her a message.

##Workout based on location
You can create a future workout based on location, maybe someone will join you.

##Twitter
You can post on twitter and on the index page you get the most recent twitter postings straight into your feed.
The twitter seacrh is based on # so use #CS263Diary if you want it to show up.

##Sign inn or out
You can sign inn or out using your google account


## Skeleton application for use with App Engine Java.

Requires [Apache Maven](http://maven.apache.org) 3.0 or greater, and JDK 6+ in order to run.

To build, run

    mvn package

Building will run the tests, but to explicitly run tests you can use the test target

    mvn test

To start the app, use the [App Engine Maven Plugin](http://code.google.com/p/appengine-maven-plugin/) that is already included in this demo.  Just run the command.

    mvn appengine:devserver

For further information, consult the [Java App Engine](https://developers.google.com/appengine/docs/java/overview) documentation.

To see all the available goals for the App Engine plugin, run

    mvn help:describe -Dplugin=appengine
