# ObservableEvent

## About

ObservableEvent is a simple observer pattern implemented in Swift. For more information on why ObservableEvent was created and thinking behind it, see the blog bost: [Observable Events in Swift](http://endlesswavesoftware.com/blog/observable-events-in-swift/)

## Installation
The ObservableEvent framework can be installed using CocoaPods. Add the following line to your project pod file and the run "pod install".

```text
	pod 'ObservableEvent', '~> 1.0.0'
```

## Using ObservableEvent

#### Creating an ObservableEvent

To create an observable event create an instances of the ObservableEvent class. ObservableEvents are typed with the data type that is being observered. When notifiying oberservers a value of that type will be sent with the notification. 

For example, a game might have an observable event that would notify observers whenever the score changes. Since the score is an Int type creating the ObservableEvent would look like:

```swift
let scoreChangedEvent = ObservableEvent<Int>()
```

It is possible to create an ObservableEvent that can notifiy observers with multiple values. Simply use a tuple for the generic type. For example:

```swift
let scoreChangedEvent = ObservableEvent<(score:Int, isHighScore:Bool)>()
```

It is even possible to create ObeservableEvents without any type. Simply use Void for the generic type:

```swift
let myEvent = ObservableEvent<Void>()
```

#### Notifying Observers

To notify all oberservers of the event call the event's notifyObservers method passing a value for the event. In our game score example we can notify all observers that the score changed and pass the new score to the observers as follows:

```swift
scoreChangedEvent.notifyObservers(1000)
```

If you are using a tuple as the genric type:

```swift
scoreChangedEvent.notifyObservers((score:25, isHighScore:false))
```

Or with no generic type:

```swift
myEvent.notifyObservers()
```

#### Adding an Observer

To add an observer for an event call the event's addObserver method, passing a closure that will be called when notifyObservers is called. The addObserver call returns a closure that can be can called later to remove the observer (see below for more details). The returned closure should be saved so that it can be called later.

In our game score event example, an observer might look like:

```swift
let removeScoreObserver = scoreChangeEvent.addObserver { score in
    // process new score
}
```

Of for if the event had a tuple type:

```swift
let removeScoreObserver = scoreChangeEvent.addObserver { score, isHighScore in
    // process new score and isHighScore
}
```

Or if the event is using Void for the generic type:

```swift
let removeMyEventObserver = scoreChangeEvent.addObserver { 
    // event fired, do something
}
```

#### Removing an Observer

To remove an observer call the closure that was returned when addObserver was called.  For example:

```swift
removeScoreObserver()
```

## License
Copyright 2016 Endless Wave Software LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
