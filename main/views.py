from django.shortcuts import render
from django.http import JsonResponse
from pprint import pprint
import json


def home(request):
    return render(request, "main/header.html")


def split_money(request):
    # pprint([i for i in dir(request) if not i.startswith("_")])
    # pprint(json.loads('{"bla": "1", "asdasd": "23"}'))
    for key in request.GET.keys():
        users = json.loads(key)
    pprint(users)
    return JsonResponse({
        # here should be nice response
    })
