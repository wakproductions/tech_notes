## Reformat a dict so that it's more readable

```
import pprint
pprint.pprint(my_dict)
```
https://bard.google.com/chat/cbd5f418c643d0bc

## String interpolations
```
name = 'Alice'
print(f'Hello, {name}!')   # Uses single quotes outside — inside can have double quotes
print(f"She said, \"Hello, {name}!\"")  # Escape double quotes inside a double quoted f-string

print(f'''He replied, "That's awesome, {name}!"''')
print(f"""He replied, 'That's awesome, {name}!'"""")

print("Hello, {}".format(name))
print('She said, "Hello, {}!"'.format(name))

print("Hello, %s!" % name)
print('She said, "Hello, %s!"' % name)

print('Hello, ' + name + '!')
print("She said, \"Hello, " + name + "!\"")
```


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


## Underscore variables

https://stackoverflow.com/questions/8920341/finding-a-list-of-all-double-underscore-variables

__name__: name of the current modules, has the value "__main__" when script is run directly.
__builtins__: This variable refers to the module containing all built-in functions, exceptions, and other objects that are always available.
__file__: This variable holds the pathname of the file from which the module was loaded.
__package__: This variable indicates the name of the package to which a module belongs. If the module is not part of a package, it will be None.
__doc__: This variable holds the documentation string (docstring) of a module, class, or function.
__all__: This variable is a list of strings defining the public interface of a module. When from module import * is used, only the names listed in __all__ are imported.
__dict__: This variable is a dictionary or other mapping object used to store an object's (module, class, or instance) writable attributes.
