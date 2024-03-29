## BeOS Generic Makefile ##

## Fill in the top section of this makefile to define exactly what sort of
## binary you are creating, and what sources, resources and libraries are
## needed to create it.  The makefile will then determine the proper
## platform specific options.

## Fill in the top section to define the binary being created and the makefile
## will make sure that all of the hard work is taken care of for you, for both
## PowerPC and Intel versions of the BeOS.

## Application Specific Settings ---------------------------------------------

# specify the name of the binary
NAME = beserved_client

# specify the type of binary
#	APP:	Application
#	SHARED:	Shared library or add-on
#	STATIC:	Static library archive
#	DRIVER: Kernel Driver
TYPE = DRIVER

# specify the source files to use
#	full paths or paths relative to the makefile can be included
# 	all files, regardless of directory, will have their object
#	files created in the common object directory.
#	Note that this means this makefile will not work correctly
#	if two source files with the same name (source.c or source.cpp)
#	are included from different directories.  Also note that spaces
#	in folder names do not work well with this makefile.
SRCS = nfs_add_on.c btClient.c readerWriter.c

# specify the resource files to use
#	full path or a relative path to the resource file can be used.
RSRCS =

#specify additional libraries to link against
#	if libName.so or libName.a is the name of the library to link against
# 	then simply specify Name in the LIBS list
# 	if there is another naming scheme use the full binary
#	name: my_library.so or my_lib.a
#	libroot.so never needs to be specified here, although libbe.so does
LIBS =

#	specify the paths to directories where additional
# 	libraries are to be found.  /boot/develop/lib/PLATFORM/ is
#	already set.  The paths can be full or relative to this
#	makefile.  The paths included may not be recursive, so
#	specify all of the needed paths explicitly
#	Directories containing source-files are automatically added.
LIBPATHS =

#	specify additional directories where header files can be found
# 	directories where sources are found are included automatically
#	included.
INCPATHS = ../Common

#	specify the level of optimization that you desire
#	NONE, SOME, FULL
OPTIMIZE= FULL

#	specify any symbols to be defined.  The symbols will be
#	set to a value of 1.  For example specify DEBUG if you want
#	DEBUG=1 to be set when compiling.
DEFINES= 

#	specify special warning levels
#	if unspecified default warnings will be used
#	NONE = supress all warnings
#	ALL = enable all warnings
WARNINGS = 

#	specify symbols
#	if TRUE debug symbols will be created
SYMBOLS = 


## Generic Makefile Rules ---------------------------
##	DO NOT MODIFY BENEATH THIS LINE -----------------

#	set the directory where object files and binaries will be created
	OBJ_DIR		:= obj.$(CPU)

# 	specify that the binary should be created in the object directory
	TARGET		:= ../Release/$(NAME)

#	specify the mimeset tool
	MIMESET		:= mimeset

# specify the tools for adding and removing resources
	XRES		= xres

# 	SETTING: define debug symbols if desired
ifeq ($(SYMBOLS), TRUE)
	CFLAGS += -g
endif


# 	platform specific settings

#	x86 Settings
ifeq ($(CPU), x86)
#	set the compiler and compiler flags
	CC		=	gcc
	##!! change next time : drivers get -no-fpic and -fpic goes away !!
	CFLAGS	+=	-fpic

#	SETTING: set the proper optimization level
	ifeq ($(OPTIMIZE), FULL)
		OPTIMIZER	= -O3
	else
	ifeq ($(OPTIMIZE), SOME)
		OPTIMIZER	= -O1
	else
	ifeq ($(OPTIMIZE), NONE)
		OPTIMIZER	=
	endif
	endif
	endif

	CFLAGS += $(OPTIMIZER)
	
#	SETTING: set warning level
	ifeq ($(WARNINGS), ALL)
		CFLAGS += -Wall -Wno-multichar -Wno-ctor-dtor-privacy
	else
	ifeq ($(WARNINGS), NONE)
	
	endif
	endif

#	set the linker and linker flags
	LD			= gcc
	LDFLAGS		=

#	SETTING: set linker flags for each binary type
	ifeq ($(TYPE), APP)
		LDFLAGS += -Xlinker -soname=_APP_
	else
	ifeq ($(TYPE), SHARED)
		LDFLAGS += -addon -Xlinker -soname=$(NAME)
	else
	ifeq ($(TYPE), DRIVER)
		LDFLAGS += -nostdlib  /boot/develop/lib/x86/_KERNEL_
	endif 
	endif 
	endif 

else

#	SETTING: set the proper optimization level
	ifeq ($(OPTIMIZE), FULL)
		OPTIMIZER	= -O7
	else
	ifeq ($(OPTIMIZE), SOME)
		OPTIMIZER	= -O3
	else
	ifeq ($(OPTIMIZE), NONE)
		OPTIMIZER	=
	endif
	endif

	CFLAGS += $(OPTIMIZER)
	
#	SETTING: set warning level
	ifeq ($(WARNINGS), ALL)
		CFLAGS += -w all
	else
	ifeq ($(WARNINGS), NONE)
		CFLAGS += -w 0
	endif
	endif

	# clear the standard environment variable
	# now there are no standard libraries to link against
	BELIBFILES=

#	set the linker and linker flags
	LD			= mwldppc

	ifeq ($(TYPE), APP)
		LDFLAGS += 
	else
	ifeq ($(TYPE), SHARED)
		LDFLAGS += 	-xms 
	endif
	endif

	ifeq ($(TYPE), DRIVER)
		LDFLAGS += -nodefaults \
					-export all \
					-G \
					/boot/develop/lib/ppc/glue-noinit.a \
					/boot/develop/lib/ppc/_KERNEL_
	else
		# override the standard environment variable
		LDFLAGS +=	-export pragma \
					-init _init_routine_ \
					-term _term_routine_ \
					-lroot \
					/boot/develop/lib/ppc/glue-noinit.a \
					/boot/develop/lib/ppc/init_term_dyn.o \
					/boot/develop/lib/ppc/start_dyn.o 
					
	endif
	

endif
endif


# psuedo-function for converting a list of source files in SRCS variable
# to a corresponding list of object files in $(OBJ_DIR)/xxx.o
# The "function" strips off the src file suffix (.ccp or .c or whatever)
# and then strips of the directory name, leaving just the root file name.
# It then appends the .o suffix and prepends the $(OBJ_DIR)/ path
define SRCS_LIST_TO_OBJS
	$(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(foreach file, $(SRCS), \
	$(basename $(notdir $(file))))))
endef

OBJS = $(SRCS_LIST_TO_OBJS)

# create a unique list of paths to our sourcefiles
SRC_PATHS += $(sort $(foreach file, $(SRCS), $(dir $(file))))

# add source paths to VPATH if not already present
VPATH :=
VPATH += $(addprefix :, $(subst  ,:, $(filter-out $($(subst, :, ,$(VPATH))), $(SRC_PATHS))))

# add source paths and include paths to INLCUDES if not already present
INCLUDES = $(foreach path, $(INCPATHS) $(SRC_PATHS), $(addprefix -I, $(path)))


# SETTING: add the -L prefix to all library paths to search
LINK_PATHS = $(foreach path, $(LIBPATHS) $(SRC_PATHS) , \
	$(addprefix -L, $(path)))

# SETTING: add the -l prefix to all libs to be linked against
LINK_LIBS = $(foreach lib, $(LIBS), $(addprefix -l, $(lib)))

# add to the linker flags 
LDFLAGS += $(LINK_PATHS) $(LINK_LIBS)

#	SETTING: add the defines to the compiler flags
CFLAGS += $(foreach define, $(DEFINES), $(addprefix -D, $(define)))

#	SETTING: use the archive tools if building a static library
#	otherwise use the linker
ifeq ($(TYPE), STATIC)
	BUILD_LINE = ar -cru $(NAME) $(OBJS)
else
	BUILD_LINE = $(LD) -o $@ $(OBJS) $(LDFLAGS)
endif

#	create the resource instruction
	ifeq ($(RSRCS), )
		DO_RSRCS :=
	else
		DO_RSRCS := $(XRES) -o $(TARGET) $(RSRCS)
	endif


#	define the actual work to be done	
default: $(TARGET)

$(TARGET):	$(OBJ_DIR) $(OBJS) $(RSRCS)
		$(BUILD_LINE)
		$(DO_RSRCS)
		$(MIMESET) -f $@


#	rule to create the object file directory if needed
$(OBJ_DIR)::
	@[ -d $(OBJ_DIR) ] || mkdir $(OBJ_DIR) > /dev/null 2>&1

$(OBJ_DIR)/%.o : %.c
	$(CC) $(INCLUDES) $(CFLAGS) -c $< -o $@
$(OBJ_DIR)/%.o : %.cpp
	$(CC) $(INCLUDES) $(CFLAGS) -c $< -o $@
$(OBJ_DIR)/%.o : %.cp
	$(CC) $(INCLUDES) $(CFLAGS) -c $< -o $@
$(OBJ_DIR)/%.o : %.C
	$(CC) $(INCLUDES) $(CFLAGS) -c $< -o $@
$(OBJ_DIR)/%.o : %.CC
	$(CC) $(INCLUDES) $(CFLAGS) -c $< -o $@
$(OBJ_DIR)/%.o : %.CPP
	$(CC) $(INCLUDES) $(CFLAGS) -c $< -o $@


#	empty rule. Things that depend on this rule will always get triggered
FORCE:

#	The generic clean command. Delete everything in the object folder.
clean :: FORCE
	-rm -rf $(OBJ_DIR)

#	remove just the application from the object folder
rmapp ::
	-rm -f $(TARGET)
