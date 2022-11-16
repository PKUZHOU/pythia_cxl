from turtle import right


no = []
base = []
active = []
with open("streamer.txt",'r') as f:
    ipc = f.readlines()
    no_line = ipc[0].strip().split("\t")
    base_line = ipc[1].strip().split("\t")
    active_line = ipc[2].strip().split("\t")

    for x in no_line:
        try:
            no.append(-float(x))
        except:
            pass
    for x in base_line:
        base.append(-float(x))
    for x in active_line:
        active.append(-float(x))

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


print(stat(no))
print(stat(base))
print(stat(active))