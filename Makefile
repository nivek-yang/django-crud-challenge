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

	# 從分支中取得檔案清單，排除 Makefile 和 .gitignore
	FILES=$$(git ls-tree --name-only $(name) | grep -vE '^(Makefile|\.gitignore)$$'); \
	for file in $$FILES; do \
		git checkout $(name) -- "$$file"; \
		git mv "$$file" $(name)/; \
	done

	# 提交並推送
	git add .
	git commit -m "Archive $(name) into $(name)/"
	git push origin master

	@echo "✅ Done archiving $(name) → master:$(name)/"


