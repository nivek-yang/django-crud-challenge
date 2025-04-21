from django.db import models

# Create your models here.
class Interview(models.Model):
    company_name = models.CharField(max_length=100)
    position = models.CharField(max_length=50)
    interviewed_at = models.DateField(null=True)
    rating = models.PositiveSmallIntegerField(help_text="請輸入1~10")
    review = models.TextField()
    result = models.CharField(max_length=100)


