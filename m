Return-Path: <SRS0=lWmI=34=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A657EC35242
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 20:09:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE0121741
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 20:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sury.org header.i=@sury.org header.b="F4ufsKIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE0121741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sury.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 018K9Db2011068;
	Sat, 8 Feb 2020 21:09:13 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 939BF77ED;
	Sat,  8 Feb 2020 21:09:13 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A1AA47718
 for <cocci@systeme.lip6.fr>; Sat,  8 Feb 2020 21:09:12 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1031])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 018K9AkN013390
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 8 Feb 2020 21:09:11 +0100 (CET)
Received: by mail-pj1-x1031.google.com with SMTP id ep11so2412373pjb.2
 for <cocci@systeme.lip6.fr>; Sat, 08 Feb 2020 12:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sury.org; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=DnD6myQD1N1sfcz5hIb3yVmF5pwHwh+5qm3yDw+h8Cw=;
 b=F4ufsKIJFYZPLUAjzTR3u5tYJYW9KgD/hJ7xMcXzfBlfW4RCwbS0sjhj9d7tVe/C3Y
 LFcQYafGjF1Uy+gA+Od1mr0R7mQFzrQ2n+3r+JJow+S3MsZQ/91SQkWGi7xTsu7ABek3
 TKBuMscMuLTDF98NcHmzcRAczXvMhtWrtTQOWXnfYMDy84s9xH8q9dcOQnYVv2zhBDo9
 3Pq7XNRCgM6dk9pd4ZbueYZfAfZa732QMFr1xRk4xBtNZOV0PR0wP4vaF5v9jeD2ZT/v
 G+rhzg0/4e+Bi9zMb6opRCjEppFrt/kwgKN2BZdqGye3aynxzH/WMU+Y1Z+J6VqffwHh
 nbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=DnD6myQD1N1sfcz5hIb3yVmF5pwHwh+5qm3yDw+h8Cw=;
 b=tmZigOHz9s6g6XxwZFePegA4Qy1OE3PnpGQpIpH4hn4/ehhvBYnPdIUucYUmIxPosZ
 xsOPiCKRvnXUnvUKqpuxRRx5QEyyqQngznunFYvgY+vhhIdjxA1rTrXxULqGbqcSoW65
 6B9ZMDfgLoXmfdjrs/73TXxsF9/eHxFrFXU8YjcNeX63n9ecRYip+HRyOKNTRt+C3h6/
 gOrKNPsRjLhTAJCtu4Yv08xSHiMFSwyRZaJAarXRNbG5ZpZ3TXZ2qsuSHgLp/y1u+oaj
 zAcAN/Atq0WxP6eScO/LaeSqzgimD5xMVKZXutys/8w4//JVboS25IgDa/xssjLulLQc
 ISNg==
X-Gm-Message-State: APjAAAUlh7HUtOl5B74XlMf0xDFlFSWVfWbOuElY9U8xVoSTIim/Ebsp
 9IV7L8QH1RVTfYA66xotvCSTSg==
X-Google-Smtp-Source: APXvYqzqCiNoY7aqQpPjrT5XPbaEGlzxY87AszGNcmLKuvgFAKrQ0zsG74n/whZk6mfkkEOOzyDsHA==
X-Received: by 2002:a17:90a:2351:: with SMTP id
 f75mr11859511pje.133.1581192549433; 
 Sat, 08 Feb 2020 12:09:09 -0800 (PST)
Received: from [10.6.5.47] ([172.83.43.139])
 by smtp.gmail.com with ESMTPSA id q21sm7071563pff.105.2020.02.08.12.09.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Feb 2020 12:09:08 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
From: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
In-Reply-To: <beddf327-4b09-16fa-f011-ae14c20e988b@web.de>
Date: Sat, 8 Feb 2020 12:09:07 -0800
Message-Id: <9DEC698B-1094-4D4C-AE98-719DCE517EFE@sury.org>
References: <beddf327-4b09-16fa-f011-ae14c20e988b@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 08 Feb 2020 21:09:14 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 08 Feb 2020 21:09:11 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Replacing the type casting
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

SGkgTWFya3VzLAoKSSBlbmRlZCB1cCB3aXRoOgoKYGBgCkBACnR5cGUgVDsKZXhwcmVzc2lvbiBz
b3VyY2U7CkBACgotIFJFUVVJUkUoKChUICopc291cmNlKSAhPSBOVUxMKTsKKyBSRVFVSVJFKHNv
dXJjZSAhPSBOVUxMKTsKCgpAQAp0eXBlIFQ7CnR5cGVkZWYgZG5zX3JkYXRhY29tbW9uX3Q7Cmlk
ZW50aWZpZXIgY29tbW9uLCByZHR5cGU7CmlkZW50aWZpZXIgc291cmNlOwpAQAoKICBSRVFVSVJF
KCgKLSAoVCAqKXNvdXJjZQorIChkbnNfcmRhdGFjb21tb25fdCAqKXNvdXJjZQogICktPgotIGNv
bW1vbi4KICByZHR5cGUgPT0gLi4uKTsKCkBACnR5cGUgVDsKdHlwZWRlZiBkbnNfcmRhdGFjb21t
b25fdDsKaWRlbnRpZmllciBjb21tb24sIHJkY2xhc3M7CmlkZW50aWZpZXIgc291cmNlOwpAQAoK
ICBSRVFVSVJFKCgKLSAoVCAqKXNvdXJjZQorIChkbnNfcmRhdGFjb21tb25fdCAqKXNvdXJjZQog
ICktPgotIGNvbW1vbi4KICByZGNsYXNzID09IC4uLik7CmBgYAoKCj4gT24gOCBGZWIgMjAyMCwg
YXQgMTE6NDQsIE1hcmt1cyBFbGZyaW5nIDxNYXJrdXMuRWxmcmluZ0B3ZWIuZGU+IHdyb3RlOgo+
IAo+IENhbiB0aGUgZm9sbG93aW5nIHRyYW5zZm9ybWF0aW9uIHZhcmlhbnRzIGJlIGFsc28gaGVs
cGZ1bD8KPiAKPiAKPj4gQEAKPj4gdHlwZSBUOwo+PiBleHByZXNzaW9uIHNvdXJjZTsKPj4gQEAK
Pj4gCj4+IC0gUkVRVUlSRSgoKFQgKilzb3VyY2UpICE9IE5VTEwpOwo+PiArIFJFUVVJUkUoc291
cmNlICE9IE5VTEwpOwo+IAo+IFJFUVVJUkUoKAo+IC0gICAgICAgICAoVCopCj4gICAgICAgICAg
c291cmNlKSAhPSBOVUxMKTsKClRoYW5rcywgdGhhdOKAmXMgaGVscGZ1bC4gSeKAmWxsIHVzZSB0
aGF0LgoKPj4gQEAKPj4gCj4+ICBSRVFVSVJFKHNvdXJjZSAhPSBOVUxMKTsKPj4gIC4uLgo+PiAg
UkVRVUlSRSgoCj4+IC0gKFQgKikKPj4gKyAoZG5zX3JkYXRhY29tbW9uX3QgKikKPiAKPiAoCj4g
LVQKPiArZG5zX3JkYXRhY29tbW9uX3QKPiAqKQoKClRoaXMgY2Fubm90IGJlIGRvbmUsIGFzIEkg
bmVlZCB0byBjb252ZXJ0IG9ubHkgLmNvbW1vbiBtZW1iZXJzLCBhcyB0aGUgbW9yZSBzcGVjaWZp
YyBkYXRhIHR5cGVzIGluY2x1ZGUgZG5zX3JkYXRhY29tbW9uX3QgYXMgYSBmaXJzdCBtZW1iZXIg
b2YgdGhlIHN0cnVjdCAoYSBoZWFkZXIpLCBidXQgdGhleSB1c3VhbGx5IGNvbnRhaW4gbW9yZSBm
aWVsZHMsIGYuZS46CgogICAgICAgIFJFUVVJUkUodHlwZSA9PSBkbnNfcmRhdGF0eXBlX25zZWMp
OwogICAgICAgIFJFUVVJUkUoKHNvdXJjZSkgIT0gTlVMTCk7CiAgICAgICAgUkVRVUlSRSgoKGRu
c19yZGF0YWNvbW1vbl90ICopc291cmNlKS0+cmR0eXBlID09IHR5cGUpOwogICAgICAgIFJFUVVJ
UkUoKChkbnNfcmRhdGFjb21tb25fdCAqKXNvdXJjZSktPnJkY2xhc3MgPT0gcmRjbGFzcyk7CiAg
ICAgICAgUkVRVUlSRSgoKGRuc19yZGF0YV9uc2VjX3QgKilzb3VyY2UpLT50eXBlYml0cyAhPSBO
VUxMIHx8CiAgICAgICAgICAgICAgICAoKGRuc19yZGF0YV9uc2VjX3QgKilzb3VyY2UpLT5sZW4g
PT0gMCk7CgpPbmRyZWoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5
c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
