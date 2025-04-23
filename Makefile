.PHONY: archive archive-all

ifndef name
$(error Usage: make archive name=challenge-<X>)
endif

# 使用 git subtree 將分支內容匯入到對應資料夾中，保留 commit 記錄
archive:
	@echo "🌲 Archiving $(name) into master:$(name)/ using git subtree..."

	# 確保在 master 分支
	@git checkout master

	# 檢查有無未提交的變更
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "❌ master branch has uncommitted changes. Please commit or stash first."; \
		exit 1; \
	fi

	# 匯入分支內容到對應資料夾（不使用 --squash，可保留所有 commit）
	@git subtree add --prefix=$(name) origin/$(name)

	@echo "✅ Done archiving $(name) into master:$(name)/"

# 對所有符合 challenge-* 的分支執行 subtree 匯入
archive-all:
	@git fetch origin
	@git branch -r | grep 'origin/challenge_' | sed 's|origin/||' | while read branch; do \
		$(MAKE) archive name=$$branch; \
	done

