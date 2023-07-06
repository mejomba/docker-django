from django.db import models


class Simple(models.Model):
    file = models.FileField()
