import collections
import re
import string

with open("./src/day07/input.txt") as file:
    data = file.read().splitlines()

def parse_steps():
    regex = re.compile(' [A-Z] ')
    return list(map(lambda i:
                    list(map(lambda j: j.strip(),
                             regex.findall(i))),
    data))

def add_next_step(steps, next_step, current_step):
    try:
        steps[next_step].add(current_step)
    except KeyError:
        steps[next_step] = [current_step]
    return steps


def add_steps(parsed_steps):
    steps = collections.defaultdict(set)
    for directions in parsed_steps:
        steps = add_next_step(steps, directions[1], directions[0])
    return steps

def requirements_met(letter, steps, solution):
    return letter not in solution and \
        steps[letter] & set(solution) == steps[letter]


def solution1():
    steps = add_steps(parse_steps())
    letters = list(string.ascii_uppercase)
    solution = []
    while len(solution) < 26:
        for letter in letters:
            if requirements_met(letter, steps, solution):
                solution.append(letter)
                break
    return ''.join(solution)
