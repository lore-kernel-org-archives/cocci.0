Return-Path: <SRS0=wRWv=RL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925D5C43381
	for <cocci@archiver.kernel.org>; Fri,  8 Mar 2019 19:32:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C6D20851
	for <cocci@archiver.kernel.org>; Fri,  8 Mar 2019 19:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C6D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x28JWKZo015900
          ; Fri, 8 Mar 2019 20:32:20 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 005F3771D;
	Fri,  8 Mar 2019 20:32:20 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F13FB770F
 for <cocci@systeme.lip6.fr>; Fri,  8 Mar 2019 20:32:18 +0100 (CET)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x28JWHY8010450
 for <cocci@systeme.lip6.fr>; Fri, 8 Mar 2019 20:32:17 +0100 (CET)
X-pt: isis.lip6.fr
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8261F81E18;
 Fri,  8 Mar 2019 19:32:16 +0000 (UTC)
Received: from redhat.com (ovpn-124-248.rdu2.redhat.com [10.10.124.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 264ED5C1A1;
 Fri,  8 Mar 2019 19:32:16 +0000 (UTC)
Date: Fri, 8 Mar 2019 14:32:14 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20190308193212.GE5618@redhat.com>
References: <20190308181954.GB5618@redhat.com>
 <alpine.DEB.2.21.1903081956350.2518@hadrien>
 <20190308191152.GD5618@redhat.com>
 <alpine.DEB.2.21.1903082022351.2518@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903082022351.2518@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 08 Mar 2019 20:32:20 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 08 Mar 2019 20:32:17 +0100 (CET)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 08 Mar 2019 19:32:16 +0000 (UTC)
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Fri, Mar 08, 2019 at 08:23:48PM +0100, Julia Lawall wrote:
> > test.spatch
> > @@
> > type T1, T2;
> > @@
> > -typedef int (*filler_t)(T1,
> > +typedef int (*filler_t)(T1, struct address_space *,
> =

> If this is the whole rule, it is clear that it will not work.  A semantic
> patch rule has to e a complete syntactic unit.  So something with an open
> parenthesis and no corresponding close parenthesis will not be accepted.

Yeah and adding "T2);" to the rule does not help either it error to
error in collection of - tokens: line 4 less than line 6

Any variation really do error in some way or another.

Cheers,
J=E9r=F4me
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
