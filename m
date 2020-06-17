Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B090DC433DF
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 21:12:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5263E21841
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 21:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5263E21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05HLCemD027579;
	Wed, 17 Jun 2020 23:12:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 385567577;
	Wed, 17 Jun 2020 23:12:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 482A63D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 23:12:39 +0200 (CEST)
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:191:4433:0:0:0:2])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05HLCcin027921
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 23:12:38 +0200 (CEST)
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.93) (envelope-from <johannes@sipsolutions.net>)
 id 1jlf4x-007Jp4-KM
 for cocci@systeme.lip6.fr; Wed, 17 Jun 2020 22:54:39 +0200
Message-ID: <812b3a31097815244e0f929552819ac1f119f5a0.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: cocci@systeme.lip6.fr
Date: Wed, 17 Jun 2020 22:54:31 +0200
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 23:12:40 +0200 (CEST)
X-Greylist: Delayed for 00:17:58 by milter-greylist-4.4.3 (isis.lip6.fr
 [IPv6:2001:660:3302:283c:0:0:0:2]); Wed, 17 Jun 2020 23:12:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] moving variable declarations up
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

Hi spatchers,

I've been working on an old code base, and toying with something like
this:

@@
type T;
identifier x;
expression E, F;
@@
{
+T x;
+
 E;
...
-T x;
...
}

(and also a variant with "T x = F;" where F is an expression).


That works OK if there's only a single variable, but...

First, it only moves a single variable up, even if I run it multiple
times (I think)?

Secondly, sometimes it says something like:

previous modification:

  <<< T x;
      
CONTEXT
According to environment 2:
   rule starting on line 15.x -> id var1
   rule starting on line 15.T -> u32

current modification:

  <<< T x;
      
CONTEXT
According to environment 2:
   rule starting on line 15.x -> id var2
   rule starting on line 15.T -> u32

EXN:Failure("rule starting on line 15: already tagged token:\nC code context\nFile \"/tmp/cocci_small_output-170001-6edb7c.c\", line 150, column 4,  charpos = 8969\n    around = 'DEBUG_PRINT', whole content =     DEBUG_PRINT(...omitted...);")


That's basically what I saw, something like

DEBUG_PRINT(...);
u32 var1 = ...;
u32 var2 = ...;


Any ideas how I can make it move more variable declarations up?

Thanks,
johannes

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
