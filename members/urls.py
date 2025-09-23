from django.urls import path
from . import views

urlpatterns = [
    path('boletins/turma/', views.boletins_por_turma, name='boletins_por_turma'),
]
