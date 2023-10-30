all: clean build

build:
	mkdir -p /home/abelahce/data/mariadb_volume
	mkdir -p /home/abelahce/data/wordpress_volume
	docker-compose -f srcs/docker-compose.yml up -d --build

clean:
	docker-compose -f srcs/docker-compose.yml down

fclean:
	rm -rf /home/abelahce/data/mariadb_volume
	rm -rf /home/abelahce/data/wordpress_volume
	docker-compose -f srcs/docker-compose.yml down -v

.PHONY: all fclean build clean