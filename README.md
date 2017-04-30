# ObservableEvent

## About

ObservableEvent is a simple observer pattern implemented in Swift. For more information on why ObservableEvent was created and thinking behind it, see the blog bost: [Observable Events in Swift](http://endlesswavesoftware.com/blog/observable-events-in-swift/)

## Installation
The ObservableEvent framework can be installed using CocoaPods. Add the following line to your project pod file and the run "pod install".

```text
	pod 'ObservableEvent', '~> 2.0.0'
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

To add an observer for an event call the event's observe method, passing a closure that will be called when notifyObservers is called. The observe call returns a Disposable object that can be used to remove the observer (see below for more details). 

In our game score event example, an observer might look like:

```swift
let scoreDisposable = scoreChangeEvent.observe { score in
    // process new score
}
```

Or if the event had a tuple type:

```swift
let scoreDisposable = scoreChangeEvent.observe { score, isHighScore in
    // process new score and isHighScore
}
```

Or if the event is using Void for the generic type:

```swift
let myEventDispsoable = myEvent.observe { 
    // event fired, do something
}
```

#### Removing an Observer

To remove an observer call the dispose method on the Disposable object that was returned by the observe method. For example:

```swift
scoreDisposable.dispose()
```

If you are observing several events and have multiple Disoposable objects, it is more convient to use a DisposeBag to remove all the observers at once. First create an instance of DisposeBag. Then when adding an observer, add the returned disposble to the bag by calling the diposeWith(bag) method. For example:

```swift
let bag = DisposeBag()

scoreChangeEvent.observe { score, isHighScore in
    // process new score and isHighScore
}.disposeWith(bag)

myEvent.observe { 
    // event fired, do something
}.disposeWith(bag)
```

Now when the bag is deallocated all its contents will automatically be disposed causing all the observers to be removed. You can also explicitly call the dispose() method on the bag itself to dispose all of its contents.

## Property
ObservableEvents are often used to provide change notifications for when a specific variable changes. It would typically look something like:

```swift
var score: Int = 0 {
	didSet {
		scoreChangedEvent.notififyObservers(score)
	}
}
let scoreChangedEvent = ObservableEvent<Int>()
```

The Property class provides a convient way to implement this pattern by combining the variable instance and the observerable event into a single class.

#### Using Properties

To create a property, create an instance of the Property class, passing the properties initial value to the intialaizer. The above score example can be implementing using a Property as follows:

```swift
var score: Property(0)
```

To access the value of the Property use its value property:

```swift
let currentScore = score.value
```

You set the property's value by assigning to its value property. Whenever a property's value is set, it will automatically notify all observers.

```swift
score.value = currentScore + 100
```

To add an observer to a property call its observe method. It works identical to the observe method on ObservableEvent, passing in a closure and returning a Disposable:


```swift
score.observe { score in
	// process the score
}.disposeWith(bag)
```

An important note about properties... the observer closure will be called with the current value of the property as soon as the observe method is called. This means that property observers are called with the current value of the property and any future values. 

## License
Copyright 2017 Endless Wave Software LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
