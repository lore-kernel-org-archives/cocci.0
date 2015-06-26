From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Thu, 25 Jun 2015 18:06:51 -0700
Subject: [Cocci] [PATCH] patches: increase 0001-netlink-portid.cocci
	dependability
In-Reply-To: <1434748917-23404-1-git-send-email-mcgrof@do-not-panic.com>
References: <1434748917-23404-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <CAB=NE6WB9POGJZMNDxHNgnkV9PZDdEtWwnSJw_mqJezwxnHdog@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jun 19, 2015 at 2:21 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> Using expression is pretty flexible, in this case we
> don't want that flexibility as it can override any
> struct who also uses the same variable name. For a
> specific example of the issue refer to the netdev-ops
> demo git tree [0] which provide an example of the issue
> with two SmPL rules.
>
> We keep the expression on the last rule on NETLINK_CB(skb)
> given that we know only an skb can possibly be used on it.
>
> 1   3.0.101             [  OK  ]
> 2   3.1.10              [  OK  ]
> 3   3.2.68              [  OK  ]
> 4   3.3.8               [  OK  ]
> 5   3.4.107             [  OK  ]
> 6   3.5.7               [  OK  ]
> 7   3.6.11              [  OK  ]
> 8   3.7.10              [  OK  ]
> 9   3.8.13              [  OK  ]
> 10  3.9.11              [  OK  ]
> 11  3.10.75             [  OK  ]
> 12  3.11.10             [  OK  ]
> 13  3.12.40             [  OK  ]
> 14  3.13.11             [  OK  ]
> 15  3.14.39             [  OK  ]
> 16  3.15.10             [  OK  ]
> 17  3.16.7              [  OK  ]
> 18  3.17.8              [  OK  ]
> 19  3.18.12             [  OK  ]
> 20  3.19.5              [  OK  ]
> 21  4.0.0               [  OK  ]
> 22  4.1-rc8             [  OK  ]
>
> [0] https://github.com/mcgrof/netdev-ops.git
>
> Cc: cocci at systeme.lip6.fr
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>

Applied and pushed.

 Luis
