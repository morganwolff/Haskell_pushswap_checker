##
## EPITECH PROJECT, 2022
## Makefile
## File description:
## Makefile
##

SRC	=	checker.hs

NAME	=	pushswap_checker

all:
	ghc $(SRC) -o $(NAME)

clean:
	rm -f *.hi *.o

fclean:	clean
	rm -f $(NAME)

re:	fclean all
