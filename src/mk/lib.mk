
include $(PREFIX)/rules.mk

## Rule for making the actual target
$(TARGET): $(OBJ)
	@echo "============="
	@echo "Linking the target $@"
	@echo "============="
	$(LD) -shared $^ $(LDFLAGS) -o $@ $(LIBS)
	@echo -- Link finished --

