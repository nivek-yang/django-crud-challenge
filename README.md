# GitHub 多挑戰專案架構管理流程筆記

這篇筆記紀錄如何建立一個乾淨的 GitHub 範本架構，其中 `template` 為開發初始樣板分支，`master` 負責整合所有挑戰結果，每個挑戰以 `challenge_<n>` 為分支名稱，最終整合進 `master` 的資料夾中。

---

## 🧱 建立 template 分支

```bash
# 從 master 建立 template 分支
git checkout -b template

# 推送到遠端
git push origin template
```

---

## ⚙️ 更改預設分支（GitHub 操作）

1. 前往 GitHub Repo 頁面
2. 點擊「⚙ Settings」
3. 左側選單中選擇「Branches」
4. 將 Default branch 改為 `template`

---

## 🗑️ 刪除 master 並重建

```bash
# 刪除遠端 master 分支
git push origin --delete master

# 本地切換並建立新的空 master 分支
git checkout --orphan master

# 移除所有檔案（保留工作區）
git rm -rf .

# 建立 .gitignore 和 Makefile
touch .gitignore Makefile

# 提交並推送新的空白 master 分支
git add .gitignore Makefile
git commit -m "Initialize new master branch"
git push -u origin master
```

---

## 🚀 建立 Makefile 自動遷移腳本

在新的 `master` 分支根目錄建立 `Makefile`：

```makefile
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

	# 備份 master 根目錄的 .gitignore 和 Makefile（避免被覆蓋）
	cp .gitignore .gitignore.master.bak || true
	cp Makefile Makefile.master.bak || true

	# 從分支中檢出所有檔案
	FILES=$$(git ls-tree --name-only $(name)); \
	for file in $$FILES; do \
		git checkout $(name) -- "$$file"; \
		git mv "$$file" $(name)/; \
	done

	# 還原 master 的 .gitignore 和 Makefile
	mv .gitignore.master.bak .gitignore
	mv Makefile.master.bak Makefile

	# 提交並推送
	git add .
	git commit -m "Archive $(name) into $(name)/"
	git push origin master

	@echo "✅ Done archiving $(name) → master:$(name)/"
```


---

## 📦 遷移挑戰分支內容

每完成一個 `challenge_<n>` 分支的專案後，執行：

```bash
make archive name=challenge_<n>
```

系統會自動將該分支所有檔案移動到 `master` 的 `challenge_<n>/` 資料夾中，並保留 `master` 自己的 `.gitignore` 和 `Makefile`。

---

## ✅ 效果展示

```
master
├── .gitignore
├── Makefile
├── challenge_1/
│   ├── manage.py
│   ├── app/
│   └── ...
├── challenge_2/
│   └── ...
└── challenge_3/
    └── ...
```

這樣的架構適合多人練習、範本複用、PR 管理與 GitHub Contributions 紀錄整理。

