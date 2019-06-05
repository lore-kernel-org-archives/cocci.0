Return-Path: <SRS0=mj88=UE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D64FC28CC5
	for <cocci@archiver.kernel.org>; Wed,  5 Jun 2019 19:51:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB2D2083E
	for <cocci@archiver.kernel.org>; Wed,  5 Jun 2019 19:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="nSyj+oEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB2D2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x55Jp5rm012880;
	Wed, 5 Jun 2019 21:51:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CC861776A;
	Wed,  5 Jun 2019 21:51:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 568FB7767
 for <cocci@systeme.lip6.fr>; Wed,  5 Jun 2019 21:51:04 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x55Jp2Cu014790
 for <cocci@systeme.lip6.fr>; Wed, 5 Jun 2019 21:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1559764261;
 bh=11aXCgTXs0ychx2OS2xXvut5EcoX7sc0AGdAEjL0r+U=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=nSyj+oEGtwVzvDfSY6gW2RO1jR0g+RHp37vXMwciDep27kGSmSL6j6CPSb/ZgWVSb
 GGTs5sPn+9XjmcISsN6VD6dwIUZ7jtxtUWoZCuFb3kxrlDfhykYuav4irpUHHSw+CI
 CiaJLKjvKnkFrzzAPzPggbiI9W0UR5i0L9sW2vLU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([2.244.21.66]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvS5r-1ga59a2VEJ-010cyP; Wed, 05
 Jun 2019 21:51:01 +0200
To: Enrico Weigelt <lkml@metux.net>
References: <5c138195-ac1a-4ad6-c6e6-720acd4ea34f@metux.net>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c8bf14e3-6c6c-f278-a898-c5aea3f42920@web.de>
Date: Wed, 5 Jun 2019 21:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5c138195-ac1a-4ad6-c6e6-720acd4ea34f@metux.net>
Content-Language: en-US
X-Provags-ID: V03:K1:w4zvGoxKE/LOTESawj6bKuIV5e1rYNcNt5hGMT8Axr+/x4XT2QU
 gCNLEfOqXZyLiefUDYfPE0HO+vCNm8g0HG5/iMnt68ABycQrLLvtYoqiX3JIWvDMJqt5hOm
 kMwr1kpi1ynCmICoFrRCjSrsy1lP/3zflYmlOPceH2gxuqJt9IpYHqpfzl3Tr0aQzd1pxQz
 FydDaxBOgnm5399dYbdaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kvjQYrU9Sao=:RzTTQVm6X/sfWOXoqvr/+o
 86C4OHx59uSsTu6EIa4gXOeUk5EhFKwgtxURVkllmxtxD02fDTU3WHO2dXFPnuqHlBetN1QWw
 FFu4sWtljYEM0w/nh1FD0EXKZpa0ilnDO1573Vu1gwKttcsX0AZslu8718zb/DSAu0Q0anlQI
 pr6fJBmJAFGoZ0uovCdfdAZutPpFU5aMNgWwuxZYYiWzn6AEdBeIRQh9F3y7o1tLpM0C9CNTn
 mDtgFBO/rb2fvv0rij0oQG1XptFhU9xXBwzAlvsd6LBpEI0bb0UR5O0tiEe7MHRS7dSt6crCC
 LFHI+MNR1vkhp4jM94nD0vn/ICpnWJAoUx0Q+Q1L9EMfYyqD9p/QB90lq7dV/Mzm2rfMFWJsp
 FccW1G5/IOX+6WbYJMIKXbIIGdMnyXr60edGJ3e9XoovQBPhXUUH898U648rnsmfYhOSW4VdE
 mZtP3hs+Knx/SuOatrjEe4N+xLAEDrXnI2ZAwgxyM2syH/eeFjurqw7kRuEGb78M8QZG8F8in
 bVJS2g7BemkAcxPwulk6i0RG6CbBbwSmem1CoNJN6+8WgvE3rj3oEGPmb2JDEx7rPE1G/T7CF
 QdzcOGptJyd9z5ODEmUGLRM7XRHYqgUX4VyVyxoMtrNUBTsl41rukWtl4RVcB61BHmtKlyu0E
 GnD6jsHaWJ/C82IucuxIzO/5RvHrlga8oiT7KZjHdooTnreV3S/7RY8jWms5tZgxWq+TlErdO
 LY2uyMcKx1U2D5wSUJtfDOaK5irvAlCQheBxOLA0h+BYC3EtUs4WVI9KjnDE/P7JmzvFull9Z
 0X5U0cymZxKyKd+rUxVSuYf69EYnicrJ6TWcX3UUMeAlSISWOD75c0b3Up25jMILXdQ/NiB3l
 Nxo5Ymu9DNRM0ODW/3DE4IgMpH0k+19M5CifZ2Af3gh3VyaaMi0LZiIA9VBwHI6awUa61anS+
 dLV4lOiYUa3EaCjARbM04mdr/u3xkSPvTYcCudpMZeKZKI3uduk9d
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Jun 2019 21:51:06 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 05 Jun 2019 21:51:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to replace obsolete #ifdef's?
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

PiBKdXN0IHdyYXBwaW5nIHRoZSBhc3NpZ25tZW50IGludG8gdGhlIG1hY3JvIGNhbGwgdHVybmVk
IG91dCB0byBiZSBlYXN5LgoKVGhpcyBmZWVkYmFjayBzZWVtcyB0byBiZSBwcm9taXNpbmcuCgoK
PiBCdXQgSSBoYXZlbid0IGZvdW5kIGEgd2F5IHRvIHJlbW92ZSB0aGUgbm93ICNpZmRlZiA6KAoK
SSBnZXQgdGhlIGZvbGxvd2luZyB0ZXN0IHJlc3VsdCBmb3IgYSBjb3JyZXNwb25kaW5nIFNtUEwg
dHJhbnNmb3JtYXRpb24gYXBwcm9hY2guCgpAcmVwbGFjZW1lbnRACmlkZW50aWZpZXIgdmFsdWU7
CkBACi0jaWZkZWYgQ09ORklHX09GCiAub2ZfbWF0Y2hfdGFibGUgPQotICAgICAgICAgICAgICAg
ICAgdmFsdWUKKyAgICAgICAgICAgICAgICAgIG9mX21hdGNoX3B0cih2YWx1ZSkKICwKLSNlbmRp
ZiAvKiBDT05GSUdfT0YgKi8KCgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvTGludXgvbmV4dC1w
YXRjaGVkPiBzcGF0Y2ggfi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL1Byb2JlL1dlaWdlbHQxLmNvY2Np
IHNvdW5kL3NvYy9jb2RlY3MvcGNtMzA2MC1pMmMuYwppbml0X2RlZnNfYnVpbHRpbnM6IC91c3Iv
bG9jYWwvYmluLy4uL2xpYi9jb2NjaW5lbGxlL3N0YW5kYXJkLmgKRmlsZSAiL2hvbWUvZWxmcmlu
Zy9Qcm9qZWt0ZS9Db2NjaW5lbGxlL1Byb2JlL1dlaWdlbHQxLmNvY2NpIiwgbGluZSA0LCBjb2x1
bW4gMSwgY2hhcnBvcyA9IDM2CiAgYXJvdW5kID0gJyNpZmRlZiBDT05GSUdfT0YnLAogIHdob2xl
IGNvbnRlbnQgPSAtI2lmZGVmIENPTkZJR19PRgoKCj4gQW55IGlkZWEgaG93IEkgY291bGQgc29s
dmUgdGhpcyA/CgpIb3cgYXJlIHRoZSBjaGFuY2VzIGZvciBjb250cmlidXRpb24gb2YgYWRkaXRp
b25hbCBzb2Z0d2FyZSBkZXZlbG9wbWVudCByZXNvdXJjZXMKYWNjb3JkaW5nIHRvIHRoZSBpbmZv
cm1hdGlvbiDigJxTdXBwb3J0IGZvciBtYXRjaGluZyAjaWZkZWYsIGV0Yy7igJ0/Cmh0dHBzOi8v
Z2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxvYi8xOWVlMTY5N2JmMTUyZDM3YTc4
YTIwY2VmZTE0ODc3NWJmNGIwZTBkL2NoYW5nZXMudHh0I3VwY29taW5ncGxhbm5lZHRvZG8KClJl
Z2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lz
dGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
