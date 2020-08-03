Return-Path: <SRS0=D+wQ=BN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945E8C433DF
	for <cocci@archiver.kernel.org>; Mon,  3 Aug 2020 12:18:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F84F204EC
	for <cocci@archiver.kernel.org>; Mon,  3 Aug 2020 12:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F84F204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 073CI5nm028864;
	Mon, 3 Aug 2020 14:18:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DEAAD76BF;
	Mon,  3 Aug 2020 14:18:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E22FE41F5
 for <cocci@systeme.lip6.fr>; Mon,  3 Aug 2020 14:18:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 073CI44m012532
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 3 Aug 2020 14:18:04 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,430,1589234400"; d="scan'208";a="355857185"
Received: from clt-128-93-177-162.vpn.inria.fr ([128.93.177.162])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Aug 2020 14:18:04 +0200
Date: Mon, 3 Aug 2020 14:18:03 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <a8d8eade-1d98-b8d9-7c66-bd05b22af751@linux.com>
Message-ID: <alpine.DEB.2.22.394.2008031416301.27678@hadrien>
References: <20200605204237.85055-1-efremov@linux.com>
 <20200731210026.7186-1-efremov@linux.com>
 <alpine.DEB.2.22.394.2008022142550.2531@hadrien>
 <a8d8eade-1d98-b8d9-7c66-bd05b22af751@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 03 Aug 2020 14:18:06 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 03 Aug 2020 14:18:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v6] coccinelle: api: add kvfree script
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



On Mon, 3 Aug 2020, Denis Efremov wrote:

>
>
> On 8/2/20 11:24 PM, Julia Lawall wrote:
> >> +@initialize:python@
> >> +@@
> >> +# low-level memory api
> >> +filter = frozenset(['__vmalloc_area_node'])
> >> +
> >> +def relevant(p):
> >> +    return not (filter & {el.current_element for el in p})
> >
> > Is this used?
>
> I'll remove it in v8. Or do you want me to add iterate_dir_item() in the list?

What is that?

>
> >
> > Otherwise, I think it would be good to not warn about a use of kvfree
> > if that use is reachable from a kvmalloc.  There seems to be such a false
> > positive in fs/btrfs/send.c, on line 1118.
>
> I don't know how to handle this case without position filter.
> It's too complex. In iterate_dir_item() there is:
> buf = kmalloc(buf_len, GFP_KERNEL);
> while(...) {
> 	if (...) {
> 		if (is_vmalloc_addr(buf)) {
> 			vfree(buf);
> 			...
> 		} else {
> 			char *tmp = krealloc(buf, ...);
>
> 			if (!tmp)
> 				kfree(buf);
> 			...
> 		}
> 		if (!buf) {
> 			buf = kvmalloc(buf_len, GFP_KERNEL);
> 			...
> 		}
> 	}
> }
> kvfree(buf);
>
> Adding "when != kvfree(E)" is not enough:
> * E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
> *       kvmalloc_array\)(...)@k
> 	... when != is_vmalloc_addr(E)
> +	when != kvfree(E)
> 	when any
> * \(kfree\|kzfree\|vfree\|vfree_atomic\)(E)@p

Why not just

@ok exists@
position p;
expression E;
@@

E = kvalloc(...)
...
kvfree@p(...)

Probably that is what you mean by a position filter, but why not add a
position filter?

julia


> >
> > It also seems that when there are both a kmalloc and a vmalloc, there is
> > no warning if kfree or vfree is used.  Is that intentional?
> >
>
> No, I will try to address it in v8.
>
> Regards,
> Denis
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
