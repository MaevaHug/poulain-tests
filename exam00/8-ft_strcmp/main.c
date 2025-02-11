/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/11 07:43:54 by mahug             #+#    #+#             */
/*   Updated: 2025/02/11 07:43:56 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>

int	ft_strcmp(char *s1, char *s2);

int	main(int argc, char **argv)
{
	char	*s1;
	char	*s2;
	int		ret_ft;
	int		ret_libc;

	if (argc != 3)
	{
		printf("Usage: %s <string1> <string2>\n", argv[0]);
		return (0);
	}
	s1 = argv[1];
	s2 = argv[2];
	ret_ft = ft_strcmp(s1, s2);
	ret_libc = strcmp(s1, s2);
	if (ret_ft == ret_libc)
		printf("OK\n");
	else
	{
		printf("KO\n");
		printf("ft_strcmp: %d\n", ret_ft);
		printf("strcmp: %d\n", ret_libc);
	}
	return (0);
}
