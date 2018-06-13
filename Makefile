.DEFAULT_GOAL := build

BINNAME=ponitor

build:
	stable env ponyc src/ -b $(BINNAME)

build-debug:
	stable env ponyc src/ -b $(BINNAME) -d


run: build
	./ponitor

clean:
	rm ponitor
