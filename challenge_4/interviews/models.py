from django.db import models

# Create your models here.
class Interview(models.Model):
    company_name = models.CharField(max_length=100)
    position = models.CharField(max_length=50)
    interviewed_at = models.DateField(null=True)
    rating = models.PositiveSmallIntegerField(help_text="請輸入1~10")
    review = models.TextField()
    result = models.CharField(max_length=100)

class Comment(models.Model):
    interview = models.ForeignKey(Interview, on_delete=models.CASCADE)
    content = models.TextField()
    created_at = models.DateField(auto_now_add=True)