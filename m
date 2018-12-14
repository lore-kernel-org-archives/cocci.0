Return-Path: <SRS0=WLW8=OX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69B3C6786C
	for <cocci@archiver.kernel.org>; Fri, 14 Dec 2018 08:08:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131872080F
	for <cocci@archiver.kernel.org>; Fri, 14 Dec 2018 08:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131872080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBE88Bcw000594
          ; Fri, 14 Dec 2018 09:08:11 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C411B76D8;
	Fri, 14 Dec 2018 09:08:11 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1D88E60D7
 for <cocci@systeme.lip6.fr>; Fri, 14 Dec 2018 09:08:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBE88AMN019083
 for <cocci@systeme.lip6.fr>; Fri, 14 Dec 2018 09:08:10 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,352,1539640800"; d="scan'208";a="360335709"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Dec 2018 09:08:03 +0100
Date: Fri, 14 Dec 2018 09:08:00 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: "=?ISO-2022-JP?Q?=1B$BF#K\\B=404u=1B=28J?=" <fjtkut@gmail.com>
In-Reply-To: <CADa4oMViD=7G5=54L9n2fK=2AdPQs14bBRMNRXxJjUWiZV6iLg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1812140902120.3571@hadrien>
References: <CADa4oMViD=7G5=54L9n2fK=2AdPQs14bBRMNRXxJjUWiZV6iLg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1608859821=="
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Dec 2018 09:08:12 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 14 Dec 2018 09:08:10 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] how to use Coccinelle
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

--===============1608859821==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 14 Dec 2018, 藤本太希 wrote:

>
> Hello. 
>
> I am a student of Kochi University of Technology in Japan.
>
> I have asked a question before.
>
> Thank you for all your help on that occasion.
>
> This time I have two questions about how to use Coccinelle.
>
>
>
> This is the first question.
>
> Identifiers can be declared in scripts.
>
> Can you declare the type in same way?
>
> For example, there are the following programs.
>
> ———————————————————
>
> @script:python pre@
>
> alloc;
>
> @@
>
> coccinelle.alloc = “malloc”
>
>
> @ rule1 @
>
> type T={int, double};
>
> identifier v, pre.alloc;
>
> @@
>
> T v;
>
> …
>
> alloc(...)
>
>
> @ rule2 @
>
> type T={int, double};
>
> identifier v, pre.alloc;
>
> @@
>
> T v;
>
> … when != alloc(…)
>
> ———————————————————
>
> In these two rules there is T of type with the same restriction.
>
> Can you declare this like alloc?
>
> Do you have to declare in each rule?

I think that you can say

type T = {r1.type1, r1.type2};

In your python rule, though, you should say eg

coccinelle.type1 = make_type("int")

It is necessary to make the list of possible types in each rule.  If you
said type rule1.T; in rule2, that would only be the specific binding of T
chosen in rule1.


>
>
>
> Next is the second question.
>
> In the previous answer you said
>
> “Coccinelle rather focuses on the case where variables are all defined at the top of a function”.
>
> Do you mean that we can not distinguish between the same name variables?
>
> For example, there are the following programs.
>
> ———————————————————
>
> —c-program—
>
> void foo() {
>
>   int a;
>
>   {
>
>     int a;
>
>     hoge(a);
>
>   }
>
> }
>
>
> —cocci—
>
> @rule@
>
> identifier v;
>
> type T;
>
> @@
>
> T v;
>
> …
>
> hoge(v);
>
> ———————————————————
>
> matched first a and second a．

An identifier is just a name.  It has no notion of scope.  If you want to
be sure that the second one is not matched, then you should put

T v;
... when != T1 v;
hoge(v);

julia
--===============1608859821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1608859821==--
