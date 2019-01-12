Return-Path: <SRS0=Afiw=PU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6796C43444
	for <cocci@archiver.kernel.org>; Sat, 12 Jan 2019 17:52:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B56C2086C
	for <cocci@archiver.kernel.org>; Sat, 12 Jan 2019 17:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B56C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0CHpxIV018951
          ; Sat, 12 Jan 2019 18:52:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DC49676E2;
	Sat, 12 Jan 2019 18:51:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C67FF76E1
 for <cocci@systeme.lip6.fr>; Sat, 12 Jan 2019 18:51:57 +0100 (CET)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0CHpgfY027694
 for <cocci@systeme.lip6.fr>; Sat, 12 Jan 2019 18:51:43 +0100 (CET)
X-pt: isis.lip6.fr
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4838058E55;
 Sat, 12 Jan 2019 17:51:42 +0000 (UTC)
Received: from redhat.com (ovpn-120-208.rdu2.redhat.com [10.10.120.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3E4D5D70A;
 Sat, 12 Jan 2019 17:51:41 +0000 (UTC)
Date: Sat, 12 Jan 2019 12:51:39 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20190112175139.GA3891@redhat.com>
References: <20190111222417.GE3190@redhat.com>
 <alpine.DEB.2.21.1901121744560.2837@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901121744560.2837@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 12 Jan 2019 18:52:01 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 12 Jan 2019 18:51:43 +0100 (CET)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Sat, 12 Jan 2019 17:51:42 +0000 (UTC)
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Adding a field to struct and new line issues
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

On Sat, Jan 12, 2019 at 05:45:47PM +0100, Julia Lawall wrote:
> =

> =

> On Fri, 11 Jan 2019, Jerome Glisse wrote:
> =

> > Hi,
> >
> > I am trying to add a field to struct however coccinelle insist on
> > adding it on the same line as struct name definition ie:
> =

> The problem should be fixed.  Please try the version from github.  Thanks
> for the report.
> =


Works for me with lastest github ! :)

Thank you so much for fixing this.

Cheers,
J=E9r=F4me
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
