from django.db import models
from django.contrib.auth.models import User


class Account(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    class Meta:
        ordering = ['id']


class Word(models.Model):
    ENGLISH = 'ENG'
    GERMAN = 'GER'

    WORD_LANGUAGE = [
        (ENGLISH, 'English'),
        (GERMAN, 'German')
    ]

    BEGINER = 'A1'
    INTERMEDIATE = 'B1'

    WORD_LEVEL = [
        (BEGINER, 'Beginer'),
        (INTERMEDIATE, 'Intermediate')
    ]

    word = models.CharField(max_length=30)
    translation = models.CharField(max_length=30)
    language = models.CharField(choices=WORD_LANGUAGE, max_length=3)
    level = models.CharField(choices=WORD_LEVEL, max_length=2)
    description = models.TextField(blank=True, default='')

    class Meta:
        ordering = ['id']

