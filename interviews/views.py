from django.shortcuts import render, redirect, get_object_or_404
from .models import Interview
from .forms import InterviewForm

# Create your views here.
def add(req):
    if req.method == "POST":
        form = InterviewForm(req.POST)
        interview = form.save()
        return redirect("interviews:show", id = interview.id)

    form = InterviewForm
    return render(req, "interviews/add.html", {"form": form})