Return-Path: <SRS0=mjN0=CH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FC5C433E2
	for <cocci@archiver.kernel.org>; Sat, 29 Aug 2020 11:09:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB48A207DF
	for <cocci@archiver.kernel.org>; Sat, 29 Aug 2020 11:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YLurJD3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB48A207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07TB94WI011766;
	Sat, 29 Aug 2020 13:09:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 006CC777D;
	Sat, 29 Aug 2020 13:09:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 778833F6C
 for <cocci@systeme.lip6.fr>; Sat, 29 Aug 2020 13:02:22 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07TB2LiH006974
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 29 Aug 2020 13:02:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598698940;
 bh=8LrM9VIqL+rQCCc4+f6LIH399/dbYOvNqW7CZ4L05hY=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=YLurJD3HS3ZSo1YLQZjXDrokkuc8xn1q4+sIi+NrShjg8nAeQviNg8WZs20QCHbp5
 +IB8OHG9XSI8m7+FrXv9U7g1SVBXXzk+OP+38bNgHqCBZ0KIBvghevKddSXAbYirEp
 6KzogTNy4eseW8Hnsxn7o2zkSJBfGypjxfkJ7y1Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.31.245]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6BN-1jvogT1kAf-00IzrN; Sat, 29
 Aug 2020 13:02:20 +0200
To: Julia Lawall <julia.lawall@inria.fr>, Denis Efremov <efremov@linux.com>
References: <75644b75-443c-1da9-fd1b-35e2ce34cf47@web.de>
 <alpine.DEB.2.22.394.2008291113140.3629@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2a6a3871-610b-07ad-40d5-5530c18d3c21@web.de>
Date: Sat, 29 Aug 2020 13:02:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2008291113140.3629@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:b9QYiu8FzhSXqT2wgoV0Y+3fDzOOeiZQsHWkUi4bOvgO6ZF7TWj
 qsQcUhLL/Pkb2H7DDjTZmkO3D60LtzGieYVTUrN40cy0eaSPhRcJEnkLsbbiDAsf2M4LKTh
 RRkWiP6Sue22C73NElcsoyb/0UIG7qGmNbNVbao3WutOtzVaPf1Osehutu1PhV6K9/TED4T
 qZ/xKdU9l3M23xrwEmwYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BgsUOhlrsiI=:V/rKDBZwVyz8Duf05oGVUd
 ZnsBMdfSHpbrddlv6CqF4FkzU+8O7GVJg7LwGhfzyVn2XCL3t+X9NoM1mBcOmeJe25VqC9hWf
 teVFhhYLslaLX3VMJnRUEdJ44QPqVbICWnbDdha9pKdPNdiHSMrWUg3roThtnPDFLwyfUOH1m
 aKeUYf4M3TWqs3bT1LrKOrNy6yhm/+3VXj3QALjEdxV0kq4pTmGOYD4Tf45ZMGFmR0FzU6lbv
 m8o/OGBv5o5kHDTKGEms4rvXPQz3up7j/rm2hPuVLNpjdvIurIa75BTQuzHqUVs/s/NBrh882
 ctkM1he0VAifcr7vS63Nnqdd/1X4KWR5SoDlM7IVOXU1HY1woI7qcPRCjEGQVLvSu8n7i9KX9
 2xo1aSFFyoPiGIOUk7WuVCMjiTlrNR5J/gGmeo+soP00AsDvOtyoX+iqO/ExpWiuYAFFv7lDG
 ptnVo9LdG0pYN0tB0n1o9+nf3ascbEbpINuF1LvplaM88mxYzmXPF4W5Jpyc7R3GcnmtNyJ++
 /l4VjvjRtKwx/R34oqIeuQtz65F6kfetORVHngn1ukfBiGFxj89tDYwkQY2gwhEDYVGKShoZT
 V8O7+rnIXByQw6wmc4UftRPZk/UJ8tnTAt4CtiqXNKsHlemjQ2nm7Of/7T20QFbBYXDKQaDUt
 IiaV5jmgY//t0b0ggwqRxhKCblnoH58jIiCQ8aaCj7Nzs/mhHI03xzoyPToE90vjr0ebc4vXY
 mPQhPTLDbVa4EVV7JEeiPl/QOJrd4xuVOzDiptO87V03QJjmYNSzus0F2DCOFsyfIRDOJBckO
 P/DyFzrA20wHLA0+tvjoDwdL9TSWXmLIbnFfj7oKkLjJzkfJikJ3Du7cfed6M+SjB0KPhnVdG
 qTAmyGbKho13ktRWmMRsASgkB2m/M9DnpLXdqkbJO0Qo/0cH25h+XjP498/RLoBYdoBaXj5XH
 qIHd5H/mJpTQ+X7ZL0j6lHwleqVj7WKuWc7KoWlwM/l1SWboog7D2tIftb0kkNontPNTpP54N
 z7YjeSx3ehSkPr3EdGF6FP609nOxMPoIYReUDTmbSOmMgVkKQppgwP5ngHp1MNdTCSZKgVECE
 SnWfdodRYzJY7VLZjghMlVYDCQ4CF3RrrasAiBKiWLSz86gcx4hGsKixa3uCwrtNVuqNLJcjk
 J4k9D9THYy55ctRVCJD3om7ZWOiKx/NCHTCwYKDH7rhlYD7+kMXBq1wFZx5QnV0PXNQA6ud6f
 rexyJMsfRuKHDJz5swmUN0i65R1PggsFiITvuIg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 29 Aug 2020 13:09:04 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 29 Aug 2020 13:02:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 29 Aug 2020 13:09:02 +0200
Cc: Coccinelle <cocci@systeme.lip6.fr>, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [Cocci] Checking the application of a SmPL disjunction for a
 function call addition
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

Pj4gQHJlcGxhY2VtZW50QAo+PiBpZGVudGlmaWVyIGFycmF5LCBpbnN0YW5jZSwgc2l6ZTsKPj4g
dHlwZSBUOwo+PiBAQAo+PiAoCj4+IC1zaXplb2YoVCkKPj4gfAo+PiAtc2l6ZW9mKCppbnN0YW5j
ZS0+YXJyYXkpCj4+ICkKPj4gICoKPj4gK2ZsZXhfYXJyYXlfc2l6ZShpbnN0YW5jZSwgYXJyYXks
Cj4+ICAgICAgICAgICAgICAgICAgaW5zdGFuY2UtPnNpemUKPj4gKyAgICAgICAgICAgICAgICkK
Pgo+IFRoaXMgc2VtYW50aWMgcGF0Y2ggd2lsbCBmYWlsIGlmIHRoZSBzaXplb2YoVCkgb3B0aW9u
IGlzIG1hdGNoZWQsIGJlY3VzZQo+IHRoZW4gaXQgd29uJ3QgYmUgYWJsZSB0byBjcmVhdGUgdGhl
ICsgY29kZSwgc2luY2UgaXQgd29uJ3Qga25vdyB3aGF0IGFycmF5Cj4gc2hvdWxkIGJlLgoKV2ls
bCB0aGlzIGluZm9ybWF0aW9uIHRyaWdnZXIgZnVydGhlciBjb25zZXF1ZW5jZXMgZm9yIHRoZSBj
bGFyaWZpY2F0aW9uCm9mIHRoZSB0b3BpYyDigJxbUkZDIFBBVENIXSBjb2NjaW5lbGxlOiBhcGk6
IGFkZCBmbGV4X2FycmF5X3NpemUuY29jY2kgc2NyaXB04oCdPwpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9jb2NjaS8yMDIwMDgyODE2MzEzNC40OTYzODYtMS1lZnJlbW92QGxpbnV4LmNvbS8KaHR0
cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvcGlwZXJtYWlsL2NvY2NpLzIwMjAtQXVndXN0LzAwODE2OS5o
dG1sCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRw
czovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
