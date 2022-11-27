from django.http import JsonResponse, HttpResponse, HttpRequest
from json import dumps
from django.shortcuts import render
from .models import *
from rest_framework.response import Response
from django.forms.models import model_to_dict
from rest_framework.permissions import AllowAny
from rest_framework.decorators import api_view, permission_classes
from django.db.models import Sum

# Create your views here.

def printHello(request):
    return HttpResponse("hello world")


@api_view(['GET'])
@permission_classes([AllowAny])
def hello_django(request):
    print("Request Received")
    return Response({'message: Got it!'}, status = 200)

@api_view(['GET'])
@permission_classes([AllowAny])
def users(request):
    response = []
    users = User.objects.all()
    for user in users:
        response.append(model_to_dict(user))
    return JsonResponse(response,safe = False)

@api_view(['GET'])
@permission_classes([AllowAny])
def result(request: HttpRequest, roll):
    response = []
    results = Result.objects.filter(user=roll).all()
    total_marks = Result.objects.filter(user=roll).aggregate(Total = Sum("marks"))['Total']
    for result in results:
        response.append(model_to_dict(result))
    return JsonResponse({"subjects": response, "total_marks": total_marks}, safe = False)

# @api_view(['GET'])
# @permission_classes([AllowAny])
# def totalmarks(request):
#     total = Result.objects.aggregate(Total = Sum('marks'))['Total']
#     return Response(total)