from rest_framework import serializers
from api.models import Account, Language, Word


class WordSerializer(serializers.ModelSerializer):

    language = serializers.SerializerMethodField()
    level = serializers.SerializerMethodField()

    class Meta:
        model = Word
        fields = ['id','word', 'translation', 'language', 'level', 'description']
    
    def get_language(self, word):
        return word.language.name
    
    def get_level(self, word):
        return word.level.name

class AccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ['user', 'language_learnd']

class LanguageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Language
        fields = ['id', 'name']

