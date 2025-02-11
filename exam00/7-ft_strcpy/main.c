/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/11 07:42:35 by mahug             #+#    #+#             */
/*   Updated: 2025/02/11 07:42:39 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char	*ft_strcpy(char *dest, char *src);

void	check_result(char *dest_ft, char *dest_libc)
{
	if (strcmp(dest_ft, dest_libc) == 0)
		printf("OK\n");
	else
		printf("KO\n");
}

int	main(int argc, char **argv)
{
	char	*src;
	char	*dest_ft;
	char	*dest_libc;

	if (argc != 2)
	{
		printf("Usage: %s <string>\n", argv[0]);
		return (0);
	}
	src = argv[1];
	dest_ft = (char *)malloc(strlen(src) + 1);
	dest_libc = (char *)malloc(strlen(src) + 1);
	if (!dest_ft || !dest_libc)
	{
		printf("Memory allocation failed\n");
		return (1);
	}
	ft_strcpy(dest_ft, src);
	strcpy(dest_libc, src);
	check_result(dest_ft, dest_libc);
	free(dest_ft);
	free(dest_libc);
	return (0);
}
