from django.conf.urls import url, include

from .views import split_money_view, home

urlpatterns = [
    url(r'^ajax/', split_money_view, name='split_money'),
    url(r'^$', home, name='home')
]
