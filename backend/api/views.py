from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from api.models import Language, Word
from api.serializers import LanguageSerializer, WordSerializer

@api_view(['GET','POST'])
def word_list(request, format=None):
    """
    List all words or create a new one
    """
    if request.method == 'GET':
        words = Word.objects.all()
        serializer = WordSerializer(words, many=True)
        return Response(serializer.data)
    
    elif request.method == 'POST':
        serializer = WordSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET', 'POST'])
def language_list(request, format=None):
    """
    List all languages or create new one
    """
    if request.method == 'GET':
        lang = Language.objects.all()
        serializer = LanguageSerializer(lang, many=True)
        return Response(serializer.data)
        
    elif request.method == 'POST':
        serializer = LanguageSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
