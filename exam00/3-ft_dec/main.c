/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/11 07:19:15 by mahug             #+#    #+#             */
/*   Updated: 2025/02/11 07:24:19 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>

void	ft_dec(int *ptr);

int	main(void)
{
	int	a;

	a = 42;
	ft_dec(&a);
	printf("%d\n", a);
	return (0);
}
