Return-Path: <SRS0=Ssaw=JS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E757C433B4
	for <cocci@archiver.kernel.org>; Wed, 21 Apr 2021 19:16:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7132D61428
	for <cocci@archiver.kernel.org>; Wed, 21 Apr 2021 19:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7132D61428
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13LJGpTS011916;
	Wed, 21 Apr 2021 21:16:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CEA3D77D8;
	Wed, 21 Apr 2021 21:16:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EACAA3E3B
 for <cocci@systeme.lip6.fr>; Wed, 21 Apr 2021 21:16:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13LJGoww020408
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 21 Apr 2021 21:16:50 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AmKRxCqPW/XRxQMBcTnKjsMiAIKoaSvp033AA?=
 =?us-ascii?q?0UdtRRtJNumRkM6zlPoWvCWE7go5cncmhNyGJe28UWrRnKQFhrU5EL++UGDdyQ?=
 =?us-ascii?q?iVBa5464+K+VPdMg34stVQzKJxN5V5YeeAaWRSqebfzE2GH807wN+BmZrY4Nv2?=
 =?us-ascii?q?63t2VwllZ+VBwm5CajqzKUF9SAlYCZdRLvP1jPZvnDaudW8aac62HBA+M9Trnc?=
 =?us-ascii?q?HBl57tfHc9aiIP1Q/mt1yVwYLhHwPd9hkTVC4n+8ZBzUH11yP+/buqqPy2x1v5?=
 =?us-ascii?q?23XI55pb3Pvto+EjOOW8zu4PKjvtjQ60ZINuH5261QpfnN2S?=
X-IronPort-AV: E=Sophos;i="5.82,240,1613430000"; d="scan'208";a="379307648"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Apr 2021 21:16:49 +0200
Date: Wed, 21 Apr 2021 21:16:49 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Akos Pasztory <akos.pasztory@gmail.com>
In-Reply-To: <CAJwHcF6jc_NNGeXpPh0z7upKLXSOuprS=SPmiR-x-QdYxZiEyw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2104212103160.20674@hadrien>
References: <CAJwHcF6jc_NNGeXpPh0z7upKLXSOuprS=SPmiR-x-QdYxZiEyw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1535627851-1619032610=:20674"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 21 Apr 2021 21:16:52 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 21 Apr 2021 21:16:50 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] getting rid of implicit boolean expressions
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

--8323329-1535627851-1619032610=:20674
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 21 Apr 2021, Akos Pasztory wrote:

> Hi,
>
> I'm trying do the following kind of transformations:
>
>  int x, y;
>  char *p;
>  bool b, c;
>
> -b = x || !y;
> +b = (x != 0) || (y == 0);
>
> -c = !p;
> +c = (p == NULL);
>
> -if (x & 3)
> +if ((x & 3) != 0)
>  f();
> // etc
>
> That is: trying to eliminate implicit boolean-ness (and add parentheses as well).
>
> I was thinking along the lines of first finding expressions
> that are in "boolean context" (part of a || or && expression,
> or an if/for/while condition, maybe something else too?).
> Then find sub-expressions of those that are not of the form 'E op F'
> where 'op' is a comparison operator (==, !=, <=, ...).
> And finally depending on whether they are pointer or integer and
> whether they are negated, replace them with the above constructs (x != 0, etc.)
>
> Is this the right way to think about this?  Meaning does it fit the mental model
> of Coccinelle, or some other approach is needed? (E.g. it crossed my mind to
> maybe match all expressions and try to filter out "unwanted" ones via
> position p != { ... } constraints but that seemed infeasible.)

I think you can do

A simple approach could be:

@@
idexpression *x;
@@

- x
+ (x != NULL)
  || ...

@@
idexpression x;
@@

- x
+ (x != 0)
  || ...

If you want to do function calls, you could do

@@
expression *e;
identifier f;
expression list es;
@@

- f(es)@e
+ (f(es) != NULL)
  || ...

@@
identifier f;
expression list es;
@@

- f(es)
+ (f(es) != 0)
  || ...

Some explanation:

* For pattern || ... there is an isomorphism that allows the pattern to
appear anywhere in the top level of a chain of ||s, including an empty
chain.  So it actually should match any expression in a boolean context.

* In the third rule, there is )@e.  That means that e should match the
smallest expression that contains the ), which turns out to the be
function call.  That way you can talk about the return type of the
function call.  A limitation here is that Coccinelle has to be able to
figure out what the type is (this is also a limitation of the first rule
above).  If it can't figure out the type of the variable or the return
type of the function call, then the first/third rule will fail and you
will end up with a != 0 test on a pointer.  To try to avoid this, you can
use the options --recursive-includes --use-headers-for-types
--relax-include-path to try to take into account as many header files as
possible.

An alternate approach is indeed to do something with position variables.
So you could do something like:

@ok@
position p;
expression e;
expression x;
@@

 (x != 0)@e@p

@@
position p != ok.p;
expression x;
@@

- x@p
+ (x != 0)
  || ...

But the first rule would have to be extended to consider lots of cases.

A binary operator metavariable could be helpful, eg:

binary operator bop = { ==, !=, <, > };

julia
--8323329-1535627851-1619032610=:20674
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1535627851-1619032610=:20674--
