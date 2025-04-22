from django.forms import ModelForm, DateInput
from .models import Interview

class InterviewForm(ModelForm):
    class Meta:
        model = Interview
        fields = [
            'company_name',
            'position',
            'interviewed_at',
            'rating',
            'review',
            'result'
        ]
        labels = {
            'company_name': "公司名稱",
            'position': "職位",
            'interviewed_at': "面試日期",
            'rating': "評價",
            'review': "心得",
            'result': "結果"
        }

        widgets = {"interviewed_at": DateInput({"type": "date"})}