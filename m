Return-Path: <SRS0=21EQ=7Q=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0004EC433DF
	for <cocci@archiver.kernel.org>; Wed,  3 Jun 2020 19:45:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C5820678
	for <cocci@archiver.kernel.org>; Wed,  3 Jun 2020 19:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C5820678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 053Jj6Ke007076;
	Wed, 3 Jun 2020 21:45:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A52E17567;
	Wed,  3 Jun 2020 21:45:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 587403BAB
 for <cocci@systeme.lip6.fr>; Wed,  3 Jun 2020 21:45:05 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 053Jj4HW025881
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 3 Jun 2020 21:45:04 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,469,1583190000"; d="scan'208";a="350501595"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 21:45:04 +0200
Date: Wed, 3 Jun 2020 21:45:03 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@ispras.ru>
In-Reply-To: <5149c7dd-2771-e592-c5da-f36cca725a4e@ispras.ru>
Message-ID: <alpine.DEB.2.21.2006032128480.2548@hadrien>
References: <5149c7dd-2771-e592-c5da-f36cca725a4e@ispras.ru>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 03 Jun 2020 21:45:07 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 03 Jun 2020 21:45:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] How to match a part of a rule expression (documentation)
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



On Wed, 3 Jun 2020, Denis Efremov wrote:

> Hi,
>
> I'm trying to write a rule to match consecutive function calls. For example:
> @r@
> expression E, E1;
> @@
>
>   call_func(E);
>   ... when != E = E1
> * call_func(E);
>
> It works well, but not in case "E == p->f" and p is updated in between calls.
> So, I'm to understand how can I avoid these kind of pointers update.
>
> And fail case example:
>
> struct test {
> 	int a;
> };
>
> void call_func(int);
>
> void test(void)
> {
> 	struct test t[10];
> 	struct test *i;
> 	for(i = t; i < i + 10; ++i) {
> 		call_func(i->a);
> 	}
> }
>
>
> While I tried to figure it out, I faced some cocci constructions with no documentation.
> For example, what are rulekinds, "when strict", and "expression *r.E;", "expression E1 <= r.E;"?
>
> 1)
> main_grammar.pdf, page 2:
> rulekind ::= expression
>              identifier
>              type
>
> What is it and how it could be used? I see that it's used in deref_null.cocci, doublebitand.cocci.

Some times it is not clear what kind of term a semantic patch should
match.  For example, if the semantic patch is:

@@
@@

- x
+ y

should f.x be converted to f.y.  Actually, it will not.  By default a
semantic patch rule is parsed as a statement or an expression.  But x in
f.x is an identifier.  So if you really want to replace all the x's by y's
no matter what they are used for, you would put @identifier@ on the first
line of the semantic patch.  Putting expression can avoid some parsing
ambiguities.  I'm not sure that type is actually useful, because
Coccinelle should be able to figure out what is a type by itself, at least
with the typedef declaration.

>
> 2)
> What is "... when strict"? Is it negation of "... when any" and enabled by default?

When strict is unrelated to when any and it is not emabled by default.

In a transformation rule, by default A ... B requires that there is a B
after A on every control-flow path.  But that is not reasonable if between
A and B there is some code that checks for an error condition and if
one is found aborts the function.  So by default the condition of A always
followed by B does not require B on such error paths.  Sometimes, however,
eg for locks and unlocks, you want B to appear in error handling code too.
In that case you would put when strict, to be sure B really appears in all
paths.

When any has to do with the constraint that when you have A ... B you want
the A that is closest to B.  That is the default.  If you put when any,
you get any B that is after A.


> 3) What is "expression *r.E;" in ./null/deref_null.cocci, for example:
> 43:expression *E;
> 54:expression *ifm.E;
> 115:expression *ifm.E;
> 175:expression *ifm.E;
> 239:expression *E;
> 248:expression *ifm1.E;

Any expression that is a pointer.  You can also say expression struct.

> 4) What is "expression  <= " in ./null/deref_null.cocci?
> 53:expression subE <= ifm.E;
> 114:expression subE <= ifm.E;
> 174:expression subE <= ifm.E;
> 247:expression subE <= ifm1.E;

subE is a expressionof whatever expression was previously matched to E in
the rule ifm.  <= can only be used when the metavariable on the right side
is inherited from another rule.  Ths is probably what you want for your
problem.

julia


>
> Regards,
> Denis
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
