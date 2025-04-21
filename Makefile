runserver:
	uv run python manage.py runserver

startapp:
	uv run python manage.py startapp $(name)

makemigrations:
	uv run python manage.py makemigrations

migrate:
	uv run python manage.py migrate

start_project:
	uv run python -m time_tracking.main start_project

end_project:
	uv run python -m time_tracking.main end_project

start_feature:
	uv run python -m time_tracking.main start_feature $(feature)

end_feature:
	uv run python -m time_tracking.main end_feature $(feature)
	