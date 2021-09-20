from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from api import views

urlpatterns = [
    path('words/', views.word_list, name='word_list'),
    path('words/<int:pk>', views.word_detail, name='word_detail'),
]

urlpatterns = format_suffix_patterns(urlpatterns)