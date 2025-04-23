.PHONY: archive archive-all

# 使用 git subtree 將分支內容匯入到對應資料夾中，保留 commit 記錄
archive:
ifndef name
	$(error Usage: make archive name=challenge-<X>)
endif
	@echo "🌲 Archiving $(name) into master:$(name)/ using git subtree..."

	@git checkout master

	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "❌ master branch has uncommitted changes. Please commit or stash first."; \
		exit 1; \
	fi

	@git subtree add --prefix=$(name) origin/$(name)

	@echo "✅ Done archiving $(name) into master:$(name)/"

# 對所有符合 challenge-* 的分支執行 subtree 匯入
archive-all:
	@git fetch origin
	@git branch -r | grep 'origin/challenge_' | sed 's|origin/||' | while read branch; do \
		$(MAKE) archive name=$$branch; \
	done
