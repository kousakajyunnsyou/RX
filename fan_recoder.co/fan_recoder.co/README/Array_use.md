#  Array 数组


## 1. filter
    let array = Array(5...25)
    var anotherArray = [Int]()
     
    for i in array{
        if i > 20{
           anotherArray.append(i)
        }
    }
    print(anotherArray) //[21, 22, 23, 24, 25]
    
/// 上面已经实现功能了，但是我们可以使用更简单的方式，那就是 filter函数， 可以大大缩减相关的代码量，如下：
    
    let secondArray = array.filter { (i: Int) -> Bool in
        return i > 20  
    }
    print(secondArray) //[21, 22, 23, 24, 25]
    
    
/// 通过Swift提供的闭包简化写法，我们可以进一步精简：

    let thirdArray = array.filter ({$0 > 20})
    print(thirdArray) // [21, 22, 23, 24, 25]
----------------------------------------------------------

## 2. 找到数组中最大（或最小的元素）

    let numberArray = [10,-22,753,55,137,-1,-279,1034,77]
/// 最小值

    numberArray.sort().first
    numberArray.reduce(Int.max, combine: min)
    numberArray.minElement
    
/// 最大值
    
    numberArray.sort().last
    numberArray.reduce(Int.min, combine: max)
    numberArray.maxElement()
    

