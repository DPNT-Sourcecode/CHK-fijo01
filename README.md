# My Notes for "Developer Insights" Tech Test

- Testing framework is MiniTest. Found a quick reference: https://blog.teamtreehouse.com/short-introduction-minitest

## CHK_R5
"_buy any 3 of (S,T,X,Y,Z) for 45_"

I had a few possible approachs to tackle this one. Mainly they come under the following options:  
  * **['S', 'T', 'X', 'Y', 'Z'].repeated_permutation(3).to_a**  
    *1. Calculate all the possible combinations that qualify for the group offer  
    2. From item_list array, collect sub-arrays of 3 elements each, consisting of some combination of S,T,X,Y,Z  
    3. if this sub-array matches any of the calculated permutations, apply the discount*
     
    ***Abandoned this approach because there's no need to know all the possible combinations***
   
  * Extract any S, T, X, Y, or Z that are in the item_list, into its own array:
    *1. If array length isn't multiple of 3, return elements back to item_list, until it is
    2. Maximize discount by removing from consideration (for discounting) the cheapest items (i.e. X)
    3. Z is most expensive of the discounted group so only remove it from discount group as a last resort (e.g. ZZZZ, 3Z for 45, 1Z charged at 21* 

