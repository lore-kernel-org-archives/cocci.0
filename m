Return-Path: <SRS0=yhX/=IB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5001C433E0
	for <cocci@archiver.kernel.org>; Wed,  3 Mar 2021 15:08:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D99C64EE9
	for <cocci@archiver.kernel.org>; Wed,  3 Mar 2021 15:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D99C64EE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 123F85ET026477;
	Wed, 3 Mar 2021 16:08:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2493177CC;
	Wed,  3 Mar 2021 16:08:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6102F571B
 for <cocci@systeme.lip6.fr>; Wed,  3 Mar 2021 16:08:03 +0100 (CET)
Received: from smtprelay.hostedemail.com (smtprelay0227.hostedemail.com
 [216.40.44.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 123F812u002841
 for <cocci@systeme.lip6.fr>; Wed, 3 Mar 2021 16:08:02 +0100 (CET)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 942DA180943D7
 for <cocci@systeme.lip6.fr>; Wed,  3 Mar 2021 14:51:07 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id 486F81800CDE0;
 Wed,  3 Mar 2021 14:51:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crib64_1f0b27a276c6
X-Filterd-Recvd-Size: 2443
Received: from [192.168.1.159] (unknown [47.151.137.21])
 (Authenticated sender: joe@perches.com)
 by omf03.hostedemail.com (Postfix) with ESMTPA;
 Wed,  3 Mar 2021 14:51:04 +0000 (UTC)
Message-ID: <a186c9d063663ac6de66db944d1925146393bec5.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        kernelnewbies
 <kernelnewbies@kernelnewbies.org>,
        kernel-janitors
 <kernel-janitors@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>
Date: Wed, 03 Mar 2021 06:51:02 -0800
In-Reply-To: <a15e5c4d-a60f-14b9-90e5-4e600771aa9d@prevas.dk>
References: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>
 <a15e5c4d-a60f-14b9-90e5-4e600771aa9d@prevas.dk>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 03 Mar 2021 16:08:06 +0100 (CET)
X-Greylist: Delayed for 11:42:04 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Wed, 03 Mar 2021 16:08:02 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci] linux-kernel janitorial RFP: Mark static arrays as const
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Wed, 2021-03-03 at 10:41 +0100, Rasmus Villemoes wrote:
> On 02/03/2021 18.42, Joe Perches wrote:
> > Here is a possible opportunity to reduce data usage in the kernel.
> > =

> > $ git grep -P -n '^static\s+(?!const|struct)(?:\w+\s+){1,3}\w+\s*\[\s*\=
]' drivers/ | \
> > =A0=A0grep -v __initdata | \
> > =A0=A0wc -l
> > 3250
> > =

> > Meaning there are ~3000 declarations of arrays with what appears to be
> > file static const content that are not marked const.
> > =

> > So there are many static arrays that could be marked const to move the
> > compiled object code from data to text minimizing the total amount of
> > exposed r/w data.
> =

> You can add const if you like, but it will rarely change the generated
> code. gcc is already smart enough to take a static array whose contents
> are provably never modified within the TU and put it in .rodata:

At least some or perhaps even most of the time, true, but the gcc compiler
from v5 through at least v10 seems inconsistent about when it does the
appropriate conversion.

See the example I posted:
https://lore.kernel.org/lkml/6b8b250a06a98ce42120a14824531a8641f5e8aa.camel=
@perches.com/

It was a randomly chosen source file conversion btw, I had no prior
knowledge of whether the text/data use would change.

I'm unsure about clang consistently moving static but provably const arrays
from data to text.  I rarely use clang.  At least for v11 it seems to be
better though.  I didn't try 10.1.


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
