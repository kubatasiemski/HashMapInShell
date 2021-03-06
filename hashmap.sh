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
    local count=$(Hashmap.size $1)
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
    while [[ "$f" != "" && "$f" != $2 ]] ; do
        i=$(Hashmap.next $1 $((i-5)) hash2)
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
    local maxSize=$(Hashmap.getMaxSize $1)
    local size=$(Hashmap.size $1)
    local res=$((${size}*1000/${maxSize}))
    if [ $res -gt 700 ] ; then
        Hashmap.resize $1
    fi
    ifContainsKey=$(Hashmap.containsKey $1 $2)
    if [ $ifContainsKey -eq 0 ] ; then
        local array_name=$1
        local size=$(eval echo \${$array_name[2]})
        ((size++))
        eval ${1}[2]=$size
    fi
    local i=$(Hashmap.getI $1 $2)
    eval ${1}[i]=$2
    local iv=$(Hashmap.getIv $1 $i)
    eval ${1}[iv]=$3
}

Hashmap.containsKey(){
    local array_name=$1
    local i=$(Hashmap.getI $1 $2)
    local f=$(eval echo \${$array_name[i]})
    if [[ $f == $2 ]] ; then
        echo 1
    else
        echo 0
    fi
}

Hashmap.get(){
    ifContainsKey=$(Hashmap.containsKey $1 $2)
    if [ $ifContainsKey -eq 1 ] ; then
        local array_name=$1
        local i=$(Hashmap.getI $1 $2)
        local iv=$(Hashmap.getIv $1 $i)
        eval echo \${$array_name[iv]}
    else
        echo ""
    fi
}

Hashmap.size(){
    local array_name=$1
    local size=$(eval echo \${$array_name[2]})
    local ninjaSize=$(eval echo \${$array_name[3]})
    echo $((size-ninjaSize))
}

Hashmap.remove(){
    ifContainsKey=$(Hashmap.containsKey $1 $2)
    if [ $ifContainsKey -eq 1 ] ; then
        local array_name=$1
        local ninjaSize=$(eval echo \${$array_name[3]})
        ((ninjaSize++))
        eval ${1}[3]=$ninjaSize
        local i=$(Hashmap.getI $1 $2)
        local iv=$(Hashmap.getIv $1 $i)
        eval ${1}[i]="empty"
        eval ${1}[iv]=""
        local maxSize=$(Hashmap.getMaxSize $1)
        local res=$((${ninjaSize}*1000/${maxSize}))
        if [ $res -gt 500 ] ; then
            Hashmap.removeNinja $1
        fi
    fi
}

Hashmap.clear() {
    local n=$(Hashmap.getMaxSize $1)
    n=$((n*2+5))
    local i=0
    while [ $i -lt $n ] ; do
        eval ${1}[i]=""
        ((i++))
    done
    Hashmap.hashmap $1
}

Hashmap.toString() {
    local array_name=$1
    local n=$(Hashmap.getMaxSize $1)
    local i=0
    while [ $i -lt $n ] ; do
        local name=$(eval echo \${$array_name[$((i+5))]})
        if [[ "$name" != "empty" && "$name" != "" ]] ; then
            local value=$(eval echo \${$array_name[$((i+5+n))]})
            printf "[$name:$value] "
        fi
        ((i++))
    done
    printf "\n"
}

Hashmap.keys() {
    local array_name=$1
    local array_out=$2
    local n=$(Hashmap.getMaxSize $1)
    local i=0
    local outi=0
    while [ $i -lt $n ] ; do
        local name=$(eval echo \${$array_name[$((i+5))]})
            if [[ "$name" != "empty" && "$name" != "" ]] ; then
                eval ${2}[outi]=$name
                ((outi++))
            fi
        ((i++))
    done
}

Hashmap.values() {
    local array_name=$1
    local array_out=$2
    local n=$(Hashmap.getMaxSize $1)
    local i=0
    local outi=0
    while [ $i -lt $n ] ; do
        local name=$(eval echo \${$array_name[$((i+5+n))]})
        if [[ "$name" != "empty" && "$name" != "" ]] ; then
            eval ${2}[outi]=$name
            ((outi++))
        fi
        ((i++))
    done
}

Hashmap.add() {
    ifContainsKey=$(Hashmap.containsKey $1 $2)
    if [ $ifContainsKey -eq 1 ] ; then
        local array_name=$1
        local i=$(Hashmap.getI $1 $2)
        local iv=$(Hashmap.getIv $1 $i)
        local value=$(eval echo \${$array_name[iv]})
        if [ "$value" -eq "$value" ] 2>/dev/null; then
            value=$((value+$3))
            eval ${1}[iv]=$value
        else
            eval ${1}[iv]=$value$3
        fi
   else
        Hashmap.put $1 $2 $3
    fi
}

Hashmap.copy() {
    local array_name=$1
    local n=$(Hashmap.getMaxSize $1)
    n=$((n*2+5))
    local i=0
    while [ $i -lt $n ] ; do
        eval ${2}[i]=$(eval echo \${$array_name[i]})
        ((i++))
    done
}

Hashmap.equals() {
    local array_name=$1
    local array2=$2
    local s1=$(Hashmap.size $1)
    local s2=$(Hashmap.size $2)
    if [ $s1 -ne $s2 ] ; then
        echo 0
    else
        local n=$(Hashmap.getMaxSize $1)
        local i=0
        while [ $i -lt $n ] ; do
            local name=$(eval echo \${$array_name[$((i+5))]})
            if [[ "$name" != "empty" && "$name" != "" ]] ; then
                v1=$(Hashmap.get $1 $name)
                v2=$(Hashmap.get $2 $name)
                if [[ "$v1" != "$v2" ]] ; then
                    break
                fi
            fi
            ((i++))
        done
        if [ $i -eq $n ] ; then
            echo 1
        else
            echo 0
        fi
    fi
}

Hashmap.reload() {
    local array_name=$1
    local size=$(eval echo \${$array_name[0]})
    local keys
    local values
    local i=0
    local iK=0
    local n=0
    local n=$(Hashmap.getMaxSize $1)
    local i=0
    while [ $i -lt $n ] ; do
        local v1=$(eval echo \${$array_name[i+5]})
        local v2=$(eval echo \${$array_name[i+n+5]})
        if [[ "$v1" != "empty" && "$v1" != "" ]] ; then
            keys[$iK]=$v1
            values[$iK]=$v2
            ((iK++))
        fi
        ((i++))
    done
    size=$((size+$2))
    local neWsize=$(Hashmap.primeNumbers $size)
    Hashmap.clear $1
    eval ${1}[0]=$size
    eval ${1}[1]=$neWsize
    eval ${1}[2]=0
    eval ${1}[3]=0
    i=0
    while [ $i -lt $iK ] ; do
        Hashmap.put $1 ${keys[$i]} ${values[$i]}
        ((i++))
    done
}


Hashmap.resize() {
    Hashmap.reload $1 1
}

Hashmap.removeNinja() {
    Hashmap.reload $1 0
}
