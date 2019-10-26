Return-Path: <SRS0=j8Co=YT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F08CA9EB9
	for <cocci@archiver.kernel.org>; Sat, 26 Oct 2019 20:04:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37BCE20863
	for <cocci@archiver.kernel.org>; Sat, 26 Oct 2019 20:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BCE20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9QK44iv000380;
	Sat, 26 Oct 2019 22:04:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CC11E77BB;
	Sat, 26 Oct 2019 22:04:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 385F977B4
 for <cocci@systeme.lip6.fr>; Sat, 26 Oct 2019 21:59:04 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0138.hostedemail.com
 [216.40.44.138])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9QJwGxR021969
 for <cocci@systeme.lip6.fr>; Sat, 26 Oct 2019 21:58:17 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 5A244180366F6
 for <cocci@systeme.lip6.fr>; Sat, 26 Oct 2019 19:40:34 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3C59D180357D1;
 Sat, 26 Oct 2019 19:40:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stone20_785fe5ad57825
X-Filterd-Recvd-Size: 3871
Received: from XPS-9350.home (unknown [47.151.135.224])
 (Authenticated sender: joe@perches.com)
 by omf12.hostedemail.com (Postfix) with ESMTPA;
 Sat, 26 Oct 2019 19:40:27 +0000 (UTC)
Message-ID: <c790578751dd69fb1080b355f5847c9ea5fb0e15.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: zhanglin <zhang.lin16@zte.com.cn>, davem@davemloft.net,
        cocci
 <cocci@systeme.lip6.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas
 Gleixner <tglx@linutronix.de>,
        Linus Torvalds
 <torvalds@linux-foundation.org>
Date: Sat, 26 Oct 2019 12:40:23 -0700
In-Reply-To: <1572076456-12463-1-git-send-email-zhang.lin16@zte.com.cn>
References: <1572076456-12463-1-git-send-email-zhang.lin16@zte.com.cn>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 26 Oct 2019 22:04:05 +0200 (CEST)
X-Greylist: Delayed for 00:17:44 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sat, 26 Oct 2019 21:58:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 26 Oct 2019 22:04:03 +0200
Cc: mkubecek@suse.cz, jakub.kicinski@netronome.com, ast@kernel.org,
        jiang.xuexin@zte.com.cn, f.fainelli@gmail.com, daniel@iogearbox.net,
        john.fastabend@gmail.com, lirongqing@baidu.com,
        maxime.chevallier@bootlin.com, vivien.didelot@gmail.com,
        dan.carpenter@oracle.com, wang.yi59@zte.com.cn, hawk@kernel.org,
        arnd@arndb.de, jiri@mellanox.com, xue.zhihong@zte.com.cn,
        natechancellor@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linyunsheng@huawei.com,
        pablo@netfilter.org, bpf@vger.kernel.org
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

On Sat, 2019-10-26 at 15:54 +0800, zhanglin wrote:
> memset() the structure ethtool_wolinfo that has padded bytes
> but the padded bytes have not been zeroed out.
[]
> diff --git a/net/core/ethtool.c b/net/core/ethtool.c
[]
> @@ -1471,11 +1471,13 @@ static int ethtool_reset(struct net_device *dev, char __user *useraddr)
>  
>  static int ethtool_get_wol(struct net_device *dev, char __user *useraddr)
>  {
> -	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
> +	struct ethtool_wolinfo wol;
>  
>  	if (!dev->ethtool_ops->get_wol)
>  		return -EOPNOTSUPP;
>  
> +	memset(&wol, 0, sizeof(struct ethtool_wolinfo));
> +	wol.cmd = ETHTOOL_GWOL;
>  	dev->ethtool_ops->get_wol(dev, &wol);
>  
>  	if (copy_to_user(useraddr, &wol, sizeof(wol)))

It seems likely there are more of these.

Is there any way for coccinelle to find them?

There are ~4000 structs in include/uapi and
there are ~3000 uses of copy_to_user in the tree.

$ git grep -P '\bstruct\s+\w+\s*{' include/uapi/ | cut -f2 -d" "|sort|uniq|wc -l
3785
$ git grep -w copy_to_user|wc -l
2854

A trivial grep and manual search using:

$ git grep -B20 -w copy_to_user | grep -A20 -P '\bstruct\s+\w+\s*=\s*{'

shows at least 1 (I didn't look very hard and stopped after finding 1):

   include/uapi/linux/utsname.h:struct oldold_utsname {
   include/uapi/linux/utsname.h-   char sysname[9];
   include/uapi/linux/utsname.h-   char nodename[9];
   include/uapi/linux/utsname.h-   char release[9];
   include/uapi/linux/utsname.h-   char version[9];
   include/uapi/linux/utsname.h-   char machine[9];
   include/uapi/linux/utsname.h-};

and 

   kernel/sys.c-	struct oldold_utsname tmp = {};
   kernel/sys.c-
   kernel/sys.c-	if (!name)
   kernel/sys.c-		return -EFAULT;
   kernel/sys.c-
   kernel/sys.c-	down_read(&uts_sem);
   kernel/sys.c-	memcpy(&tmp.sysname, &utsname()->sysname, __OLD_UTS_LEN);
   kernel/sys.c-	memcpy(&tmp.nodename, &utsname()->nodename, __OLD_UTS_LEN);
   kernel/sys.c-	memcpy(&tmp.release, &utsname()->release, __OLD_UTS_LEN);
   kernel/sys.c-	memcpy(&tmp.version, &utsname()->version, __OLD_UTS_LEN);
   kernel/sys.c-	memcpy(&tmp.machine, &utsname()->machine, __OLD_UTS_LEN);
   kernel/sys.c-	up_read(&uts_sem);
   kernel/sys.c:	if (copy_to_user(name, &tmp, sizeof(tmp)))

where there is likely 3 bytes of padding after 45 bytes of data
in the struct.


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
