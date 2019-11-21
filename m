Return-Path: <SRS0=3gGd=ZN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6E8C432C0
	for <cocci@archiver.kernel.org>; Thu, 21 Nov 2019 20:42:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EAEF2068D
	for <cocci@archiver.kernel.org>; Thu, 21 Nov 2019 20:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="GJL7npfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAEF2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xALKgUVG015275;
	Thu, 21 Nov 2019 21:42:30 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EFB1577CF;
	Thu, 21 Nov 2019 21:42:29 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2FAFF77CE
 for <cocci@systeme.lip6.fr>; Thu, 21 Nov 2019 21:42:28 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xALKgRn7014781
 for <cocci@systeme.lip6.fr>; Thu, 21 Nov 2019 21:42:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574368946;
 bh=FXlDry3ey95eMmlHoP6cj8lWfQjxYni2A12Jqnq+FHg=;
 h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
 b=GJL7npfGVkourroCoBZCjSvWWszZ6xM/Fk4cC6WGnpcjKN0jnY6g5msXDiVdOyIWf
 PUyRELvmEJesKRz9SuGYry4+98QDtmnOrDCA0VtMsjq8PDZsUmdomaSx3Y+A7qSPnz
 q7waa2Entf9pVysPSyey8lv+lvxzv4lY32Hnmtyo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.172.213]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MI6C2-1iYRW344sA-003tWw; Thu, 21
 Nov 2019 21:42:26 +0100
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
References: <7FB3DF60-DEFB-434B-9A84-33575D34576E@sury.org>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1020049f-4ba8-a0c4-2678-e1b981a582ab@web.de>
Date: Thu, 21 Nov 2019 21:42:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7FB3DF60-DEFB-434B-9A84-33575D34576E@sury.org>
Content-Language: en-US
X-Provags-ID: V03:K1:RObiAO5mUmGWuSDRa3UrBwOPrju1KEk3FhA/5AuP6z8Rcg/TnWk
 88xuV2YiPqHu4DXJRCQjQAVLRMcTOpzrlPzN/suDKVLJEI7DozPvwHezc/YXoF2z3g87n+w
 aYVVD+DIyb3pWhpZ7BMv+atRYVXLC488MfbYXa8TZhNiZgw8POraSn7v9dHDLVzab2jstOg
 TDxZh/zARahr3+FKMf/+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WoUDUk/hoEc=:x8g9Ks4pQ/2pPGpiria6RH
 Lwmg+v0gcROQrs/N+HeCydyAmr8XkQboHL1iyh6SxtztVVJ5vvT0VYYa0gWXK48Fy1V0d+Wyn
 rPc6U4wHsyxiVMWwpbXLwRYxJvTD89YtSxZcFP6vrTcNZSaYgbQQUytg8Wu751X1shG2ejvLf
 iY5EAdEp0+4X8nE1yRmOYu2/tPsWkRqAhpCH0p6s6O/M+j6OpSvGfQmj6aeX6d6sMZQTyme1e
 vKqbX3UlxCZTCqMN8E5Qx6kWEAQec5dHeBbdWbzKoDtMqTlSMRCSSTOg/jbFkauoh5G3+nC/O
 0u3PPqzY1FtsSRe8f+pXxf2liC70QUO1vTP2B9HwmAN0OoXxIAfTj1Afr7WdiVlvlxuMHNKJY
 sV7x1Kka8qFOBAUNv9wgEVT5wI+GutTogHKBsDzSX0JjMWF0oS9MtHN7EHqmGOAj2P6yAyUOt
 gkzcZeRs2qVDXYJNjhzYpu7ijA3BumKC698daqUHBGs1scSGClEnnc9QnSxk0S16msYyt4gYK
 /On132HgSiuCdkkumob0rYMkUSXdOWqW5oSg3Sb1zyAnN9qcIxuVnBrUuc8266zwURCfeEY/B
 f5MVIToGd0XEmLsUe0asZi/0Ry0VPJYCk7WpN9wX4XSphR2YSfytW3H95Egwc7vSiCoghyNV4
 iPJRIaT6PwGBKsGWp2FK8UG6kv5bPv8Q9wysCLPvTvKQSIx/AOLYY5yJdhvIGTRRsdrIEJlDZ
 Mq/+zzLggj51S/B79BGc+gHs6sUBAjxkN7sHCKBf9svpI01oAis8SvejzkFbcY5NRsHtGDBUg
 G8aHhaHDGwxXCStZ+2DK8MXrWLgkYQIBYSu9biZ3Sq9ZjLuNxWgTHqJjOUBcipUPrqHxFq/FN
 Ied2kmpAvG/83IhkuAlYcc/ntTaJHsNYcUT1AeqwwPY1HQU5cAbE9LTcEpa4OmoS3+f8Nxloq
 r+qp1h32Nwh72tz3XCoiOXKKwxMZot2WMB3Q/h6cdyGT/VLFyiAtkbknnNEaHwJS/p4MmS0X8
 RiSAlCNhW3AHDTaCa6YsXeiZBnkom1j81iZV2N7c8zhlejMH2IICMbek4QshKJx1FOqR1s9H+
 4BIj6C76o738EOuabicSQ/fqYJ2+L+GFNU7tAiUwgdceigPnsEEPzLiJpIjXlWQLgUH9Cjfds
 BrnEi464NXce8W+6oihUUCPY6kDB+Xcw5H0wq3jT7YB8IFZk5FvF9LUSDugM8E7EXQP88xv+N
 5bGMjsz03pVoUykHjGvo2ROnx0UHyl6pjEEC2asX5H/p08/V5JgmtItuTvqs=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 21 Nov 2019 21:42:31 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 21 Nov 2019 21:42:27 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Merging SmPL rules
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

PiBJcyB0aGVyZSBhIHNpbXBsZSB3YXkgaG93IHRvIG1lcmdlIHRoZXNlIHRoZXNlIHJ1bGVzIHRv
Z2V0aGVyPwoKVGhlIGFuc3dlciB3aWxsIGRlcGVuZCBvbiB5b3VyIGV4cGVjdGF0aW9ucyBmb3Ig
c2ltcGxpY2l0eS4KCgo+IEl0IHNlZW1zIGxpa2UgaXQgc2hvdWxkIGJlIHBvc3NpYmxlLAoKKiBD
YW4geW91IGlkZW50aWZ5IHVzZWZ1bCBtZXJnZSBjcml0ZXJpYSBhbHJlYWR5PwoKKiBBcmUgeW91
IGF3YXJlIG9mIHNvZnR3YXJlIGRlc2lnbiBwb3NzaWJpbGl0aWVzIGZyb20KICB0aGUgYXBwbGlj
YXRpb24gb2YgU21QTCBkaXNqdW5jdGlvbnM/CgoKPiBidXQgSSB3YXNu4oCZdCBhYmxlIHRvIGRl
Y2lwaGVyIHRoZSBzeW50YXggZm9yIG1ha2luZyBwYXJ0cwo+IG9mIHRoZSBtYXRjaCB0byBiZSBy
ZW1vdmUgdG8gYmUgb3B0aW9uYWwKCkRpZCB5b3UgdHJ5IG91dCB0byBzcGVjaWZ5IHRoZSBtaW51
cyBjaGFyYWN0ZXIgYXQgdGhlIGJlZ2lubmluZwpvZiBzZXZlcmFsIGxpbmVzIGluc3RlYWQgb2Yg
dHJ5aW5nIHRvIGV4cHJlc3MgYSBjaGFuZ2UKb25seSBpbiBhIHNpbmdsZSB0ZXh0IGxpbmU/CgpS
ZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5
c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
