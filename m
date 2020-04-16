Return-Path: <SRS0=lBEj=6A=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F67C2BB55
	for <cocci@archiver.kernel.org>; Thu, 16 Apr 2020 14:15:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CF6206B9
	for <cocci@archiver.kernel.org>; Thu, 16 Apr 2020 14:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="K1n0mHZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CF6206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03GEFNMk027470;
	Thu, 16 Apr 2020 16:15:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3F17F781F;
	Thu, 16 Apr 2020 16:15:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EE59D7816
 for <cocci@systeme.lip6.fr>; Thu, 16 Apr 2020 16:15:21 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03GEFLuE017006
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 16 Apr 2020 16:15:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587046519;
 bh=W2kj3bkkgCl1fXqL23dgWVcX4KesaLyXELCTzldr/Ok=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=K1n0mHZN1AeLk5cNqEK3WASwPJVSibAKZLqQr+l8C+mMWWetxPFGnI6SM9J5bnlIh
 j2m39z9Ad4N0FwizH2AUVHMU7M3Zng+4tvOyv9MO4/GHOp+7jOXhO6u5490d9LoEGM
 4Wp4Ydq03BQ8otqDIgOLyE47eaYjLwBgsCPT2POQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.109.113]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPHKO-1jKhZn1NNg-004VF7; Thu, 16
 Apr 2020 16:15:19 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <alpine.DEB.2.21.2004151949230.2381@hadrien>
 <5702b553-d054-33a4-8544-f68ed5457acc@web.de>
 <alpine.DEB.2.21.2004161052210.2447@hadrien>
 <0365dceb-3b66-48cd-c273-4bf7fceb4688@web.de>
 <alpine.DEB.2.21.2004161444300.8125@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <735a3c61-695b-a857-b0ce-8999b04644b1@web.de>
Date: Thu, 16 Apr 2020 16:15:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004161444300.8125@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:CUTkMijG+tz+uqPq4AHk1S3zXNvhttPgW/jo1eQdRZngbTZoCQU
 qUTE2N6Fqy+/QcW+d/YbSWETeSvEMU3/k1ZByaAMFdloMwSszZC9OuyVN54pWtbUE3KaafN
 mkHGsnRJfiPrLj5KOZzh8k2otbY6W6qzUrnBSecTDW2fAhSaQgPD/uk5NpZ0R5zyqIiA3nW
 i/7WlBgdGbhX6Wle85nwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E4/6hXw9If8=:EoDkCUvdOn1WEoHvuXcXZR
 8R93SzWQhj5MN90+chTgiX5phBZWA1z4y8V1h9YbmRysA56miDSyFgC8/YrAhR96NFwzvc5cE
 HmmRilUR1jEW7tEMbu6JIN1qFTp1X7bVa9nnL4H2DYld4C7vVejLk7tX2sySwkR1IAd4fgURK
 3IEe/f6zMfMEUF5QbQZ9k4es2pxljC/KLU+6YQYM+NhzFuMIRZBSBVlo0l8FOuPk/bTJjPKkp
 VfZQ0yLAbt9S4Y9L8BxhWrRWLxRXoq91gRDVngSICoSmaWN3ScfRXDSLI7drqPvFOihoPlc9m
 F+1HlqN39XIci+ufEKzPC6RPjHEgK/GDanigTKf1rFjpXG6qg73pUzi/1nSSoNF/VtKYf/mFm
 irkeCXpC5zhJnRNlA/1cxW/PYOCi+ebm5RoTXJ1NAAyn0SvHgPQqPemV6fJl7hypdsYNHkD9K
 0cuiP+6/BKX3Q2krEaoAu4NRPQgiF7iIRIvB7YrdiT17l6xI+aEzxr45lL1RTRHj1+Se9jodf
 HWCPRrIzuzQwk+fXJDThKSSnE6TTFj8xbaCMg/KYKeedmYUBUyMzae6ciOyHaQLVLj0O5Jehq
 yGN6NuJvNzYo475jCLVzZLzNAn3BJ9myJ4pzvMt3XcyvLSTXpMXKeSfY7U8BmZ+KB1MO4LKVb
 88scMsVuYz2ssmu4jmHU8AxkfRIRgB9XM2qrzeWDrBs4hS2XEOIpUxygGMHOAQ7afp8S44827
 t033SOeJvZtI84SnG4jTgf1S1uxhtVAfbOOmnJrUdIF4saiqiCRxeWf0jUlpTKAZkxuClJuaa
 CHGL5rMtJQeNVaPVdAtINUTl5dIh2LbcCYN6D14tyQ6rJhxkL9/YNx/Ma03kNXyL4BEA/84Mb
 ASvWhUMg4/N/uHZnAqESKRXuUoXh/S7pU/hoTSbxxJLLHTbqbPtuYET7ZCYO+oOUMbshoU6RO
 guWDSlmDcsiSgJQpqdoQLE6xjmgIUIeLL8nFDay0Fwcjz3y97NcZDs9II04NVs+NInXatmp0k
 9uWQaX4eOm/yiCOoQyowWQJmPJstJ755KVdTdRuTypbSuC1FtOWUFOCiS5keSxlA7DqtDDOkE
 6ZiaFVsaORAbZzNMcO9ZEitZN9tAdglWqqeDWOFW0qzbH5ImMJ7kjZs8Fc7qZqO9WsJKSES+z
 ER8EEMe/FttuJR1zVu1m6utqfPtfp9Wxl3fJL0KY0FL5G8Wov4Vo0t5t4n6nXtjIzkwkOnQ2j
 FrMV2SAnf89jMvAbL
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Apr 2020 16:15:23 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 16 Apr 2020 16:15:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Dejin Zheng <zhengdejin5@gmail.com>, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking the replacement of two specific function calls
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Pj4gV291bGQgSSBuZWVkIGFueSBleHRyYSBwYXJhbWV0ZXJzIGhlcmU/Cj4KPiBQZXJoYXBzIC1J
IG9wdGlvbnMgdG8gaGVscCBpdCBmaW5kIHRoZSByZWxldmFudCAuaCBmaWxlLgoKSSB3b25kZXIg
d2h5IHRoZSByZWxldmFudCBoZWFkZXIgZmlsZXMgd291bGQgbm90IGJlIGZvdW5kIGRpcmVjdGx5
CmZyb20gdGhlIGNvcnJlc3BvbmRpbmcgR2l0IHJlcG9zaXRvcnkuCgpDYW4gYSBmaWxlIGluY2x1
c2lvbiBmYWlsdXJlIGJlY29tZSBhbiBpbW1lZGlhdGUgU21QTCBzY3JpcHQgZXhlY3V0aW9uIGVy
cm9yCndoZW4gYSBzcGVjaWFsIHByb2dyYW0gcGFyYW1ldGVyIHdvdWxkIGJlIHBhc3NlZD8KCgpD
YW4gaXQgYmUgdGhhdCB0aGUgcG9pbnRlciB2YXJpYWJsZSDigJxwcml24oCdIHRvIHRoZSBkYXRh
IHN0cnVjdHVyZSDigJxyY2FyX2kyY19wcml24oCdCmRpc3RyYWN0cyBmcm9tIHRoZSBkZXNpcmVk
IHVuZGVyc3RhbmRpbmcgb2YgYSBxdWVzdGlvbmFibGUgc29mdHdhcmUgc2l0dWF0aW9uCndoZW4g
dGhlIHJlbGV2YW50IGRlY2xhcmF0aW9uIGlzIHByb3ZpZGVkIGluIHRoZSBzYW1lIHNvdXJjZSBm
aWxlPwpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS43LXJjMS9zb3VyY2UvZHJp
dmVycy9pMmMvYnVzc2VzL2kyYy1yY2FyLmMjTDExOQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2ky
Yy9idXNzZXMvaTJjLXJjYXIuYz9pZD04NjMyZTliNTY0NWJiYzIzMzFkMjFkODkyYjBkNjk2MWMx
YTA4NDI5I24xMTkKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2
LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
