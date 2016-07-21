from django.shortcuts import render, redirect
from django.contrib.auth import (
    authenticate,
    login,
    logout,
)
from .forms import UserLoginForm, UserRegisterForm


def login_view(request):
    print(request.user.is_authenticated())
    form = UserLoginForm(request.POST or None)
    if form.is_valid():
        username = form.cleaned_data.get('username')
        password = form.cleaned_data.get('password')
        user = authenticate(username=username, password=password)
        login(request, user)
        return redirect('/')
    return render(request, "accounts/form.html", {"form": form, "title": 'Login'})


def register_view(request):
    print(request.user.is_authenticated())
    form = UserRegisterForm(request.POST or None)
    if form.is_valid():
        user = form.save(commit=False)
        password = form.cleaned_data.get('password')
        user.set_password(password)
        user.save()

        new_user = authenticate(username=user.username, password=password)
        login(request, new_user)
        return redirect('/')

    context = {
        'form': form,
        "title": 'Register'
    }
    return render(request, "accounts/form.html", context)


def logout_view(request):
    logout(request)
    return redirect('/')
