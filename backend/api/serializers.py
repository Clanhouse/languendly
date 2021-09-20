from rest_framework import serializers
from api.models import Account, Word


class WordSerializer(serializers.ModelSerializer):

    class Meta:
        model = Word
        fields = ['id','word', 'translation', 'language', 'level', 'description']
        read_only_fields = ['id']
    

class AccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ['user', 'language_learnd']
