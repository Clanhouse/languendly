from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from api import views

urlpatterns = [
    path('', views.api_root),
    path('words/', views.WordList.as_view(), name='word_list'),
    path('words/<int:pk>', views.WordDetail.as_view(), name='word_detail'),
]

urlpatterns = format_suffix_patterns(urlpatterns)