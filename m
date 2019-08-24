Return-Path: <SRS0=z30s=WU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DA2C3A59E
	for <cocci@archiver.kernel.org>; Sat, 24 Aug 2019 11:33:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039302146E
	for <cocci@archiver.kernel.org>; Sat, 24 Aug 2019 11:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039302146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7OBXXOH020052;
	Sat, 24 Aug 2019 13:33:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A9370778E;
	Sat, 24 Aug 2019 13:33:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 36007778B
 for <cocci@systeme.lip6.fr>; Sat, 24 Aug 2019 13:33:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7OBXVXQ016837
 for <cocci@systeme.lip6.fr>; Sat, 24 Aug 2019 13:33:31 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,425,1559512800"; d="scan'208";a="398737841"
Received: from unknown (HELO [192.168.0.132]) ([223.255.127.50])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Aug 2019 13:24:03 +0200
Date: Sat, 24 Aug 2019 19:23:15 +0800 (CST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <44525ca7-a97b-0858-9131-a97459bac4b5@linux.com>
Message-ID: <alpine.DEB.2.21.1908241922190.2720@hadrien>
References: <44525ca7-a97b-0858-9131-a97459bac4b5@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 24 Aug 2019 13:33:34 +0200 (CEST)
X-Greylist: Delayed for 00:09:26 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sat, 24 Aug 2019 13:33:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Rule for turning !unlikely to likely
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



On Sat, 24 Aug 2019, Denis Efremov wrote:

> Hi,
>
> I'm trying to write a rule for turning !unlikely to likely and vice versa.
> However, it's hard for me to understand what is wrong with the rule and how to
> make it work. Any suggestions? Do I need to introduce 'expression E;' instead
> '(...)'? BTW, spatch hangs with -Dorg.

Try adding

disable unlikely

to each rule.  There is an isomorphism that makes likely and unlikely
optional and perhaps it causes problems.

julia

>
> The rule:
>
> virtual patch
> virtual context
> virtual org
> virtual report
>
> //----------------------------------------------------------
> //  For context mode
> //----------------------------------------------------------
>
> @depends on context disable unlikely@
> @@
>
> (
> * !likely(...)
> |
> * !unlikely(...)
> )
>
> //----------------------------------------------------------
> //  For patch mode
> //----------------------------------------------------------
>
> @depends on patch disable unlikely@
> @@
>
> (
> -!likely
> +unlikely
>  (...)
> |
> -!unlikely
> +likely
>  (...)
> )
>
> //----------------------------------------------------------
> //  For org and report mode
> //----------------------------------------------------------
>
> @r depends on (org || report) disable unlikely@
> position p;
> @@
>
> (
>  !likely@p(...)
> |
>  !unlikely@p(...)
> )
>
> @script:python depends on org@
> p << r.p;
> @@
>
> coccilib.org.print_todo(p[0], "WARNING use unlikely instead of !likely")
>
> @script:python depends on report@
> p << r.p;
> @@
>
> msg="WARNING: Use unlikely instead of !likely and likely instead of !unlikely"
> coccilib.report.print_report(p[0], msg)
>
> Thanks,
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
