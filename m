Return-Path: <SRS0=An1N=P6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D9EC282C3
	for <cocci@archiver.kernel.org>; Tue, 22 Jan 2019 19:53:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A5120870
	for <cocci@archiver.kernel.org>; Tue, 22 Jan 2019 19:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A5120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0MJr7bx016172
          ; Tue, 22 Jan 2019 20:53:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 99B5876F2;
	Tue, 22 Jan 2019 20:53:07 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BB71C76EA
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 20:53:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0MJr6uK028701
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 20:53:06 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,508,1539640800"; d="scan'208";a="365311700"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 20:53:05 +0100
Date: Tue, 22 Jan 2019 20:53:05 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: "=?ISO-2022-JP?Q?=1B$BF#K\\B=404u=1B=28J?=" <fjtkut@gmail.com>
In-Reply-To: <CADa4oMX2YL+ZLy2QA+=HELLTvFyMxw_dxueceLBH30Pk6+se3A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1901222050430.2519@hadrien>
References: <CADa4oMX2YL+ZLy2QA+=HELLTvFyMxw_dxueceLBH30Pk6+se3A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-137569497-1548186786=:2519"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 22 Jan 2019 20:53:08 +0100 (CET)
X-Greylist: Delayed for 00:09:06 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Tue, 22 Jan 2019 20:53:06 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Questions about coccinelle
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

--8323329-137569497-1548186786=:2519
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 23 Jan 2019, 藤本太希 wrote:

> Hello.
> I am a student of Kochi University of Technology in Japan.I have asked a question before.
> Thank you for all your help on that occasion.
> This time I have one questions about to create rule.
>
> I would like to apply rule2 only to routes that did not match rule1.
> What should I do?

I could probably better answer the question if you could send the actual
code.

Perhaps you can put a position variable in rule1, and then declare another
position variable in rule2, and be sure that the position in rule2 is
different than the position in rule1.  For example:

@r@
position p;
@@

f@p(0);

@@
position p != r.p;
expression e;
@@

f@p(e);  // won't match f(0)

julia
--8323329-137569497-1548186786=:2519
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-137569497-1548186786=:2519--
