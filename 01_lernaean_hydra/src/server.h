/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: john <marvin@42.fr>                        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/03/07 23:47:25 by john              #+#    #+#             */
/*   Updated: 2019/03/08 01:55:31 by john             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef SERVER_H
# define SERVER_H

# include <unistd.h>
# include <stdlib.h>
# include <sys/socket.h>
# include <sys/types.h>
# include <arpa/inet.h>

# define PORT 4200
# define BACKLOG 42

# define BUFF_SIZE 4098
# define BAD_CONN -1

int			ft_strcmp(const char *s1, const char *s2);
int			read_args(int argc, char **argv);
void		ft_bzero(void *s, size_t n);
void		ft_putstr_fd(char const *s, int fd);

#endif
