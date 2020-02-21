# PhotoAlbumsExample

This example project is made using the Clean Swift architecture, which you can study at https://clean-swift.com

It's an architecture where each "Scene" has 5 components, all based in the VIP cycle:

## 1) View (controller)
The passive view for the app. Communicates to the Interactor sending messages that contain a Request.

## 2) Interactor
Business logic of the app. Communicates with the Presenter sending messages that contain a Response.

## 3) Presenter
Presentation logic of the app. Communicates with the View sending messages that contain a ViewModel (this VM is passive, meaning it does not have any presentation or business logic involved).

## 4) Router
Routing and data passing logic between scenes, it manages Models that represent data in the different endpoints and transform it to business logic objects inside the front-end app (usually a representation with the same structure for simplicity).

## 5) Worker(s)
Each worker works as a use case data layer, with each one for a particular data source. For example, you can have a worker for local data and another one for a remote API.

## A little description for the architecture

The architecture has a one-way communication scheme, where the View only draws data that come from the Presenter and it communicates only with the Interactor (which, according to business, will do one thing or another).

The Interactor can communicate with the Presenter (which decides how the business data given by the interactor is formatted and sent to the View).

The Interactor can also have 0-to-N different workers for sending or getting data from different data sources.

The View also has access to the router and decides where and when to navigate to another scene.

Watch a diagram with all this (and read more) here: https://nerohoop.gitbooks.io/frontend/ios-development/architecture/clean-swift.html
