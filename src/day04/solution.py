from collections import Counter, defaultdict
from datetime import datetime

with open ("input.txt") as file:
    data = file.read().splitlines()

def read_guard_logs():
    """
    Read the log and return a dictionary of each guard id,
    with a list of all minutes that they were asleep
    """
    guards = defaultdict(list)
    for t, info in [l.split('] ') for l in sorted(data)]:
        time = datetime.strptime(t, '[%Y-%m-%d %H:%M')
        if '#' in info:
            guard = int(info.split('#')[1].split()[0])
        if 'falls' in info:
            sleep_start = time
        if 'wakes' in info:
            sleep_end = time
            for i in range(sleep_start.minute, sleep_end.minute):
                guards[guard].append(i)
    return guards

def minutes_asleep(guard):
    """
    Return a tuple of the minute which the guard slept the most,
    and how many times it appears in the list
    """
    return Counter(guard).most_common(1)[0]

def slept_most(guards):
    """
    Return the ID of the guard who slept the most
    """
    max = 0
    for guard in guards:
        if len(guards[guard]) > max:
            max = len(guards[guard])
            id = guard
    return id

def minutes_slept_most(guards):
    """
    Return the ID of the guard who spent a minute alseep more than any other
    """
    max = 0
    for guard in guards:
        if guards[guard][1] > max:
            max = guards[guard][1]
            id = guard
    return id

def solution1():
    guards = read_guard_logs()
    most = slept_most(guards)
    return most * minutes_asleep(guards[most])[0]

def solution2():
    guards = read_guard_logs()
    for guard in guards:
        guards[guard] = minutes_most_asleep(guards[guard])
    most = minutes_slept_most(guards)
    return most * guards[most][0]
