Return-Path: <SRS0=Ea+1=RY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A579C43381
	for <cocci@archiver.kernel.org>; Thu, 21 Mar 2019 13:38:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671F020693
	for <cocci@archiver.kernel.org>; Thu, 21 Mar 2019 13:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671F020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2LDbrwD016914
          ; Thu, 21 Mar 2019 14:37:53 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6BA9C7724;
	Thu, 21 Mar 2019 14:37:53 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 28250771B
 for <cocci@systeme.lip6.fr>; Thu, 21 Mar 2019 14:37:51 +0100 (CET)
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:191:4433:0:0:0:2] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2LDboDr023576
 for <cocci@systeme.lip6.fr>; Thu, 21 Mar 2019 14:37:50 +0100 (CET)
X-pt: isis.lip6.fr
Received: by sipsolutions.net with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92-RC5)
 (envelope-from <johannes@sipsolutions.net>) id 1h6xXC-00084U-Ca
 for cocci@systeme.lip6.fr; Thu, 21 Mar 2019 14:15:02 +0100
Message-ID: <fa68a6e4e3047058d9f0dfc572cf5fbbe7f07367.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: cocci@systeme.lip6.fr
Date: Thu, 21 Mar 2019 14:15:01 +0100
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 21 Mar 2019 14:37:54 +0100 (CET)
X-Greylist: Delayed for 00:22:47 by milter-greylist-4.4.3 (isis.lip6.fr
 [IPv6:2001:660:3302:283c:0:0:0:2]); Thu, 21 Mar 2019 14:37:50 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] modifying C99 initializers?
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

Hi all,

I'm trying to do something like this:

@@
identifier list;
@@
struct my_struct list[] = {
<...
 {
+       .field = 27,
 },
...>
};


where "field" is a new struct member and I want it initialized
everywhere.

The above doesn't parse, but is there another way of doing it?

The expected output would be

struct my_struct xyz[] = {
	{
+		.field = 27,
		.other_field = 7,
	},
	{
+		.field = 27,
		.third_field = 8,
	},
};

Thanks,

johannes

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
