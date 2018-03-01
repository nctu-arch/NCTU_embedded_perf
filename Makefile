CC ?= gcc
CFLAGS ?= -Wall -std=gnu99 -g3 -DDEBUG -O0

EXEC = pi matrix
GIT_HOOKS := .git/hooks/applied
.PHONY: all
all: $(GIT_HOOKS) $(EXEC)

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

SRCS_common = main.c

pi: $(SRCS_common) $@.c
	$(CC) $(CFLAGS_common) \
		-o $@ -DPI -DHEADER="\"$@.h\"" \
		$(SRCS_common) $@.c

matrix: $(SRCS_common) $@.c
	$(CC) $(CFLAGS_common) \
		-o $@ -DMATRIX -DHEADER="\"$@.h\"" \
		$(SRCS_common) $@.c

run: $(EXEC)
	echo 3 | sudo tee /proc/sys/vm/drop_caches
	watch -d -t "./phonebook_orig && echo 3 | sudo tee /proc/sys/vm/drop_caches"

cache-test: $(EXEC)
	perf stat --repeat 100 \
		-e cache-misses,cache-references,instructions,cycles \
		./phonebook_orig
	perf stat --repeat 100 \
		-e cache-misses,cache-references,instructions,cycles \
		./phonebook_opt_struct
	perf stat --repeat 100 \
		-e cache-misses,cache-references,instructions,cycles \
		./phonebook_opt_hash

output.txt: cache-test calculate
	./calculate

plot: output.txt
	gnuplot scripts/runtime.gp


.PHONY: clean
clean:
	$(RM) $(EXEC) *.o perf.*
