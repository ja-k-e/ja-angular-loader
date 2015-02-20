# Example DOM Reference
Pass a loader object to the directive.

```
  <div ja-angular-loader="loader"></div>
```

# The Loader Object
The loader object should at least include a condition boolean value to toggle `ng-show` on the loader container. You can optionally pass a message and/or history array.

```
  $scope.loader = {
    condition: required boolean
    message: optional string
    history: optional array of strings
  }
```

# Example Loader Object Manipulation:
Initially set the loader object to minimum blank required values

```
  $scope.loader = {
    condition: false
    message: null
    history: []
  }
```

I like to feed the loader object via a method that takes the loader object, a message (a noun like 'Results'), present tense prefix (like 'Getting'), and past tense prefix (like 'Got'). From these parameters, I can pass the message as present tense and push the past tense to the history.

```
  feedLoader = (loader, message, present, past) ->
    unless $scope.loader.condition then $scope.loader.condition = true # only sets condition to true if it needs to
    $scope.loader.message = [present, message].join(' ') # set the message
    $scope.loader.history.push [past, message].join(' ') # add message to history
```

We then need a method to clear the loader object.

```
  clearLoader = (loader) ->
    $scope.loader = {
      condition: false
      message: null
      history: []
    }
```

Then we can use these functions at whatever points in a process we need to.

```
    # dummy process function
    processData = () ->
        # add first message (will initiate display of loader)
        feedLoader($scope.loader, 'Request', 'Making', 'Made')

        # dummy request function
        makeRequest().then (res) ->
            # update loader to second message (same method as initial)
            feedLoader($scope.loader, 'Response', 'Processing', 'Processed')
    
            # dummy response function
            processResponse(res).then () ->
                # clear the loader now that everything has been processed
                clearLoader($scope.loader) 
```

# Loader Template:

You can style/organize the loader template in the directive as you see fit. It has a main wrapper with `ng-show` on the condition, displays the message in a `span` and history in a `ul`.

```
    <div class="loader" ng-show="loader.condition" ng-cloak>
        <div class="loader-image"></div>
        <div class="loader-message">
            <span ng-if="loader.message" ng-bind="loader.message"></span>
            <ul ng-if="loader.history">
                <li ng-if="$index < loader.history.length - 1" 
                    ng-repeat="message in loader.history track by $index" 
                    ng-bind="message">
                </li>
            </ul>
        </div>
    </div>
```