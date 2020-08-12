import UIKit

// Higher order functions are simply functions that can either accept functions or closures as arguments, or return a function/closure.

// Filter

var nums = [1, 2, 3, 4, 5, 6]
nums = nums.filter { $0 >= 4 }
print(nums)

// Map

nums = [1, 2, 3]
nums = nums.map { $0 * 2 }
print(nums)

// Map and Dictionaries

var dictionary = ["first": "Andre", "last": "Muis", "race": "white"]
dictionary = Dictionary(uniqueKeysWithValues: dictionary.map { ($0.key, $0.value.uppercased()) })
print(dictionary)

// CompactMap

let numsWithNil = [10, nil, 34, 56, nil, nil, 100]
let mappedNums = numsWithNil.compactMap { $0 != nil ? $0! * 10 : nil }
print(mappedNums)

// FlatMap

let nestedNums = [[1, 2, 3], [4, 5, 6]]
let mappedNestedNums = nestedNums.flatMap { $0 }
print(mappedNestedNums)

// Reduce

nums = [1, 2, 3]
let result = nums.reduce(0, { $0 + $1 })
print(result)
