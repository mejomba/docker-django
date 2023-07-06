import time

from psycopg2 import OperationalError as Psycopg2OperationalError
from django.db.utils import OperationalError

from django.core.management.base import BaseCommand


class Command(BaseCommand):
    """Django command to wait for database"""

    def handle(self, *args, **options):
        self.stdout.write('wait for db...')
        db_up = False
        while db_up is False:
            try:
                self.check(databases=['default'])
                db_up = True
            except (Psycopg2OperationalError, OperationalError):
                self.stdout.write('database unavailable, wait 1 second.')
                time.sleep(1)

        self.stdout.write(self.style.SUCCESS('database ready.'))