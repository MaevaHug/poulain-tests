/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/19 16:20:33 by mahug             #+#    #+#             */
/*   Updated: 2025/02/19 16:20:35 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>

int	*ft_rrange(int start, int end);

size_t	calculate_size(int start, int end)
{
	return (abs(start - end) + 1);
}

void	print_int_array(int *array, size_t size)
{
	size_t	i;

	i = 0;
	while (i < size)
	{
		if (i == size - 1)
			printf("%d\n", array[i]);
		else
			printf("%d ", array[i]);
		i++;
	}
}

int	main(int argc, char **argv)
{
	int		*range;
	int		start;
	int		end;
	size_t	size;

	if (argc != 3)
	{
		printf("Usage: %s <start> <end>\n", argv[0]);
		return (0);
	}
	start = atoi(argv[1]);
	end = atoi(argv[2]);
	range = ft_rrange(start, end);
	if (!range)
	{
		printf("Memory allocation failed\n");
		return (1);
	}
	size = calculate_size(start, end);
	print_int_array(range, size);
	free(range);
	return (0);
}
