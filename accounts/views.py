from django.shortcuts import render
from django.contrib.auth import (
    authenticate,
    get_user_model,
    login,
    logout,
)
from .forms import UserLoginForm


def login_view(request):
    print(request.user.is_authenticated())
    form = UserLoginForm(request.POST or None)
    if form.is_valid():
        username = form.cleaned_data.get('username')
        password = form.cleaned_data.get('password')
        user = authenticate(username=username, password=password)
        login(request, user)
        print(request.user.is_authenticated())
        # redirect
    return render(request, "accounts/form.html", {"form": form, "title": 'Login'})


def register_view(request):
    # code ...
    return render(request, "accounts/form.html", {})


def logout_view(request):
    logout(request)
    # redirect
    return render(request, "accounts/form.html", {})
