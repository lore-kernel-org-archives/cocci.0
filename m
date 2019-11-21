Return-Path: <SRS0=3gGd=ZN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5E4C432C3
	for <cocci@archiver.kernel.org>; Thu, 21 Nov 2019 20:06:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120F020672
	for <cocci@archiver.kernel.org>; Thu, 21 Nov 2019 20:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120F020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xALK6hkC023989;
	Thu, 21 Nov 2019 21:06:43 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A07DF77CF;
	Thu, 21 Nov 2019 21:06:43 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1D8A277CE
 for <cocci@systeme.lip6.fr>; Thu, 21 Nov 2019 21:06:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xALK6fJM009020
 for <cocci@systeme.lip6.fr>; Thu, 21 Nov 2019 21:06:41 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,227,1571695200"; d="scan'208";a="412932504"
Received: from abo-228-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.228])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Nov 2019 21:06:41 +0100
Date: Thu, 21 Nov 2019 21:06:40 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-2?Q?Ond=F8ej_Sur=FD?= <ondrej@sury.org>
In-Reply-To: <7FB3DF60-DEFB-434B-9A84-33575D34576E@sury.org>
Message-ID: <alpine.DEB.2.21.1911212057420.2902@hadrien>
References: <7FB3DF60-DEFB-434B-9A84-33575D34576E@sury.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1206647461-1574366801=:2902"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 21 Nov 2019 21:06:44 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 21 Nov 2019 21:06:41 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] "already tagged token" error?
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

--8323329-1206647461-1574366801=:2902
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 20 Nov 2019, Ondřej Surý wrote:

> Hi,
>
> this is the error we started getting with upgrade to 1.0.7 (from 1.0.6).
>
> EXN: Failure("rule starting on line 1: already tagged token:\nC code context\nFile \"./lib/dns/client.c\", line 1342, column 1, charpos = 33224\n  around = 'if',\n  whole content = \tif (rctx == NULL)“)
>
> EXN: Failure("rule starting on line 1: already tagged token:\nC code context\nFile \"./lib/ns/tests/nstest.c\", line 704, column 1, charpos = 15998\n  around = 'if',\n  whole content = \tif (qctx != NULL) {")
>
> The minimal reproducer is:
>
> @@
> statement S1, S2;
> expression V;
> @@
>
> V = isc_mem_get(...);
> - if (V == NULL) S1 else { S2 }
> + S2

I would need the C code as well.  Maybe it would help to write:

- if (V == NULL) S1 else {
  S2
- }

>
> --
>
> On related note, what would be the correct way to write a rule for:
>
> foo = isc_mem_get(…);
> bar = isc_mem_get(…);
>
> if (foo == NULL || bar == NULL) { … };
>
> my naive approach:
>
> @@
> statement S;
> expression V, E;
> @@
>
> V = isc_mem_get(...);
> ...
> - if (V == NULL || E) S
> + if (E) S
>
> doesn’t really work (it matches only a simple case, but not when there’s more than two memory allocations).

Try replacing E by ...

Then reorganize the pattern so that there is only - code, not + code.
I'm not sure this will actually work for transformation though.  You may
have to be resigned to just searching for the problem, ie

V = isc_mem_get(...);
...
* if (V == NULL || E) S

and not actually doing the update.


> I thought something like this might work:
>
> @@
> statement S;
> expression V, E;
> @@
>
> V = isc_mem_get(...);
> ...
> if (...
> -|| V == NULL
> ...) S

The ... right after NULL doesn't work.  It could be || ...

> @@
> statement S;
> expression V, E;
> @@
>
> V = isc_mem_get(...);
> ...
> if (...
> - V == NULL ||
> ...) S
>
> would work, but it says:
>
> minus: parse error:
>   File "x", line 10, column 0, charpos = 86
>   around = '...',
>   whole content = ...) S

Likewise, you would need ... ||

>
> --
>
> And one last question:
>
> Is there a simple way how to merge these these rules together?  It seems
> like it should be possible, but I wasn’t able to decipher the syntax for
> making parts of the match to be remove to be optional (but if you point
> me to an example in the base files or coccinellery, I would try harder).
>
> @@
> statement S1, S2;
> expression V;
> @@
>
> V = isc_mem_get(...);
> - if (V == NULL) S1 else { S2 }
> + S2
>
> @@
> statement S;
> expression V;
> @@
>
> V = isc_mem_get(...);
> - if (V == NULL) S
>
> @@
> type T;
> statement S;
> expression V;
> @@
>
> V = (T *)isc_mem_get(...);
> - if (V == NULL) S

If you had just (T) rather than (T*), then this rule would also cover
everything covered by the previous rule.  But if you want to specify that
it has to be a pointer type then a specific rule is needed.

>
> @@
> statement S;
> expression V;
> @@
>
> if (V == NULL) V = isc_mem_get(...);
> - if (V == NULL) S
>
> @@
> type T;
> expression V, E1, E2;
> @@
>
> - V = (T)isc_mem_get(E1, E2);
> + V = isc_mem_get(E1, E2);

If you put this rule first, then the other rules would not have to
consider the type case.

julia

>
> Thank you,
> --
> Ondřej Surý
> ondrej@sury.org
>
>
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1206647461-1574366801=:2902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1206647461-1574366801=:2902--
