From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Fri,  5 Jun 2015 17:09:59 -0700
Subject: [Cocci] [PATCH 2/4] patches: change 0054-struct-proto_ops-sig
	backport strategy
In-Reply-To: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
References: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1433549401-17006-3-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This modifies we backport the struct proto_ops and struct proto
declarations from adding #idefs around the function prototype
arguments to just declaring our own new backport callback for
older kernels with the extra argument which calls the the
upstream function. This is done because we cannot write an
SmPL grammar patch to backport the collateral evolution as we
do it now. The backport strategy we provide now is equivalent
in terms of functionality but also a lot more clear, it also
leaves the upstream code unmodified as much as possible, this
should enable anyone reviewing the code to be able to more
easily determine exactly what is going on.

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

real    53m48.791s
user    1437m15.048s
sys     217m20.652s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../0054-struct-proto_ops-sig/bluetooth.patch      | 235 +++++++++++++--------
 .../0054-struct-proto_ops-sig/ieee802154.patch     | 161 +++++++++-----
 .../network/0054-struct-proto_ops-sig/nfc.patch    | 138 ++++++++----
 3 files changed, 356 insertions(+), 178 deletions(-)

diff --git a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
index 1bd0ced..2cf5a9e 100644
--- a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
@@ -1,120 +1,187 @@
 --- a/net/bluetooth/hci_sock.c
 +++ b/net/bluetooth/hci_sock.c
-@@ -906,8 +906,13 @@ static void hci_sock_cmsg(struct sock *s
- 	}
+@@ -953,6 +953,14 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+ 
+ 	return err ? : copied;
  }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_hci_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
++				     struct msghdr *msg, size_t len,
++				     int flags)
++{
++	return hci_sock_recvmsg(sock, msg, len, flags);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
- 			    int flags)
-+#else
-+static int hci_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
-+			    struct msghdr *msg, size_t len, int flags)
-+#endif
- {
- 	int noblock = flags & MSG_DONTWAIT;
- 	struct sock *sk = sock->sk;
-@@ -1065,8 +1070,13 @@ done:
- 	return err;
+ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
+ 			struct msghdr *msg, size_t msglen)
+@@ -1189,6 +1196,13 @@ drop:
+ 	kfree_skb(skb);
+ 	goto done;
  }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
++				     struct msghdr *msg, size_t len)
++{
++	return hci_sock_sendmsg(sock, msg, len);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
  
+ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
+ 			       char __user *optval, unsigned int len)
+@@ -1345,8 +1358,13 @@ static const struct proto_ops hci_sock_ops = {
+ 	.release	= hci_sock_release,
+ 	.bind		= hci_sock_bind,
+ 	.getname	= hci_sock_getname,
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
- 			    size_t len)
+ 	.sendmsg	= hci_sock_sendmsg,
+ 	.recvmsg	= hci_sock_recvmsg,
 +#else
-+static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
-+			    struct msghdr *msg, size_t len)
-+#endif
- {
- 	struct sock *sk = sock->sk;
- 	struct hci_mgmt_chan *chan;
++	.sendmsg = backport_hci_sock_sendmsg,
++	.recvmsg = backport_hci_sock_recvmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+ 	.ioctl		= hci_sock_ioctl,
+ 	.poll		= datagram_poll,
+ 	.listen		= sock_no_listen,
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -944,8 +944,13 @@ static int l2cap_sock_setsockopt(struct
+@@ -975,6 +975,13 @@ static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg,
+ 
  	return err;
  }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_l2cap_sock_sendmsg(struct kiocb *iocb,
++				       struct socket *sock,
++				       struct msghdr *msg, size_t len){
++	return l2cap_sock_sendmsg(sock, msg, len);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg,
- 			      size_t len)
-+#else
-+static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
-+			      struct msghdr *msg, size_t len)
-+#endif
- {
- 	struct sock *sk = sock->sk;
- 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-@@ -976,8 +981,13 @@ static int l2cap_sock_sendmsg(struct soc
+ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
+ 			      size_t len, int flags)
+@@ -1036,6 +1043,14 @@ done:
+ 	release_sock(sk);
  	return err;
  }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_l2cap_sock_recvmsg(struct kiocb *iocb,
++				       struct socket *sock,
++				       struct msghdr *msg, size_t len,
++				       int flags){
++	return l2cap_sock_recvmsg(sock, msg, len, flags);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
  
+ /* Kill socket (only if zapped and orphan)
+  * Must be called on unlocked socket.
+@@ -1618,8 +1633,16 @@ static const struct proto_ops l2cap_sock_ops = {
+ 	.listen		= l2cap_sock_listen,
+ 	.accept		= l2cap_sock_accept,
+ 	.getname	= l2cap_sock_getname,
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
- 			      size_t len, int flags)
+ 	.sendmsg	= l2cap_sock_sendmsg,
 +#else
-+static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
-+			      struct msghdr *msg, size_t len, int flags)
-+#endif
- {
- 	struct sock *sk = sock->sk;
- 	struct l2cap_pinfo *pi = l2cap_pi(sk);
++	.sendmsg = backport_l2cap_sock_sendmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	.recvmsg	= l2cap_sock_recvmsg,
++#else
++	.recvmsg = backport_l2cap_sock_recvmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+ 	.poll		= bt_sock_poll,
+ 	.ioctl		= bt_sock_ioctl,
+ 	.mmap		= sock_no_mmap,
 --- a/net/bluetooth/rfcomm/sock.c
 +++ b/net/bluetooth/rfcomm/sock.c
-@@ -549,8 +549,13 @@ static int rfcomm_sock_getname(struct so
- 	return 0;
- }
+@@ -622,6 +622,13 @@ done:
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- static int rfcomm_sock_sendmsg(struct socket *sock, struct msghdr *msg,
- 			       size_t len)
-+#else
-+static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
-+			       struct msghdr *msg, size_t len)
-+#endif
- {
- 	struct sock *sk = sock->sk;
- 	struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
-@@ -615,8 +620,13 @@ done:
  	return sent;
  }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_rfcomm_sock_sendmsg(struct kiocb *iocb,
++					struct socket *sock,
++					struct msghdr *msg, size_t len){
++	return rfcomm_sock_sendmsg(sock, msg, len);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
  static int rfcomm_sock_recvmsg(struct socket *sock, struct msghdr *msg,
  			       size_t size, int flags)
-+#else
-+static int rfcomm_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
-+			       struct msghdr *msg, size_t size, int flags)
-+#endif
+@@ -647,6 +654,14 @@ static int rfcomm_sock_recvmsg(struct socket *sock, struct msghdr *msg,
+ 
+ 	return len;
+ }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_rfcomm_sock_recvmsg(struct kiocb *iocb,
++					struct socket *sock,
++					struct msghdr *msg, size_t len,
++					int flags){
++	return rfcomm_sock_recvmsg(sock, msg, len, flags);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
+ 
+ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname, char __user *optval, unsigned int optlen)
  {
- 	struct sock *sk = sock->sk;
- 	struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
+@@ -1044,8 +1059,16 @@ static const struct proto_ops rfcomm_sock_ops = {
+ 	.listen		= rfcomm_sock_listen,
+ 	.accept		= rfcomm_sock_accept,
+ 	.getname	= rfcomm_sock_getname,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	.sendmsg	= rfcomm_sock_sendmsg,
++#else
++	.sendmsg = backport_rfcomm_sock_sendmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	.recvmsg	= rfcomm_sock_recvmsg,
++#else
++	.recvmsg = backport_rfcomm_sock_recvmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+ 	.shutdown	= rfcomm_sock_shutdown,
+ 	.setsockopt	= rfcomm_sock_setsockopt,
+ 	.getsockopt	= rfcomm_sock_getsockopt,
 --- a/net/bluetooth/sco.c
 +++ b/net/bluetooth/sco.c
-@@ -688,8 +688,13 @@ static int sco_sock_getname(struct socke
- 	return 0;
+@@ -713,6 +713,12 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
+ 	release_sock(sk);
+ 	return err;
  }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
++				     struct msghdr *msg, size_t len){
++	return sco_sock_sendmsg(sock, msg, len);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
- 			    size_t len)
-+#else
-+static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
-+			    struct msghdr *msg, size_t len)
-+#endif
+ static void sco_conn_defer_accept(struct hci_conn *conn, u16 setting)
  {
- 	struct sock *sk = sock->sk;
- 	int err;
-@@ -758,8 +763,13 @@ static void sco_conn_defer_accept(struct
- 	}
+@@ -779,6 +785,13 @@ static int sco_sock_recvmsg(struct socket *sock, struct msghdr *msg,
+ 
+ 	return bt_sock_recvmsg(sock, msg, len, flags);
  }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
++				     struct msghdr *msg, size_t len,
++				     int flags){
++	return sco_sock_recvmsg(sock, msg, len, flags);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
  
+ static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
+ {
+@@ -1178,8 +1191,16 @@ static const struct proto_ops sco_sock_ops = {
+ 	.listen		= sco_sock_listen,
+ 	.accept		= sco_sock_accept,
+ 	.getname	= sco_sock_getname,
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- static int sco_sock_recvmsg(struct socket *sock, struct msghdr *msg,
- 			    size_t len, int flags)
+ 	.sendmsg	= sco_sock_sendmsg,
 +#else
-+static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
-+			    struct msghdr *msg, size_t len, int flags)
-+#endif
- {
- 	struct sock *sk = sock->sk;
- 	struct sco_pinfo *pi = sco_pi(sk);
++	.sendmsg = backport_sco_sock_sendmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	.recvmsg	= sco_sock_recvmsg,
++#else
++	.recvmsg = backport_sco_sock_recvmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+ 	.poll		= bt_sock_poll,
+ 	.ioctl		= bt_sock_ioctl,
+ 	.mmap		= sock_no_mmap,
diff --git a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
index cfb77f3..0497dbe 100644
--- a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
@@ -1,79 +1,134 @@
 --- a/net/ieee802154/socket.c
 +++ b/net/ieee802154/socket.c
-@@ -96,12 +96,21 @@ static int ieee802154_sock_release(struc
- 	return 0;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- static int ieee802154_sock_sendmsg(struct socket *sock, struct msghdr *msg,
- 				   size_t len)
-+#else
-+static int ieee802154_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
-+				   struct msghdr *msg, size_t len)
-+#endif
+@@ -101,8 +101,19 @@ static int ieee802154_sock_sendmsg(struct socket *sock, struct msghdr *msg,
  {
  	struct sock *sk = sock->sk;
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
  	return sk->sk_prot->sendmsg(sk, msg, len);
 +#else
-+	return sk->sk_prot->sendmsg(iocb, sk, msg, len);
-+#endif
++	return sk->sk_prot->sendmsg(NULL, sk, msg, len);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
  }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_ieee802154_sock_sendmsg(struct kiocb *iocb,
++					    struct socket *sock,
++					    struct msghdr *msg, size_t len){
++	return ieee802154_sock_sendmsg(sock, msg, len);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
  
  static int ieee802154_sock_bind(struct socket *sock, struct sockaddr *uaddr,
-@@ -253,7 +262,12 @@ static int raw_disconnect(struct sock *s
- 	return 0;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
-+#else
-+static int raw_sendmsg(struct kiocb *iocb, struct sock *sk,
-+		       struct msghdr *msg, size_t size)
-+#endif
- {
- 	struct net_device *dev;
- 	unsigned int mtu;
-@@ -324,8 +338,13 @@ out:
+ 				int addr_len)
+@@ -323,6 +334,12 @@ out_dev:
+ out:
  	return err;
  }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_raw_sendmsg(struct kiocb *iocb, struct socket *sock,
++				struct msghdr *msg, size_t len){
++	return raw_sendmsg(sock, msg, len);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
  static int raw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
  		       int noblock, int flags, int *addr_len)
-+#else
-+static int raw_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
-+		       size_t len, int noblock, int flags, int *addr_len)
-+#endif
- {
- 	size_t copied = 0;
- 	int err = -EOPNOTSUPP;
-@@ -612,7 +631,12 @@ static int dgram_disconnect(struct sock
- 	return 0;
+@@ -356,6 +373,13 @@ out:
+ 		return err;
+ 	return copied;
  }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_raw_recvmsg(struct kiocb *iocb, struct socket *sock,
++				struct msghdr *msg, size_t len, int noblock,
++				int flags, int *addr_len){
++	return raw_recvmsg(sock, msg, len, noblock, flags, addr_len);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
  
+ static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
+ {
+@@ -409,8 +433,16 @@ static struct proto ieee802154_raw_prot = {
+ 	.obj_size	= sizeof(struct sock),
+ 	.close		= raw_close,
+ 	.bind		= raw_bind,
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- static int dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
+ 	.sendmsg	= raw_sendmsg,
 +#else
-+static int dgram_sendmsg(struct kiocb *iocb, struct sock *sk,
-+			 struct msghdr *msg, size_t size)
-+#endif
- {
- 	struct net_device *dev;
- 	unsigned int mtu;
-@@ -711,8 +735,14 @@ out:
++	.sendmsg = backport_raw_sendmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	.recvmsg	= raw_recvmsg,
++#else
++	.recvmsg = backport_raw_recvmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+ 	.hash		= raw_hash,
+ 	.unhash		= raw_unhash,
+ 	.connect	= raw_connect,
+@@ -434,7 +466,11 @@ static const struct proto_ops ieee802154_raw_ops = {
+ 	.shutdown	   = sock_no_shutdown,
+ 	.setsockopt	   = sock_common_setsockopt,
+ 	.getsockopt	   = sock_common_getsockopt,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	.sendmsg	   = ieee802154_sock_sendmsg,
++#else
++	.sendmsg = backport_ieee802154_sock_sendmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+ 	.recvmsg	   = sock_common_recvmsg,
+ 	.mmap		   = sock_no_mmap,
+ 	.sendpage	   = sock_no_sendpage,
+@@ -710,6 +746,12 @@ out_dev:
+ out:
  	return err;
  }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_dgram_sendmsg(struct kiocb *iocb, struct socket *sock,
++				  struct msghdr *msg, size_t len){
++	return dgram_sendmsg(sock, msg, len);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
  static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
  			 int noblock, int flags, int *addr_len)
-+#else
-+static int dgram_recvmsg(struct kiocb *iocb, struct sock *sk,
-+			 struct msghdr *msg, size_t len, int noblock,
-+			 int flags, int *addr_len)
-+#endif
+@@ -751,6 +793,13 @@ out:
+ 		return err;
+ 	return copied;
+ }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_dgram_recvmsg(struct kiocb *iocb, struct socket *sock,
++				  struct msghdr *msg, size_t len, int noblock,
++				  int flags, int *addr_len){
++	return dgram_recvmsg(sock, msg, len, noblock, flags, addr_len);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
+ 
+ static int dgram_rcv_skb(struct sock *sk, struct sk_buff *skb)
  {
- 	size_t copied = 0;
- 	int err = -EOPNOTSUPP;
+@@ -947,8 +996,16 @@ static struct proto ieee802154_dgram_prot = {
+ 	.init		= dgram_init,
+ 	.close		= dgram_close,
+ 	.bind		= dgram_bind,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	.sendmsg	= dgram_sendmsg,
++#else
++	.sendmsg = backport_dgram_sendmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	.recvmsg	= dgram_recvmsg,
++#else
++	.recvmsg = backport_dgram_recvmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+ 	.hash		= dgram_hash,
+ 	.unhash		= dgram_unhash,
+ 	.connect	= dgram_connect,
+@@ -973,7 +1030,11 @@ static const struct proto_ops ieee802154_dgram_ops = {
+ 	.shutdown	   = sock_no_shutdown,
+ 	.setsockopt	   = sock_common_setsockopt,
+ 	.getsockopt	   = sock_common_getsockopt,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	.sendmsg	   = ieee802154_sock_sendmsg,
++#else
++	.sendmsg = backport_ieee802154_sock_sendmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+ 	.recvmsg	   = sock_common_recvmsg,
+ 	.mmap		   = sock_no_mmap,
+ 	.sendpage	   = sock_no_sendpage,
diff --git a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch
index 3bc5fc0..e29c4d8 100644
--- a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch
+++ b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch
@@ -1,59 +1,115 @@
 --- a/net/nfc/llcp_sock.c
 +++ b/net/nfc/llcp_sock.c
-@@ -750,8 +750,13 @@ error:
- 	return ret;
- }
+@@ -792,6 +792,12 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
- 			     size_t len)
-+#else
-+static int llcp_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
-+			     struct msghdr *msg, size_t len)
-+#endif
- {
- 	struct sock *sk = sock->sk;
- 	struct nfc_llcp_sock *llcp_sock = nfc_llcp_sock(sk);
-@@ -793,8 +798,13 @@ static int llcp_sock_sendmsg(struct sock
  	return nfc_llcp_send_i_frame(llcp_sock, msg, len);
  }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_llcp_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
++				      struct msghdr *msg, size_t len){
++	return llcp_sock_sendmsg(sock, msg, len);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
  static int llcp_sock_recvmsg(struct socket *sock, struct msghdr *msg,
  			     size_t len, int flags)
-+#else
-+static int llcp_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
-+			     struct msghdr *msg, size_t len, int flags)
-+#endif
- {
- 	int noblock = flags & MSG_DONTWAIT;
- 	struct sock *sk = sock->sk;
---- a/net/nfc/rawsock.c
-+++ b/net/nfc/rawsock.c
-@@ -211,7 +211,12 @@ static void rawsock_tx_work(struct work_
- 	}
+@@ -882,6 +888,13 @@ done:
+ 
+ 	return copied;
  }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_llcp_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
++				      struct msghdr *msg, size_t len,
++				      int flags){
++	return llcp_sock_recvmsg(sock, msg, len, flags);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
  
+ static const struct proto_ops llcp_sock_ops = {
+ 	.family         = PF_NFC,
+@@ -898,8 +911,16 @@ static const struct proto_ops llcp_sock_ops = {
+ 	.shutdown       = sock_no_shutdown,
+ 	.setsockopt     = nfc_llcp_setsockopt,
+ 	.getsockopt     = nfc_llcp_getsockopt,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	.sendmsg        = llcp_sock_sendmsg,
++#else
++	.sendmsg = backport_llcp_sock_sendmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
- static int rawsock_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
+ 	.recvmsg        = llcp_sock_recvmsg,
 +#else
-+static int rawsock_sendmsg(struct kiocb *iocb, struct socket *sock,
-+			   struct msghdr *msg, size_t len)
-+#endif
- {
- 	struct sock *sk = sock->sk;
- 	struct nfc_dev *dev = nfc_rawsock(sk)->dev;
-@@ -247,8 +252,13 @@ static int rawsock_sendmsg(struct socket
++	.recvmsg = backport_llcp_sock_recvmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+ 	.mmap           = sock_no_mmap,
+ };
+ 
+@@ -919,7 +940,11 @@ static const struct proto_ops llcp_rawsock_ops = {
+ 	.setsockopt     = sock_no_setsockopt,
+ 	.getsockopt     = sock_no_getsockopt,
+ 	.sendmsg        = sock_no_sendmsg,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	.recvmsg        = llcp_sock_recvmsg,
++#else
++	.recvmsg = backport_llcp_sock_recvmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+ 	.mmap           = sock_no_mmap,
+ };
+ 
+--- a/net/nfc/rawsock.c
++++ b/net/nfc/rawsock.c
+@@ -246,6 +246,12 @@ static int rawsock_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
+ 
  	return len;
  }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_rawsock_sendmsg(struct kiocb *iocb, struct socket *sock,
++				    struct msghdr *msg, size_t len){
++	return rawsock_sendmsg(sock, msg, len);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
  static int rawsock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  			   int flags)
+@@ -274,6 +280,12 @@ static int rawsock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+ 
+ 	return rc ? : copied;
+ }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++static int backport_rawsock_recvmsg(struct kiocb *iocb, struct socket *sock,
++				    struct msghdr *msg, size_t len, int flags){
++	return rawsock_recvmsg(sock, msg, len, flags);
++}
++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
+ 
+ static const struct proto_ops rawsock_ops = {
+ 	.family         = PF_NFC,
+@@ -290,8 +302,16 @@ static const struct proto_ops rawsock_ops = {
+ 	.shutdown       = sock_no_shutdown,
+ 	.setsockopt     = sock_no_setsockopt,
+ 	.getsockopt     = sock_no_getsockopt,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	.sendmsg        = rawsock_sendmsg,
++#else
++	.sendmsg = backport_rawsock_sendmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	.recvmsg        = rawsock_recvmsg,
 +#else
-+static int rawsock_recvmsg(struct kiocb *iocb, struct socket *sock,
-+			   struct msghdr *msg, size_t len, int flags)
-+#endif
- {
- 	int noblock = flags & MSG_DONTWAIT;
- 	struct sock *sk = sock->sk;
++	.recvmsg = backport_rawsock_recvmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+ 	.mmap           = sock_no_mmap,
+ };
+ 
+@@ -311,7 +331,11 @@ static const struct proto_ops rawsock_raw_ops = {
+ 	.setsockopt     = sock_no_setsockopt,
+ 	.getsockopt     = sock_no_getsockopt,
+ 	.sendmsg        = sock_no_sendmsg,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	.recvmsg        = rawsock_recvmsg,
++#else
++	.recvmsg = backport_rawsock_recvmsg,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+ 	.mmap           = sock_no_mmap,
+ };
+ 
-- 
2.3.2.209.gd67f9d5.dirty
