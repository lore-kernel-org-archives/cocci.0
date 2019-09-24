Return-Path: <SRS0=hgwh=XT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C011C432C1
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 20:48:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A21E207FD
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 20:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="DOyupayx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A21E207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OKma9r020470;
	Tue, 24 Sep 2019 22:48:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B8BFB77AB;
	Tue, 24 Sep 2019 22:48:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B3CDD779E
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 22:48:35 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OKmZLc001570;
 Tue, 24 Sep 2019 22:48:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569358114;
 bh=yRbXX7r+zr/0rfD1fHNGaEu8Sk4VEBtpUtN263+ZrXo=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=DOyupayxgj9nULTq7hpq/eAYBhnjW3bbRHQXHBb2BjkqVNgQqCa4HaMU6zZTqYX0H
 G9dy2R6ZvYeFgAY0SBzV6TKFidnl4740oE6aPJrb1owQ/AV7J/YI1UfTdGpH8v342k
 wfle7zmtFDi1zOKLL/aoMB/edBcuihmwL0IyXFn4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.71.162]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MV4bp-1igyH12z2T-00YTl7; Tue, 24
 Sep 2019 22:48:34 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
 <e3e922ef-fab2-ee5c-57f1-0f36ccc682fd@web.de>
 <alpine.DEB.2.21.1909242219450.2589@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3628f3d4-b9c2-d42a-b1a9-d5e7fe32f171@web.de>
Date: Tue, 24 Sep 2019 22:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909242219450.2589@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:3bPHuBDWA6tsNIB2LSVP76Lk1pmIAkca5/nD8lsuebU69DwqHns
 JmKcsZT90cPrAupfiAyHY6P6zqCpPwe0cEKxlkHXHT2BFbY8wMHiZFHQjBqHc2q693hGIDj
 q+TnAm4/C0eLcfWjV29d4ksg/rKxFdU4YeYq62aPVqEUOL/4nbPWaLTcr82TvIg0H6RmMuh
 ZY9noidrrcAr4FdVc0Ucg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+PUH2rjMAbw=:TAZasH6jVwQriL/pQTwXV5
 VtBaRv73koI7/iqq9nbcJHRM8XdVSMF2weNK4xsi1a0Q7OLBcBIVlBqYrKdpgPghCawkVuBO5
 Q1hngnr/ydd412u17flplZFP1hpDRulgkPgh0RbmL1yoC9c5lsPM8WzBvGPaohsHDQSYjG0gX
 0d9o6ljjFiiGx9IN/9lA/jaWtrTSZC4u93MPejQnEoe8wqp5dqQniWQi3M9FHRHL0WXcu7JBC
 MGRKqm3h+iHrLu6wWrgDuXU6JhmoDpcRWL4ifuYD7VQ5qRYTY0iuDFJJB1P7nmrcZj0U9HonE
 krfqopQg7cANxDLoWBXCGoqUS2kCMsn9Zgz3wgyNA4NKpRKTBRUzI/Qnc50QDji3IhPUSz2LU
 +igY5JcnoWmSohfRM8rFVFUUH/MmfZeBklueReb6m1RHHJVF/XKrCzVyULw2pUV0ht/4oHJTD
 sUZb7dbrEc05sfLZAcBpA3U6fbibjhdcMV4RLLc0n1FYEyEypqF2Pd5as9YT2tYI/WVWQp1nN
 YPq62Kt5d0fOTq8LIgB6tfwlcauUFdmw/pF6OR4j3F0SJ/sL8/RNhLvUHsRo5XBFNbQ4ztdbj
 BEbUL2X9vr9Dncr+HeoFoptiRrmGHNxNm1Eb67xpBLARKIUPA1AVIKXoPJKK3aGi2qO1Vt1UQ
 KEmGIByhIZfR4nVk28cj9ddDXKzxIhCZJidfdj3Q1K14q0ZxJ85fNniodxJhfqf3x/JUHfrms
 zcphdvMUsnqi6hP/IXxFy7bb3hEv1OOlbOEF3ZZGL3XHqUtgk5HqMKse+8F+ORIkkTV5nLYzK
 +NM8mLiq75Uo+V+BGzPSnSuY1DCTeBWZG1+8LJPYD0rXESjpDOrzpe/C5K1B4KPx0Q/4Qe3ug
 VjSmvRttwhfD+O9T10rzYFuZf+xrTKq0c2oUXMu2ycJPcIiukCMS/xe25J3M4woHl4tD5uhkn
 0Gf05bSVbPJlHOouhB1DsvkzQBEzhNEwvo5py/HCA6zxMJfD9Li6TjZTCkh6vOrJ+s+DeX3YL
 k2HnJtTSh2/H/L8ubn0KRIZs1CK9E2D+g+SmGJf54Q7uAN0oWxqYCU6FAb3PKxdv62BWlZeD7
 asiTkACjasR0hKXcU89nWuKSIkEscArzhvXQwOr6DBfClgDG9+VnKdv11X6QDIvngIx3/o0UC
 4iwytfiU58GYPKJ7yVvH5pQIZRR/0DLERhts9ZIEHrjPWfSjTvrLbASui61A14v5HnKpyskD1
 DD9uRsE3s//xS6NWbAfOMtx8Zm4g97VIaXmBdgJBiMCLKsYLk+01xj5g2gaQ=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 22:48:37 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 22:48:35 +0200 (CEST)
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

Pj4gSSBzdWdnZXN0IHRvIGNvbXBhcmUgdGhpcyBvdXRwdXQgd2l0aCB0aGUgZm9sbG93aW5nIHNv
dXJjZSBjb2RlIHRyYW5zZm9ybWF0aW9uIGFwcHJvYWNoLgrigKYKPj4gKiBXaHkgYXJlIHRoZSBm
dW5jdGlvbnMg4oCccHRyYWNlX2hicF9jcmVhdGXigJ0gYW5kIOKAnHB0cmFjZV9oYnBfZmlsbF9h
dHRyX2N0cmzigJ0KPj4gICBwcmVzZW50ZWQgaGVyZT8KPgo+IFdoYXQgZG9lcyAiaGVyZSIgbWVh
bi4gIFlvdSBnaXZlIHR3byBzZW1hbnRpYyBwYXRjaGVzIHdpdGggdHdvIHNldHMgb2YKPiBvdXRw
dXQuICBXaGljaCBpcyBoZXJlPwoKUGxlYXNlIGNoZWNrIHRoZSByZWxldmFuY2Ugb2YgdGhlIG1l
bnRpb25lZCB0d28gZnVuY3Rpb24gbmFtZXMgb25jZSBtb3JlLgoKCj4+ICogV2h5IGlzIHRoZSBm
aXJzdCB2YXJpYWJsZSBkZWNsYXJhdGlvbiBmcm9tIHRoZSBmdW5jdGlvbiDigJxwdHJhY2VfaGJw
X3NldF9hZGRy4oCdCj4+ICAgbm90IG1hcmtlZCBieSB0aGUgU21QTCBhc3RlcmlzayBmdW5jdGlv
bmFsaXR5IGluIHRoaXMgdGVzdCBleGFtcGxlPwo+Cj4gSSBkb24ndCBrbm93IHdoYXQgeW91IGFl
IHJlZmVycmluZyB0byBzbyBJIGNhbid0IGFuc3dlciBwcmVjaXNlbHksCgpEbyB5b3UgZmluZCBj
b3JyZXNwb25kaW5nIGxpbmtzIGNsZWFyZXI/Cmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2FyY2gvYXJtNjQva2Vy
bmVsL3B0cmFjZS5jP2lkPTA4ZjEwM2I5YTk1MDI5NzQxMDlmYWI0N2VhMzVjYTg1NDJjNGU1N2Ej
bjQ1MQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4zLjEvc291cmNlL2FyY2gv
YXJtNjQva2VybmVsL3B0cmFjZS5jI0w0NTEKCgo+IGJ1dCB5b3Ugc2hvdWxkIGtub3cgdGhhdCB0
aGUgb25seSBjb25uZWN0aW9uIGJldHdlZW4geW91ciBmaXJzdCB0d28gcnVsZXMgd2l0aCBhICoK
PiBpcyB0aGUgbmFtZSBvZiBhbiBpZGVudGlmaWVyLgoKSSB3b3VsZCBleHBlY3QgdGhhdCB0aGUg
c2VsZWN0ZWQgaWRlbnRpZmllciBzaG91bGQgcmVmZXIgdG8gdGhlIHNhbWUgc2NvcGUKb2YgdGhl
IGVuY2xvc2luZyBmdW5jdGlvbiBpbXBsZW1lbnRhdGlvbi4KCgo+IFRoZXJlIGlzIG5vIGd1YXJh
bnRlZSB0aGF0IHRoZSB0d28gcnVsZXMgbWF0Y2ggY29kZSBpbiB0aGUgc2FtZSBmdW5jdGlvbi4K
CldpbGwgYW55IGFkZGl0aW9uYWwgbWV0YXZhcmlhYmxlcyBiZSBuZWVkZWQgdG8gYWNoaWV2ZSB0
aGlzPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0
cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
