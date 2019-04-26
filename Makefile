all:
	erlc *.erl

clean:
	rm -f *.beam *.dump

.PHONY: clean

