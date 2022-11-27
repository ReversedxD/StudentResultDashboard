from django.contrib import admin
from django.urls import path
from backendcore.views import *

urlpatterns = [
    path('admin/', admin.site.urls),
    path('home/', printHello),
    path('hello_django/', hello_django),
]