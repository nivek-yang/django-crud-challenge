.PHONY: archive

# 存放資料夾名稱，避免直接修改檔案
ifndef name
	$(error "Usage: make archive name=challenge-1")
endif

archive:
	@echo "📦 Archiving branch $(name) into folder $(name)/ in master..."

	# 確保在 master branch
	git checkout master

	# 確保 local 沒有未提交的變更
	if [ -n "$(git status --porcelain)" ]; then \
		echo "❌ master branch has uncommitted changes. Please commit or stash first."; \
		exit 1; \
	fi

	# 創建目標資料夾
	mkdir -p $(name)

	# 從指定分支提取檔案並移動至資料夾
	git checkout $(name) -- .

	# 把檔案移動到資料夾
	git ls-tree --name-only $(name) | xargs -I {} git mv {} $(name)/

	# 提交變更並推送到遠端
	git add .
	git commit -m "Archive $(name) into $(name)/"
	git push origin master

	@echo "✅ Done archiving $(name) → master:$(name)/"