Return-Path: <SRS0=bkjO=YR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52B9CA9EAF
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2019 07:58:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8702A205ED
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2019 07:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8702A205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9O7wZMu029514;
	Thu, 24 Oct 2019 09:58:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C033B77BB;
	Thu, 24 Oct 2019 09:58:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1D61D77B9
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 09:58:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9O7wWNr027303
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 09:58:32 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.68,224,1569276000"; d="scan'208";a="324077627"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 09:58:31 +0200
Date: Thu, 24 Oct 2019 09:58:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <37ad0bcd-941d-e02e-ae99-e89f2ce98ff0@web.de>
Message-ID: <alpine.DEB.2.21.1910240956450.4479@hadrien>
References: <alpine.DEB.2.21.1910240816040.2771@hadrien>
 <37ad0bcd-941d-e02e-ae99-e89f2ce98ff0@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1170188596-1571903912=:4479"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Oct 2019 09:58:36 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 24 Oct 2019 09:58:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xue Zhihong <xue.zhihong@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2] coccicheck: support $COCCI being defined as
 a directory
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

--8323329-1170188596-1571903912=:4479
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 24 Oct 2019, Markus Elfring wrote:

> > Second the commit log could be more concise as:
>
> I like your desire for choosing a more appropriate commit message.
>
>
> > Allow defining COCCI as a directory that contains .cocci files.
>
> I would prefer to concentrate the patch subject on other information.
>
>
> > In general, at least in simple cases, it is not necessary to mention the
> > name of the file you are modifying in the comit log, because one can see
> > that just below from looking at the diffstat and the patch.
>
> This view can be reasonable. - How does it fit to the usual requirement
> for the specification of a “subsystem” (or “prefix”) according to the
> canonical patch format?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=13b86bc4cd648eae69fdcf3d04b2750c76350053#n656

Huh?  I was talking about the log message, not the subject line.  Likewise
"Allow defining..." was not proposed as a subject line, but as the log
message.  With that degree of orientation, I think one can look at the
code and figure out what the intent is.  At least if one knows the meaning
of -d.

julia
--8323329-1170188596-1571903912=:4479
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1170188596-1571903912=:4479--
