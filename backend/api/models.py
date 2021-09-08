from typing import Text
from django.db import models
from django.db.models.fields import CharField, TextField

WORD_LEVELS = [
    ('A1','Beginer'),
    ('A2', 'Pre-Intermediate'),
    ('B1', 'Intermediate'),
    ('B2', 'Upper-Intermediate'),
    ('C1', 'Advanced')
    ]

WORD_LANGUAGES = ['EN', 'English']

class Word(models.Model):
    word = CharField(max_length=30)
    translation = CharField(max_length=30)
    language = CharField(choices=WORD_LANGUAGES, max_length=100)
    level = CharField(choices=WORD_LEVELS, max_length=100)
    description =TextField(blank=True, default='')
