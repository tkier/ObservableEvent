# ObservableEvent

## About

ObservableEvent is a simple observable pattern implemented in Swift.

## Documentation

For full documentation see the blog post [Observable Events in Swift](http://endlesswavesoftware.com/blog/observable-events-in-swift/)

## Example

#### Creating an ObservableEvent

```swift
let scoreChangedEvent = ObservableEvent<Int>()
```

#### Adding an Observer

```swift
let removeScoreObserver = scoreChangeEvent.addObserver{ score in
        // process new score
	}
```

#### Notifying Observers

```swift
scoreChangedEvent.notifyObservers(1000)
```

#### Removing an Observer

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
