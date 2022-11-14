#!/usr/bin/env python3


# array of length 10 consisting of 2x 5 Xfield

# 10*3*8


def rescue_prime_hash(
    parameters=None, input_sequence=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
):
    L = len(input_sequence)

    m = 9
    capacity = 3
    rate = m - capacity
    assert rate + capacity == m
    assert L % rate == 0

    state = [0] * m

    # absorbing
    for i in range(L):
        state[i % rate] += input_sequence[i]

        if i % rate == 0 and i > 0:
            state = rescue_XLIX_permutation(parameters, state)

    print(state)

    # squeezing
    return state[:rate]


def rescue_prime_wrapper(parameters, input_sequence):
    rate = 6

    padded_input = input_sequence
    padded_input += [1]
    padded_input += [0] * (len(padded_input) % rate)

    assert len(padded_input) % rate == 0

    return rescue_prime_hash(parameters, padded_input)


def rescue_XLIX_permutation(parameters, state):

    # number of rounds
    m = 9
    N = 4

    for i in range(N):
        state = rescue_XLIX_round(parameters, state, i)

    return state


def rescue_XLIX_round(parameters, state, i):
    # S - box
    for j in range(m):
        state[j] = state[j] ** alpha
    # mds
    state = MDS @ state
    # constants
    for j in range(m):
        state[j] += round_constants[i * 2 * m + j]
    # inverse S - box
    for j in range(m):
        state[j] = state[j] ** alphainv
    # mds
    state = MDS @ state
    # constants
    for j in range(m):
        state[j] += round_constants[i * 2 * m + m + j]

    return state
