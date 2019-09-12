Return-Path: <SRS0=dhti=XH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813CDC49ED6
	for <cocci@archiver.kernel.org>; Thu, 12 Sep 2019 02:08:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2232082C
	for <cocci@archiver.kernel.org>; Thu, 12 Sep 2019 02:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nZpsi6Ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2232082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netbsd.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8C28AOj005034;
	Thu, 12 Sep 2019 04:08:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B63C27797;
	Thu, 12 Sep 2019 04:08:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 779F87795
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 04:08:08 +0200 (CEST)
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8C287ob004629
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 04:08:07 +0200 (CEST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
 by pb-smtp1.pobox.com (Postfix) with ESMTP id A160920411
 for <cocci@systeme.lip6.fr>; Wed, 11 Sep 2019 21:51:57 -0400 (EDT)
 (envelope-from dyoung@netbsd.org)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
 :subject:message-id:mime-version:content-type; s=sasl; bh=Xaq+zO
 urj+Nt1Wd+hs3NdkpnUDg=; b=nZpsi6TsTmXa4Gcv8pYk1JDDN9nHKG0IzJcDb7
 AnyQBR1Wrw/L1EgfYeCr9n1020auIMydcNMGsH/vX0aGnFvTa8jjHDVwqcLpcqUe
 eXnzPk9dRllL25WorQJ/0IjQwVeMUlMR+eVfjCkLL3zrs6D2Vvd9Hd4s+OSTQgh/
 u5oDI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
 by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A27120410
 for <cocci@systeme.lip6.fr>; Wed, 11 Sep 2019 21:51:57 -0400 (EDT)
 (envelope-from dyoung@netbsd.org)
Received: from elmendorf.whitecoralislands.com (unknown [67.173.96.142])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7B582040F
 for <cocci@systeme.lip6.fr>; Wed, 11 Sep 2019 21:51:56 -0400 (EDT)
 (envelope-from dyoung@netbsd.org)
Received: by elmendorf.whitecoralislands.com (Postfix, from userid 1000)
 id DD5C61BF516; Wed, 11 Sep 2019 20:51:55 -0500 (CDT)
Date: Wed, 11 Sep 2019 20:51:55 -0500
From: David Young <dyoung@netbsd.org>
To: cocci@systeme.lip6.fr
Message-ID: <20190912015155.GE26691@pobox.com>
Mail-Followup-To: cocci@systeme.lip6.fr
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: E6F98C6E-D4FF-11E9-961B-C28CBED8090B-71664428!pb-smtp1.pobox.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 12 Sep 2019 04:08:12 +0200 (CEST)
X-Greylist: Delayed for 00:16:08 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Thu, 12 Sep 2019 04:08:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] continue statement of death?
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

Today I built and installed Coccinelle 1.0.7 on NetBSD.

I am processing this fragment of NetBSD kernel code, `tbr_timeout.c`,

| /*
|  * tbr_timeout goes through the interface list, and kicks the drivers
|  * if necessary.
|  */
| static void
| tbr_timeout(void *arg)
| {
|         struct ifnet *ifp;
|         int active, s;
| 
|         active = 0;
|         s = splnet();
|         for (ifp = TAILQ_FIRST(&ifnet); ifp; ifp = TAILQ_NEXT(ifp, if_list)) {
|                 if (!TBR_IS_ENABLED(&ifp->if_snd))
| #if 1
|                         continue;
| #endif
|                 active++;
|                 if (!IFQ_IS_EMPTY(&ifp->if_snd) && ifp->if_start != NULL)
|                         (*ifp->if_start)(ifp);
|         }
|         splx(s);
|         if (active > 0)
|                 CALLOUT_RESET(&tbr_callout, 1, tbr_timeout, NULL);
|         else
|                 tbr_timer = 0;  /* don't need tbr_timer anymore */
| }
| 

using this semantic patch, `tailq.spatch`,

| @@
| identifier I, N;
| expression H;
| statement S;
| iterator name TAILQ_FOREACH;
| @@
| 
| - for (I = TAILQ_FIRST(H); I != NULL; I = TAILQ_NEXT(I, N)) S
| + TAILQ_FOREACH(I, H, N) S

I find that if the condition in the `#if` directive is 1, then `spatch
--sp-file tailq.spatch -o tbr_timeout.spatch tbr_timeout.c` runs for
a few minutes before running out of memory. `spatch` prints this
mysterious message when it starts:

     (ONCE) already tagged but only removed, so safe

If I turn the condition to 0, however, spatch instantaneously prints the
result with the `for (...)` clause turned to `TAILQ_FOREACH(...)`, as
expected.  I don't see the mysterious `(ONCE) ...` message.

Any ideas why `continue;` is troublesome to spatch?

Dave

-- 
David Young
dyoung@pobox.com    Urbana, IL    (217) 721-9981
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
