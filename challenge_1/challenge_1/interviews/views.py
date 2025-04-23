from django.shortcuts import render, get_object_or_404, redirect
from .models import Interview, Comment
from .forms import InterviewForm


# Create your views here.
def index(req):
    interviews = Interview.objects.order_by("-id")
    return render(req, "interviews/index.html", {"interviews": interviews})

def add(req):
    if req.method == "POST":
        form = InterviewForm(req.POST)
        interview = form.save()
        return redirect("interviews:show", id = interview.id)

    form = InterviewForm()
    return render(req, "interviews/add.html", {"form": form})

def show(req, id):
    interview = get_object_or_404(Interview, pk=id)
    comments = interview.comment_set.order_by("-id")
    return render(req, "interviews/show.html", {"interview": interview, "comments": comments})

def update(req, id):
    interview = get_object_or_404(Interview, pk=id)
    
    if req.method == "POST":
        form = InterviewForm(req.POST, instance=interview)
        form.save()
        return redirect("interviews:show", id)
    form = InterviewForm(instance=interview)
    return render(req, "interviews/update.html", {"form": form, "interview":interview})

def delete(req, id):
    interview = get_object_or_404(Interview, pk=id)
    interview.delete()

    return redirect("interviews:index")

def comment(req, id):
    interview = get_object_or_404(Interview, pk=id)
    interview.comment_set.create(content = req.POST['content'])
    return redirect("interviews:show", id)