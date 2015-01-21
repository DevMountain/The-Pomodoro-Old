The-Pomodoro
============

An iOS pomodoro timer app including history. A pomodoro app has 'Rounds' of time for focusing and taking breaks. Take a look at some sample Pomodoro apps in the app store, or run the solution code to see what you are building.

Remember, the solution code is here as a resource. Do not copy and paste. Understand, walk through it line by line, and write it yourself.

##Part 1: Tab Bar Controller

###Step 1: Add a new ViewController as your root view controller
- Add view controllers (TimerViewController, RoundsViewController) to project (include a XIB for the TimerViewController)
- Initialize the TimerViewController and RoundsViewController
- Set each viewcontroller's tabBarItem.title and tabBarItem.image
- Initialize a tab bar controller
- Set view controllers as tab bar controller viewControllers
- Set tab bar controller as root viewcontroller of window

###Part 2: The Timer App

The classes within our app are going to talk to each other with NSNotifications. 
When each second passes it will post a notification named "SecondTickNotification".
When the timer runs out of time it will post a notification named "RoundCompleteNotification". 
The round needs to post a "CurrentRoundNotification".
When a user selects a round, or when a round completes the current round notification should trigger

###Step 2: Add the interface to the TimerViewController

The Timer View Controller displays a countdown of the current round, and has a Start button to start the timer.

- Add a label and button to the timer screen using a XIB
- Add IBOutlets for the button and label
- Add an IBAction for the button that will trigger the timer
  - note: We need to disable the button while the timer is going.
  
###Step 3 (Choose One): Count down
- In the action method you need to use the method performSelector:afterDelay: to count down the seconds.
- You'll need to store the seconds and minutes and decrease the time by a second each time the method gets called.
- When seconds and minutes are zero post the notification.
- Subscribe your TimerViewController to run the updateLabel method on the SecondTickNotification.
 
###Step 3 (Choose One): Count down
- Use the separate POTimer class to manage the timer. This timer class hold the minutes and seconds and has a method to begin counting down. 
- Pay attention to what the class does for you, walk through each method, understand what it is doing.
- Add a method to your TimerViewController to update the Timer Label.
- Subscribe your TimerViewController to run the updateLabel method on the SecondTickNotification.

###Step 4: Add a tableview and datasource methods to the rounds view controller
- Create a tableview property on the RoundsViewController and instantiate it
- Add the tableview to the viewcontrollers view
- set self as datasource and delegate
- Add a method that returns a static array of times for each round (25-5-25-5-25-5-25-15)
- Add datasource methods to display cells that the user can use to select which round they want to start
- Add a method that will send a postMinutes notification
- Post the postMinutes notification
- Add didSelectRowAtIndexPath to change currentRound, reload data on the table view, and post minutes for the timer class to update the label on the TimerViewController

###Step 5: Add observer notifications
- Add RoundViewController as observer of finished notification
  - (void)endRound:(NSNotification *)notification
- Add TimerViewController as observer of roundMinutes notification
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
