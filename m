Return-Path: <SRS0=6akS=O3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E9FC43387
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 15:49:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 465F721873
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 15:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465F721873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIFmxup026088
          ; Tue, 18 Dec 2018 16:48:59 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3F1DC740A;
	Tue, 18 Dec 2018 16:48:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B5A3D3A55
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 16:48:57 +0100 (CET)
Received: from mail.sysmocom.de (mail.sysmocom.de
 [IPv6:2a01:4f8:191:444c:0:0:2:4] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIFmuZM020290
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 16:48:56 +0100 (CET)
X-pt: isis.lip6.fr
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
 by mail.sysmocom.de (Postfix) with ESMTP id A26474B7988
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 15:48:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
 by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
 with ESMTP id rXi9SWAqkn5x; Tue, 18 Dec 2018 15:48:55 +0000 (UTC)
Received: from [10.9.1.140] (ds9.sysmocom.de [90.187.64.137])
 by mail.sysmocom.de (Postfix) with ESMTPSA id C55194B7964
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 15:48:55 +0000 (UTC)
To: cocci@systeme.lip6.fr
References: <a752b0e8-8ed0-1e86-eff7-3d91e87b11ae@sysmocom.de>
 <alpine.DEB.2.20.1812121322240.4125@hadrien>
 <b9f9b797-8f26-8034-7958-6182f5813e26@sysmocom.de>
 <alpine.DEB.2.21.1812130723160.2458@hadrien>
 <768d794a-e7a6-b011-f9af-5bb5a38b3c4a@sysmocom.de>
 <alpine.DEB.2.21.1812132056230.2465@hadrien>
 <e59c00ae-6b97-f8b4-6dca-dc23ffb7d414@sysmocom.de>
 <21bb981f-083a-8501-5db3-4a544f5c9646@sysmocom.de>
 <alpine.DEB.2.20.1812181629290.2886@hadrien>
From: Max <msuraev@sysmocom.de>
Message-ID: <2b642105-f754-51a0-2e8b-c9f7d439d0d5@sysmocom.de>
Date: Tue, 18 Dec 2018 16:48:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1812181629290.2886@hadrien>
Content-Type: multipart/mixed; boundary="------------63FC3239C7D214E8D3D3F151"
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 16:48:59 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 18 Dec 2018 16:48:56 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: Re: [Cocci] replacing defines
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This is a multi-part message in MIME format.
--------------63FC3239C7D214E8D3D3F151
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Attached are spatch and minimal example to reproduce the error.

I believe that the reason is the last '}' of multiline #define. This 
seems like a valid syntax to gcc but spatch gives aforementioned error.

Just in case ML won't accept attachements, here's how #define looks like:

________________

#define OLD(msg, data, len)                         \
     if (msgb_func(msg) != len) {                    \
         printf("%s:%d ERROR! with %d\n",     \
             __func__, __LINE__, (int) len);     \
         abort();                        \
     }
________________


18.12.18 16:34, Julia Lawall пишет:
>
> It's complaining about the rule starting on line 2, which is the one
> removing the #define.  So the problem doesn't have anything to do with the
> two rules being together - it never starts executing the second one.
>
> Something being reachable by inconsistent control-flow paths occurs when
> if you trace through the function in one way (ie via one if branch) you
> get one transformation, and if you trace through it in another way you get
> another transformation (or no transformation).
>
> It's a bit strange that this would occur in your case, where you just want
> to remove the entire body of the #define.  Can you mak a simple example
> that illustrates the problem?
>
> To figure out what #define is being considered, you can try the
> command-line argument --show-trying.  If that doesn't suffice (I don't
> know to what extent it is supported for #define), then --verbose-match
> might be helpful as well.
>
> julia

-- 
- Max Suraev <msuraev@sysmocom.de>       http://www.sysmocom.de/
=======================================================================
* sysmocom - systems for mobile communications GmbH
* Alt-Moabit 93
* 10559 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Directors: Harald Welte


--------------63FC3239C7D214E8D3D3F151
Content-Type: text/x-csrc;
 name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="test.c"

/*
 * (C)omment
 * All Rights Reserved
 */

#include <errno.h>

#define OLD(msg, data, len) 						\
	if (msgb_func(msg) != len) {					\
		printf("%s:%d ERROR! with %d\n", 	\
			__func__, __LINE__, (int) len); 	\
		abort();						\
	}

static void test_error()
{
	static const uint8_t res[] = { 0x00, 0x01, 0x21 };
	struct msgb *msg;

	printf("Testing for error\n");
	msg = test_complete();
	OLD(msg, res, ARRAY_SIZE(res));
	msgb_free(msg);
}

--------------63FC3239C7D214E8D3D3F151
Content-Type: text/plain; charset=UTF-8;
 name="my.spatch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="my.spatch"

Ly8gc3BhdGNoIC0taW4tcGxhY2UgLS1zcC1maWxlIG15LnNwYXRjaCB0ZXN0LmMKQEAKQEAK
LSAjZGVmaW5lIE9MRChtc2csIGRhdGEsIGxlbikgLi4uCgpAQApleHByZXNzaW9uIGEsIGIs
IGM7CkBACi0gT0xEKGEsIGIsIGMpOworIGlmICghbXlfZnVuYyhhLCBiLCBjKSkKKyAgYWJv
cnQoKTsK
--------------63FC3239C7D214E8D3D3F151
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--------------63FC3239C7D214E8D3D3F151--
