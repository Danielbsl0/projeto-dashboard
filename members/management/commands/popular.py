from django.core.management.base import BaseCommand
from members.models import Disciplina, Curso, Serie, DisciplinaCursoSerie

class Command(BaseCommand):
    help = 'Popula a DisciplinaCursoSerie com vínculos entre disciplinas, cursos e séries.'

    def handle(self, *args, **options):
        # Pegue todas as disciplinas ainda não associadas
        disciplinas = list(Disciplina.objects.all())
        cursos = list(Curso.objects.all())
        series = list(Serie.objects.all())

        if not disciplinas or not cursos or not series:
            self.stdout.write(self.style.ERROR('Certifique-se de que há disciplinas, cursos e séries cadastrados.'))
            return

        # Exemplo: associa cada disciplina ao primeiro curso e à primeira série disponíveis
        for disc in disciplinas:
            DisciplinaCursoSerie.objects.create(
                disciplina=disc,
                curso=cursos[0],
                serie=series[0]
            )
            self.stdout.write(f'Vínculo criado: disciplina={disc.descricao}, curso={cursos[0].descricao}, serie={series[0].descricao}')

        self.stdout.write(self.style.SUCCESS('Vinculações DisciplinaCursoSerie criadas!'))