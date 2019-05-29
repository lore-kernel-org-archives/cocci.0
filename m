Return-Path: <SRS0=gowI=T5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BBDC28CC0
	for <cocci@archiver.kernel.org>; Wed, 29 May 2019 14:54:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8439323B07
	for <cocci@archiver.kernel.org>; Wed, 29 May 2019 14:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W99v/x62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8439323B07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4TEsefW002687;
	Wed, 29 May 2019 16:54:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 54E067762;
	Wed, 29 May 2019 16:54:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E26A87756
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 16:54:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4TEscAH001826
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 16:54:38 +0200 (CEST)
Received: from [192.168.1.20] (cpe-24-28-70-126.austin.res.rr.com
 [24.28.70.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C970E23B07;
 Wed, 29 May 2019 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1559141677;
 bh=PhCLeAVFH0i6Wp+fBeYCm4ezNCMBcUJS0XuMwOPmKVs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=W99v/x6200DodwhTEdsagbSHWYUnRWOblzLevfASvcPfGWN2NSQXkJs5+DcuxaJwm
 TgLD0NlfjDNp6G3LFynJKLZuxIuEWIKHzyusBkNWdBFp4D8G4lEtD4Ba7/1tDFmC2a
 PSWwtbNLRjB0Szq7cyZGQvZ+H1X14mq0L60WVg1A=
To: Markus Elfring <Markus.Elfring@web.de>
References: <CAOZdJXVuNYEkFOiUWYq0GbqRUfuTNV35FGt7EViSSq6AqAY2-A@mail.gmail.com>
 <88a6a825-9691-33bf-150c-4b5b096475d9@web.de>
From: Timur Tabi <timur@kernel.org>
Message-ID: <f0bf87c4-7ac9-e599-4243-5b5b0fee6ad1@kernel.org>
Date: Wed, 29 May 2019 09:54:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <88a6a825-9691-33bf-150c-4b5b096475d9@web.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 16:54:40 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 16:54:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Controlling where braces are located?
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

T24gNS8yOS8xOSA3OjI4IEFNLCBNYXJrdXMgRWxmcmluZyB3cm90ZToKPiAqIERvIHlvdSBleHBl
Y3QgdGhhdCB0aGUgQ29jY2luZWxsZSBzb2Z0d2FyZSBzaG91bGQgcGljayBhIGNvZGluZyBzdHls
ZSB1cAo+ICAgIGZyb20gdGhlIG1lbnRpb25lZCBzb3VyY2UgZmlsZXMgYXV0b21hdGljYWxseT8K
CkF1dG9tYXRpY2FsbHk/ICBOby4gIEJ1dCBpdCB3b3VsZCBiZSBuaWNlIGlmIEkgY291bGQgY29u
dHJvbCBzb21lIApjb21tb25seS11c2VkIG9wdGlvbnMsIGxpa2Ugd2hlcmUgYnJhY2VzIGdvLCB2
aWEgYSBjb21tYW5kLWxpbmUgCnBhcmFtZXRlciBvciBhICNwcmFnbWEgaW4gdGhlIGNvY2NpIGZp
bGUgaXRzZWxmLgoKPiAqIEkgd291bGQgYXBwcmVjaWF0ZSBpZiBtb3JlIGRldmVsb3BlcnMgd2ls
bCBjb250cmlidXRlIHRvIGEgZmVhdHVyZSByZXF1ZXN0Cj4gICAgbGlrZSDigJxNYWtlIGNoYW5n
ZSBpbmZsdWVuY2UgY29uZmlndXJhYmxlIGZvciBjb2Rpbmcgc3R5bGUgcnVsZXPigJ0uCj4gICAg
aHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS9pc3N1ZXMvMzcKCkkgZG9u
J3QgaGF2ZSBhbnl0aGluZyB0byBjb250cmlidXRlIG90aGVyIHRoYW4gIkkgbmVlZCB0aGlzIGZl
YXR1cmUiLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpD
b2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5s
aXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
