Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18555C41513
	for <cocci@archiver.kernel.org>; Tue, 28 May 2024 05:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=hbb1TYxZuIfpukL9pRvV5HWVRdLiVb6cBG0WH8XBuNk=;
  b=IvOyNJiBYRR8pmJErN5ZNAfM6ykzuKdD8uqnYaJgYxDt134r+OaOOzTO
   sio6fIqipzlh0DpyJXld5VEQ0PCC7mb1bOULuqFE4S97yhc3Q2aG9ZdmQ
   0a9VdqshS0gTJuPb1rcDtX66YehYlR1euqTj4GT+ve98a3qWrl2NK+DNH
   o=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.08,194,1712613600"; 
   d="scan'208";a="167714104"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 May 2024 07:09:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F0D68E0CCC; Tue, 28 May 2024 07:09:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4A8A2E00B7
	for <cocci@sympa.inria.fr>; Tue, 28 May 2024 07:09:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hbb1TYxZuIfpukL9pRvV5HWVRdLiVb6cBG0WH8XBuNk=;
  b=VLMZWgZUSAenFhYkmk5aYHI5d6fMdv0vFlmGNB1MqiqmxvgiZHNyWDrx
   xskENNF6aS0eBdTXzqzn71lJa4cPwQaPcQ3wXWa0H8mbWwefzy3cdTx6R
   YTC3IuGqV6OApM2H0gaM09Nswu8j5buRYSJXjxcXwTOsbNWIQ73grCHhx
   s=;
X-IronPort-AV: E=Sophos;i="6.08,194,1712613600"; 
   d="scan'208";a="88117195"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 07:09:36 +0200
Date: Tue, 28 May 2024 07:09:35 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Paul E. McKenney" <paulmck@kernel.org>
cc: Vlastimil Babka <vbabka@suse.cz>, 
    "linux-mm@kvack.org" <linux-mm@kvack.org>, RCU <rcu@vger.kernel.org>, 
    cocci@inria.fr, qiang.zhang1211@gmail.com
In-Reply-To: <2a64cf68-2189-4553-88c9-fd73784c22ff@paulmck-laptop>
Message-ID: <alpine.DEB.2.22.394.2405280708410.3709@hadrien>
References: <68b85796-c674-4691-936a-2051849f4692@suse.cz> <6b7e3ed9-d974-cb3b-6839-a6b7cf5f5a36@inria.fr> <a1f15e67-25f5-4a0b-a9d0-ebbc0555fb12@paulmck-laptop> <alpine.DEB.2.22.394.2405272226510.3330@hadrien>
 <2a64cf68-2189-4553-88c9-fd73784c22ff@paulmck-laptop>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to kfree_rcu
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1764
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/alpine.DEB.2.22.394.2405280708410.3709%40hadrien>



On Mon, 27 May 2024, Paul E. McKenney wrote:

> On Mon, May 27, 2024 at 10:43:08PM +0200, Julia Lawall wrote:
> >
> >
> > On Mon, 27 May 2024, Paul E. McKenney wrote:
> >
> > > On Mon, May 27, 2024 at 10:13:40AM +0200, Julia Lawall wrote:
> > > >
> > > >
> > > > On Mon, 27 May 2024, Vlastimil Babka wrote:
> > > >
> > > > > Hi,
> > > > >
> > > > > one bit from LSF/MM discussions is that there might be call_rcu users with a
> > > > > callback that only does a kmem_cache_free() to a specific cache. Since SLOB
> > > > > was removed, it's always ok to use kfree() and thus also kfree_rcu() on
> > > > > allocations from kmem_cache_alloc() in addition to kmalloc(). Thus, such
> > > > > call_rcu() users might be simplified to kfree_rcu(). I found some cases
> > > > > semi-manually, but I'd expect coccinelle could help here so if anyone wants
> > > > > to take this task, feel free to.
> > > >
> > > > Thanks for the suggestion!  I will try to look into it.
> > >
> > > Thank you both!
> >
> > I found the following functions.  Do you want some other information, such
> > as where they are called from?
>
> Thank you!
>
> > Ignore the -s at the beginning of some lines.  Those are for emphasis. not
> > to suggest to remove the code.
>
> Well, the idea is to remove not only those lines, but the functions
> containing them as well.  ;-)
>
> Then each call_rcu() function becomes kfree_rcu().

OK. I'll send a patch for your review accordingly.  If everything looks
fine, I will send the patches to the maintainers.

julia


>
> > I checked that the functions are only used in calls to call_rcu.
>
> Good point, I had forgotten about that possibility!
>
> > Without more effort, Coccinelle only looks for functions defined in the
> > same file.  Here are the functions that are passed to call_rcu where the
> > function is not defined in the same file:
> >
> > need definition for audit_free_rule_rcu
> > need definition for __i915_gem_free_object_rcu
> > need definition for io_eventfd_ops
> > need definition for ip_vs_dest_dst_rcu_free
> > need definition for __put_task_struct_rcu_cb
> > need definition for radix_tree_node_rcu_free
> >
> > They all do something more, although radix_tree_node_rcu_free doesn't do
> > much more (some memsets).
>
> Those might be important in order to handle the possibility of readers
> holding a reference to a given block of memory across the time that it
> is freed and then reallocated, but I cannot say for sure.
>
> In most cases, the reinitialization at reallocation time suffices.
>
> 							Thanx, Paul
>
> > julia
> >
> > diff -u -p /home/jll/linux/drivers/net/wireguard/allowedips.c /tmp/nothing/drivers/net/wireguard/allowedips.c
> > --- /home/jll/linux/drivers/net/wireguard/allowedips.c
> > +++ /tmp/nothing/drivers/net/wireguard/allowedips.c
> > @@ -50,7 +50,6 @@ static void push_rcu(struct allowedips_n
> >
> >  static void node_free_rcu(struct rcu_head *rcu)
> >  {
> > -	kmem_cache_free(node_cache, container_of(rcu, struct allowedips_node, rcu));
> >  }
> >
> >  static void root_free_rcu(struct rcu_head *rcu)
> > diff -u -p /home/jll/linux/fs/ecryptfs/dentry.c /tmp/nothing/fs/ecryptfs/dentry.c
> > --- /home/jll/linux/fs/ecryptfs/dentry.c
> > +++ /tmp/nothing/fs/ecryptfs/dentry.c
> > @@ -53,8 +53,6 @@ struct kmem_cache *ecryptfs_dentry_info_
> >
> >  static void ecryptfs_dentry_free_rcu(struct rcu_head *head)
> >  {
> > -	kmem_cache_free(ecryptfs_dentry_info_cache,
> > -		container_of(head, struct ecryptfs_dentry_info, rcu));
> >  }
> >
> >  /**
> > diff -u -p /home/jll/linux/kernel/fork.c /tmp/nothing/kernel/fork.c
> > --- /home/jll/linux/kernel/fork.c
> > +++ /tmp/nothing/kernel/fork.c
> > @@ -378,7 +378,6 @@ static struct kmem_cache *thread_stack_c
> >
> >  static void thread_stack_free_rcu(struct rcu_head *rh)
> >  {
> > -	kmem_cache_free(thread_stack_cache, rh);
> >  }
> >
> >  static void thread_stack_delayed_free(struct task_struct *tsk)
> > diff -u -p /home/jll/linux/kernel/workqueue.c /tmp/nothing/kernel/workqueue.c
> > --- /home/jll/linux/kernel/workqueue.c
> > +++ /tmp/nothing/kernel/workqueue.c
> > @@ -5024,8 +5024,6 @@ fail:
> >
> >  static void rcu_free_pwq(struct rcu_head *rcu)
> >  {
> > -	kmem_cache_free(pwq_cache,
> > -			container_of(rcu, struct pool_workqueue, rcu));
> >  }
> >
> >  /*
> > diff -u -p /home/jll/linux/net/ipv4/inetpeer.c /tmp/nothing/net/ipv4/inetpeer.c
> > --- /home/jll/linux/net/ipv4/inetpeer.c
> > +++ /tmp/nothing/net/ipv4/inetpeer.c
> > @@ -130,7 +130,6 @@ static struct inet_peer *lookup(const st
> >
> >  static void inetpeer_free_rcu(struct rcu_head *head)
> >  {
> > -	kmem_cache_free(peer_cachep, container_of(head, struct inet_peer, rcu));
> >  }
> >
> >  /* perform garbage collect on all items stacked during a lookup */
> > diff -u -p /home/jll/linux/net/ipv6/xfrm6_tunnel.c /tmp/nothing/net/ipv6/xfrm6_tunnel.c
> > --- /home/jll/linux/net/ipv6/xfrm6_tunnel.c
> > +++ /tmp/nothing/net/ipv6/xfrm6_tunnel.c
> > @@ -180,8 +180,6 @@ EXPORT_SYMBOL(xfrm6_tunnel_alloc_spi);
> >
> >  static void x6spi_destroy_rcu(struct rcu_head *head)
> >  {
> > -	kmem_cache_free(xfrm6_tunnel_spi_kmem,
> > -			container_of(head, struct xfrm6_tunnel_spi, rcu_head));
> >  }
> >
> >  static void xfrm6_tunnel_free_spi(struct net *net, xfrm_address_t *saddr)
> > diff -u -p /home/jll/linux/security/security.c /tmp/nothing/security/security.c
> > --- /home/jll/linux/security/security.c
> > +++ /tmp/nothing/security/security.c
> > @@ -1599,7 +1599,6 @@ static void inode_free_by_rcu(struct rcu
> >  	/*
> >  	 * The rcu head is at the start of the inode blob
> >  	 */
> > -	kmem_cache_free(lsm_inode_cache, head);
> >  }
> >
> >  /**
>
