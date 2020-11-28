Return-Path: <SRS0=SYYD=FC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93A9C64E7A
	for <cocci@archiver.kernel.org>; Sat, 28 Nov 2020 05:42:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 004E222210
	for <cocci@archiver.kernel.org>; Sat, 28 Nov 2020 05:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004E222210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AS5fp6k012077;
	Sat, 28 Nov 2020 06:41:53 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A1DA05C34;
	Sat, 28 Nov 2020 06:41:51 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BFEC9454B
 for <cocci@systeme.lip6.fr>; Sat, 28 Nov 2020 06:41:49 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AS5fmwF010180
 for <cocci@systeme.lip6.fr>; Sat, 28 Nov 2020 06:41:49 +0100 (CET)
IronPort-SDR: D3yD1KkJUIf1d+jcEX8iLQuHlB5JKsbJZBJ5XA2kAUUoFOW6NO3B1iNUERQ3Q80Sm+ejVs7bFb
 3zaQ36Krs/ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9818"; a="257165206"
X-IronPort-AV: E=Sophos;i="5.78,376,1599548400"; 
 d="scan'208,217";a="257165206"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2020 21:41:45 -0800
IronPort-SDR: AxSlvCZabhdOpJjVLtHO8Wzj8Ca2hdguSthA5di39sHEcpyIMoDODv2rB87EOJJc5G4iWrZ4wH
 5G7tepJKIJZQ==
X-IronPort-AV: E=Sophos;i="5.78,376,1599548400"; 
 d="scan'208,217";a="548262053"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2020 21:41:45 -0800
Date: Fri, 27 Nov 2020 21:41:45 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: cocci@systeme.lip6.fr
Message-ID: <20201128054145.GP1161629@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 28 Nov 2020 06:41:55 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 28 Nov 2020 06:41:49 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Itterating matches
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

I have been looking for a way to help automate my kmap/mem*/kunmap
transformation.[1]  I'm very new to coccinelle and I'm having some trouble.

I have tried to build up a script[2][3] to do this while also learning coccinelle
but I'm not getting a couple of points.

1) How do I get matches to iterate?
	1a) What is the difference between '<+... ...+>' and '<... ...>'?
2) Why can't I get the type declaration (type VP;) matched correctly.  It works
   some times but not always.  It also matches a lot of random declarations?
	2a) and for some reason in the more advanced script[3] it completely
	    breaks.  Which is very confusing because fundamentally it does not
            seem to be any different from [2]?

Any advice is appreciated.

Thanks,
Ira

[1] https://lore.kernel.org/lkml/20201124141244.GE17322@twin.jikos.cz/

[2]
<script>
  1 @ rule0 @
  2 type VP;
  3 identifier ptr;
  4 identifier page;
  5 @@
  6 
  7 -VP ptr;
  8 <...
  9 (
 10 -ptr = kmap(page);
 11 |
 12 -ptr = kmap_atomic(page);
 13 )
 14 <+...
 15 (
 16 -memset(...);
 17 +memIra();
 18 |
 19 -memcpy(...);
 20 +memIra();
 21 )
 22 ...+>
 23 (
 24 -kunmap(page);
 25 |
 26 -kunmap_atomic(ptr);
 27 )
 28 ...>
</script>

[3]
<script>
  1 @ rule0 @
  2 type VP;
  3 identifier page;
  4 identifier ptr;
  5 expression V;
  6 expression L;
  7 expression T;
  8 expression F;
  9 expression B;
 10 expression Off;
 11 @@
 12 
 13 -VP ptr;
 14 <...
 15 (
 16 -ptr = kmap(page);
 17 |
 18 -ptr = kmap_atomic(page);
 19 )
 20 <...
 21 (
 22 -memset(ptr, 0, L); 
 23 +zero_user(page, 0, L);
 24 |
 25 -memset(ptr + Off, 0, L);
 26 +zero_user(page, Off, L);
 27 |
 28 -memset(ptr, V, L);
 29 +memset_page(page, V, 0, L);
 30 |
 31 -memset(ptr + Off, V, L);
 32 +memset_page(page, V, Off, L);
 33 |
 34 -memcpy(ptr + Off, F, B);
 35 +memcpy_to_page(page, Off, F, B);
 36 |
 37 -memcpy(ptr, F, B);
 38 +memcpy_to_page(page, 0, F, B);
 39 |
 40 -memcpy(T, ptr + Off, B);
 41 +memcpy_from_page(T, page, Off, B);
 42 |
 43 -memcpy(T, ptr, B);
 44 +memcpy_from_page(T, page, 0, B);
 45 )
 46 ...>
 47 (
 48 -kunmap(page);
 49 |
 50 -kunmap_atomic(ptr);
 51 )
 52 ...>
</script>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
