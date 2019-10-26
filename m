Return-Path: <SRS0=j8Co=YT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB18CA9EB9
	for <cocci@archiver.kernel.org>; Sat, 26 Oct 2019 20:30:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601C6206DD
	for <cocci@archiver.kernel.org>; Sat, 26 Oct 2019 20:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601C6206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9QKTWvs016912;
	Sat, 26 Oct 2019 22:29:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 436FF77BB;
	Sat, 26 Oct 2019 22:29:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5C27377B4
 for <cocci@systeme.lip6.fr>; Sat, 26 Oct 2019 22:18:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9QKI0ui007519
 for <cocci@systeme.lip6.fr>; Sat, 26 Oct 2019 22:18:00 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.68,233,1569276000"; d="scan'208";a="408476953"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien)
 ([89.2.166.121])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Oct 2019 22:17:59 +0200
Date: Sat, 26 Oct 2019 22:17:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
In-Reply-To: <c790578751dd69fb1080b355f5847c9ea5fb0e15.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1910262207540.5545@hadrien>
References: <1572076456-12463-1-git-send-email-zhang.lin16@zte.com.cn>
 <c790578751dd69fb1080b355f5847c9ea5fb0e15.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 26 Oct 2019 22:29:32 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 26 Oct 2019 22:18:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 26 Oct 2019 22:29:31 +0200
Cc: mkubecek@suse.cz, jakub.kicinski@netronome.com, ast@kernel.org,
        natechancellor@gmail.com, jiang.xuexin@zte.com.cn,
        cocci <cocci@systeme.lip6.fr>, f.fainelli@gmail.com,
        daniel@iogearbox.net, john.fastabend@gmail.com, lirongqing@baidu.com,
        maxime.chevallier@bootlin.com, vivien.didelot@gmail.com,
        dan.carpenter@oracle.com, wang.yi59@zte.com.cn, hawk@kernel.org,
        arnd@arndb.de, jiri@mellanox.com, xue.zhihong@zte.com.cn,
        zhanglin <zhang.lin16@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linyunsheng@huawei.com, pablo@netfilter.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, davem@davemloft.net
Subject: Re: [Cocci] [PATCH] net: Zeroing the structure ethtool_wolinfo in
 ethtool_get_wol()
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Sat, 26 Oct 2019, Joe Perches wrote:

> On Sat, 2019-10-26 at 15:54 +0800, zhanglin wrote:
> > memset() the structure ethtool_wolinfo that has padded bytes
> > but the padded bytes have not been zeroed out.
> []
> > diff --git a/net/core/ethtool.c b/net/core/ethtool.c
> []
> > @@ -1471,11 +1471,13 @@ static int ethtool_reset(struct net_device *dev, char __user *useraddr)
> >
> >  static int ethtool_get_wol(struct net_device *dev, char __user *useraddr)
> >  {
> > -	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
> > +	struct ethtool_wolinfo wol;
> >
> >  	if (!dev->ethtool_ops->get_wol)
> >  		return -EOPNOTSUPP;
> >
> > +	memset(&wol, 0, sizeof(struct ethtool_wolinfo));
> > +	wol.cmd = ETHTOOL_GWOL;
> >  	dev->ethtool_ops->get_wol(dev, &wol);
> >
> >  	if (copy_to_user(useraddr, &wol, sizeof(wol)))
>
> It seems likely there are more of these.
>
> Is there any way for coccinelle to find them?
>
> There are ~4000 structs in include/uapi and
> there are ~3000 uses of copy_to_user in the tree.
>
> $ git grep -P '\bstruct\s+\w+\s*{' include/uapi/ | cut -f2 -d" "|sort|uniq|wc -l
> 3785
> $ git grep -w copy_to_user|wc -l
> 2854
>
> A trivial grep and manual search using:
>
> $ git grep -B20 -w copy_to_user | grep -A20 -P '\bstruct\s+\w+\s*=\s*{'
>
> shows at least 1 (I didn't look very hard and stopped after finding 1):
>
>    include/uapi/linux/utsname.h:struct oldold_utsname {
>    include/uapi/linux/utsname.h-   char sysname[9];
>    include/uapi/linux/utsname.h-   char nodename[9];
>    include/uapi/linux/utsname.h-   char release[9];
>    include/uapi/linux/utsname.h-   char version[9];
>    include/uapi/linux/utsname.h-   char machine[9];
>    include/uapi/linux/utsname.h-};
>
> and
>
>    kernel/sys.c-	struct oldold_utsname tmp = {};
>    kernel/sys.c-
>    kernel/sys.c-	if (!name)
>    kernel/sys.c-		return -EFAULT;
>    kernel/sys.c-
>    kernel/sys.c-	down_read(&uts_sem);
>    kernel/sys.c-	memcpy(&tmp.sysname, &utsname()->sysname, __OLD_UTS_LEN);
>    kernel/sys.c-	memcpy(&tmp.nodename, &utsname()->nodename, __OLD_UTS_LEN);
>    kernel/sys.c-	memcpy(&tmp.release, &utsname()->release, __OLD_UTS_LEN);
>    kernel/sys.c-	memcpy(&tmp.version, &utsname()->version, __OLD_UTS_LEN);
>    kernel/sys.c-	memcpy(&tmp.machine, &utsname()->machine, __OLD_UTS_LEN);
>    kernel/sys.c-	up_read(&uts_sem);
>    kernel/sys.c:	if (copy_to_user(name, &tmp, sizeof(tmp)))
>
> where there is likely 3 bytes of padding after 45 bytes of data
> in the struct.

I looked into this at one point, but didn't get as far as generating
patches.  I think that the approach was roughly to collect the types of
the fields, and then generate code that would use BUILD_BUG_ON to complain
if the sum of the sizes was not the same as the size of the structure.
The problem was that I wasn't sure what was a real problem, nor what was
the best way to solve it.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
