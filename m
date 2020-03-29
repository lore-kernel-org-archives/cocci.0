Return-Path: <SRS0=tDau=5O=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41544C43331
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2020 08:49:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE67420714
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2020 08:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="v7YSwanw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE67420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02T8mrmC004417;
	Sun, 29 Mar 2020 10:48:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E57717750;
	Sun, 29 Mar 2020 10:48:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B4D7E66CB
 for <cocci@systeme.lip6.fr>; Sun, 29 Mar 2020 10:48:50 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:32c])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02T8mn6Y003321
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 29 Mar 2020 10:48:49 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id d198so16400210wmd.0
 for <cocci@systeme.lip6.fr>; Sun, 29 Mar 2020 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xGgtSWQqgeLOCyPrlE+3AYUU6yOah3C55p1XMSuBUD8=;
 b=v7YSwanwdbIkYhcw4notbTfcgd4+LgAuAhCQ9xU3Kbbi/Rz7ltONErcgb3e3IcleT1
 TltKCzk/sXL8JVxFl45rce8qqVwnpv90lBgsWqQSC/sy55AJu2IWAK+TWzAHsKLEoiSk
 HeX39p/FtNM5E02FKr8eKMQPvH7VNug2IrZkh4tRfNf8VOwg/Q3jceFXZJJZuxh3ffEf
 GbZHiwkFqX4e0lb/bUbvzJaG95QbkxaGCEUAKz9uzyGjyHPHvh6D2DkgySlflzeDdlRM
 ezho9JNXAqTgsrT0wHB8Mp0qtLNV+rxWVCVgqujCJwl0yO/jl89mkK7aJtMcqtbpiBZX
 yizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xGgtSWQqgeLOCyPrlE+3AYUU6yOah3C55p1XMSuBUD8=;
 b=ATXwAfC6EjjwTz1zSdzs8vgN60bplLp2SftVx9Ir8OaQJ0aYXclP5PdHBbTu2wFHGz
 StIHSm2NzxyiZ0tYJB4TJC2F2A8bXrDC2x/o+LzijUyo4jIa07+trZ16+n+ipu6gozV8
 mTpqm3mUdZHtYVLwbnOD1ZsrX0h1QaBo0cduQw3uz38s4TRO/Z89zVIrGafgNnLjna2b
 f5/KoQ0SIPbsI1qJSI7x4naJcjPgwVDONzp6XHTO2Qc/M9I5s+JlNZTavupM3jS04nE5
 1XrHgBIdNH0Q/DNGq5qQcmBK4dF54iPnWLkbB6dx5OKYXL1XZXAhspTVFYfk4pqi27UB
 Ua5g==
X-Gm-Message-State: ANhLgQ08GRm1qNFTKi0LSNylSYE8Ut3b+eZiTYgjCdaUpN0JrNObq4yh
 dK/69kAtarzYt5cC2OsdcdmsqPLO2Js=
X-Google-Smtp-Source: ADFU+vsjg8mVIDLif/eYTrKzDdhKdnrhr1zQyeb3mh06Ggca4xE69Hd2EPhbG15X7OOOBdH8rWG/HA==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr7050894wmj.132.1585471729094; 
 Sun, 29 Mar 2020 01:48:49 -0700 (PDT)
Received: from localhost.localdomain ([94.136.13.132])
 by smtp.gmail.com with ESMTPSA id q72sm16747318wme.31.2020.03.29.01.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Mar 2020 01:48:48 -0700 (PDT)
To: Julia Lawall <julia.lawall@inria.fr>
References: <b86347f3-69d3-0801-c91f-87c3424e71dc@linbit.com>
 <alpine.DEB.2.21.2003271645370.2709@hadrien>
 <1f1a7b29-b767-551c-e2ec-d5cdf5ceecd0@linbit.com>
 <alpine.DEB.2.21.2003271714150.2709@hadrien>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <2a36722e-c5ff-aa94-fac1-d885b89176d0@linbit.com>
Date: Sun, 29 Mar 2020 10:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003271714150.2709@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 29 Mar 2020 10:48:53 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 29 Mar 2020 10:48:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Matching against a declarer macro
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

QW0gMjcuMDMuMjAgdW0gMTc6MTUgc2NocmllYiBKdWxpYSBMYXdhbGw6Cj4gCj4gCj4gT24gRnJp
LCAyNyBNYXIgMjAyMCwgQ2hyaXN0b3BoIELDtmhtd2FsZGVyIHdyb3RlOgo+IAo+PiBBbSAyNy4w
My4yMCB1bSAxNjo0NyBzY2hyaWViIEp1bGlhIExhd2FsbDo+IEFyZSB5b3Ugc3VyZSB0aGF0IHRo
ZSBDIGNvZGUgaXMKPj4gcGFyc2VkIHN1Y2Nlc3NmdWxseT8gIEknbSBub3QgYXQgYWxsIHN1cmUK
Pj4+IHRoYXQgc3RhdGljIGlzIGFsbG93ZWQgaW4gYW4gYXJndW1lbnQgbGlzdC4gIFR5cGVzIGFy
ZSBhbGxvd2VkLCBidSBzdGF0aWMKPj4+IGlzIG9ubHkgcGFydCBvZiBhIHR5cGUuCj4+Cj4+IEkn
bSBwcmV0dHkgc3VyZSBpdCBpcyBwYXJzZWQgc3VjY2Vzc2Z1bGx5LiBBdCBsZWFzdCBzcGF0Y2gg
ZG9lc24ndCBjb21wbGFpbgo+PiBhYm91dCBpdCwgbm8gbWF0dGVyIGhvdyBtYW55IGRlYnVnIGZs
YWdzIEkgc3BlY2lmeS4KPiAKPiBEaWQgeW91IHRyeSBzcGF0Y2ggLS1wYXJzZS1jIGZpbGUuYz8K
Ckl0IHNlZW1zIGxpa2UgUkJfREVDTEFSRV9DQUxMQkFDS1NfTUFYIGlzIHJlY29nbml6ZWQgYXMg
YSAia25vd24gbWFjcm8iPyAKTG9va3MgbGlrZSBpdCBpcyBhYmxlIHRvIHBhcnNlIHRoaXMgYml0
IG9mIGNvZGUganVzdCBmaW5lOgoKJCBzcGF0Y2ggLS1wYXJzZS1jIGRyYmQvZHJiZF9pbnRlcnZh
bC5jIC0tZGVidWcKaW5pdF9kZWZzX2J1aWx0aW5zOiAvdXNyL2xvY2FsL2Jpbi8uLi9saWIvY29j
Y2luZWxsZS9zdGFuZGFyZC5oCgpQQVJTSU5HOiBkcmJkL2RyYmRfaW50ZXJ2YWwuYwpwYXJzZSBl
cnJvcgogID0gZXJyb3IgaW4gZHJiZC9kcmJkX2ludGVydmFsLmg7IHNldCB2ZXJib3NlX3BhcnNp
bmcgZm9yIG1vcmUgaW5mbwpiYWRjb3VudDogNQpiYWQ6ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgaW50KTsKYmFkOgpiYWQ6ICNkZWZpbmUgZHJiZF9mb3JfZWFj
aF9vdmVybGFwKGksIHJvb3QsIHNlY3Rvciwgc2l6ZSkgICAgICAgICAgICAgICBcCmJhZDogICAg
Zm9yIChpID0gZHJiZF9maW5kX292ZXJsYXAocm9vdCwgc2VjdG9yLCBzaXplKTsgICAgICAgICBc
CmJhZDogICAgICAgICBpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcCkJBRDohISEhISAgICAgICAgICAgIGkgPSBkcmJkX25leHRfb3ZlcmxhcChpLCBz
ZWN0b3IsIHNpemUpKQooT05DRSkgQ1BQLU1BQ1JPOiBmb3VuZCBrbm93biBtYWNybyA9IFJCX0RF
Q0xBUkVfQ0FMTEJBQ0tTX01BWApwYXNzZWQ6c3RhdGljICwgYXVnbWVudF9jYWxsYmFja3MgLCBz
dHJ1Y3QgZHJiZF9pbnRlcnZhbCAsIHJiICwKcGFzc2VkOnNlY3Rvcl90ICwgZW5kICwgTk9ERV9F
TkQKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KbWF5YmUgMTAgbW9zdCBwcm9ibGVtYXRpYyB0b2tlbnMKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KTkIgdG90YWwgZmlsZXMgPSAxOyBwZXJmZWN0ID0gMTsg
cGJzID0gMDsgdGltZW91dCA9IDA7ID09PT09PT09PT4gMTAwJQpuYiBnb29kID0gMTYwLCAgbmIg
cGFzc2VkID0gMiA9PT09PT09PT0+IDEuMjMlIHBhc3NlZApuYiBnb29kID0gMTYwLCAgbmIgYmFk
ID0gMCA9PT09PT09PT0+IDEwMC4wMCUgZ29vZCBvciBwYXNzZWQKCj4gRG8geW91IHdhbnQgdG8g
YWN0dWFsbHkgbWF0Y2ggTk9ERV9FTkQ/ICBJZiBzbywgaXQgc2hvdWxkbid0IGJlIGRlY2xhcmVk
Cj4gYXMgYSBtZXRhdmFyaWFibGUuCgpSaWdodCwgSSBkbyB3YW50IHRvIGV4YWN0bHkgbWF0Y2gg
Tk9ERV9FTkQsIHNvIEkgcmVtb3ZlZCB0aGUgCmRlY2xhcmF0aW9uOyBzdGlsbCBubyBtYXRjaCB0
aG91Z2guIElmIGl0IGlzIGRldGVjdGVkIGFzIGEga25vd24gbWFjcm8gCml0IHNob3VsZCBiZSBh
YmxlIHRvIGJlIHN1YnN0aXR1dGVkLCByaWdodD8KCj4gCj4ganVsaWEKPgoKVGhhbmtzLAotLQpD
aHJpc3RvcGggQsO2aG13YWxkZXIKTElOQklUIHwgS2VlcGluZyB0aGUgRGlnaXRhbCBXb3JsZCBS
dW5uaW5nCkRSQkQgSEEg4oCUICBEaXNhc3RlciBSZWNvdmVyeSDigJQgU29mdHdhcmUgZGVmaW5l
ZCBTdG9yYWdlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1l
LmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
