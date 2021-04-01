Return-Path: <SRS0=lxNs=I6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4205C433ED
	for <cocci@archiver.kernel.org>; Thu,  1 Apr 2021 08:13:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1895060FEA
	for <cocci@archiver.kernel.org>; Thu,  1 Apr 2021 08:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1895060FEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1318DJxG006865;
	Thu, 1 Apr 2021 10:13:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D2CE877D5;
	Thu,  1 Apr 2021 10:13:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E2D2C74DE
 for <cocci@systeme.lip6.fr>; Thu,  1 Apr 2021 10:13:17 +0200 (CEST)
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1318DFnr010553
 for <cocci@systeme.lip6.fr>; Thu, 1 Apr 2021 10:13:16 +0200 (CEST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ssl.serverraum.org (Postfix) with ESMTPSA id DF5A42224D;
 Thu,  1 Apr 2021 10:13:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2016061301; t=1617264795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hy8XEj29+OsMPDW0hZlNUAbsCmaOPI/QgTJbwRc4Sz4=;
 b=Bky67C3/TRvYihJQwImrGG+cXW7U1u4sMX6Wuxe8QHY99Qy0VOT1ebKqDaJ6qpMAyJU41A
 cPwtXqDvm7QDt8oDfswkoPDgn6BNbneqFUAS/saFktuzWsisRo1x9KG/Njt6ZeOrLUYTuX
 v13GVsaTJFqXaFQGRFUV9W2e/W8aLCE=
MIME-Version: 1.0
Date: Thu, 01 Apr 2021 10:13:14 +0200
From: Michael Walle <michael@walle.cc>
To: cocci@systeme.lip6.fr
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <acfc6d2f0a7ea90f451de6d1185a0383@walle.cc>
X-Sender: michael@walle.cc
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 01 Apr 2021 10:13:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 01 Apr 2021 10:13:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] changing of_get_mac_address() to pass a buffer
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

Hi,

so first I need to say I've never used coccinelle before,
so please bear with me ;)

To make of_get_mac_address() work with DSA ports (and a nvmem
provider) I'd need to change the semantics of of_get_mac_address().
Right now it returns a pointer to "const char *", I'd need to change
that so a buffer will be passed as a parameter in which the MAC
address gets stored.

(1) Usually the call is something like:

   const char *mac;
   mac = of_get_mac_address(np);
   if (!IS_ERR(mac))
     ether_addr_copy(ndev->dev_addr, mac);

This would need to be changed to:

   of_get_mac_address(np, ndev->dev_addr);

(2) Unfortunately, there are also other variants of this like. Eg.

   const char *mac;
   mac = of_get_mac_address(np);
   if (IS_ERR(mac))
     eth_hw_addr_random(ndev);
   else
     ether_addr_copy(ndev->dev_addr, mac);

This would need to be changed to:

   ret = of_get_mac_address(np, ndev->dev_addr);
   if (ret)
     eth_hw_addr_random(ndev);

(3) Of course there are more variants like "if .. else if .. else"
     and so on.

This is what I've come up for now:

<spml>
virtual patch

@depends on patch@
type T;
identifier mac;
expression node, dev_addr;
statement S;
statement list SL;
@@

- T mac;
<+...
- mac = of_get_mac_address(node);
(
+ of_get_mac_address(node, dev_addr);
- if (!IS_ERR(mac))
-   ether_addr_copy(dev_addr, mac);
|
+ ret_tbd = of_get_mac_address(node, dev_addr);
+ if (!ret_tdb) {
- if (!IS_ERR(mac)) {
     ... when != mac
-   ether_addr_copy(dev_addr, mac);
     ... when != mac
   }
|
+ ret_tbd = of_get_mac_address(node, dev_addr);
+ if (!ret_tdb) {
- if (!IS_ERR(mac)) {
     ... when != mac
-   ether_addr_copy(dev_addr, mac);
     ... when != mac
   } else {
     ... when != mac
   }
|
- if (IS_ERR(mac))
-   S
- else
-   ether_addr_copy(dev_addr, mac);
+ ret_tbd = of_get_mac_address(node, dev_addr);
+ if (ret_tbd) S
|
- if (IS_ERR(mac)) {
-   SL
- } else {
-   ether_addr_copy(dev_addr, mac);
- }
+ ret_tbd = of_get_mac_address(node, dev_addr);
+ if (ret_tbd) { SL }
)
...+>

@depends on patch@
type T;
identifier mac;
expression node, dev_addr;
statement S;
@@

- T mac = of_get_mac_address(node);
+ of_get_mac_address(node, dev_addr);
- if (!IS_ERR(mac))
-   ether_addr_copy(dev_addr, mac);
   ... when != mac
</spml>

Maybe someone could have a brief look at it. Maybe (well I'm sure)
there is something to improve here. There is some repeated code
here, esp. for the different "if" and  "if else" branches. Is there
a better way to tell coccinelle, that the else might be optional?
And I guess, I need to go over the (maybe) new ret_tbd manually.

Of course, this won't match all occurrences, I'll go over the
remaining ones manually.

Thanks,
-michael
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
