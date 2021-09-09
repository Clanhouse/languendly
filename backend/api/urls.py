from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from api import views

urlpatterns = [
    path('words/', views.word_list),
    path('words/<int:pk>', views.word_detail),

    path('lang/', views.language_list)
]

urlpatterns = format_suffix_patterns(urlpatterns)