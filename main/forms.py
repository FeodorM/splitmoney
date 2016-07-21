from django import forms
from django.forms.formsets import formset_factory

class MainForm(forms.Form):
    name = forms.CharField()
    amount = forms.CharField()

MainFormSet = formset_factory(MainForm)
