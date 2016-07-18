from django.conf.urls import url, include

from . import views

urlpatterns = [
    url(r'^ajax/', views.split_money, name='split_money'),
    url(r'^$', views.home, name='home')
]
