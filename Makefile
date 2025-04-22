.PHONY: archive

ifndef name
$(error Usage: make archive name=challenge-<X>)
endif

archive:
	@echo "📦 Archiving branch $(name) into folder $(name)/ in master..."

	# 確保在 master 分支
	git checkout master

	# 確保沒有未提交變更
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "❌ master branch has uncommitted changes. Please commit or stash first."; \
		exit 1; \
	fi

	# 備份 master 的 Makefile 和 .gitignore
	cp Makefile .Makefile.bak || true
	cp .gitignore .gitignore.bak || true

	# 建立目標資料夾
	mkdir -p $(name)

	FILES=$$(git ls-tree --name-only $(name)); \
	for file in $$FILES; do \
		git checkout $(name) -- "$$file"; \
		git mv "$$file" $(name)/; \
	done

	# 還原 master 的 Makefile 和 .gitignore
	mv .Makefile.bak Makefile || true
	mv .gitignore.bak .gitignore || true

	# 提交並推送
	git add .
	git commit -m "Archive $(name) into $(name)/"
	git push origin master

	@echo "✅ Done archiving $(name) → master:$(name)/"
