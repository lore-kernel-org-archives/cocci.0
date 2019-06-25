Return-Path: <SRS0=4esG=UY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8125DC48BD5
	for <cocci@archiver.kernel.org>; Tue, 25 Jun 2019 12:40:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6232208CA
	for <cocci@archiver.kernel.org>; Tue, 25 Jun 2019 12:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gokfaP+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6232208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5PCeatx026551;
	Tue, 25 Jun 2019 14:40:37 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 046D87770;
	Tue, 25 Jun 2019 14:40:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 67F1E76AC
 for <cocci@systeme.lip6.fr>; Tue, 25 Jun 2019 14:40:34 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5PCeWoJ005365
 for <cocci@systeme.lip6.fr>; Tue, 25 Jun 2019 14:40:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1561466431;
 bh=2l4T7IuC9e91d5x7BltUJc/7V5uH94CR0Xwcr6bIyII=;
 h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
 b=gokfaP+gtL82LhfAVZ/njGUCVXRauQuEnTMLBihcCzoqznHHztYW4Re7Jn+EEAnyW
 tV+anbT88Ofm7kX0eXhbJBcBb+ZvWQXtAqCMT1ri8ngAFTVHB8SLJjzZeAxdS4rWc9
 D6yuseGBhv49rxMLDZVn9PRzvII+ybVe5g1f2R/g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.103.88]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lakoa-1iQ8Ax2ur2-00kMtS for
 <cocci@systeme.lip6.fr>; Tue, 25 Jun 2019 14:40:31 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <43dc8f93-4c20-32da-f5c2-6f26bc4ef627@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <eb86530e-4d1b-c080-fc7c-341d24acb8ef@web.de>
Date: Tue, 25 Jun 2019 14:40:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <43dc8f93-4c20-32da-f5c2-6f26bc4ef627@web.de>
Content-Language: en-GB
X-Provags-ID: V03:K1:q9CxuIahMeLxcrt48pr7trZmsQbbSwYs0sobN88UZOQoj8r/+aZ
 oRfEus1IDG8QwlTD1YJm9BMQ0EK/8JHdj4RkHGy9hVcAVcwESkg5XHk/iKi1ehBJbk6Ig4a
 fPnrEzuwE0XkI1weyJzWiT3m4HSV9SKD8rVsRodRz5NZLi/n3s5rKjyw+quwF2dIyHopOBA
 r4PryG54o8q7utw7dQYrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RgZw3PA4QMY=:gy0UbrTAShrGMe40ftOXZk
 taQC6+BSPwhJUYiLvknVflN+6iJdGoxAy3xnaJSR5G6LVc3bneuG+KVRnC3B9MdAx4yEBcjmv
 PGwoQbKnzSsPnwwE5i6hgB4F+g/STpBGQqKzCrf9nRMCAIF24+ZqF8TqEatGBWUNLBaZb0Azz
 K+PSr0j51Wbvjqn+2PGlnI6i3sz0kDPqA1IW/4kTXn3MreUZ5T91P4j1e4dJkMPxviITS5t6B
 10bT9TKBGKaB6elir/b11gXjJXl0e4vVExsXrtYBhchH8Fd2Jh224gxJQ74JGn4UnDIEpO3jm
 aB8aTBk9dP5ejHbNLEAioZhoLCP1XMQguIPceRHcHlWLp5o0TTgV1JmDIuAcpM+/hD6X2NibP
 /TQtIN80GglpcpwkwRPrWgqwx+mEXjoQtpqFV/Zl9aC6kypTxGW5KliTDGzCh05zji4uJIB3l
 41vlEzaLOgEW81/t+sFJenKaAO1P9AHIUgl7NABUf5Y8ccL3LjW71Sq55GnGvwCmm/nCid3Z9
 rmRYInD9uFROX8ZNbvLvzEeYYVLeGIJT8D7yI7vnNb62uzhgvFFxJGm94aXiUJ8yQSBJxr/H/
 yxENyl4QLx6+wIc7Km1cnICanix6jT5ZgLt8syGUoUPk8uQRTSwI6qRKhulhzbHCzSz7QMXkq
 YW8lgL+6TaVuqvtAfDFiw5TmrOk2ArGPjkkdBQVYX5HrQHokXAS7sjZzxJW+QZ4xt8CAnSTaa
 y7/ZFOYn2suOaABu9aCpnfHpPpYul/t10icD9qLqnED66dyEcvk20BewaKDDm5SCuY4WkFPZG
 7hD+k99YWU0/uBONlo09jcBff+KMlDxhAWbcYhKcYHT/nfeyZSk1bwv6XMJz+V+p6nPEv766B
 yR/FbrFopXXKjZKRxC56+p5KEGPPbUEspKFTny0a7kMgw/Gqp+pSribr9fhlRyMx23y7ksiCR
 qHZTDgZe53S4yHyNzy8bOstObhcDxxP0QeG0nIWIsxTsL+0KPT1Qj
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 25 Jun 2019 14:40:37 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 25 Jun 2019 14:40:33 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] More precise distinction of types for source code
	searches?
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

> The expected difference can trigger the need to express this detail
> by the usage of two identifiers based on the same metavariable type.

I guess that this wording should be clarified a bit more according to
the current software development status around the semantic patch language.
A selection of different metavariable types is supported already.
https://github.com/coccinelle/coccinelle/blob/c6d7554edf7c4654aeae4d33c3f040e300682f23/docs/manual/cocci_syntax.tex#L199

So it seems to be occasionally appropriate to use metavariables with
the same type while different names are chosen then for the corresponding
variable declaration.


Another SmPL script example:
@test@
constant c1, c2;
@@
 x =
*    c1
 ;
 x =
*    c2
 ;


Such a source code search specification is too generic so far
when you would really like to determine if these assignments (or its elements)
are equivalent or even identical (or not).

I am looking again for possibilities to improve language distinctions here.

* How can a single metavariable remember a mapping to a previous instance
  from its type?

* How will it become possible to match only a subset of a known base type?

* How often do you want to exclude something because of a previous match with
  a similar type?


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
