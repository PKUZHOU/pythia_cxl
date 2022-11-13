from turtle import right


no_pref = []
pythia = []
with open("80_ns_slowdown.txt",'r') as f:
    ipc = f.readlines()
    no_pref_line = ipc[0].strip().split("\t")
    pythia_line = ipc[1].strip().split("\t")
    no_pref = [1-float(x) for x in no_pref_line]
    pythia = [1-float(x) for x in pythia_line]


def stat(data):
    steps = [[-100,5],[5,15],[15,25],[25,35],[35,1000]]
    numbers = []
    for step in steps:
        left = step[0]
        right = step[1]
        number = 0
        for x in data:
            if left<=x*100<=right:
                number += 1
        numbers.append(number)
    return numbers


print(stat(no_pref))
print(stat(pythia))