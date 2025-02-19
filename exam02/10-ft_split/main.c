/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/19 16:22:08 by mahug             #+#    #+#             */
/*   Updated: 2025/02/19 16:26:12 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>

char	**ft_split(char *str);

void	print_words(char **words)
{
	int	i;

	i = 0;
	while (words[i])
	{
		printf("[%s]", words[i]);
		i++;
	}
	printf("[%s]", words[i]);
	printf("\n");
}

void	free_words(char **words)
{
	int	i;

	i = 0;
	while (words[i])
	{
		free(words[i]);
		i++;
	}
	free(words);
}

int	main(int argc, char **argv)
{
	char	**words;

	if (argc != 2)
	{
		printf("Usage: %s <string>\n", argv[0]);
		return (0);
	}
	words = ft_split(argv[1]);
	if (!words)
	{
		printf("Memory allocation failed.\n");
		return (1);
	}
	print_words(words);
	free_words(words);
	return (0);
}
