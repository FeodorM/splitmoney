from django.shortcuts import render
from django.http import JsonResponse
import json
from pprint import pprint
from typing import List, Tuple, Dict, Union


def home(request):
    return render(request, "main/header.html")


def split_money_view(request):
    users = json.loads(next(iter(request.GET.keys())))
    prettify_users(users)
    _split_money(users)
    # pprint(users)
    return JsonResponse(users, safe=False)


def prettify_users(users: List[Dict]): # -> List[Dict]:
    """
    Modify list of users in place.
    Make 'money' int, remove 'num'
    """
    for user in users:
        user['money'] = int(user['money'])
        del user['num']


def _split_money(data: List[Dict]): # -> List[Dict[str, Union[str, int]]]:
    """
    Calculate how much each man should give / get
    :param data: List[
        name -- name,
        money -- how much money did he / she gave
    ]
    :return: list of dicts with keys 'name', 'to_pay', 'to_get'
    """
    whole_sum = sum(x['money'] for x in data)  # why sum takes no keyword arguments???
    sum_per_man = whole_sum / len(data)
    for user in data:
        user['to_pay'] = sum_per_man - user['money']
        del user['money']
