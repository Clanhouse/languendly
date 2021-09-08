from rest_framework import serializers
from api.models import Word, WORD_LEVELS, WORD_LANGUAGES


class WordSerializer(serializers.ModelSerializer):
    class Meta:
        model = Word
        fields = ['id','word', 'translation', 'language' , 'level', 'description']
