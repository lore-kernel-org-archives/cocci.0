Return-Path: <SRS0=wRWv=RL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8A4C43381
	for <cocci@archiver.kernel.org>; Fri,  8 Mar 2019 19:12:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BEC20684
	for <cocci@archiver.kernel.org>; Fri,  8 Mar 2019 19:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BEC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x28JBxbN012530
          ; Fri, 8 Mar 2019 20:11:59 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2527F771D;
	Fri,  8 Mar 2019 20:11:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8A5D9770F
 for <cocci@systeme.lip6.fr>; Fri,  8 Mar 2019 20:11:57 +0100 (CET)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x28JBuRh029408
 for <cocci@systeme.lip6.fr>; Fri, 8 Mar 2019 20:11:56 +0100 (CET)
X-pt: isis.lip6.fr
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6ED5F7FD59;
 Fri,  8 Mar 2019 19:11:55 +0000 (UTC)
Received: from redhat.com (ovpn-124-248.rdu2.redhat.com [10.10.124.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12EAC1001E79;
 Fri,  8 Mar 2019 19:11:54 +0000 (UTC)
Date: Fri, 8 Mar 2019 14:11:53 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20190308191152.GD5618@redhat.com>
References: <20190308181954.GB5618@redhat.com>
 <alpine.DEB.2.21.1903081956350.2518@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903081956350.2518@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 08 Mar 2019 20:11:59 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 08 Mar 2019 20:11:56 +0100 (CET)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 08 Mar 2019 19:11:55 +0000 (UTC)
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Changing function pointer typedef
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

On Fri, Mar 08, 2019 at 07:57:08PM +0100, Julia Lawall wrote:
> 
> 
> On Fri, 8 Mar 2019, Jerome Glisse wrote:
> 
> > Coccinelle seems to have issue with function pointer. For instance
> > if i want to add a new argument to a function pointer typdef i need
> > to replace the whole typedef as one line. For instance:
> >
> > test.c:
> > typedef int (*filler_t)(void *, struct page *);
> >
> > test.spatch:
> > @@
> > type T1, T2;
> > @@
> > -typedef int (*filler_t)(T1, T2);
> > +typedef int (*filler_t)(T1, struct address_space *, T2);
> >
> > Anything else will not work and also if the function pointer typedef
> > spread accross multiple line then the above does not work, in fact
> > i have not found a work around for that case.
> >
> > I am missing some syntax that make this work with coccinelle ?
> 
> Thanks for the report.  Is the error you got something like:
> 
> error in collection of - tokens: line 4 less than line 6
> 
> I will have to look into it.

With:
@@
type T1, T2;
@@
typedef int (*filler_t)(T1,
+struct address_space *,
T2);

I get:
error in collection of - tokens: line 4 less than line 6

The error message depends on the semantic patch i tried several
variation hopping to find some syntax that would work but failed
so far.


In case of multiline typdef:
minus: parse error: 
  File "typedef-func.spatch", line 6, column 0, charpos = 101
  around = '',
  whole content = 

test.c:
typedef int (*filler_t)(void *,
    struct page *);

test.spatch
@@
type T1, T2;
@@
-typedef int (*filler_t)(T1,
+typedef int (*filler_t)(T1, struct address_space *,
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
