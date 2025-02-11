/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/11 07:45:48 by mahug             #+#    #+#             */
/*   Updated: 2025/02/11 07:45:51 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "stdio.h"

int	ft_atoi(const char *str);

int	main(int argc, char **argv)
{
	int	result;

	if (argc != 2)
	{
		printf("Usage: %s <number>\n", argv[0]);
		return (0);
	}
	result = ft_atoi(argv[1]);
	printf("%d\n", result);
	return (0);
}
