Return-Path: <SRS0=XveF=OV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1547BC67839
	for <cocci@archiver.kernel.org>; Wed, 12 Dec 2018 22:52:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A5420851
	for <cocci@archiver.kernel.org>; Wed, 12 Dec 2018 22:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A5420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBCMqGqR029666
          ; Wed, 12 Dec 2018 23:52:16 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5967176AB;
	Wed, 12 Dec 2018 23:52:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3F7E860D7
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 23:52:13 +0100 (CET)
Received: from mail.sysmocom.de (mail.sysmocom.de
 [IPv6:2a01:4f8:191:444c:0:0:2:4] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBCMqCG1005037
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 23:52:12 +0100 (CET)
X-pt: isis.lip6.fr
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
 by mail.sysmocom.de (Postfix) with ESMTP id 575D047C965
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 22:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
 by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
 with ESMTP id BvxY4mZlmlVP; Wed, 12 Dec 2018 22:52:11 +0000 (UTC)
Received: from [10.2.1.203] (port-92-195-24-223.dynamic.qsc.de [92.195.24.223])
 by mail.sysmocom.de (Postfix) with ESMTPSA id B045847C94D
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 22:52:11 +0000 (UTC)
To: cocci@systeme.lip6.fr
From: Max <msuraev@sysmocom.de>
Message-ID: <0c0bf80c-56bd-6560-12b8-97a4b1b89963@sysmocom.de>
Date: Wed, 12 Dec 2018 19:39:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 12 Dec 2018 23:52:16 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 12 Dec 2018 23:52:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] struct replacement
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hi.

I have been trying to use spatch to update c struct but haven't found a 
way to do so yet.

For example, we have

struct old_thing {

uint8_t a;

uint16_t b[5];

};

which I'd like to replace with

struct new_thing {

uint8_t x1;

uint32_t x2;

uint8_t x3[11];

};

So pretty much replace every function parameter:

f1(... struct old_thing *t...) => f1(... struct new_thing *t...)

Replace the field access and variable definitions:

...

struct old_thing t1; => struct new_thing t1;

struct old_thing *t2; => struct new_thing *t2;

...

t1.a => t1.x1

t2->b => t2->x3

...

The thing which escapes me is how to make coccinelle treat it like a type?

Do I need to use @@typedef struct old_thing@@? Do I use it as 
@@identifier old_stuff@@ or @@identifier struct old_stuff@@?

Doesn't seem to work for me.

Any links to .spatch examples playing around with structs would be 
greatly appreciated.

-- 
- Max Suraev <msuraev@sysmocom.de>       http://www.sysmocom.de/
=======================================================================
* sysmocom - systems for mobile communications GmbH
* Alt-Moabit 93
* 10559 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Directors: Harald Welte

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
