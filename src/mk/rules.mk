
OBJ=$(join $(addsuffix .obj/, $(dir $(SOURCE))), $(notdir $(SOURCE:.cpp=.o))) 

## Fix dependency destination to be ../.dep relative to the src dir
DEPENDS=$(join $(addsuffix .dep/, $(dir $(SOURCE))), $(notdir $(SOURCE:.cpp=.d)))
PUBLIC_HEADERS_=$(join $(addsuffix ../include/, $(dir $(PUBLIC_HEADERS))), $(notdir $(PUBLIC_HEADERS)))

## Default rule executed
all: $(PUBLIC_HEADERS_) $(TARGET)
	@true

clean: 
	$(RM) -f $(OBJ) $(DEPENDS)

## Rules for object files from cpp files
## Object file for each file is put in obj directory
## one level up from the actual source directory.
.obj/%.o : %.cpp
	@mkdir -p $(dir $@)
	@echo "============="
	@echo "Compiling $<"
	@$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $@

## Make dependancy rules
.dep/%.d: %.cpp
	@mkdir -p $(dir $@)
	@echo "============="
	@echo Building dependencies file for $*.o
	@$(SHELL) -ec '$(CC) -M $(CFLAGS) $(INCLUDE) $< | sed "s^$*.o^.obj/$*.o^" > $@'

$(PUBLIC_HEADERS_):
	@mkdir -p $(dir $@)
	@echo "============="
	@echo Creating public header $@
	$(LN) $(shell pwd)/$(notdir $@) $@


## Include the dependency files
-include $(DEPENDS)
