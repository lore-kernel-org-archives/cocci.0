Return-Path: <SRS0=+0BU=7X=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573F7C433E2
	for <cocci@archiver.kernel.org>; Wed, 10 Jun 2020 15:01:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15CC2078C
	for <cocci@archiver.kernel.org>; Wed, 10 Jun 2020 15:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="UzqjoX5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15CC2078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05AF13sr010518;
	Wed, 10 Jun 2020 17:01:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8DFD47783;
	Wed, 10 Jun 2020 17:01:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 08AD23BAB
 for <cocci@systeme.lip6.fr>; Wed, 10 Jun 2020 17:01:02 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05AF11pC012624
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 10 Jun 2020 17:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591801260;
 bh=gy/+A5soOFQxH/ueF2FunvAHzxxD0h7NbXCD12ODjOk=;
 h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
 b=UzqjoX5r/akAlm+Ea+/kdYEHAJVSbiflgvPYEAIjfpX6AIPX2F8Bobuu1eOVkUw0D
 h8zCUVCoxx2PLIEv32UggF8b90hZ5ziEyHQdnUIpV6u14PLQC0CAFRo7E3cM/JR8K7
 RuC2ZFKJNcKOkwdksFQZ04EElb0zi43HLVoO3B8Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.155.16]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79RG-1iqstc0Fa8-017O3N; Wed, 10
 Jun 2020 17:01:00 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <88d56de0-0a22-3371-ebd9-0ccbbc81f76e@web.de>
 <alpine.DEB.2.21.2006091952570.2516@hadrien>
 <5156fabe-d9c0-def9-cd8c-d85b8b5c704f@web.de>
 <alpine.DEB.2.21.2006101653030.2235@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4befcdd7-5c9c-ebfe-7c2b-f493c8c2cbc8@web.de>
Date: Wed, 10 Jun 2020 17:00:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006101653030.2235@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:y6pZZIq4K2ZyF4ndhw5NCZfzHlVsu+Cxu8En+wJnb+IwV6TmsHp
 +sZUvv+P95Jj9nJk46/CJ23WSfIyc185z2K9uEmEttbpN05O3e7a1w4g3ib6O1yHNmukHhU
 BVm9c4nTbQ/UQ/qDNv7PV8L3+oTjeleUSvkdxa9uUnCLX0TwA/TP6wLnBBNzJFbLNrbcHnH
 Y8ktztVW34q/hfHy+Eceg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yVTpoIFW5wA=:f6EAzRz2E4A6cBCMLr/J4R
 a7Hvnq/XBur/DwCTqZ6sqtHaj2FwqTFEJtBI8alD+CXWwgAZnySRc4rexGGi7KbohgoexLU6Q
 HrEemuMFLi4jQOM318fdNkFpBonebBu7HE/POtxV5+IXkbBQ2PKiHx4JoX0ZtEBY13PPs8PXq
 AdRBxIjVmQFIS87YuohAv18/7xQRK1/iodClU1RXDk4/B/dwoiAOP0ZtkL6q6nWNq9yicCfa1
 B6CMNFu1g9wmvhVyXXrWkkzXh+YeOWIiwLyAtJpVRbF0qbM/G2FtKoKE4VZ/PMu0jbdJe5psh
 BaOnA2RWp1qRMvD7LPPNFFM7IOPIAPkoVfp3HOqXfKjEGVeJCROAHmVn8kzgcbwKx1/PQzc7O
 k3+yOBr4jHsoNL6lrH0q9RadTpdB1IibWhGppmcntSuyqoLr1wxkVimRjk3pKBaGyLtOXNqMp
 VEFO9aCzJB/IW1j7cR5wvL2FmSZ/0dt25bQRrAl3s0f0URIvh05mUmafW95S2OdyleogaExTU
 /ub5LvICeCEXyePLqkL08GoKUnF4xSL2Tg+sE3GW8v0DVSRLZ88srIeQMtuvZzxraUZcqFqsZ
 ljYb55YASP0lApPt1PwXBWzIIpububoN7CY3VzYkTRdQwHujQl7Dw+xRq6Vzc2E+a0qlxWwRl
 yb9uJuQNUMqQw720wglAe607MA/WP61UPGGhgolVEEtC/+bGRkL2OIybw/GI5U39ibQF1Kr9J
 H3qBM3NMRZYgXHVtp4R9oeWF7QEkXfBbqpxhNwuACn1BAaOmpqQ3Pgura5vOCB861A9lBJW5P
 VNJqlk0VZW3MEQ4LuwavGoI2Pg7XFw4U7o2oyaxpQstD93ChApkqBWvKKOOMzUUd6aJ4/31I0
 aqRJ9VBJnegZ4Da/2lnzjuc6V4w3eHXd+UN4Mypz1pI3K+WwSKk1mBrChncON4gp4Psr1Il2/
 UsbAeL3FjSma5n2gh0T2i+AKcZR9OAdXp2YkPm5nSP61EkDyjubISIHFglzWc4jgvYn6LF9a6
 O6pfEMYBxPN1eYHPrN6tQTZdwEtdFqpdRrE3kQGdZDpab77anh0Nrb4Ua4quoce+4V6U3q6J4
 66lrEQGv0yqRW1v+mGVzjCS4Eq8DSSq3OpOYmaPzhzCGYjbGq8MIpSTzlJdZ2kAnaj2i9LD//
 8EdLbYlA5TeOtTkRc2quQf+OcRCGxG4kmbFbNHjaGbIF7L6GPupQCt2sR8SPLnCGBCccNDeFQ
 9l4wjB3EXREgnS+yl
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 10 Jun 2020 17:01:03 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 10 Jun 2020 17:01:01 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking software behaviour according to selected SmPL
 code variants
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

Pj4gQGRpc3BsYXlACj4+IGV4cHJlc3Npb24gZTsKPj4gQEAKPj4gKmJyZWxzZShlKTsKPj4gIDwr
Li4uIHdoZW4gIT0gZSA9IC4uLgo+PiAqZQo+PiAgLi4uKz4K4oCmCj4+IGVsZnJpbmdAU29ubmU6
fi9Qcm9qZWt0ZS9MaW51eC9uZXh0LXBhdGNoZWQ+IHNwYXRjaCB+L1Byb2pla3RlL0NvY2NpbmVs
bGUvamFuaXRvci9zaG93X3F1ZXN0aW9uYWJsZV9icmVsc2VfdXNhZ2U4LmNvY2NpIGZzL2V4dDQv
ZXh0ZW50cy5jCj4+IOKApgo+PiBAQCAtMTEyNyw4ICsxMTIxLDYgQEAgc3RhdGljIGludCBleHQ0
X2V4dF9zcGxpdChoYW5kbGVfdCAqaGFuZArigKYKPj4gLQlicmVsc2UoYmgpOwo+PiAtCWJoID0g
TlVMTDsK4oCmCj4+IFdvdWxkIHlvdSBsaWtlIHRvIHN1Z2dlc3QgYW55IGZpbmUtdHVuaW5nIGZv
ciB0aGUgc2VhcmNoIGFwcHJvYWNoPwo+Cj4gV2hlbiBkZXNjcmliZXMgd2hhdCBoYXBwZW5zIGVs
c2V3aGVyZSB0aGFuIGluIHRoZSBzdGF0ZW1lbnQgbWF0Y2hlZCBieSB0aGUgcGF0dGVybi4KCkkg
aG9wZWQgdGhhdCBteSBzcGVjaWZpY2F0aW9uIG9mIGEgU21QTCBjb2RlIGV4Y2x1c2lvbiBzaG91
bGQgcHJldmVudAp0aGUgcHJlc2VudGF0aW9uIG9mIGFzc2lnbm1lbnRzIChpbmRlcGVuZGVudCBm
cm9tIHN0YXRlbWVudHMgYW5kL29yIGV4cHJlc3Npb25zKS4KClJlZ2FyZHMsCk1hcmt1cwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5n
IGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxt
YW4vbGlzdGluZm8vY29jY2kK
