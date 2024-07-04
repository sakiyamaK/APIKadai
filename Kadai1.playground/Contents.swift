import UIKit

let arr = Array(1...100)

for v in arr {
    if v%2==0 {
        print(v)
    }
}

for v in arr where v%2==0 {
    print(v)
}

let arr2 = arr.filter({ v in v%2 == 0})
for v in arr2 {
    print(v)
}
