from django.contrib import admin
from django.contrib.auth.models import Group
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from .models import Account, Word

@admin.register(Account)
class AccountAdmin(BaseUserAdmin):
    
    list_display = ('email', 'is_staff', 'is_superuser')

    fieldsets = (
        (None, {'fields': ('email', 'password')}),
        ('Personal info', {'fields': ('first_name', 'last_name')}),
    )

    add_fieldsets = (
        (None, {'fields': ('email','is_staff', 'is_superuser','password1', 'password2')}),
        ('Personal info', {'fields': ('first_name', 'last_name')}),
    )


    search_fields = ('email',)
    ordering = ('email',)
    filter_horizontal = ()

admin.site.unregister(Group)


@admin.register(Word)
class WordAdmin(admin.ModelAdmin):
    list_display = ('id', 'word', 'translation', 'language', 'level', 'short_desc')

    def short_desc(self, obj):
        if len(obj.description)>20:
            return obj.description[0:20] + '...'
        else:
             return obj.description


