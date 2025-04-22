.PHONY: archive-archive archive-index

# 指定要歸檔的分支名稱，例如 name=challenge-1
ifndef name
$(error Usage: make archive name=challenge-<X>)
endif

# 使用 git archive 方法歸檔
# 比較好，根目錄的 Makefile, .gitignore, README.md 不會先被刪除再生成
archive-archive:
	@echo "📦 Archiving branch $(name) using git-archive into folder $(name)/ in master..."
	@echo "🔀 Switching to master branch..."
	@git checkout master
	@mkdir -p $(name)
	git archive $(name) | tar -x -C $(name)
	git add $(name)
	git commit -m "Archive $(name) via git-archive → $(name)/"
	git push origin master
	@echo "✅ Done archiving $(name) via git-archive → master:$(name)/"

# 使用 git checkout-index 方法歸檔
archive-index:
	@echo "📦 Archiving branch $(name) using git-checkout-index into folder $(name)/ in master..."
	@mkdir -p $(name)
	@echo "🔀 Switching to master branch..."
	git checkout master
	git --work-tree=$(name) checkout $(name) -- .
	git add $(name)
	git commit -m "Archive $(name) via checkout-index → $(name)/"
	git push origin master
	@echo "✅ Done archiving $(name) via git-checkout-index → master:$(name)/"
