# HashMapInShell
HashMap in Shell
## Constructor
### Hashmap.hashmap
Initializes a new empty map

`Hashmap.hashmap NAME`

## Methods
### Hashmap.containsKey
Returns 1 if there is an entry for key in this map.

`Hashmap.containsKey NAME KEY`

### Hashmap.isEmpty
Returns 1 if this map contains no entries.

`Hashmap.isEmpty NAME`

### Hashmap.put
Associates key with value in this map.

`Hashmap.put NAME KEY VALUE`

### Hashmap.get
Returns the value associated with key in this map.

`Hashmap.get NAME KEY`

### Hashmap.size
Returns the number of entries in this map.

`Hashmap.size NAME`
### Hashmap.remove
Removes any entry for key from this map.

`Hashmap.remove NAME KEY`
### Hashmap.clear
Removes all entries from this map

`Hashmap.clear NAME`
### Hashmap.toString
Converts the map to a printable string representation.

`Hashmap.toString NAME`
### Hashmap.keys
Returns a table copy of all keys in this map.

`Hashmap.keys NAME tableNAME`
### Hashmap.values
Returns a table copy of all values in this map.

`Hashmap.values NAME tableNAME`
### Hashmap.add
Add to value associated with key

`Hashmap.add NAME KEY VALUE`
### Hashmap.copy
Copy fMAP to tMAP

`Hashmap.copy fMAP tMAP`
### Hashmap.equals (in progress)
Returns true if the two maps contain the same elements.

`Hashmap.copy fNAME sNAME`


## Examples
### In
```Hashmap.hashmap myMap
Hashmap.put myMap a 1
Hashmap.put myMap b 2
Hashmap.put myMap c 3
Hashmap.add myMap c 10
Hashmap.put myMap w aaa
Hashmap.add myMap w bbb
Hashmap.toString myMap
```
### Out
`[b:2] [c:13] [w:aaabbb] [a:1] `

## Include
```
#!/bin/bash
source $PATH/HashMapInShell/hashmap.sh
```

## O(?)
| Methods        | O(?)          
| ------------- |:-------------:| 
| containsKey   | O(1) | 
| isEmpty       | O(1)      | 
| put            | O(1)      |
| add            | O(1)      |
| get            | O(1)      |
| size            | O(1)      |
| remove         | O(1)      |
| clear          | O(n)      |
| toString       | O(n)      |
| keys            | O(n)      |
| values            | O(n)      |
| copy            | O(n)      |
| equals            | O(n)      |


