from django.shortcuts import render
from members.models import Aluno

def lista_alunos(request):
  lista_alunos = Aluno.objects.all()
  return render(request, 'template.html', {'lista_alunos': lista_alunos})