#! /usr/bin/awk -f

/^ *$/{print; next}
/^ *#/{print; next}
{
    for (i=2; i<=NF; i++){
	if ($(i)+0 == $i){
	    nnum = i
	    break
	}
    }
    nmol = 0
    delete aname
    for (i=2; i<nnum; i++){
	nmol++
	aname[nmol] = $(i)
    }

    nmol = 0
    delete anum
    for (i=nnum; i < NF; i++){
	nmol++
	anum[nmol] = $(i)
    }

    for (i=1; i <= nmol; i++){
	print anum[i]
	print aname[i]
    }
    print "0"
    print $NF
}
