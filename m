From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 6 Jun 2015 07:33:21 +0200 (CEST)
Subject: [Cocci] [PATCH 4/4] patches: provide 0054-struct-proto_ops-sig
 SmPL patch replacement
In-Reply-To: <1433549401-17006-5-git-send-email-mcgrof@do-not-panic.com>
References: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
 <1433549401-17006-5-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <alpine.DEB.2.02.1506060733030.2009@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Acked-by: Julia Lawall <julia.lawall@lip6.fr>
for the semantic patch.

julia

On Fri, 5 Jun 2015, Luis R. Rodriguez wrote:

> This replaces the 436 line of unified diff with 152
> lines of grammar Coccinelle SmPL patch. SmPL patch
> equivalence proof tests reveals only cosmetic changes
> between using Coccinelle SmPL and unified diff as shown
> below. The difference shown are the results of two
> trees, one in which we applied the SmPL patch, and another
> in which the old unified patch series were used. This
> gives us an idea of what Coccinelle did differently.
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
> 22  4.1-rc1             [  OK  ]
> 
> mcgrof at ergon ~/backports (git::master)$ time \
> 	./gentree.py --clean --prove-cocci \
> 	patches/collateral-evolutions/network/0054-struct-proto_ops-sig.cocci \
> 	/home/mcgrof/linux-next/ /home/mcgrof/build/backports-20150525
> 
> Copy original source files ...
> Applying patches from patches to
> /home/mcgrof/build/backports-20150525 ...
> Proving Coccinelle SmPL patch: 0054-struct-proto_ops-sig.cocci
> Aggregating patch for Coccinelle SmPL 0054-struct-proto_ops-sig proof: ieee802154.patch
> Aggregating patch for Coccinelle SmPL 0054-struct-proto_ops-sig proof: nfc.patch
> Aggregating patch for Coccinelle SmPL 0054-struct-proto_ops-sig proof: bluetooth.patch
> 
> Review the difference between what the tree looks like
> by applying your SmPL patch, then reverting that and
> only applying your the patches in the patch series.
> 
> Change directory to /home/mcgrof/build/backports-20150525 and run 'git diff'
> diff stat of the changes:
> 
> net/bluetooth/hci_sock.c | 11 +++++------
> 1 file changed, 5 insertions(+), 6 deletions(-)
> 
> Done!
> 
> real    0m21.965s
> user    0m45.947s
> sys     0m4.072s
> 
> Now when I change directory to /home/mcgrof/build/backports-20150525 and
> run 'git diff' I get:
> 
> 	diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> 	index 9326bc8..9ca0166 100644
> 	--- a/net/bluetooth/hci_sock.c
> 	+++ b/net/bluetooth/hci_sock.c
> 	@@ -956,7 +956,8 @@ static int hci_sock_recvmsg(struct socket *sock,
> 	struct msghdr *msg, size_t len,
> 	 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> 	 static int backport_hci_sock_recvmsg(struct kiocb *iocb, struct socket
> 	*sock,
> 					     struct msghdr *msg, size_t len,
> 	-                                    int flags){
> 	+                                    int flags)
> 	+{
> 		return hci_sock_recvmsg(sock, msg, len, flags);
> 	 }
> 	 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> 	@@ -1198,7 +1199,8 @@ drop:
> 	 }
> 	 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> 	 static int backport_hci_sock_sendmsg(struct kiocb *iocb, struct socket
> 	*sock,
> 	-                                    struct msghdr *msg, size_t len){
> 	+                                    struct msghdr *msg, size_t len)
> 	+{
> 		return hci_sock_sendmsg(sock, msg, len);
> 	 }
> 	 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> 	@@ -1360,12 +1362,9 @@ static const struct proto_ops hci_sock_ops = {
> 		.getname        = hci_sock_getname,
> 	 #if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> 		.sendmsg        = hci_sock_sendmsg,
> 	-#else
> 	-       .sendmsg = backport_hci_sock_sendmsg,
> 	-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> 	-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> 		.recvmsg        = hci_sock_recvmsg,
> 	 #else
> 	+       .sendmsg = backport_hci_sock_sendmsg,
> 		.recvmsg = backport_hci_sock_recvmsg,
> 	 #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> 		.ioctl          = hci_sock_ioctl,
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> ---
>  .../network/0054-struct-proto_ops-sig.cocci        | 177 +++++++++++++++++++
>  .../0054-struct-proto_ops-sig/bluetooth.patch      | 187 ---------------------
>  .../0054-struct-proto_ops-sig/ieee802154.patch     | 134 ---------------
>  .../network/0054-struct-proto_ops-sig/nfc.patch    | 115 -------------
>  4 files changed, 177 insertions(+), 436 deletions(-)
>  create mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig.cocci
>  delete mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
>  delete mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
>  delete mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch
> 
> diff --git a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig.cocci b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig.cocci
> new file mode 100644
> index 0000000..0c0845a
> --- /dev/null
> +++ b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig.cocci
> @@ -0,0 +1,177 @@
> +/*
> +This provides the backport for the collateral evolution introduced
> +via commit 1b784140474e4fc94281a49e96c67d29df0efbde, titled
> +"net: Remove iocb argument from sendmsg and recvmsg".
> +
> +The net/tipc/ subsystem (Transparent Inter Process Communication (TIPC))
> +relied historically on using an argument passed on the struct proto_ops
> +and struct proto sendmsg and recvmsg callbacks to determine if it needed
> +to perform a lock within its own code. Commit 1b784140474e4 removed replaced
> +the locking functionality to require the argument and instead moved all
> +the necessary heuristics into net/tipc. Other subsystems just passed NULL.
> +After the net/tipc code was cleaned up from the locking (see commmit
> +39a0295f901423e260a034ac7c3211ecaa9c2745 titled "tipc: Don't use iocb
> +argument in socket layer") we no longer needed the extra argument on the
> +struct proto_ops and struct proto callbacks.
> +
> +To backport non-tipc subsystems we then just need to modify the upstream
> +code which declares these callbacks and add the extra argument again, but
> +the same routine can be used from upstream code. The grammar we use below
> +declares routines which can be pegged to struct proto_ops and struct proto
> +callbacks that simply call the same upstream code, the extra argument is
> +ignored. The argument can be ignored as it was only used within the
> +net/tipc subsystem for locking purposes.
> +*/
> +
> +@ proto_ops @
> +identifier s, send_func, recv_func;
> +@@
> +
> + struct proto_ops s = {
> + 	.sendmsg = send_func,
> + 	.recvmsg = recv_func,
> +};
> +
> +@ mod_send depends on proto_ops @
> +identifier proto_ops.send_func;
> +fresh identifier backport_send = "backport_" ## send_func;
> +@@
> +
> +send_func(...)
> +{
> +	...
> +}
> +
> ++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> ++static int backport_send(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len)
> ++{
> ++	return send_func(sock, msg, len);
> ++}
> ++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> +
> +@ mod_recv depends on proto_ops @
> +identifier proto_ops.recv_func;
> +fresh identifier backport_recv = "backport_" ## recv_func;
> +@@
> +
> +recv_func(...)
> +{
> +	...
> +}
> +
> ++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> ++static int backport_recv(struct kiocb *iocb, struct socket *sock,
> ++			  struct msghdr *msg, size_t len, int flags)
> ++{
> ++	return recv_func(sock, msg, len, flags);
> ++}
> ++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> +
> +@ mod_proto_ops_tx depends on proto_ops && mod_send @
> +identifier s, proto_ops.send_func, mod_send.backport_send;
> +@@
> +
> + struct proto_ops s = {
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> + 	.sendmsg = send_func,
> ++#else
> ++	.sendmsg = backport_send,
> ++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> +};
> +
> +@ mod_proto_ops_rx depends on proto_ops && mod_recv @
> +identifier s, proto_ops.recv_func, mod_recv.backport_recv;
> +@@
> +
> + struct proto_ops s = {
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> + 	.recvmsg = recv_func,
> ++#else
> ++	.recvmsg = backport_recv,
> ++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> +};
> +
> +@ mod_sock_send_callers depends on proto_ops@
> +identifier proto_ops.send_func;
> +identifier sock, msg, len, sk;
> +@@
> +
> +send_func(struct socket *sock, struct msghdr *msg, size_t len)
> +{
> +	...
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> +	return sk->sk_prot->sendmsg(sk, msg, len);
> ++#else
> ++	return sk->sk_prot->sendmsg(NULL, sk, msg, len);
> ++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> +}
> +
> +@ proto @
> +identifier s, send_func, recv_func;
> +@@
> +
> + struct proto s = {
> + 	.sendmsg = send_func,
> + 	.recvmsg = recv_func,
> +};
> +
> +@ proto_mod_send depends on proto @
> +identifier proto.send_func;
> +fresh identifier backport_send = "backport_" ## send_func;
> +@@
> +
> +send_func(...)
> +{
> +	...
> +}
> +
> ++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> ++static int backport_send(struct kiocb *iocb, struct socket *sock,
> ++			  struct msghdr *msg, size_t len)
> ++{
> ++	return send_func(sock, msg, len);
> ++}
> ++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> +
> +@ proto_mod_recv depends on proto @
> +identifier proto.recv_func;
> +fresh identifier backport_recv = "backport_" ## recv_func;
> +@@
> +
> +recv_func(...)
> +{
> +	...
> +}
> +
> ++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> ++static int backport_recv(struct kiocb *iocb, struct socket *sock,
> ++			  struct msghdr *msg, size_t len,
> ++			  int noblock, int flags, int *addr_len)
> ++{
> ++	return recv_func(sock, msg, len, noblock, flags, addr_len);
> ++}
> ++#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> +
> +@ mod_proto_tx depends on proto && proto_mod_send @
> +identifier s, proto.send_func, proto_mod_send.backport_send;
> +@@
> +
> + struct proto s = {
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> + 	.sendmsg = send_func,
> ++#else
> ++	.sendmsg = backport_send,
> ++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> +};
> +
> +@ mod_proto_rx depends on proto && proto_mod_recv @
> +identifier s, proto.recv_func, proto_mod_recv.backport_recv;
> +@@
> +
> + struct proto s = {
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> + 	.recvmsg = recv_func,
> ++#else
> ++	.recvmsg = backport_recv,
> ++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> +};
> diff --git a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
> deleted file mode 100644
> index 2cf5a9e..0000000
> --- a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
> +++ /dev/null
> @@ -1,187 +0,0 @@
> ---- a/net/bluetooth/hci_sock.c
> -+++ b/net/bluetooth/hci_sock.c
> -@@ -953,6 +953,14 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> - 
> - 	return err ? : copied;
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_hci_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
> -+				     struct msghdr *msg, size_t len,
> -+				     int flags)
> -+{
> -+	return hci_sock_recvmsg(sock, msg, len, flags);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
> - 			struct msghdr *msg, size_t msglen)
> -@@ -1189,6 +1196,13 @@ drop:
> - 	kfree_skb(skb);
> - 	goto done;
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> -+				     struct msghdr *msg, size_t len)
> -+{
> -+	return hci_sock_sendmsg(sock, msg, len);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
> - 			       char __user *optval, unsigned int len)
> -@@ -1345,8 +1358,13 @@ static const struct proto_ops hci_sock_ops = {
> - 	.release	= hci_sock_release,
> - 	.bind		= hci_sock_bind,
> - 	.getname	= hci_sock_getname,
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.sendmsg	= hci_sock_sendmsg,
> - 	.recvmsg	= hci_sock_recvmsg,
> -+#else
> -+	.sendmsg = backport_hci_sock_sendmsg,
> -+	.recvmsg = backport_hci_sock_recvmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> - 	.ioctl		= hci_sock_ioctl,
> - 	.poll		= datagram_poll,
> - 	.listen		= sock_no_listen,
> ---- a/net/bluetooth/l2cap_sock.c
> -+++ b/net/bluetooth/l2cap_sock.c
> -@@ -975,6 +975,13 @@ static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg,
> - 
> - 	return err;
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_l2cap_sock_sendmsg(struct kiocb *iocb,
> -+				       struct socket *sock,
> -+				       struct msghdr *msg, size_t len){
> -+	return l2cap_sock_sendmsg(sock, msg, len);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
> - 			      size_t len, int flags)
> -@@ -1036,6 +1043,14 @@ done:
> - 	release_sock(sk);
> - 	return err;
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_l2cap_sock_recvmsg(struct kiocb *iocb,
> -+				       struct socket *sock,
> -+				       struct msghdr *msg, size_t len,
> -+				       int flags){
> -+	return l2cap_sock_recvmsg(sock, msg, len, flags);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - /* Kill socket (only if zapped and orphan)
> -  * Must be called on unlocked socket.
> -@@ -1618,8 +1633,16 @@ static const struct proto_ops l2cap_sock_ops = {
> - 	.listen		= l2cap_sock_listen,
> - 	.accept		= l2cap_sock_accept,
> - 	.getname	= l2cap_sock_getname,
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.sendmsg	= l2cap_sock_sendmsg,
> -+#else
> -+	.sendmsg = backport_l2cap_sock_sendmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.recvmsg	= l2cap_sock_recvmsg,
> -+#else
> -+	.recvmsg = backport_l2cap_sock_recvmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> - 	.poll		= bt_sock_poll,
> - 	.ioctl		= bt_sock_ioctl,
> - 	.mmap		= sock_no_mmap,
> ---- a/net/bluetooth/rfcomm/sock.c
> -+++ b/net/bluetooth/rfcomm/sock.c
> -@@ -622,6 +622,13 @@ done:
> - 
> - 	return sent;
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_rfcomm_sock_sendmsg(struct kiocb *iocb,
> -+					struct socket *sock,
> -+					struct msghdr *msg, size_t len){
> -+	return rfcomm_sock_sendmsg(sock, msg, len);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static int rfcomm_sock_recvmsg(struct socket *sock, struct msghdr *msg,
> - 			       size_t size, int flags)
> -@@ -647,6 +654,14 @@ static int rfcomm_sock_recvmsg(struct socket *sock, struct msghdr *msg,
> - 
> - 	return len;
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_rfcomm_sock_recvmsg(struct kiocb *iocb,
> -+					struct socket *sock,
> -+					struct msghdr *msg, size_t len,
> -+					int flags){
> -+	return rfcomm_sock_recvmsg(sock, msg, len, flags);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname, char __user *optval, unsigned int optlen)
> - {
> -@@ -1044,8 +1059,16 @@ static const struct proto_ops rfcomm_sock_ops = {
> - 	.listen		= rfcomm_sock_listen,
> - 	.accept		= rfcomm_sock_accept,
> - 	.getname	= rfcomm_sock_getname,
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.sendmsg	= rfcomm_sock_sendmsg,
> -+#else
> -+	.sendmsg = backport_rfcomm_sock_sendmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.recvmsg	= rfcomm_sock_recvmsg,
> -+#else
> -+	.recvmsg = backport_rfcomm_sock_recvmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> - 	.shutdown	= rfcomm_sock_shutdown,
> - 	.setsockopt	= rfcomm_sock_setsockopt,
> - 	.getsockopt	= rfcomm_sock_getsockopt,
> ---- a/net/bluetooth/sco.c
> -+++ b/net/bluetooth/sco.c
> -@@ -713,6 +713,12 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
> - 	release_sock(sk);
> - 	return err;
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> -+				     struct msghdr *msg, size_t len){
> -+	return sco_sock_sendmsg(sock, msg, len);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static void sco_conn_defer_accept(struct hci_conn *conn, u16 setting)
> - {
> -@@ -779,6 +785,13 @@ static int sco_sock_recvmsg(struct socket *sock, struct msghdr *msg,
> - 
> - 	return bt_sock_recvmsg(sock, msg, len, flags);
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
> -+				     struct msghdr *msg, size_t len,
> -+				     int flags){
> -+	return sco_sock_recvmsg(sock, msg, len, flags);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
> - {
> -@@ -1178,8 +1191,16 @@ static const struct proto_ops sco_sock_ops = {
> - 	.listen		= sco_sock_listen,
> - 	.accept		= sco_sock_accept,
> - 	.getname	= sco_sock_getname,
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.sendmsg	= sco_sock_sendmsg,
> -+#else
> -+	.sendmsg = backport_sco_sock_sendmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.recvmsg	= sco_sock_recvmsg,
> -+#else
> -+	.recvmsg = backport_sco_sock_recvmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> - 	.poll		= bt_sock_poll,
> - 	.ioctl		= bt_sock_ioctl,
> - 	.mmap		= sock_no_mmap,
> diff --git a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
> deleted file mode 100644
> index 0497dbe..0000000
> --- a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
> +++ /dev/null
> @@ -1,134 +0,0 @@
> ---- a/net/ieee802154/socket.c
> -+++ b/net/ieee802154/socket.c
> -@@ -101,8 +101,19 @@ static int ieee802154_sock_sendmsg(struct socket *sock, struct msghdr *msg,
> - {
> - 	struct sock *sk = sock->sk;
> - 
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	return sk->sk_prot->sendmsg(sk, msg, len);
> -+#else
> -+	return sk->sk_prot->sendmsg(NULL, sk, msg, len);
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_ieee802154_sock_sendmsg(struct kiocb *iocb,
> -+					    struct socket *sock,
> -+					    struct msghdr *msg, size_t len){
> -+	return ieee802154_sock_sendmsg(sock, msg, len);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static int ieee802154_sock_bind(struct socket *sock, struct sockaddr *uaddr,
> - 				int addr_len)
> -@@ -323,6 +334,12 @@ out_dev:
> - out:
> - 	return err;
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_raw_sendmsg(struct kiocb *iocb, struct socket *sock,
> -+				struct msghdr *msg, size_t len){
> -+	return raw_sendmsg(sock, msg, len);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static int raw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> - 		       int noblock, int flags, int *addr_len)
> -@@ -356,6 +373,13 @@ out:
> - 		return err;
> - 	return copied;
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_raw_recvmsg(struct kiocb *iocb, struct socket *sock,
> -+				struct msghdr *msg, size_t len, int noblock,
> -+				int flags, int *addr_len){
> -+	return raw_recvmsg(sock, msg, len, noblock, flags, addr_len);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
> - {
> -@@ -409,8 +433,16 @@ static struct proto ieee802154_raw_prot = {
> - 	.obj_size	= sizeof(struct sock),
> - 	.close		= raw_close,
> - 	.bind		= raw_bind,
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.sendmsg	= raw_sendmsg,
> -+#else
> -+	.sendmsg = backport_raw_sendmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.recvmsg	= raw_recvmsg,
> -+#else
> -+	.recvmsg = backport_raw_recvmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> - 	.hash		= raw_hash,
> - 	.unhash		= raw_unhash,
> - 	.connect	= raw_connect,
> -@@ -434,7 +466,11 @@ static const struct proto_ops ieee802154_raw_ops = {
> - 	.shutdown	   = sock_no_shutdown,
> - 	.setsockopt	   = sock_common_setsockopt,
> - 	.getsockopt	   = sock_common_getsockopt,
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.sendmsg	   = ieee802154_sock_sendmsg,
> -+#else
> -+	.sendmsg = backport_ieee802154_sock_sendmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> - 	.recvmsg	   = sock_common_recvmsg,
> - 	.mmap		   = sock_no_mmap,
> - 	.sendpage	   = sock_no_sendpage,
> -@@ -710,6 +746,12 @@ out_dev:
> - out:
> - 	return err;
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_dgram_sendmsg(struct kiocb *iocb, struct socket *sock,
> -+				  struct msghdr *msg, size_t len){
> -+	return dgram_sendmsg(sock, msg, len);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> - 			 int noblock, int flags, int *addr_len)
> -@@ -751,6 +793,13 @@ out:
> - 		return err;
> - 	return copied;
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_dgram_recvmsg(struct kiocb *iocb, struct socket *sock,
> -+				  struct msghdr *msg, size_t len, int noblock,
> -+				  int flags, int *addr_len){
> -+	return dgram_recvmsg(sock, msg, len, noblock, flags, addr_len);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static int dgram_rcv_skb(struct sock *sk, struct sk_buff *skb)
> - {
> -@@ -947,8 +996,16 @@ static struct proto ieee802154_dgram_prot = {
> - 	.init		= dgram_init,
> - 	.close		= dgram_close,
> - 	.bind		= dgram_bind,
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.sendmsg	= dgram_sendmsg,
> -+#else
> -+	.sendmsg = backport_dgram_sendmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.recvmsg	= dgram_recvmsg,
> -+#else
> -+	.recvmsg = backport_dgram_recvmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> - 	.hash		= dgram_hash,
> - 	.unhash		= dgram_unhash,
> - 	.connect	= dgram_connect,
> -@@ -973,7 +1030,11 @@ static const struct proto_ops ieee802154_dgram_ops = {
> - 	.shutdown	   = sock_no_shutdown,
> - 	.setsockopt	   = sock_common_setsockopt,
> - 	.getsockopt	   = sock_common_getsockopt,
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.sendmsg	   = ieee802154_sock_sendmsg,
> -+#else
> -+	.sendmsg = backport_ieee802154_sock_sendmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> - 	.recvmsg	   = sock_common_recvmsg,
> - 	.mmap		   = sock_no_mmap,
> - 	.sendpage	   = sock_no_sendpage,
> diff --git a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch
> deleted file mode 100644
> index e29c4d8..0000000
> --- a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch
> +++ /dev/null
> @@ -1,115 +0,0 @@
> ---- a/net/nfc/llcp_sock.c
> -+++ b/net/nfc/llcp_sock.c
> -@@ -792,6 +792,12 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
> - 
> - 	return nfc_llcp_send_i_frame(llcp_sock, msg, len);
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_llcp_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> -+				      struct msghdr *msg, size_t len){
> -+	return llcp_sock_sendmsg(sock, msg, len);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static int llcp_sock_recvmsg(struct socket *sock, struct msghdr *msg,
> - 			     size_t len, int flags)
> -@@ -882,6 +888,13 @@ done:
> - 
> - 	return copied;
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_llcp_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
> -+				      struct msghdr *msg, size_t len,
> -+				      int flags){
> -+	return llcp_sock_recvmsg(sock, msg, len, flags);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static const struct proto_ops llcp_sock_ops = {
> - 	.family         = PF_NFC,
> -@@ -898,8 +911,16 @@ static const struct proto_ops llcp_sock_ops = {
> - 	.shutdown       = sock_no_shutdown,
> - 	.setsockopt     = nfc_llcp_setsockopt,
> - 	.getsockopt     = nfc_llcp_getsockopt,
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.sendmsg        = llcp_sock_sendmsg,
> -+#else
> -+	.sendmsg = backport_llcp_sock_sendmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.recvmsg        = llcp_sock_recvmsg,
> -+#else
> -+	.recvmsg = backport_llcp_sock_recvmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> - 	.mmap           = sock_no_mmap,
> - };
> - 
> -@@ -919,7 +940,11 @@ static const struct proto_ops llcp_rawsock_ops = {
> - 	.setsockopt     = sock_no_setsockopt,
> - 	.getsockopt     = sock_no_getsockopt,
> - 	.sendmsg        = sock_no_sendmsg,
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.recvmsg        = llcp_sock_recvmsg,
> -+#else
> -+	.recvmsg = backport_llcp_sock_recvmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> - 	.mmap           = sock_no_mmap,
> - };
> - 
> ---- a/net/nfc/rawsock.c
> -+++ b/net/nfc/rawsock.c
> -@@ -246,6 +246,12 @@ static int rawsock_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
> - 
> - 	return len;
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_rawsock_sendmsg(struct kiocb *iocb, struct socket *sock,
> -+				    struct msghdr *msg, size_t len){
> -+	return rawsock_sendmsg(sock, msg, len);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static int rawsock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> - 			   int flags)
> -@@ -274,6 +280,12 @@ static int rawsock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> - 
> - 	return rc ? : copied;
> - }
> -+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
> -+static int backport_rawsock_recvmsg(struct kiocb *iocb, struct socket *sock,
> -+				    struct msghdr *msg, size_t len, int flags){
> -+	return rawsock_recvmsg(sock, msg, len, flags);
> -+}
> -+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> - 
> - static const struct proto_ops rawsock_ops = {
> - 	.family         = PF_NFC,
> -@@ -290,8 +302,16 @@ static const struct proto_ops rawsock_ops = {
> - 	.shutdown       = sock_no_shutdown,
> - 	.setsockopt     = sock_no_setsockopt,
> - 	.getsockopt     = sock_no_getsockopt,
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.sendmsg        = rawsock_sendmsg,
> -+#else
> -+	.sendmsg = backport_rawsock_sendmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.recvmsg        = rawsock_recvmsg,
> -+#else
> -+	.recvmsg = backport_rawsock_recvmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> - 	.mmap           = sock_no_mmap,
> - };
> - 
> -@@ -311,7 +331,11 @@ static const struct proto_ops rawsock_raw_ops = {
> - 	.setsockopt     = sock_no_setsockopt,
> - 	.getsockopt     = sock_no_getsockopt,
> - 	.sendmsg        = sock_no_sendmsg,
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> - 	.recvmsg        = rawsock_recvmsg,
> -+#else
> -+	.recvmsg = backport_rawsock_recvmsg,
> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> - 	.mmap           = sock_no_mmap,
> - };
> - 
> -- 
> 2.3.2.209.gd67f9d5.dirty
> 
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
