/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   union.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/18 00:55:52 by mahug             #+#    #+#             */
/*   Updated: 2025/02/18 00:59:32 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>

void	print_union(char *s1, char *s2)
{
	int	ascii[256] = {0};
	int	i;

	i = 0;
	while (s1[i])
	{
		if (ascii[(unsigned char)s1[i]] == 0)
		{
			write(1, &s1[i], 1);
			ascii[(unsigned char)s1[i]] = 1;
		}
		i++;
	}
	i = 0;
	while (s2[i])
	{
		if (ascii[(unsigned char)s2[i]] == 0)
		{
			write(1, &s2[i], 1);
			ascii[(unsigned char)s2[i]] = 1;
		}
		i++;
	}
}

int	main(int argc, char **argv)
{
	if (argc == 3)
		print_union(argv[1], argv[2]);
	write(1, "\n", 1);
	return (0);
}
