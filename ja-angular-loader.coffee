app.directive 'jaAngularLoader', ()->

  scope = {
    loader: "=jaAngularLoader"
  }

  template = """
    <div class="loader" ng-show="loader.condition" ng-cloak>
      <div class="loader-image"></div>
      <div class="loader-message">
        <span ng-if="loader.message" ng-bind="loader.message"></span>
        <ul ng-if="loader.history">
          <li ng-if="$index < loader.history.length - 1" ng-repeat="message in loader.history track by $index" ng-bind="message"></li>
        </ul>
      </div>
    </div>
  """

  {scope, template, replace: true}