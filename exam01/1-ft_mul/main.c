/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/11 07:19:15 by mahug             #+#    #+#             */
/*   Updated: 2025/02/12 05:11:56 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>

void	ft_mul(int *ptr, int number);

int	main(void)
{
	int	a;
	int	b;

	a = 42;
	b = 2;
	ft_mul(&a, b);
	printf("%d\n", a);
	return (0);
}
