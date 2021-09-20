from django.contrib import admin
from .models import Word


@admin.register(Word)
class WordAdmin(admin.ModelAdmin):
    list_display = ('id', 'word', 'translation', 'language', 'level', 'short_desc')

    def short_desc(self, obj):
        if len(obj.description)>20:
            return obj.description[0:20] + '...'
        else:
             return obj.description


