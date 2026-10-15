.PHONY: all zh en print clean serve help

# 编译器与参数配置
LATEXMK    := latexmk -xelatex -interaction=nonstopmode
LATEX_DIR  := latex
BUILD_ZH   := $(LATEX_DIR)/build-zh
BUILD_EN   := $(LATEX_DIR)/build-en
RESUME_DIR := resume

# 归档文件名定义
TARGET_ZH_PDF := $(RESUME_DIR)/牛群_北京理工大学_nq_eecm@163.com_15601280520.pdf
TARGET_EN_PDF := $(RESUME_DIR)/QunNiu_BeijingInstituteofTechnology_nq_eecm@163.com_15601280520.pdf

all: zh en print

zh:
	@mkdir -p $(BUILD_ZH) $(RESUME_DIR)
	$(LATEXMK) -output-directory=$(BUILD_ZH) -jobname=cv_zh $(LATEX_DIR)/cv_zh.tex
	@cp "$(BUILD_ZH)/cv_zh.pdf" "$(TARGET_ZH_PDF)"
	@echo "==> 中文简历已生成并同步至: $(TARGET_ZH_PDF)"

en:
	@mkdir -p $(BUILD_EN) $(RESUME_DIR)
	$(LATEXMK) -output-directory=$(BUILD_EN) -jobname=cv_en $(LATEX_DIR)/cv_en.tex
	@cp "$(BUILD_EN)/cv_en.pdf" "$(TARGET_EN_PDF)"
	@echo "==> 英文简历已生成并同步至: $(TARGET_EN_PDF)"

print:
	@mkdir -p $(BUILD_ZH)
	$(LATEXMK) -output-directory=$(BUILD_ZH) -jobname=cv_zh_print $(LATEX_DIR)/cv_zh_print.tex
	@echo "==> 中文双页打印版已生成至: $(BUILD_ZH)/cv_zh_print.pdf"

clean:
	@rm -f $(BUILD_ZH)/*.aux $(BUILD_ZH)/*.log $(BUILD_ZH)/*.fls $(BUILD_ZH)/*.fdb_latexmk $(BUILD_ZH)/*.out $(BUILD_ZH)/*.xdv
	@rm -f $(BUILD_EN)/*.aux $(BUILD_EN)/*.log $(BUILD_EN)/*.fls $(BUILD_EN)/*.fdb_latexmk $(BUILD_EN)/*.out $(BUILD_EN)/*.xdv
	@echo "==> 编译临时辅助文件清理完毕"

serve:
	uv run python -m http.server 8000

help:
	@echo "可用指令列表："
	@echo "  make        一键编译全量中文、英文及双页打印版，并自动同步发布 PDF"
	@echo "  make zh     编译中文简历并同步至 resume/ 目录"
	@echo "  make en     编译英文简历并同步至 resume/ 目录"
	@echo "  make print  编译中文双页打印版简历至 latex/build-zh/cv_zh_print.pdf"
	@echo "  make clean  清理 LaTeX 编译生成的中间临时文件"
	@echo "  make serve  通过 uv 启动本地静态主页服务 (端口 8000)"
