Return-Path: <SRS0=VaV3=27=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053C9C33CA2
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 12:35:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FD620721
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 12:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FD620721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00ACYign011560;
	Fri, 10 Jan 2020 13:34:45 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D86EA77EA;
	Fri, 10 Jan 2020 13:34:44 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5645377E3
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 13:34:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00ACYgom023262
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 13:34:42 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,416,1571695200"; d="scan'208";a="430787412"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 13:34:41 +0100
Date: Fri, 10 Jan 2020 13:34:41 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b6e7b8ac-4de8-00a0-d12c-ebf727af3e26@web.de>
Message-ID: <alpine.DEB.2.21.2001101334160.2897@hadrien>
References: <20200107170240.47207-1-wenyang@linux.alibaba.com>
 <b6e7b8ac-4de8-00a0-d12c-ebf727af3e26@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1162816898-1578659682=:2897"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 13:34:45 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 13:34:42 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?ISO-8859-15?Q?Matthias_M=E4nnich?= <maennich@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2] coccinelle: semantic patch to check for
 inappropriate do_div() calls
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

--8323329-1162816898-1578659682=:2897
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 10 Jan 2020, Markus Elfring wrote:

> > +@initialize:python@
> …
> > +def construct_warnings(str, suggested_fun):
>
> This function will be used only for the operation modes “org” and “report”.
> Thus I suggest to replace the specification “initialize” by a corresponding dependency
> which is already applied for the SmPL rule “r”.
>
>
> Can subsequent SmPL disjunctions become more succinct?
>
>
> The passing of function name variants contains a bit of duplicate Python code.
> Will a feature request like “Support for SmPL rule groups” become more interesting
> for the shown use case?
> https://github.com/coccinelle/coccinelle/issues/164

The code is fine as it is in these respects.

julia
--8323329-1162816898-1578659682=:2897
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1162816898-1578659682=:2897--
