## Reformat a dict so that it's more readable

```
import pprint
pprint.pprint(my_dict)
```
https://bard.google.com/chat/cbd5f418c643d0bc

## Working with JSON

```
json.dumps(your_dict, indent=4)
```

```
json.loads(my_string)
```

# Comprehensions
https://www.youtube.com/watch?v=I72uD8ED73U
```
people: list[str] = ['Jim', 'Charly', 'Steph', 'Mario', 'Luigi']

# No comprehension
long_names: list[str] = []
for person in people:
    if len(person) > 5:
        long_names.append(person)

# With comprehension
long_names: list[:str] = [p for p in people if len(p) > 5]
```


## Debugging
`breakpoint()` - equivalent to binding.pry


## Find methods on an object
```
obj = MyClass()
methods_list = [method for method in dir(obj) if callable(getattr(obj, method)) and not method.startswith("__")]
print("Methods using dir():", methods_list)
```

## Type checking

Run type checking from console:
`$ mypy main.py`
