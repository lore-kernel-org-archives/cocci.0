Return-Path: <SRS0=wRWv=RL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B35C43381
	for <cocci@archiver.kernel.org>; Fri,  8 Mar 2019 18:20:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B0420661
	for <cocci@archiver.kernel.org>; Fri,  8 Mar 2019 18:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B0420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x28IK2pf005085
          ; Fri, 8 Mar 2019 19:20:02 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E759F771D;
	Fri,  8 Mar 2019 19:20:01 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DFD56770F
 for <cocci@systeme.lip6.fr>; Fri,  8 Mar 2019 19:20:00 +0100 (CET)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x28IJvsq007008
 for <cocci@systeme.lip6.fr>; Fri, 8 Mar 2019 19:19:57 +0100 (CET)
X-pt: isis.lip6.fr
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3531E307D849
 for <cocci@systeme.lip6.fr>; Fri,  8 Mar 2019 18:19:57 +0000 (UTC)
Received: from redhat.com (ovpn-124-248.rdu2.redhat.com [10.10.124.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB21E2A2CB
 for <cocci@systeme.lip6.fr>; Fri,  8 Mar 2019 18:19:56 +0000 (UTC)
Date: Fri, 8 Mar 2019 13:19:55 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: cocci@systeme.lip6.fr
Message-ID: <20190308181954.GB5618@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 08 Mar 2019 19:20:03 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 08 Mar 2019 19:19:58 +0100 (CET)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 08 Mar 2019 18:19:57 +0000 (UTC)
Subject: [Cocci] Changing function pointer typedef
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

Coccinelle seems to have issue with function pointer. For instance
if i want to add a new argument to a function pointer typdef i need
to replace the whole typedef as one line. For instance:

test.c:
typedef int (*filler_t)(void *, struct page *);

test.spatch:
@@
type T1, T2;
@@
-typedef int (*filler_t)(T1, T2);
+typedef int (*filler_t)(T1, struct address_space *, T2);

Anything else will not work and also if the function pointer typedef
spread accross multiple line then the above does not work, in fact
i have not found a work around for that case.

I am missing some syntax that make this work with coccinelle ?

Cheers,
J=E9r=F4me
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
