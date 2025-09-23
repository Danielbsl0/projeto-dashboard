import io
import base64
import matplotlib.pyplot as plt
import pandas as pd
from django.shortcuts import render
from members.models import Boletim, Turma

def boletins_por_turma(request):
    turmas = Turma.objects.all().order_by('ano', 'descricao')
    turma_id = request.GET.get('turma_id')

    if turma_id:
        boletins = Boletim.objects.filter(turma_id=turma_id).values('aluno_matricula__nome', 'final')
        df = pd.DataFrame(list(boletins))
        if not df.empty:
            medias = df.groupby('aluno_matricula__nome')['final'].mean().sort_values()
            plt.figure(figsize=(10,5))
            medias.plot(kind='bar')
            plt.title('Média Final por Aluno na Turma')
            plt.xlabel('Aluno')
            plt.ylabel('Nota Final')
            plt.tight_layout()

            buffer = io.BytesIO()
            plt.savefig(buffer, format='png')
            plt.close()
            buffer.seek(0)
            grafico_base64 = base64.b64encode(buffer.getvalue()).decode('utf-8')
        else:
            grafico_base64 = None
    else:
        medias = None
        grafico_base64 = None

    context = {
        'turmas': turmas,
        'grafico': grafico_base64,
        'selecionada': turma_id,
    }
    return render(request, 'boletins_por_turma.html', context)