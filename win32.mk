# Win32 only distribution

main_target: Beremiz-nsis-installer.exe Beremiz-portable.zip

include $(src)/windows_installer.mk

DIST_FROM_SOURCE_PROJECTS = Modbus

# Main target that depends on Modbus build
ide_targets_from_dist: Modbus
	touch $@


Modbus_dir = installer/Modbus


Modbus: $(Modbus_dir)/.stamp


$(Modbus_dir)/.stamp: sources/Modbus_src | installer
	@echo "Building Modbus..."
	rm -rf $(Modbus_dir)
	mkdir -p $(Modbus_dir)
	cp -a sources/Modbus/* $(Modbus_dir)/  # Note a mudança para copiar o conteúdo
    
	$(MAKE) -C $(Modbus_dir) || exit 1
	cd $(Modbus_dir) && find . -name "*.o" -exec rm {} \;  # Limpeza
	touch $@


installer:
	mkdir -p installer

.PHONY: clean
clean:
	rm -rf $(Modbus_dir)
	rm -f ide_targets_from_dist
