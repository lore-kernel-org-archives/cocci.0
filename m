Return-Path: <SRS0=peAA=EA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F75C388F7
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 20:27:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC3C22284
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 20:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC3C22284
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09PKRUax029374;
	Sun, 25 Oct 2020 21:27:30 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B98E25C18;
	Sun, 25 Oct 2020 21:27:30 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0D2F95C16
 for <cocci@systeme.lip6.fr>; Sun, 25 Oct 2020 21:27:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09PKRSZf028930
 for <cocci@systeme.lip6.fr>; Sun, 25 Oct 2020 21:27:28 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.77,417,1596492000"; d="scan'208";a="474226999"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2020 21:27:27 +0100
Date: Sun, 25 Oct 2020 21:27:27 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bee0c5df-8f28-ee9d-99e2-abbf84df76e6@web.de>
Message-ID: <alpine.DEB.2.22.394.2010252122320.2714@hadrien>
References: <0d1575b0-ab37-663e-2464-278fd76280b5@web.de>
 <alpine.DEB.2.22.394.2010251924290.2714@hadrien>
 <8f58a94e-b093-a587-c56a-a0ea0fc1f3ea@web.de>
 <alpine.DEB.2.22.394.2010251955280.2714@hadrien>
 <bee0c5df-8f28-ee9d-99e2-abbf84df76e6@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1179668747-1603657647=:2714"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 21:27:31 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 21:27:28 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?Coccinelle=3A_null=3A_Optimise_disjunctions_in_?=
 =?utf-8?b?U21QTCBzY3JpcHQg4oCcZW5vLmNvY2Np4oCd?=
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

--8323329-1179668747-1603657647=:2714
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 25 Oct 2020, Markus Elfring wrote:

> >> Would you become interested to configure a representative test environment
> >> for safe comparisons of corresponding run time characteristics
> >> of the affected software?
> >
> > In what sense could the comparison possibly be unsafe?
>
> * Our test systems are obviously different.
>   Thus concerns can be considered for reproducibility of test results
>   on other possible configurations.
>
> * We share only a tiny fraction of technical information which would probably
>   be needed for “benchmarks”.
>
>
> > Just use time and run spatch on whatever machine you want.
>
> fring@Sonne:~/Projekte/Linux/next-patched>
> elfring@Sonne:~/Projekte/Linux/next-patched> git checkout next-20201023 && XX=$(date) && time spatch -D patch --timeout 9 --jobs 4 --chunksize 1 --include-headers --no-includes --dir . scripts/coccinelle/null/eno.cocci > ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno1.diff 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno1-errors.txt; YY=$(date) && echo "$XX | $YY"
> …
> real	2m54,266s
> user	10m15,553s
> sys	0m4,004s
> So 25. Okt 20:53:56 CET 2020 | So 25. Okt 20:56:51 CET 2020
> elfring@Sonne:~/Projekte/Linux/next-patched> git checkout next-20201023 && XX=$(date) && time spatch -D context --timeout 9 --jobs 4 --chunksize 1 --include-headers --no-includes --dir . scripts/coccinelle/null/eno.cocci > ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno2.txt 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno2-errors.txt; YY=$(date) && echo "$XX | $YY"
> …
> real	2m38,494s
> user	9m39,364s
> sys	0m4,094s
> So 25. Okt 20:58:05 CET 2020 | So 25. Okt 21:00:44 CET 2020
> elfring@Sonne:~/Projekte/Linux/next-patched> git checkout optimise_disjunction_in_eno.cocci-1 && XX=$(date) && time spatch -D patch --timeout 9 --jobs 4 --chunksize 1 --include-headers --no-includes --dir . scripts/coccinelle/null/eno.cocci > ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno3.diff 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno3-errors.txt; YY=$(date) && echo "$XX | $YY"
> …
> real	2m46,097s
> user	10m15,467s
> sys	0m3,984s
> So 25. Okt 21:00:56 CET 2020 | So 25. Okt 21:03:42 CET 2020
> elfring@Sonne:~/Projekte/Linux/next-patched> git checkout optimise_disjunction_in_eno.cocci-1 && XX=$(date) && time spatch -D context --timeout 9 --jobs 4 --chunksize 1 --include-headers --no-includes --dir . scripts/coccinelle/null/eno.cocci > ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno4.txt 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno4-errors.txt; YY=$(date) && echo "$XX | $YY"
> …
> real	2m41,472s
> user	9m37,492s
> sys	0m3,834s

In the patch case, the user and system time are essentially identical.  In
the context case, the difference in user time is 2 seconds out of 9.5
minutes, 0.3%.

In the patch case, the real time is a bit slower.  But I believe that this
is due to the time to read in the data from the file system.  I also had a
number like that, but the difference disappeared when I reran it
afterwards, which meant running that case in the same conditions as the
others.

In the context case, the real time is slightly slower with your patch.

So I see no compelling evidence for making the change.

julia

> So 25. Okt 21:03:56 CET 2020 | So 25. Okt 21:06:37 CET 2020
>
>
> > Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
>
> AMD Phenom(tm) II X4 850 Processor
>
> Will any other aspects become relevant?
>
> Regards,
> Markus
>
--8323329-1179668747-1603657647=:2714
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1179668747-1603657647=:2714--
