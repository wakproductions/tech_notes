# Potential settings

* Format floats as readable numbers
* Wrap lines at size



```ruby
{:carpet=>{:quantity=>0.2533e2, :material_cost=>0.526e1, :labor_cost=>0.305e1, :profit_cost=>0.115e1, :tax_cost=>0.0},
 :pad=>{:quantity=>0.2533e2, :material_cost=>0.106e1, :labor_cost=>0.15e0, :profit_cost=>0.4e0, :tax_cost=>0.0},
 :haul_away=>{:quantity=>0.2533e2, :material_cost=>0.48e0, :labor_cost=>0.0, :profit_cost=>0.0, :tax_cost=>0.0},
 :cove=>{:quantity=>0.12e2, :material_cost=>0.63e0, :labor_cost=>0.45e0, :profit_cost=>0.51e0, :tax_cost=>0.0},
 :metal=>{:quantity=>0.8e1, :material_cost=>0.746e1, :labor_cost=>0.0, :profit_cost=>0.87e0, :tax_cost=>0.0},
 :glue_down=>{:quantity=>0.2533e2, :material_cost=>0.0, :labor_cost=>0.75e0, :profit_cost=>0.7e0, :tax_cost=>0.0},
 :take_up=>{:quantity=>0.0, :material_cost=>0.0, :labor_cost=>0.0, :profit_cost=>0.0, :tax_cost=>0.0},
 :occupied=>{:quantity=>0.0, :material_cost=>0.0, :labor_cost=>0.12e0, :profit_cost=>0.0, :tax_cost=>0.0},
 :trip_charge=>{:quantity=>0.0, :material_cost=>0.0, :labor_cost=>0.25e2, :profit_cost=>0.1e2, :tax_cost=>0.0},
 :floor_prep=>{:quantity=>0.2e1, :material_cost=>0.0, :labor_cost=>0.25e2, :profit_cost=>0.1e2, :tax_cost=>0.0},
 :upholstered_stairs=>{:quantity=>0.4e1, :material_cost=>0.0, :labor_cost=>0.25e1, :profit_cost=>0.0, :tax_cost=>0.0},
 :tack_strip=>{:quantity=>0.3e1, :material_cost=>0.0, :labor_cost=>0.75e0, :profit_cost=>0.25e0, :tax_cost=>0.0}}
```

When writing unit test coverage for such data structures, sometimes it’s convenient to write a single test that checks over the entire data set by using a hash.

Take this following data structure for example. It’s a list of materials and costs associated with them. If I want to write a test expectation for a piece of data that, it could be cumbersome to type. I’d much rather have the computer generate a hash like this, look it over manually until I get it right, and then copy and paste it into my test file.  However, the way Ruby prints a Hash like this on screen doesn’t format quite perfectly when you copy and paste it into a code file.

For one, floating point numbers are displayed in exponential format, which isn’t as nicely readable to humans. And other data types such as dates and timestamps can’t be loaded back into the system in the same way that Ruby prints the output. 

Also, the style of the way Ruby displays hash keys with the equals/greater than sign isn’t so efficient on space. I much prefer the singular colon format. Then there’s the issue of text wrapping, which I think could be better.

The Ruby ecosystem has a few popular options for dealing with the pretty printing of hashes, such as the “pretty print” function. There's also the "awesome print" Ruby gem. But, through experience I've been unsatisfied with the output generated by either of these routines. So how about we go about building Ruby hash printing function from scratch? 