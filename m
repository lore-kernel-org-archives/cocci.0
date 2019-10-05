Return-Path: <SRS0=uzOD=X6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894F6C4740A
	for <cocci@archiver.kernel.org>; Sat,  5 Oct 2019 17:50:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2932520862
	for <cocci@archiver.kernel.org>; Sat,  5 Oct 2019 17:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="FJ5Q/cZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2932520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x95HoEvZ008039;
	Sat, 5 Oct 2019 19:50:14 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9C77277AA;
	Sat,  5 Oct 2019 19:50:14 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CA7F977A9
 for <cocci@systeme.lip6.fr>; Sat,  5 Oct 2019 19:50:12 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x95HoBO7023881;
 Sat, 5 Oct 2019 19:50:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570297791;
 bh=jsR06q+t7pJCAnSPj64314LWwBEj/jpyrv50D8vGJjU=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=FJ5Q/cZNrCTa+1saiYyriZc14n4x28U2+7s6A4fFeVDlksh/pKQmlf/tNnhS5dP/Y
 6brjiONJRSsgx+zxojGT58jjmvsGqZdl0Xur8pBcuDeDFOqUDbFrv2ULpH1eWKjiLb
 7r5V+oMG8yF6u0pHkKC+KZFk6WuMoWwstF4mkP3o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.178.111]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYejS-1idIs83eza-00VOqf; Sat, 05
 Oct 2019 19:49:51 +0200
To: Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
 <21684307-d05c-1856-c849-95436aedeb86@web.de>
 <alpine.DEB.2.21.1910051425050.2653@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <673eaa62-f5b2-7ad4-6ea0-6a190e3ce509@web.de>
Date: Sat, 5 Oct 2019 19:49:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910051425050.2653@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:uuTDLFkjqmcMfBeZxbt7051bNqFMbCvvYIB5RU9qmIL8MFcwvI0
 Maem0qUQrQrfU/HJdvfbbpYbQSQnclBMlMCYnHNDXbIhZBNWv/EMxn8DXKCMwmBTRZ1a86+
 OTY9os4FHRvsfDbuqYlcg/urpAX6JAOTQaJTSDGQbsL2wjsJcIlUe+2Eop0R7iScPPCRn/6
 yeWeXrCJa1sbuw6xpXpCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wvs1FuVgvrg=:nngzz8ZOdZEy7ZWu5djMQ9
 CsTuhaFWPX+2MLVPpHHgM6017GgBKDToAVzHzvdipXHKX/8UKADalS8drqGq96cjK/RCCJVRC
 eih8phXBqkzAEFkMXRueEZqLVUwokAPdaatyjE+qrNk54CEgfPbiQURJ+wt6CqG9hQD6RXkzT
 zrqJ6iSBjvo4fZHcQF5m8/eZ3lynO+n2bGPBA7HBfsblTIE64xziMwHWZq18qIGP9SNfOQ+Xx
 Bh9eRgLO7tqqFUftoihCG9zVoSwQoBZD6Pb/DH7s2M1pvP/sns5C8oFIpGJI7lrSUXFWv3nKc
 NHdHxdc5T+iyumpESo9Ms0xAo7xw3J1R0mGOw/Ll3p9B3Gpr0dlvRViceklUmVLdwKBSTHAy9
 MjMhk7/Un3CSsHCfO5YgPxJsxONLTB9c0SLWFgE+WKN4++mXiF2aqzBXw0/6S1G0lQPWJJUKU
 xoC7mWguaYEgT0fZmCOUPzsH6vTNG90vkVK7KwT5HanPaia5BzMDVFZmksSIFRVeQaXM69kWE
 2KqJIRIQKEApm3qZxCIH9bYwdCoWrZXgHVVNng9wFlIXOr2GD2f74l9vaZDdrtMB7V77PeJR6
 toRlca94lQLSBwcaK7llDHbJLatw39gzJoZ5CLZZdlSjdiod7V9eK0B9UADbch/VuTslZdbSZ
 Q1u1FzU3OT6FzOBlSefPMP1Lr/QiqAzin/NTF4u2Oejk64S6bj4nepy0Z7+uSlg7FSqi76iNx
 W2EEmB03XYYGNtBjPDvic7kvD2uXo48QcKdVlM6DSGMf3giEdYmXq9Nts+CXuIdcWG1LNJlvM
 EtFG82e0BkCl/0erp674eXyX4R4Ez9GDNrnQnkr2vaQwRo0LFr63Pvq2x1V2Ryes5ncKJNeaG
 xIEagMUXp5JEjtNlki/9lR0YGoZupWwl8eTbctGtaos+JTu1lDVRR2+jqDLOVNYCdr6cjJ9w5
 /x4B/STJEtk8Q8nWHfvD6dspNF1QbYKJEDp3+q54q11deqznt9XIFF3m7e7/MR2I0CJT7QTSH
 yz2ZRkO9U7KwQoFswiphHXSwD7MWaIwurrtwdS/nKo3TYuxMHCnLNtdquKor1dOEeJAl7x0L1
 WEiasGeIR/SHsfa7v7vj74Icjz3jElw9RZVvuQ9tXILaXsTYVkXCqEWgLqBmTnFnMsykxbMaW
 OS9/u2Dvw4Lg8sH2RASYlUIU6Xne8clgN2niL8kv6h4YPmNb+OAwd9h1/TvuZttWfjV+62fAj
 HMGI/yWpAi/CwM5kb3DjaG7fUx9dQ31TT5b/1YL+2hLx8TVYmM/HMy5IUCBE=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 05 Oct 2019 19:50:15 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 05 Oct 2019 19:50:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Yue Haibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Martijn Coenen <maco@android.com>
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
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

Pj4gV291bGQgeW91IGxpa2UgdG8gdGFrZSB0aGUgY2hhbmdlIHBvc3NpYmlsaXR5IGludG8gYWNj
b3VudAo+PiB0aGF0IHRoZSBjb2NjaWNoZWNrIHN5c3RlbSBjb25maWd1cmF0aW9uIHNob3VsZCBi
ZSBhZGFwdGVkIGluc3RlYWQ/Cj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL3NjcmlwdHMvY29jY2ljaGVjaz9p
ZD00ZWE2NTUzNDNjZTQxODBmZTliMmM3ZWM4Y2I4ZWY5ODg0YTQ3OTAxI24yNTcKPgo+IEkgcHJl
ZmVyIHRoZSBvbmUgbGluZSBjaGFuZ2UgZm9yIG5vdy4KClRoYW5rcyBmb3IgdGhpcyBpbmZvcm1h
dGlvbi4KCgo+IElmIG1vcmUgaXNzdWVzIGFyaXNlIG9uZSBjYW4gc2VlIHdoYXQgaXMgbW9yZSBk
ZXNpcmFibGUgYXQgYSBsYXJnZXIgc2NhbGUuCgpJIHN1Z2dlc3QgdG8gcmVjb25zaWRlciB0aGUg
Y29ycmVzcG9uZGluZyBzb2Z0d2FyZSBkZXNpZ24gY29uc2VxdWVuY2VzIG5vdy4KCiogRG8geW91
IGFjY2VwdCBvbmx5IFNtUEwgc2NyaXB0cyB3aGljaCB3aWxsIHdvcmsgdG9nZXRoZXIgd2l0aAog
IHRoZSBvcGVyYXRpb24gbW9kZSDigJxyZXBvcnTigJ0gb2YgdGhlIHRvb2wg4oCcY29jY2ljaGVj
a+KAnT8KCiogVW5kZXIgd2hpY2ggY2lyY3Vtc3RhbmNlcyB3aWxsIHlvdXIgY2hhbmdlIHJlc2lz
dGFuY2UgZXZvbHZlIGluIHRoZSB3YXkKICB0aGF0IGEgY2xlYXIgZmlsZSB0eXBlIHNlcGFyYXRp
b24gY2FuIGJlIGFwcGxpZWQgZmluYWxseT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29j
Y2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGlu
Zm8vY29jY2kK
