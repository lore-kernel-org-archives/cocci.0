Return-Path: <SRS0=Qlnj=ST=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F073C10F12
	for <cocci@archiver.kernel.org>; Wed, 17 Apr 2019 07:58:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA5F20821
	for <cocci@archiver.kernel.org>; Wed, 17 Apr 2019 07:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA5F20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3H7vnPG020324
          ; Wed, 17 Apr 2019 09:57:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8B00D773C;
	Wed, 17 Apr 2019 09:57:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E6DC87735
 for <cocci@systeme.lip6.fr>; Wed, 17 Apr 2019 09:57:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3H7vlql010575
 for <cocci@systeme.lip6.fr>; Wed, 17 Apr 2019 09:57:47 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,361,1549926000"; d="scan'208";a="378995705"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 09:57:46 +0200
Date: Wed, 17 Apr 2019 09:57:46 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <39151ab1-0310-95cb-bbcc-c5edb4a179d9@web.de>
Message-ID: <alpine.DEB.2.21.1904170956300.2612@hadrien>
References: <39151ab1-0310-95cb-bbcc-c5edb4a179d9@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-967338190-1555487867=:2612"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Apr 2019 09:57:50 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 17 Apr 2019 09:57:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Working with backreferences in SmPL scripts?
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

--8323329-967338190-1555487867=:2612
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 17 Apr 2019, Markus Elfring wrote:

> Hello,
>
> I have tried another small SmPL script out.
>
>
> @replacement@
> expression ex;
> identifier var;
> @@
>  var
> -   = var +
> +   +=
>             ex
>
>
> elfring@Sonne:~/Projekte/Coccinelle/Probe> spatch simplify_addition1.cocci Test_increment1.c
> …
> @@ -1,6 +1,6 @@
>  int main(void)
>  {
>  int counter = 3;
> -counter = counter + 5;
> +counter += 5;
>  return counter;
>  }
>
>
> I have repeated this transformation approach with the following source code.
>
>
> int main(void)
> {
> int x = 2, y = 3;
> x = y + 5;
> return x;
> }

A metavariable is always bound to the same value within a given
control-flow path.  I have no idea what you are trying to get at with
this example.

julia

>
>
> This test example did not present a generated change suggestion.
> I find that such a result can be interpreted in two ways then.
>
> 1. The Coccinelle software ensured that the specified metavariable “var”
>    referred to the same source code at all shown places with the consequence
>    that the variable “y” could not match in this test case.
>
> 2. A possible data output was not displayed despite of the detail
>    that the variable “y” is also an identifier according to the syntax of
>    the C programming language.
>    Would there be a need to express a relationship to a previous match
>    by a kind of notation for backreferences?
>
>
> The situation can become challenging for the safe handling of advanced
> statements in more meaningful source files.
>
> * How do you think about to help with the reconsideration
>   (and occasional deletion) of duplicate code by the means of
>   the semantic patch language?
>
> * Would you like to clarify the desired software behaviour for such use cases?
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-967338190-1555487867=:2612
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-967338190-1555487867=:2612--
