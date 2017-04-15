Hashmap.primeNumbers() {
    local primes=(227 457 919 1847 3697
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
    local array_name=$1
    mod=$(eval echo \${$array_name[1]})
    local separated=$(echo $2 | sed 's/./& /g')
    local arr=($separated)
    local len=${#arr[@]}
    local hash=0
    local i=0
    local prim=$3
    while [ $i -lt $len ] ; do
        local var=$(Hashmap.ascii ${arr[$i]})
        hash=$((hash+var*prim))
        prim=$((prim*7))
        ((i++))
    done
    hash=$((hash%mod))
    echo $hash
}

Hashmap.next() {
    local array_name=$1
    local mod=$(eval echo \${$array_name[1]})
    echo $((($2+$3)%mod))
}

Hashmap.firstHash(){
    Hashmap.hash $1 $2 7
}

Hashmap.secondHash(){
    local hash=$(Hashmap.hash $1 $2 13)
    if [ $hash -eq 0 ] ; then
        echo 1
    else
        echo $hash
    fi
}

Hashmap.getI(){
    local array_name=$1
    local hash1=$(Hashmap.firstHash $1 $2)
    local hash2=$(Hashmap.secondHash $1 $2)
    local i=$((hash1+5))
    local f=$(eval echo \${$array_name[i]})
    while [[ $f != "" && $f != $2 ]] ; do
        i=$((i-5))
        i=$(Hashmap.next $1 $i hash2)
        i=$((i+5))
        f=$(eval echo \${$array_name[i]})
    done
    echo $i
}

Hashmap.getIv(){
    local i=$(Hashmap.getMaxSize $1)
    i=$((i+$2))
    echo $i
}

Hashmap.put(){
    #TO DO resize array
    local i=$(Hashmap.getI $1 $2 $3)
    eval ${1}[i]=$2
    local iv=$(Hashmap.getIv $1 $i)
    eval ${1}[iv]=$3
}

Hashmap.containsKey(){
    local array_name=$1
    local i=$(Hashmap.getI $1 $2 $3)
    local f=$(eval echo \${$array_name[i]})
    if [[ $f == $2 ]] ; then
        echo 1
    else
        echo 0
    fi
}
