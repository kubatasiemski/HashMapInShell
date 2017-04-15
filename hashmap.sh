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

Hashmap.getMaxSize(){
    local array_name=$1
    eval echo \${$array_name[1]}
}

Hashmap.isEmpty() {
    local array_name=$1
    local count=$(eval echo \${$array_name[2]})
    if [ $count -eq 0 ] ; then
        echo 1
    else
        echo 0
    fi
}

Hashmap.ascii() {
    LC_CTYPE=C printf '%d' "'$1"
}

Hashmap.hash() {
    local separated=$(echo $1 | sed 's/./& /g')
    local arr=($separated)
    len=${#arr[@]}
    local hash=0
    local i=0
    local prim=$2
    while [ $i -lt $len ] ; do
        local var=$(Hashmap.ascii ${arr[$i]})
        hash=$((hash+var*prim))
        prim=$((prim*7))
        ((i++))
    done
    echo $hash
}

Hashmap.firstHash(){
    Hashmap.hash $1 7
}

Hashmap.secondHash(){
    Hashmap.hash $1 13
}
