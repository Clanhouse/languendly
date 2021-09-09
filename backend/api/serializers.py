from rest_framework import serializers
from api.models import Account, Language, Word


class WordSerializer(serializers.ModelSerializer):
    class Meta:
        model = Word
        fields = ['id','word', 'translation', 'language', 'level', 'description']

class AccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ['user', 'language_learnd']

class LanguageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Language
        fields = ['id', 'name']
