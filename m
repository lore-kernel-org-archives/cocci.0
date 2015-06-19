From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Fri, 19 Jun 2015 14:21:57 -0700
Subject: [Cocci] [PATCH] patches: increase 0001-netlink-portid.cocci
	dependability
Message-ID: <1434748917-23404-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Using expression is pretty flexible, in this case we
don't want that flexibility as it can override any
struct who also uses the same variable name. For a
specific example of the issue refer to the netdev-ops
demo git tree [0] which provide an example of the issue
with two SmPL rules.

We keep the expression on the last rule on NETLINK_CB(skb)
given that we know only an skb can possibly be used on it.

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.68              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.107             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.75             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.40             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.39             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.12             [  OK  ]
20  3.19.5              [  OK  ]
21  4.0.0               [  OK  ]
22  4.1-rc8             [  OK  ]

[0] https://github.com/mcgrof/netdev-ops.git

Cc: cocci at systeme.lip6.fr
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../collateral-evolutions/network/0001-netlink-portid.cocci    | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/patches/collateral-evolutions/network/0001-netlink-portid.cocci b/patches/collateral-evolutions/network/0001-netlink-portid.cocci
index 409e926..5fc504e 100644
--- a/patches/collateral-evolutions/network/0001-netlink-portid.cocci
+++ b/patches/collateral-evolutions/network/0001-netlink-portid.cocci
@@ -1,23 +1,15 @@
- at nl1@
-identifier notify;
 @@
 struct netlink_notify *notify;
 @@
-identifier nl1.notify;
-@@
 -notify->portid
 +netlink_notify_portid(notify)
 
-// This works because no other struct in the kernel
-// has an snd_portid member.
 @@
-expression info;
+struct genl_info *info;
 @@
 -info->snd_portid
 +genl_info_snd_portid(info)
 
-// skb is an expression since it could be something
-// other than just an identifier, e.g. cb->skb
 @@
 expression skb;
 @@
-- 
2.3.2.209.gd67f9d5.dirty
