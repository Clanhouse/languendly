from django.http.response import Http404
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from api.models import Word
from api.serializers import WordSerializer
from .permissions import AdminOrReadOnly


class WordList(APIView):
    """
    List all words or create a new one
    """
    permission_classes = [AdminOrReadOnly]

    def get(self, request, format=None):
        words = Word.objects.all()
        serializer = WordSerializer(words, many=True)   
        return Response(serializer.data)

    def post(self, request, format=None):
        serializer = WordSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class WordDetail(APIView):
    """
    Retrieve, update or delete word.
    """
    permission_classes = [AdminOrReadOnly]

    def get_object(self, pk):
        try:
            return Word.objects.get(pk=pk)
        except Word.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        word = self.get_object(pk)
        serializer = WordSerializer(word)
        return Response(serializer.data)
    
    def put(self, request, pk, format=None):
        word = self.get_object(pk)
        serializer = WordSerializer(word, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    def delete(self, request, pk, format=None):
        word = self.get_object(pk)
        word.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


