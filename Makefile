NAME = magisk-Kyrielight-Pixel-Thermal
MODBIN = https://raw.githubusercontent.com/topjohnwu/Magisk/master/scripts/module_installer.sh
MODFILES = module.prop customize.sh LICENSE README.md
THERMAL = thermal_info_config.json thermal-engine.conf
VER = $(shell grep version= module.prop | cut -d= -f2)
TARGET = $(addsuffix .zip,$(addsuffix -$(VER),$(NAME)))
OUT = dist

.PHONY: $(OUT) $(THERMAL)

$(OUT):
	@curl $(MODBIN) --create-dirs -o dist/META-INF/com/google/android/update-binary
	@echo '#MAGISK' > dist/META-INF/com/google/android/updater-script

$(THERMAL): $(OUT)
	@install -D $@ $(OUT)/system/vendor/etc/$@

check:
	@unzip -l dist/$(TARGET)

clean:
	@rm -rf dist

pkg: $(THERMAL)
	@install $(MODFILES) $(OUT)
	@cd dist && zip -qr $(TARGET) META-INF system $(MODFILES)

all: clean pkg check
