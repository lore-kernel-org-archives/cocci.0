Return-Path: <SRS0=hgwh=XT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DB6C432C1
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 20:35:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683352146E
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 20:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="rZ/uZgy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683352146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OKZWPU025436;
	Tue, 24 Sep 2019 22:35:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 645B677AB;
	Tue, 24 Sep 2019 22:35:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CCB72779E
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 22:35:30 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OKZSiH013390;
 Tue, 24 Sep 2019 22:35:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569357328;
 bh=9GkpuEzTpLtUAoQmKn/4PGnYgPSQfBNva1fQeWQ7dCQ=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=rZ/uZgy2345NeQiI+DcfJTu+uWdUOV+zON06qT/GnD6Gz5tXSR4L/xU+qSRLRfb+7
 PT4wJHznirofBszfFuCR8eX0gkVmUylEsiq+7PDnSUsQDe/rsrJlZD1szp6IIE9iPo
 kU4YP2qr3QkIC7iHmIr5Qa8hudBS95RUI+ho+wrE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.71.162]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LqUbl-1hiSen1iSX-00e4Nx; Tue, 24
 Sep 2019 22:35:28 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
 <c4437d9b-8795-fdfa-7914-fc30ead14cf7@web.de>
 <alpine.DEB.2.21.1909241729310.2282@hadrien>
 <f41b8e72-9a79-e65a-a652-8a257d5fac71@web.de>
 <alpine.DEB.2.21.1909242215440.2589@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b22031b2-2382-e629-a11a-09be7fc8e9c3@web.de>
Date: Tue, 24 Sep 2019 22:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909242215440.2589@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:j7pSNnZUvH8ZFzj2vybVa9H7GV/jYdgNxmYigVelT6/X+3jlGRo
 F5QTAY7xhvZ0yw/brGQjQwlUVFkwWIyrc0eZpXjNeA76NU192PYNnesjAVEo0pgAUzK4sES
 SFzmSS1qLuxdY/RHLvyh9syfN16jRLQGzuzVaOhJAjjOq4gO6IWi6iFyyyi7BhuueFM8UeD
 vt2QJx2xRNXOYYw8SCggg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZFIAOhjTwcw=:vT5BsLQ+8mLrcnTHGELcye
 wjcyV9UUwr6gOwb4Gah/Jnlr66A5rA5ik59xwDHlPKhz4mt5TMm+foxsXTfxJQNR2hldI0Veg
 fABt8tDPtd9e1koywdZJjI03ana3h/0s+OF4PTex+OL7SjuPvfSyowf3oU/EsKZ2dNiU3ir+B
 eZjSY4QIL9EYDB3lOb4RJjailg5gnamZBt0/WGFV3YtGmt8ZMV0zNRQ+9hgkj1ZXE3NbxLDlS
 jztwVMv91rnISnZP+rPIKHqE7kHwIm3u+ZMrzVlJVlFuP8FHXPQiAnqLYPZh5CBjTWylfrKMi
 +3CScQIL2wYigniGe1etbTvzwRGudwSQ9gcSr8f1kQ3aybgKctaPFsj9vz3JYfn4QydxGTmQ7
 7TI5rMdrcWHY1Cr8W1HdTnfmLiYESzy4KP9aP5Z8X+h9qka0watpCk75L/Smn2p2GTIiH5Iex
 dvOZgzCqeXc9dLgug4re9gc/j0ft7Y9BSYD0woSRmLK6Uo2uU923QeEqPoeCzlp0+ZiGFlgpP
 4sHY7qCjjKhrun+C5Avx3IvzlUZJS9FHdWeotUBweNn/I1NEoAW6nAsTqS78eJ6phqe/Md4sf
 7JyAdtutJkkFyMQjT6QsCBabrJ5fAJx83DocQtzm1pveIGcjnkuHF/DT5x9dlumcngo1e7gw2
 3dL4O2f4mvKk2dR/tjVfU2rermyvYU1IGoqiVfQCelE9U6DFdFHbzzebEPYhfeJKDQYCXJ+e9
 QmQ3vQiMsvKA4l+ca/oy0ZvvtvsnPH1GFHrtby8pQhrub0IxvOp5IhRpTM0T1HYyiOjQi+YCq
 QfCH70gDdMbavgXOGxuGwmy/kd4E4gfziaiYsb+rTfEpIsin5IGqJ0LnNDBCklJgPKQfZYYOQ
 g4Ap/QP4KRPMWtVjo5J0W4YmTJ9scw9RPNIzJV0GC8pJ1NWqClc0RlYJSGXnvMvJAWAptRo5t
 BgcQo6NYXfugyZwzii7UUY5DtPusk1c2aeFyTF8JaD8tFaBk0GiVdUCSd39YL3H5e2ISsQ4gm
 Dop+KnRSqBm7Sma8J8nPKsL44JdbPhwjyxif2zSeF3S2y7q5IKBK/CbViEr9c3+RB6CLctQq9
 3tnxhsErJgBIpTBjnLZiSnnZAJWjzZQbEM4k4zUTLp8l9DIHRx3YKpp726/+3P3zZmmrKr4z8
 WMLiyT8t5IW//F7mk/Sq+kvKxcVgVY9HVJBrWRg8skbZUVf+/k0+X5ko0uL8/gsOicvDe7rgu
 xAIpGqKMrIRvyvSa8WP+SPbmrz22a7JV0GAS3BH6e69FiXRN5NClHUs4AsSw=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 22:35:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 22:35:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reducing source code around return statements with SmPL?
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

Pj4gZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0xpbnV4L25leHQtcGF0Y2hlZD4gc3BhdGNoIH4v
UHJvamVrdGUvQ29jY2luZWxsZS9qYW5pdG9yL21vdmVfY29kZV90b19yZXR1cm4yLmNvY2NpIGFy
Y2gvYXJtNjQva2VybmVsL3B0cmFjZS5jCj4+Cj4+IFRocmVlIHNvdXJjZSBjb2RlIHBsYWNlcyBh
cmUgcG9pbnRlZCBvdXQgYnkgdGhlIFNtUEwgcnVsZSDigJx0b19kbzHigJ0KPj4gYXMgaXQgd291
bGQgYmUgZXhwZWN0ZWQuCj4+IFVuZm9ydHVuYXRlbHksIEkgbWlzcyB0aGUgbWVzc2FnZSDigJxJ
TkZPOiBNYXkgdGhlIGxvY2FsIHZhcmlhYmxlICJlcnIiIGJlIGRlbGV0ZWQ/4oCdCj4+IGZvciB0
aGUgZnVuY3Rpb24g4oCccHRyYWNlX2hicF9zZXRfYWRkcuKAnSBhY2NvcmRpbmcgdG8gdGhlIFNt
UEwgcnVsZSDigJx0b19kbzLigJ0uCj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2FyY2gvYXJtNjQva2VybmVs
L3B0cmFjZS5jP2lkPTA4ZjEwM2I5YTk1MDI5NzQxMDlmYWI0N2VhMzVjYTg1NDJjNGU1N2EjbjQ1
MQo+Pgo+PiBXaGljaCBhZGp1c3RtZW50cyB3aWxsIGJlY29tZSByZWxldmFudCBoZXJlPwo+Cj4g
SW4gdGhhdCBmdW5jdGlvbiBlcnIgaXMgdXNlZCBlbHNld2hlcmUsIHNvIHRoZSBzZWNvbmQgbWVz
c2FnZSBzaG91bGQgbm90Cj4gYmUgcHJpbnRlZC4KCkkgZGlzYWdyZWUgdG8gdGhpcyB2aWV3IChh
ZnRlciB0aGUgcmVtb3ZhbCBvZiBwcmV2aW91cyB1c2VzKS4KClRoZSBmb2xsb3dpbmcgU21QTCBz
Y3JpcHQgdmFyaWFudCBjYW4gcG9pbnQgYWxzbyBxdWVzdGlvbmFibGUgdmFyaWFibGUgZGVjbGFy
YXRpb25zIG91dC4KCkBjaGVjazFACmV4cHJlc3Npb24geDsKaWRlbnRpZmllciByYzsKbG9jYWwg
aWRleHByZXNzaW9uIGxyYzsKcG9zaXRpb24gcDsKQEAKIGxyY0ByYyA9IHhAcDsKIHJldHVybiBs
cmM7CgpAY2hlY2syQAppZGVudGlmaWVyIGNoZWNrMS5yYzsKcG9zaXRpb24gY2hlY2sxLnA7CnR5
cGUgdDsKQEAKIHQgcmNAcDsKIC4uLiB3aGVuICE9IHJjCgpAc2NyaXB0OnB5dGhvbiB0b19kbzFA
CnAgPDwgY2hlY2sxLnA7CkBACmNvY2NpbGliLm9yZy5wcmludF90b2RvKHBbMF0sCiAgICAgICAg
ICAgICAgICAgICAgICAgICJXQVJOSU5HOiBBbiBleHByZXNzaW9uIHdhcyBhc3NpZ25lZCB0byBh
IGxvY2FsIHZhcmlhYmxlIGJlZm9yZSBpdCB3aWxsIGJlIHJldHVybmVkIGJ5IHRoZSBzdWJzZXF1
ZW50IHN0YXRlbWVudC4iKQoKQHNjcmlwdDpweXRob24gdG9fZG8yQApwIDw8IGNoZWNrMS5wOwp2
IDw8IGNoZWNrMS5yYzsKQEAKY29jY2lsaWIub3JnLnByaW50X3RvZG8ocFswXSwKICAgICAgICAg
ICAgICAgICAgICAgICAgIklORk86IE1heSB0aGUgbG9jYWwgdmFyaWFibGUgXCIiCiAgICAgICAg
ICAgICAgICAgICAgICAgICsgdgogICAgICAgICAgICAgICAgICAgICAgICArICJcIiBiZSBkZWxl
dGVkPyIpCgoKQnV0IGhvdyBzaG91bGQgYmUgYWNoaWV2ZWQgdGhhdCB0aGUgbm90aWZpY2F0aW9u
IGZvciBkZWNsYXJhdGlvbnMKd2hpY2ggY2FuIGJlIG9taXR0ZWQgd2lsbCBiZSBwcmVzZW50ZWQg
b25seSBvbmNlIGZvciBlYWNoIGFmZmVjdGVkIGxvY2FsIHZhcmlhYmxlPwoKUmVnYXJkcywKTWFy
a3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2Np
IG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYu
ZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
