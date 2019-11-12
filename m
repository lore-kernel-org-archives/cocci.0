Return-Path: <SRS0=dn/h=ZE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7685DC43331
	for <cocci@archiver.kernel.org>; Tue, 12 Nov 2019 16:17:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4BED214E0
	for <cocci@archiver.kernel.org>; Tue, 12 Nov 2019 16:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BED214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xACGH8kU011999;
	Tue, 12 Nov 2019 17:17:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 27FAD77C3;
	Tue, 12 Nov 2019 17:17:08 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0077677C2
 for <cocci@systeme.lip6.fr>; Tue, 12 Nov 2019 17:17:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xACGH6Cw014317
 for <cocci@systeme.lip6.fr>; Tue, 12 Nov 2019 17:17:06 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.68,297,1569276000"; d="scan'208";a="326452799"
Received: from unknown (HELO hadrien) ([12.217.66.2])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Nov 2019 17:07:32 +0100
Date: Tue, 12 Nov 2019 08:07:30 -0800 (PST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <57f95f35-532a-a9ea-62a1-cbd8d53e1a86@web.de>
Message-ID: <alpine.DEB.2.21.1911120806480.2323@hadrien>
References: <c86eccbc-a1f3-50fa-34bf-f8fefdd3036f@web.de>
 <0488a253-fa97-cc18-7884-a7509016d8fe@web.de>
 <alpine.DEB.2.21.1911120522520.2536@hadrien>
 <57f95f35-532a-a9ea-62a1-cbd8d53e1a86@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1376517929-1573574853=:2323"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 Nov 2019 17:17:09 +0100 (CET)
X-Greylist: Delayed for 00:09:32 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Tue, 12 Nov 2019 17:17:06 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking data processing for parentheses in SmPL scripts
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

--8323329-1376517929-1573574853=:2323
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 12 Nov 2019, Markus Elfring wrote:

> > What is the question, exactly?
>
> I became curious to clarify consequences around the error message
> “unexpected close parenthesis in line 6” for the other SmPL code variant
> from yesterday.
> Is the Coccinelle software looking for pairs of parentheses?

It looks for a ( in column 0 and a matching ) that is not in column 0.  In
your example there was no ( or ) in column 0, so the message is not
relevant.

julia

>
> Regards,
> Markus
>
--8323329-1376517929-1573574853=:2323
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1376517929-1573574853=:2323--
