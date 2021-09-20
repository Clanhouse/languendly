import json
from django.test import TestCase, Client
from .models import Word
from .serializers import WordSerializer
from rest_framework import status
from django.urls import reverse

client = Client()


class GetAllWordsTest(TestCase):
    """Test module for GET all words API"""

    def setUp(self):

        Word.objects.create(word='Pen', translation='Długopis', language='ENG', level='A1')
        Word.objects.create(word='Pencil', translation='Ołówek', language='ENG', level='A1')
        Word.objects.create(word='Book', translation='Książka', language='ENG', level='A1')
        Word.objects.create(word='Marker', translation='Znacznik', language='ENG', level='A1')
        Word.objects.create(word='Car', translation='Samochód', language='ENG', level='A1')
    
    def test_get_all_words(self):
        # get API response
        response = client.get(reverse('word_list'))
        # get data from db
        words = Word.objects.all()
        serializer = WordSerializer(words, many=True)
        self.assertEqual(response.data, serializer.data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

class GetSingleWordsTest(TestCase):
    """Test module for GET single word API"""

    def setUp(self):

        self.pen = Word.objects.create(word='Pen', translation='Długopis', language='ENG', level='A1')
        self.pencil = Word.objects.create(word='Pencil', translation='Ołówek', language='ENG', level='A1')
        self.book = Word.objects.create(word='Book', translation='Książka', language='ENG', level='A1')
        self.marker = Word.objects.create(word='Marker', translation='Znacznik', language='ENG', level='A1')
        self.car = Word.objects.create(word='Car', translation='Samochód', language='ENG', level='A1')
    
    def test_get_valid_single_word(self):
        # get API response
        response = client.get(reverse('word_detail', kwargs={'pk': self.car.pk}))
        # get data from db
        word = Word.objects.get(pk=self.car.pk)
        serializer = WordSerializer(word)
        self.assertEqual(response.data, serializer.data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_get_invalid_single_word(self):
        response = client.get(
            reverse('word_detail', kwargs={'pk': 100}))
        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)

class CreateNewWordTest(TestCase):
    """Test modeule for POST single word API"""
    def setUp(self):
        self.valid_input = {
            "word": "Pen",
            "translation":"Długopis",
            "language":"ENG",
            "level":"A1",
        }
        self.invalid_input = {
            'word': 'Pen',
            'translation': 'Długopis',
            'language': 'POL',
            'level': 'A1',
        }
    def test_create_valid_word(self):
        response = client.post(
            reverse('word_list'),
            data=json.dumps(self.valid_input),
            content_type='application/json'
        )
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_create_invalid_word(self):
        response = client.post(
            reverse('word_list'),
            data=json.dumps(self.invalid_input),
            content_type='application/json'
        )
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)