The-Pomodoro
============

An iOS pomodoro timer app including history. A pomodoro app has 'Rounds' of time for focusing and taking breaks. Take a look at some sample Pomodoro apps in the app store, or run the solution code to see what you are building.

For more information and examples of Pomodoro:

* [Wired In](https://itunes.apple.com/US/app/id953366135)
* [LifeHacker on Pomodoro](http://lifehacker.com/productivity-101-a-primer-to-the-pomodoro-technique-1598992730)

Remember, the solution code is here as a resource. Do not copy and paste. Understand, walk through it line by line, and write it yourself.

##Part 1: Tab Bar Controller

###Step 1: Initialize and Add the UITabBarController as the RootViewController
- Add view controllers (```TimerViewController```, ```RoundsViewController```) to project (include a XIB for the ```TimerViewController```)
- In the app delegate, initialize the ```TimerViewController``` and ```RoundsViewController```
- Set each viewcontroller's ```tabBarItem.title``` and ```tabBarItem.image``` (find two fitting icons on icons8.com, import them into the Images.xcassets file)
- Initialize a UITabBarController
- Set the ```viewControllers``` property on the UITabBarController to an array of your ```TimerViewController``` and ```RoundsViewController``` instances
- Set the tab bar controller as ```rootViewController``` of ```window```

###Part 2: The Timer App Overview

The classes within our app are going to talk to each other with NSNotifications. 

- When each second passes it will post a notification named ```SecondTickNotification```. 
- When the timer runs out of time it will post a notification named ```RoundCompleteNotification```.  
- The round needs to post a ```CurrentRoundNotification``` that tells the rest of the app what round is starting. 
- When a user selects a round, or when a round completes the ```CurrentRoundNotification``` should trigger 

###Step 2: Add the interface to the TimerViewController

The Timer View Controller displays a countdown of the current round, and has a Start button to start the timer.

- Add a label and button to the timer screen using a XIB
- Add IBOutlets for the ```timerButton``` and ```timerLabel```
- Add an IBAction for the ```timerButton``` that will trigger the timer
  - note: We need to disable the button while the timer is going.
 
###Step 3: Count down
- Use a separate [POTimer](https://github.com/DevMountain/The-Pomodoro/blob/solution/The%20Pomodoro/POTimer.m) class to manage the timer. This timer class hold the minutes and seconds and has a method to begin counting down. 
- Pay attention to what the class does for you, walk through each method, understand what it is doing.
- Write your own timer class:
  - Create a ```POTimer``` Class as a Shared Instance
  - Add NSInteger properties for ```minutes``` and ```seconds```
  - Add a private BOOL property called ```isOn``` to allow you to check if the timer is active
  - Add a public method called ```startTimer```
    - ```startTimer``` should turn ```isOn``` to YES
    - ```startTimer``` should call ```isActive``` (which you will write below)
  - Add a public method called ```cancelTimer```
    - ```cancelTimer``` should turn ```isOn``` to NO
    - ```cancelTimer``` should cancel previous perform requests
  - Add a private method called ```endTimer```
    - ```endTimer``` should turn ```isOn``` to NO and send a ```RoundCompleteNotification``` that the timer has finished
  - Add a private method called ```decreaseSecond```
    - ```decreaseSecond``` should decrease one second from the remaining time and send a ```SecondTickNotification``` notification that one second passed
    - don't forget to change minutes, if necessary
    - if the timer has elpased, then call ```endTimer```
  - Add a private method called ```isActive```
    - ```isActive``` should check if the timer is on (```self.isOn```), and if so, call the ```decreaseSecond``` method, then it should call itself in one second
- Add a method to your ```TimerViewController``` to update the Timer Label.
- Subscribe your ```TimerViewController``` to run the update label method on the ```SecondTickNotification```.
  - ```registerForNotifications``` should be placed in a custom init method. 

###Step 4: Add a tableview and datasource methods to the rounds view controller
- Add a property ```currentRound``` of type NSInteger on ```RoundsViewController```
- Create a ```tableView``` property on the ```RoundsViewController``` and instantiate it
- set ```self``` as datasource and delegate of ```tableView```
- Add the ```tableView``` to the ```RoundsViewController```'s ```view```
- Add a method that returns a static array of times for each round  
  - ```@[@25, @5, @25, @5, @25, @5, @25, @15];```
- Add datasource methods to display cells that the user can use to select which round they want to start
- Add a method ```roundSelected```
  - that will update the minutes and seconds on the ```[POTimer sharedInstance]``` from the ```currentRound``` property
  - that will send a ```CurrentRoundNotification``` notification
- Add didSelectRowAtIndexPath
  - set the ```currentRound``` property to the indexPath   
  - and call ```roundSelected```

###Step 5: Add observer notifications
- Add RoundViewController as observer of ```RoundCompleteNotification```
  - ```-(void)roundComplete```
    - if the current round is not the last round 
      - increment the ```currentRounds``` property
      - select the correct row on the tableview
      - call ```roundSelected```
- Add TimerViewController as observer of ```CurrentRoundNotification``` notification
  - ```-(void)newRound```
    - update ```timerLabel```
    - enable ```timerButton```

##Part 3: Styling the Views

###Step 6: Stylize the app
- Update navigationBar color
- Update navigationBar title font and text color
- Update the tint color on the tab bar
- Update the background color on the tab bar
- Add images to the tableViewCells

###Black Diamond:
- Allow the user to pause the button
- The timer could constantly push what time it is, and the rounds have a label
- Create a rounds object, save rounds, and build a history view to see when you worked
