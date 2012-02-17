# Included by Makefile of application project.
# x3py framework: https://github.com/rhcad/x3py

TARGET   =$(INSTALL_DIR)/$(PROJNAME)$(APPEXT)
SOURCES  =$(wildcard *.cpp)
OBJS     =$(SOURCES:.cpp=$(OBJEXT))

all:       $(TARGET)
$(TARGET): $(OBJS)
	$(LINK) $(LDFLAGS) $(OUTFLAG)$@ $(OBJS) $(LIBS)

%.d: %.cpp
	$(DEPEND_CC) $@ $(INCLUDES) $<
%$(OBJEXT): %.cpp
	$(CPP) $(CPPFLAGS) $(INCLUDES) -c $<

ifndef clean
include $(SOURCES:.cpp=.d)
endif

clean:
ifndef SWIG_TYPE
	rm -rf *.d *.o *.obj
ifdef cleanall
	rm -rf $(TARGET)
endif
ifdef touch
	touch -c *
endif
endif