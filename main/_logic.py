from pprint import pprint
from typing import List, Tuple, Dict, Union


def read_data() -> List[Tuple[str, int]]:
    """
    Read list of people and how much did they pay
    :return: List[name, how much money did he / she gave]
    """
    print('Enter names and amounts of money in format of "Jack: 1984"'
          'If man didn\'t pay anything you can just write a name'
          'End the list with "end."')
    res = []
    while True:
        s = input()
        if s == 'end.':
            return res
        if ':' not in s:
            res.append((s, 0))
        else:
            name, money = s.split(':')
            res.append((name, int(money)))


def split_money(data: List[Tuple[str, int]]) -> List[Dict[str, Union[str, int]]]:
    """
    Calculate how much each man should give / get
    :param data: List[name, how much money did he / she gave]
    :return: list of dicts with keys 'name', 'to_pay', 'to_get'
    """
    whole_sum = sum(x for _, x in data)  # why sum takes no keyword arguments???
    sum_per_man = whole_sum / len(data)
    res = []
    for name, part in data:
        if sum_per_man > part:
            to_pay = sum_per_man - part
            to_get = 0
        else:
            to_pay = 0
            to_get = part - sum_per_man
        res.append({
            'name': name,
            'to_pay': to_pay,
            'to_get': to_get
        })
    return res

if __name__ == '__main__':
    pprint(split_money(read_data()))
