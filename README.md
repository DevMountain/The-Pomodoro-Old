The-Pomodoro
============

An iOS pomodoro timer app including history.

##Part 1: Tab Bar Controller

###Step 1: Add a new ViewController as your root view controller
- Add view controllers (Timer, History) to project
- Set each viewcontroller's tabBarItem.title and tabBarItem.image
- Initialize a tab bar controller
- Initialize each view controllers
- Set viewControllers as tab bar controller viewControllers
- Set tab bar controller as root viewcontroller of window

###Part 2: The Timer App

Our two views are going to talk to each other with notifications. 
When the timer runs out of time it will post "RoundCompleteNotification".  
The round needs to post a "CurrentRoundNotification".
When a user selects a round, or when a round completes the current round notification should trigger

###Step 2: Add the interface to the timer view controller
- Add a label and button to the timer screen
- Add outlets for the button and label
- Add an action method to trigger the timer
  - note: We need to disable the button while the timer is going.
  
###Step 3: Count down
- In the action method you need to use performSelector after delay to count down
- You'll need to store the seconds and minutes and decrease the time by a second each time the method gets called.
- When seconds and minutes are zero post the notification.

###Step 4: Add a tableview and datasource methods to the rounds view controller
- Create a tableview property on the rounds view controller and instantiate it
- Add the tableview to the viewcontrollers view
- set self as datasource and delegate
- Add a data array method (times)
- Add datasource methods
- Add a postMinutes method
- In the postMinutes method post round minutes notification
- Add didSelectRowAtIndexPath to change currentRound and reload data and post minutes

###Step 5: Add observer notifications
- Add round view controller as observer of finished notification
  - (void)endRound:(NSNotification *)notification
- Add Timer view controller as observer of roundMinutes notification
  - (void)newRound:(NSNotification *)notification

##Part 2: Styling the Views

###Step 6: Stylize the app
- Update navigationBar color
- Update navigationBar title font and text color
- Update the tint color on the tab bar
- Update the background color on the tab bar
- Add images to the tableViewCells

###Black Diamond:
- Allow the user to pause the button
- The timer could constantly push what time it is, and the rounds have a label
