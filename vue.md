## Running the webpack development server

Doing it using vue-cli tools.

```
yarn serve
```


### Action vs Mutation

https://stackoverflow.com/questions/39299042/vuex-action-vs-mutations

Vuex mutations are essentially events: each mutation has a name and a handler.
Actions: Actions are just functions that dispatch mutations.

* mutation is the only way to modify state
* mutation doesn't care about business logic, it just cares about "state"
* action is business logic
* action can dispatch more than 1 mutation at a time, it just implements the business logic, it doesn't care about data changing (which manage by mutation)