from django.contrib import admin
from .models import Language, Level, Account, Word

admin.site.register(Language)
admin.site.register(Level)

@admin.register(Account)
class AccountAdmin(admin.ModelAdmin):
    list_display = ('id','user','language_learnd','language_level')
    list_filter = ('user',)

@admin.register(Word)
class WordAdmin(admin.ModelAdmin):
    list_display = ('id', 'word', 'translation', 'language', 'level', 'short_desc')

    def short_desc(self, obj):
        if len(obj.description)>20:
            return obj.description[0:20] + '...'
        else:
             return obj.description


