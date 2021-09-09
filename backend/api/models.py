from django.db import models
from django.contrib.auth.models import User



WORD_LEVELS = [
    ('A1','Beginer'),
    ('A2', 'Pre-Intermediate'),
    ('B1', 'Intermediate'),
    ('B2', 'Upper-Intermediate'),
    ('C1', 'Advanced')
    ]

class Language(models.Model):
    name = models.CharField(max_length=30)

    def __str__(self):
        return self.name

class Account(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    language_learnd = models.ManyToManyField(Language)

class Word(models.Model):
    word = models.CharField(max_length=30)
    translation = models.CharField(max_length=30)
    language = models.ForeignKey(Language, related_name='lang', on_delete=models.CASCADE)
    level = models.CharField(choices=WORD_LEVELS, default='A1', max_length=100)
    description = models.TextField(blank=True, default='')
