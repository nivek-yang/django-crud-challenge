.PHONY: archive

ifndef name
$(error Usage: make archive name=challenge-<X>)
endif

archive:
	@echo "📦 Archiving branch $(name) into folder $(name)/ in master..."

	# 確保在 master 分支
	git checkout master

	# 檢查是否有未提交變更
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "❌ master branch has uncommitted changes. Please commit or stash first."; \
		exit 1; \
	fi

	# 建立目標資料夾
	mkdir -p $(name)

	# 從目標分支 checkout 所有檔案（包含 Makefile、.gitignore）
	git checkout $(name) -- .

	# 移動除了 .git 目錄以外的所有檔案到 $(name) 資料夾
	FILES=$$(git ls-tree --name-only $(name)); \
	for file in $$FILES; do \
		if [ "$$file" != "." ] && [ "$$file" != ".." ]; then \
			git mv "$$file" $(name)/; \
		fi \
	done

	# 從資料夾中把 master 的 Makefile 和 .gitignore 複製回來（避免被 challenge 蓋掉）
	git checkout origin/master -- Makefile .gitignore

	# 提交並推送
	git add .
	git commit -m "Archive $(name) into $(name)/"
	git push origin master

	@echo "✅ Done archiving $(name) → master:$(name)/"
