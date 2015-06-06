From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Fri,  5 Jun 2015 17:09:58 -0700
Subject: [Cocci] [PATCH 1/4] patches: remove bt_sock_stream_recvmsg() and
	bt_sock_recvmsg() from ifdefs
In-Reply-To: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
References: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1433549401-17006-2-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Both bt_sock_recvmsg() and bt_sock_stream_recvmsg() are used
within bluetooth code but the backport actually required is only
for the struct proto_ops and struct proto sendmsg and recvmsg
callbacks. The bt_sock_recvmsg() and bt_sock_stream_recvmsg()
are not callbacks, they are exported but are used all within
the code we provide and carry.

This will help simplify the network/0054-struct-proto_ops-sig
collateral evolution port to Coccinelle SmPL.

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
22  4.1-rc1             [  OK  ]

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../0054-struct-proto_ops-sig/bluetooth.patch      | 92 ----------------------
 1 file changed, 92 deletions(-)

diff --git a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
index 614e551..1bd0ced 100644
--- a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
@@ -1,53 +1,3 @@
---- a/include/net/bluetooth/bluetooth.h
-+++ b/include/net/bluetooth/bluetooth.h
-@@ -245,10 +245,17 @@ int  bt_sock_register(int proto, const s
- void bt_sock_unregister(int proto);
- void bt_sock_link(struct bt_sock_list *l, struct sock *s);
- void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
- 		     int flags);
- int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
- 			    size_t len, int flags);
-+#else
-+int  bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
-+				struct msghdr *msg, size_t len, int flags);
-+int  bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
-+			struct msghdr *msg, size_t len, int flags);
-+#endif
- uint bt_sock_poll(struct file *file, struct socket *sock, poll_table *wait);
- int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
- int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
---- a/net/bluetooth/af_bluetooth.c
-+++ b/net/bluetooth/af_bluetooth.c
-@@ -210,8 +210,13 @@ struct sock *bt_accept_dequeue(struct so
- }
- EXPORT_SYMBOL(bt_accept_dequeue);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
- 		    int flags)
-+#else
-+int bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
-+				struct msghdr *msg, size_t len, int flags)
-+#endif
- {
- 	int noblock = flags & MSG_DONTWAIT;
- 	struct sock *sk = sock->sk;
-@@ -283,8 +288,13 @@ static long bt_sock_data_wait(struct soc
- 	return timeo;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- int bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
- 			   size_t size, int flags)
-+#else
-+int bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
-+			       struct msghdr *msg, size_t size, int flags)
-+#endif
- {
- 	struct sock *sk = sock->sk;
- 	int err = 0;
 --- a/net/bluetooth/hci_sock.c
 +++ b/net/bluetooth/hci_sock.c
 @@ -906,8 +906,13 @@ static void hci_sock_cmsg(struct sock *s
@@ -108,24 +58,6 @@
  {
  	struct sock *sk = sock->sk;
  	struct l2cap_pinfo *pi = l2cap_pi(sk);
-@@ -1004,9 +1014,17 @@ static int l2cap_sock_recvmsg(struct soc
- 	release_sock(sk);
- 
- 	if (sock->type == SOCK_STREAM)
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- 		err = bt_sock_stream_recvmsg(sock, msg, len, flags);
-+#else
-+		err = bt_sock_stream_recvmsg(iocb, sock, msg, len, flags);
-+#endif
- 	else
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- 		err = bt_sock_recvmsg(sock, msg, len, flags);
-+#else
-+		err = bt_sock_recvmsg(iocb, sock, msg, len, flags);
-+#endif
- 
- 	if (pi->chan->mode != L2CAP_MODE_ERTM)
- 		return err;
 --- a/net/bluetooth/rfcomm/sock.c
 +++ b/net/bluetooth/rfcomm/sock.c
 @@ -549,8 +549,13 @@ static int rfcomm_sock_getname(struct so
@@ -156,18 +88,6 @@
  {
  	struct sock *sk = sock->sk;
  	struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
-@@ -627,7 +637,11 @@ static int rfcomm_sock_recvmsg(struct so
- 		return 0;
- 	}
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- 	len = bt_sock_stream_recvmsg(sock, msg, size, flags);
-+#else
-+	len = bt_sock_stream_recvmsg(iocb, sock, msg, size, flags);
-+#endif
- 
- 	lock_sock(sk);
- 	if (!(flags & MSG_PEEK) && len > 0)
 --- a/net/bluetooth/sco.c
 +++ b/net/bluetooth/sco.c
 @@ -688,8 +688,13 @@ static int sco_sock_getname(struct socke
@@ -198,15 +118,3 @@
  {
  	struct sock *sk = sock->sk;
  	struct sco_pinfo *pi = sco_pi(sk);
-@@ -777,7 +787,11 @@ static int sco_sock_recvmsg(struct socke
- 
- 	release_sock(sk);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- 	return bt_sock_recvmsg(sock, msg, len, flags);
-+#else
-+	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
-+#endif
- }
- 
- static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
-- 
2.3.2.209.gd67f9d5.dirty
