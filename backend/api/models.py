from django.db import models
from django.contrib.auth.models import User


class Level(models.Model):
    name = models.CharField(max_length=30)

    def __str__(self):
        return self.name

class Language(models.Model):
    name = models.CharField(max_length=30)

    def __str__(self):
        return self.name

class Account(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    language_learnd = models.ForeignKey(Language, on_delete=models.CASCADE)
    language_level = models.ForeignKey(Level, on_delete=models.CASCADE)

    class Meta:
        ordering = ['id']


class Word(models.Model):
    word = models.CharField(max_length=30)
    translation = models.CharField(max_length=30)
    language = models.ForeignKey(Language, related_name='lang', on_delete=models.CASCADE)
    level = models.ForeignKey(Level, related_name='level', on_delete=models.CASCADE)
    description = models.TextField(blank=True, default='')

    class Meta:
        ordering = ['id']

