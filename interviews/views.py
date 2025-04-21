from django.shortcuts import render, redirect, get_object_or_404
from .forms import InterviewForm
from .models import Interview

# Create your views here.
def index(req):

    interviews = Interview.objects.order_by("-id")
    return render(req, "interviews/index.html", {"interviews": interviews})

def add(req):
    
    if req.method == "POST":
        form = InterviewForm(req.POST)
        interview = form.save()
        
        return redirect("interviews:show", id=interview.id)
    
    form = InterviewForm
    return render(req, "interviews/add.html", {"form": form})

def show(req, id):
    interview = get_object_or_404(Interview, pk=id)
    return render(req, "interviews/show.html", {"interview":interview})

def update(req, id):
    interview = get_object_or_404(Interview, pk=id)
    if req.method == "POST":
        form = InterviewForm(req.POST, instance=interview)
        interview = form.save()
        return redirect("interviews:show", id=id)
    
    form = InterviewForm(instance=interview)
    
    return render(req, "interviews/update.html", {"form": form, "id": id})

def delete(req, id):
    interview = get_object_or_404(Interview, pk=id)
    interview.delete()

    return redirect("interviews:index")

