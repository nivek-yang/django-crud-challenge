
# 🛠 Django CRUD Challenge 教學指南

本指南幫助你在三十分鐘內熟練完成 Django CRUD 專案，並結合錯誤紀錄、自動化處理時間與 log 紀錄機制。

---

## 📁 專案結構

```
django-crud-template/
├── challenge_log/                  # 錯誤紀錄 JSON 檔案
│   └── errors/
├── crudapp/                        # Book CRUD 功能
│   ├── models.py
│   ├── views.py
│   ├── forms.py
│   └── templates/crudapp/
├── errorlog/                       # 錯誤報表頁面
│   ├── views.py
│   ├── urls.py
│   └── templates/errorlog/
├── error_logger/                  # ⛏️ 錯誤裝飾器與 log 記錄
│   └── logger.py
├── manage.py
├── requirements.txt
├── .gitignore
├── README.md
└── CHALLENGE_GUIDE.md             # ← 本說明檔
```

---

## ⚙️ CRUD 快速功能說明

| 模組 | 功能 |
|------|------|
| Book Model | `title`, `author`, `published_date` |
| CRUD | List、Detail、Create、Update、Delete |
| Template | 使用 `bootstrap` 簡單呈現 |
| URL | `/books/` 為主入口，對應所有 CRUD 頁面 |

---

## 🧠 錯誤記錄裝飾器 (@log_errors)

在 view function 外層使用 decorator，例如：

```python
from error_logger.logger import log_errors

@log_errors(tag="book", notes="create view")
def create_book(request):
    ...
```

### 🔍 功能
- 當錯誤發生，自動將：
  - 時間戳
  - 錯誤類型與 traceback
  - 補充說明（tag, notes）
- 寫入 `challenge_log/errors/YYYY-MM-DD.json`

---

## ⏱ 自動計算執行時間 (middleware)

可額外加上一支 middleware：

```python
# middleware/timing.py
import time

class TimingMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        start = time.time()
        response = self.get_response(request)
        duration = time.time() - start
        print(f"{request.path} 花費時間: {duration:.3f}秒")
        return response
```

並於 `settings.py` 註冊：

```python
MIDDLEWARE += ["middleware.timing.TimingMiddleware"]
```

---

## 📊 錯誤報表頁 `/error-log/`

提供錯誤查詢與展開檢視功能：

- 預設列出今天的錯誤紀錄
- 可切換日期（YYYY-MM-DD）
- 每筆錯誤可以展開細節（notes、tag、traceback）

---

## 🚀 每日練習建議

1. 開一個新分支：`feature/day-01`
2. 從 template 開始，重建 CRUD 與錯誤裝飾器應用
3. 練習時間計算與錯誤報表整合
4. Push 至 GitHub，並撰寫 Pull Request 紀錄遇到的挑戰與錯誤

---

持續訓練，每天 30 分鐘內完成 ✅

加油！你會越做越快 💪
