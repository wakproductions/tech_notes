# Liskov Substution, Duck Typing, and Strong Types in Ruby

* Problem with duck typing - sometimes objects are very similar and candidates for duck typing, but the more complex the data structure, the more likely it is that you'll run into a compatibility problem and reference something that isn't there.
* Common problem is hash keys. Sometimes you have nested data in hashes, but the keys are sometimes strings, other times hashes. Data type conversion is an issue. "1234" vs 1234.

Possible solutions:

1) Type checking and type conversions, and safe navigation operator everywhere.
    Pros: It works
    Cons: Code gets complex and messy and easy to miss something, leading to cryptic errors. Scales poorly.

2) Hashie library
    Pros: Deep conversion of objects. Can reference objects as symbols, strings, or method calls
    Cons: Third party dependency.  
    
    * I used this at Avant for credit line interactor and it worked very well.  

3) Struct
    Pros: 
        * Native to Ruby. 
        * Automatically converts hash keys from string to keys - fixes conversion issues
        * Automatic coersion of types
        * Can reference dot
    
    Cons: Complicated to set up.