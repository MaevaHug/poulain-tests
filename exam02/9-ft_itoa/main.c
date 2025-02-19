/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/19 16:16:36 by mahug             #+#    #+#             */
/*   Updated: 2025/02/19 16:16:38 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>

char	*ft_itoa(int n);

int	main(int argc, char **argv)
{
	char	*nb_str;

	if (argc != 2)
	{
		printf("Usage: %s <number>\n", argv[0]);
		return (0);
	}
	nb_str = ft_itoa(atoi(argv[1]));
	if (!nb_str)
	{
		printf("Memory allocation failed\n");
		return (1);
	}
	printf("%s\n", nb_str);
	free(nb_str);
	return (0);
}
