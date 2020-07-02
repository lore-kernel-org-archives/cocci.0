Return-Path: <SRS0=nUet=AN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C4AC433DF
	for <cocci@archiver.kernel.org>; Thu,  2 Jul 2020 00:10:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74AB2077D
	for <cocci@archiver.kernel.org>; Thu,  2 Jul 2020 00:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fp6Gy8ho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74AB2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06209aaG011486;
	Thu, 2 Jul 2020 02:09:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D7C56776E;
	Thu,  2 Jul 2020 02:09:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DE697742B
 for <cocci@systeme.lip6.fr>; Thu,  2 Jul 2020 02:09:35 +0200 (CEST)
Received: from shiva.jussieu.fr (shiva.jussieu.fr [134.157.0.129])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06209Ts1013777;
 Thu, 2 Jul 2020 02:09:29 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by shiva.jussieu.fr (8.15.2/jtpda-5.4) with ESMTP id 06209313009899
 ; Thu, 2 Jul 2020 02:09:29 +0200 (CEST)
X-Ids: 164
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=itjXWeaWl+zoa6+Nj8NLNZzan7LY+vRjjEzZZHqOrYM=; b=Fp6Gy8ho+HdQ37oJzO5GcfbzPO
 tK7QdXC2EBz0292qLZmdskbeO1Ty2g01IgVzQaLZSMeC8zx6+wd05QSflw931WXEz+uBRdKrz35IN
 IicFK8/euW9rhv7Ovj3mtRuWyt4BD7/IM2R3BP/T8Nz3h2zIawgGeOe4JtvUCHPzx29QaYKwaq/XX
 8kjuMV+rOVgU0y1f61KhO+bdl6b1/4Bz4REU9kgTDSkgYJMrZC3hQka5RO3Py3fp76wMtbcVA0Rxm
 /I1VJq+tympjYY42JqiQF8Qya5gs1ovHHHFMoCNpO6SN82JEz61cXSd5JFTthuOZ0Q1nMgcJC6ctO
 i0HwZD/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jqmmR-0003Uc-22; Thu, 02 Jul 2020 00:08:43 +0000
Date: Thu, 2 Jul 2020 01:08:43 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <20200702000843.GV25523@casper.infradead.org>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
 <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
 <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
X-Miltered: at jchkmail2.reseau.jussieu.fr with ID 5EFD259F.002 by Joe's
 j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 5EFD259F.002 from
 casper.infradead.org/casper.infradead.org/90.155.50.34/casper.infradead.org/<willy@infradead.org>
X-Scores-Stats: 5EFD259F.002 B=0.50000 L=0.33851 G=0.33851 Disagree Winner=PH
X-Label-Query: YES
X-j-chkmail-Score: MSGID : 5EFD259F.002 on shiva.jussieu.fr : j-chkmail score
 : XX : R=. U=. O=. B=0.339 -> S=0.339
X-j-chkmail-Status: Unsure
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 02 Jul 2020 02:09:37 +0200 (CEST)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 02 Jul 2020 02:09:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Jonathan Corbet <corbet@lwn.net>, Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Markus Elfring <Markus.Elfring@web.de>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [v2] Documentation: Coccinelle: fix typos and command
	example
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

On Wed, Jul 01, 2020 at 07:52:58AM -0700, Randy Dunlap wrote:
> On 7/1/20 6:32 AM, Markus Elfring wrote:
> >>> How do you think about to use the following command variant
> >>> for the adjustment of the software documentation?
> >>>
> >>> +    make C=1 CHECK='scripts/coccicheck' 'path/to/file.o'
> >>
> >> I don't understand the reason for that change...
> 
> IOW, your "patch" needs justification and/or explanation. It was missing that info.

What Markus is trying so completely ineptly to say is that
  make C=1 CHECK=scripts/coccicheck path/to/file.c
doesn't work.  You need to use the .o suffix to check the .c file.

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
