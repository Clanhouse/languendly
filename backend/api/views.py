from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from api.models import Word
from api.serializers import WordSerializer

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

@api_view(['GET','PUT','DELETE'])
def word_detail(request,pk,format=None):
    """
    Retrieve, update or delete word.
    """
    try:
        word = Word.objects.get(pk=pk)
        
    except Word.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = WordSerializer(word)
        return Response(serializer.data)

    elif request.method == 'PUT':
        serializer = WordSerializer(word, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        word.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
