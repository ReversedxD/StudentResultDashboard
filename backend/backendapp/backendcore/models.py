from django.db import models

# Create your models here.

class User(models.Model):
    name = models.CharField(max_length=200, null=True)
    email = models.CharField(max_length=200, null = True)
    enrollment = models.CharField(max_length=200, null = True, unique=True)

    def _str_(self):
        return self.name

class Result(models.Model):
    subject = models.CharField(max_length=200, null=True)
    marks = models.CharField(max_length=200, null = True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, to_field='enrollment')
    

    def _str_(self):
        return self.subject