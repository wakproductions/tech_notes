## How to map an object

```
newObj = {};
for (let [key, value] of Object.entries($scope.materialForm.materials)) { newObj[key] = value.totalMaterial }
```


## Stuff I have to keep looking up again

### Fat Arrow Vs Function

https://medium.com/@thejasonfile/es5-functions-vs-es6-fat-arrow-functions-864033baa1a

function() has its own this context. If used within an object, this won't refer to the containing object where as `()=>{ this };` does refer to parent `this` context. 

 
