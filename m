Return-Path: <SRS0=wRWv=RL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8C6C43381
	for <cocci@archiver.kernel.org>; Fri,  8 Mar 2019 18:15:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA25520661
	for <cocci@archiver.kernel.org>; Fri,  8 Mar 2019 18:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA25520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x28IFSLo025065
          ; Fri, 8 Mar 2019 19:15:28 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 295D8771D;
	Fri,  8 Mar 2019 19:15:28 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 46783770F
 for <cocci@systeme.lip6.fr>; Fri,  8 Mar 2019 19:15:25 +0100 (CET)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x28IFNSi019400
 for <cocci@systeme.lip6.fr>; Fri, 8 Mar 2019 19:15:23 +0100 (CET)
X-pt: isis.lip6.fr
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D9FF8C064279;
 Fri,  8 Mar 2019 18:15:21 +0000 (UTC)
Received: from redhat.com (ovpn-124-248.rdu2.redhat.com [10.10.124.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59CAF261B3;
 Fri,  8 Mar 2019 18:15:21 +0000 (UTC)
Date: Fri, 8 Mar 2019 13:15:19 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20190308181519.GA5618@redhat.com>
References: <20190228004342.GB11866@redhat.com>
 <alpine.DEB.2.21.1902280804520.2813@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902280804520.2813@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 08 Mar 2019 19:15:28 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 08 Mar 2019 19:15:23 +0100 (CET)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 08 Mar 2019 18:15:22 +0000 (UTC)
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Coccinelle is confuse by extern __printf macro (ie
 attribute)
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

On Thu, Feb 28, 2019 at 08:05:31AM +0100, Julia Lawall wrote:
> =

> =

> On Wed, 27 Feb 2019, Jerome Glisse wrote:
> =

> > Coccinelle get confuse with kernel extern __printf macro for instance:
> >
> > test.c:
> > extern __printf(3, 4)
> > int foo(int, int, char *, ...);
> > void toto(int, long);
> >
> > test.sp:
> > @@
> > @@
> > void toto(int,
> > +void *,
> > long);
> >
> > The semantic patch will not work. But if extern is remove or if __printf
> > macro is remove then it works. Also having extern and __printf on diffe=
rent
> > line make it works.
> =

> Maybe adding
> =

> #define __printf(a,b)
> =

> to standard.h will help?
> =


Sorry to get back so late, yes adding #define __printf(a,b) to standard.h
solve the issue. Thank you for the pointer.

Cheers,
J=E9r=F4me
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
