from django.core.management.base import BaseCommand
from members.models import Boletim, Aluno, Disciplina, Turma
from random import randint, uniform, choice

class Command(BaseCommand):
    help = 'Popula a tabela Boletim com dados fictícios.'

    def handle(self, *args, **options):
        alunos = list(Aluno.objects.all())
        disciplinas = list(Disciplina.objects.all())
        turmas = list(Turma.objects.all())
        status_opcoes = ['Aprovado', 'Reprovado', 'Em andamento']

        total = 0
        for aluno in alunos:
            disciplina = choice(disciplinas)
            turma = choice(turmas)
            Boletim.objects.create(
                aluno_matricula=aluno,
                disciplina=disciplina,
                turma_id=turma.id,
                turma_ano=turma.ano,
                bimestre1=round(uniform(5, 10), 2),
                bimestre2=round(uniform(5, 10), 2),
                recusem1=round(uniform(0, 2), 2),
                bimestre3=round(uniform(5, 10), 2),
                bimestre4=round(uniform(5, 10), 2),
                recusem2=round(uniform(0, 2), 2),
                recfinal=round(uniform(0, 2), 2),
                final=round(uniform(5, 10), 2),
                faltas=randint(0, 20),
                faltaspercent=randint(0, 100),
                status=choice(status_opcoes)
            )
            total += 1
        self.stdout.write(self.style.SUCCESS(f'{total} registros de Boletim criados!'))