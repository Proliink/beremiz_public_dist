main_target: Beremiz-nsis-installer.exe Beremiz-portable.zip

include $(src)/windows_installer.mk

DIST_FROM_SOURCE_PROJECTS = Modbus

# Alvo principal que depende da construção do Modbus
ide_targets_from_dist: Modbus
	touch $@

# Definição de variáveis
Modbus_dir = installer/Modbus

# Regra principal para construir o Modbus
Modbus: $(Modbus_dir)/.stamp

# Regra detalhada para construção
$(Modbus_dir)/.stamp: sources/Modbus_src | installer
	@echo "Building Modbus..."
	rm -rf $(Modbus_dir)
	mkdir -p $(Modbus_dir)
	cp -a sources/Modbus/* $(Modbus_dir)/  # Note a mudança para copiar o conteúdo
    
	$(MAKE) -C $(Modbus_dir) || exit 1
	cd $(Modbus_dir) && find . -name "*.o" -exec rm {} \;  # Limpeza
	touch $@

# Garante que o diretório installer existe
installer:
	mkdir -p installer

.PHONY: clean
clean:
	rm -rf $(Modbus_dir)
	rm -f ide_targets_from_dist
