Return-Path: <SRS0=3gGd=ZN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6BAC432C0
	for <cocci@archiver.kernel.org>; Thu, 21 Nov 2019 20:46:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552AB2068D
	for <cocci@archiver.kernel.org>; Thu, 21 Nov 2019 20:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552AB2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xALKjmT2003450;
	Thu, 21 Nov 2019 21:45:48 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9C6E577CF;
	Thu, 21 Nov 2019 21:45:48 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8C8EC77CE
 for <cocci@systeme.lip6.fr>; Thu, 21 Nov 2019 21:40:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xALKekCY001147
 for <cocci@systeme.lip6.fr>; Thu, 21 Nov 2019 21:40:46 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,227,1571695200"; d="scan'208";a="412935183"
Received: from abo-228-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.228])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Nov 2019 21:40:46 +0100
Date: Thu, 21 Nov 2019 21:40:45 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Michal Kubecek <mkubecek@suse.cz>
In-Reply-To: <20191121133817.GF29650@unicorn.suse.cz>
Message-ID: <alpine.DEB.2.21.1911212139130.2902@hadrien>
References: <1572076456-12463-1-git-send-email-zhang.lin16@zte.com.cn>
 <c790578751dd69fb1080b355f5847c9ea5fb0e15.camel@perches.com>
 <bc150c6a-6d3e-ff01-e40e-840e8a385bda@metux.net>
 <20191121111917.GE29650@unicorn.suse.cz> <20191121120733.GF5604@kadam>
 <20191121133817.GF29650@unicorn.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 21 Nov 2019 21:45:48 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 21 Nov 2019 21:40:46 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 21 Nov 2019 21:45:46 +0100
Cc: jakub.kicinski@netronome.com, ast@kernel.org, jiang.xuexin@zte.com.cn,
        natechancellor@gmail.com, f.fainelli@gmail.com, daniel@iogearbox.net,
        john.fastabend@gmail.com, lirongqing@baidu.com,
        maxime.chevallier@bootlin.com, vivien.didelot@gmail.com,
        pablo@netfilter.org, wang.yi59@zte.com.cn, hawk@kernel.org,
        arnd@arndb.de, jiri@mellanox.com, xue.zhihong@zte.com.cn,
        zhanglin <zhang.lin16@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>, cocci <cocci@systeme.lip6.fr>,
        Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linyunsheng@huawei.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Joe Perches <joe@perches.com>, bpf@vger.kernel.org,
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



On Thu, 21 Nov 2019, Michal Kubecek wrote:

> On Thu, Nov 21, 2019 at 03:07:33PM +0300, Dan Carpenter wrote:
> > On Thu, Nov 21, 2019 at 12:19:17PM +0100, Michal Kubecek wrote:
> > > On Thu, Nov 21, 2019 at 11:23:34AM +0100, Enrico Weigelt, metux IT consult wrote:
> > > > On 26.10.19 21:40, Joe Perches wrote:
> > > > > On Sat, 2019-10-26 at 15:54 +0800, zhanglin wrote:
> > > > >> memset() the structure ethtool_wolinfo that has padded bytes
> > > > >> but the padded bytes have not been zeroed out.
> > > > > []
> > > > >> diff --git a/net/core/ethtool.c b/net/core/ethtool.c
> > > > > []
> > > > >> @@ -1471,11 +1471,13 @@ static int ethtool_reset(struct net_device *dev, char __user *useraddr)
> > > > >>
> > > > >>  static int ethtool_get_wol(struct net_device *dev, char __user *useraddr)
> > > > >>  {
> > > > >> -	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
> > > > >> +	struct ethtool_wolinfo wol;
> > > > >>
> > > > >>  	if (!dev->ethtool_ops->get_wol)
> > > > >>  		return -EOPNOTSUPP;
> > > > >>
> > > > >> +	memset(&wol, 0, sizeof(struct ethtool_wolinfo));
> > > > >> +	wol.cmd = ETHTOOL_GWOL;
> > > > >>  	dev->ethtool_ops->get_wol(dev, &wol);
> > > > >>
> > > > >>  	if (copy_to_user(useraddr, &wol, sizeof(wol)))
> > > > >
> > > > > It seems likely there are more of these.
> > > > >
> > > > > Is there any way for coccinelle to find them?
> > > >
> > > > Just curios: is static struct initialization (on stack) something that
> > > > should be avoided ? I've been under the impression that static
> > > > initialization allows thinner code and gives the compiler better chance
> > > > for optimizations.
> > >
> > > Not in general. The (potential) problem here is that the structure has
> > > padding and it is as a whole (i.e. including the padding) copied to
> > > userspace. While I'm not aware of a compiler that wouldn't actually
> > > initialize the whole data block including the padding in this case, the
> > > C standard provides no guarantee about that so that to be sure we cannot
> > > leak leftover kernel data to userspace, we need to explicitly initialize
> > > the whole block.
> >
> > GCC will not always initialize the struct holes.  This patch fixes a
> > real bug that GCC on my system (v7.4)
>
> Just checked (again) to be sure. No matter if the function is inlined or
> not, gcc 7.4.1 initializes the structure by one movl (of 0x5) and two
> movq (of 0x0), i.e. initializes all sizeof(struct ethtool_wolinfo) = 20
> bytes including the padding.
>
> One could certainly construct examples where a real life compiler would
> only initialize the fields. That's why I said "in this case".

Looking again at the case that I mentioned, I see:

# drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:691:          struct drm_amdgpu_info_device dev_info = {};
        call    __sanitizer_cov_trace_pc        #
        leaq    840(%rsp), %rdi #, tmp1126
        xorl    %eax, %eax      # tmp1127
        movl    $46, %ecx       #, tmp1128
        rep stosq

So I guess the rep stosq is doing the memset.

julia

>
> Michal Kubecek
>
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
