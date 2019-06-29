Return-Path: <SRS0=Vvcs=U4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13796C4321A
	for <cocci@archiver.kernel.org>; Sat, 29 Jun 2019 07:49:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD680214AF
	for <cocci@archiver.kernel.org>; Sat, 29 Jun 2019 07:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD680214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5T7n8Gj025748;
	Sat, 29 Jun 2019 09:49:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CD2E07775;
	Sat, 29 Jun 2019 09:49:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1B4AB7770
 for <cocci@systeme.lip6.fr>; Sat, 29 Jun 2019 09:49:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5T7n5iD018924
 for <cocci@systeme.lip6.fr>; Sat, 29 Jun 2019 09:49:05 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,430,1557180000"; d="scan'208";a="311853501"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2019 09:49:04 +0200
Date: Sat, 29 Jun 2019 09:49:04 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <76641efc-2e3e-8664-03b2-4eb82f01c275@web.de>
Message-ID: <alpine.DEB.2.21.1906290947470.2579@hadrien>
References: <1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn>
 <904b9362-cd01-ffc9-600b-0c48848617a0@web.de>
 <76641efc-2e3e-8664-03b2-4eb82f01c275@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-766857525-1561794544=:2579"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 29 Jun 2019 09:49:09 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 29 Jun 2019 09:49:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [v2] coccinelle: semantic code search for missing
	of_node_put
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-766857525-1561794544=:2579
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 29 Jun 2019, Markus Elfring wrote:

> >> +if (x == NULL || ...) S
> >> +... when != e = (T)x
> >> +    when != true x == NULL
> >
> > I wonder if this code exclusion specification is really required
> > after a null pointer was checked before.
>
> I would like to add another view for this implementation detail.
>
> The when constraint can express a software desire which can be reasonable
> to some degree. You would like to be sure that a null pointer will not occur
> after a corresponding check succeeded.

He wants to be sure that the true branch through a NULL pointer check is
not taken.

> * But I feel unsure about the circumstances under which the Coccinelle software
>   can determine this aspect actually.
>
> * I find that it can eventually make sense only after the content of
>   the local variable (which is identified by “x”) was modified.
>   Thus I would find the exclusion of assignments more useful at this place.

I assume that it was added because it was found to be useful.  Please
actually try things out before declaring them to be useless.

julia
--8323329-766857525-1561794544=:2579
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-766857525-1561794544=:2579--
