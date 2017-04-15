Hashmap.primeNumbers() {
    primes=(227 457 919 1847 3697
    7411 14827 29663 59333 118669
    237343 474707 949423 1898861 3797723
    7595453 15190919 30381851)
    echo ${primes[$1]}
}

Hashmap.hashmap() {
    local size=$(Hashmap.primeNumbers 0)
    eval ${1}[0]=0
    eval ${1}[1]=$size
    eval ${1}[2]=0
    eval ${1}[3]=0
}
