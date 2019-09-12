Return-Path: <SRS0=dhti=XH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E83BC47404
	for <cocci@archiver.kernel.org>; Thu, 12 Sep 2019 12:34:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65ABE20856
	for <cocci@archiver.kernel.org>; Thu, 12 Sep 2019 12:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="j0vWOqkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65ABE20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8CCYdYj026465;
	Thu, 12 Sep 2019 14:34:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BD0BD7798;
	Thu, 12 Sep 2019 14:34:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B83FA7797
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 14:34:37 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:331] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8CCYbbN004299
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 14:34:37 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id n10so7459566wmj.0
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 05:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=F99BJSeVw00zE86B6EkKHka10V2a1vLc8jABr1ekTnA=;
 b=j0vWOqkdzXqRxRmQS1HnU/IKTlnkMXf7Sm8ITKB3JMnSCulGc2LDLWjFMQRPpDM6fp
 uvH26O3q2w+xG4hSnVB7iFUeSKQnOp6OfGjBdFQQBMz2hicEedsuIN5agTTnOkmenVkR
 87qMhESjXtybE0YxKywVxxJ96VmjGbtD54mfY6la+qsPuEE5oJ63tQ1Mxeao1/X0NIyP
 R8slhS5dcbMEtXAeTT/WXZnfAtV4C78tW2Ukjp9SWmWV+rs65OIlctGoe0OxMkPnwjge
 kzLBTFKcGxaI+6alAuRg26aB5D+xOWH3QjDajJBlOo0JoXxixjQuhItqMEaTQw7AVxO4
 +fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=F99BJSeVw00zE86B6EkKHka10V2a1vLc8jABr1ekTnA=;
 b=SXDuMIUBl+9ECfhfxryg2fbjP3QM9VYMQ/z+rYpQFPiioZkLgPGX9h9nITd+VHgp4I
 bIxMsK6kh6gzRj4nkHh5wg/51MA2VTnvAGRHA/Ufjs365L3JqOkILKAkCZjhJ5isbcMu
 VLIfXQ9T8TrALKlYRr7Zre7F78aRsEK9eCKqovkjwV1BFeMBunL80KnfnwQPtxDyb3X/
 78fVBeVCyXhHN7k3blR4StbJHN2JiKMRUZEhX1XBYsTVfVXKZuD5J9VDm7ytiYc2QNHJ
 Rn2o5m5CydzpFDbb4I6Wd5GoSKU7u/X6Go4KnfbgOnr2jqXKS8DYjwq+27zlH+SjAo32
 6MHQ==
X-Gm-Message-State: APjAAAXZv8+RfhuY0TDuhHD+g569iVybexUPKt4Pb21SqC3s95IYE0eP
 7Smxl/j5IUmiYZe843+eku+fzA==
X-Google-Smtp-Source: APXvYqy16gCoAtGsdHdsAsUuXEtHywXIjFXfl03Ur7RQhmxtAUzLCBuCS+ts71hBZCghb5+09HtdwA==
X-Received: by 2002:a1c:c189:: with SMTP id r131mr8427623wmf.153.1568291676892; 
 Thu, 12 Sep 2019 05:34:36 -0700 (PDT)
Received: from localhost ([2001:858:107:1:4d9:f62:e78e:efcc])
 by smtp.gmail.com with ESMTPSA id c10sm33280398wrf.58.2019.09.12.05.34.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 Sep 2019 05:34:36 -0700 (PDT)
Date: Thu, 12 Sep 2019 14:34:35 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20190912123435.ztwsymd7m4s4n6hq@gintonic.linbit>
References: <20190912111304.2fu3lcqmtgbnolpx@gintonic.linbit>
 <alpine.DEB.2.21.1909121330300.2876@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909121330300.2876@hadrien>
User-Agent: NeoMutt/20171215
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 12 Sep 2019 14:34:40 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 12 Sep 2019 14:34:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] const in parameter lists
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

T24gVGh1LCBTZXAgMTIsIDIwMTkgYXQgMDE6MzE6NTJQTSArMDIwMCwgSnVsaWEgTGF3YWxsIHdy
b3RlOgo+IAo+IFNvcnJ5LCBpdCdzIG5vdCBjbGVhciB0byBtZSB3aGF0IHlvdSB3YW50IHRvIGRv
LiAgRG8geW91IHdhbnQgdG8gdmVyaWZ5Cj4gdGhhdCB0aGVyZSBpcyBhIGNvbnN0IGJlZm9yZSBy
ZW5hbWluZyB0aGUgcGFyYW1ldGVyPyAgQ291bGQgeW91IGRvCj4gCj4gY29uc3QgdW5zaWduZWQK
PiAtYQo+ICtiCj4gCj4gPwo+IAo+IGp1bGlhCgpJJ2xsIHRyeSBhbmQgb3V0bGluZSB3aGF0IEkn
bSBhY3R1YWxseSB0cnlpbmcgdG8gZG8uCgpIZXJlJ3Mgd2hhdCBJIGhhdmU6CgppbnQgZHJiZF9z
dWJtaXRfcGVlcl9yZXF1ZXN0KHN0cnVjdCBkcmJkX2RldmljZSAqZGV2aWNlLAoJCQkgICAgIHN0
cnVjdCBkcmJkX3BlZXJfcmVxdWVzdCAqcGVlcl9yZXEsCgkJCSAgICAgY29uc3QgdW5zaWduZWQg
b3AsIGNvbnN0IHVuc2lnbmVkIG9wX2ZsYWdzLAoJCQkgICAgIGNvbnN0IGludCBmYXVsdF90eXBl
KQp7Ci8vIC4uLgp9CgpUaGlzIGlzIHdoYXQgSSB3YW50OgoKaW50IGRyYmRfc3VibWl0X3BlZXJf
cmVxdWVzdChzdHJ1Y3QgZHJiZF9kZXZpY2UgKmRldmljZSwKCQkJICAgICBzdHJ1Y3QgZHJiZF9w
ZWVyX3JlcXVlc3QgKnBlZXJfcmVxLAoJCQkgICAgIGNvbnN0IHVuc2lnbmVkIHJ3LAoJCQkgICAg
IGNvbnN0IGludCBmYXVsdF90eXBlKQp7Ci8vIC4uLgp9CgpBbmQgdGhpcyBpcyBteSBjb2NjaSBw
YXRjaDoKCkBACmlkZW50aWZpZXIgb3AsIG9wX2ZsYWdzOwpzdHJ1Y3QgYmlvICpiOwpAQApkcmJk
X3N1Ym1pdF9wZWVyX3JlcXVlc3QoLi4uCi0gICAgLCBjb25zdCB1bnNpZ25lZCBvcCwgY29uc3Qg
dW5zaWduZWQgb3BfZmxhZ3MKKyAgICAsIGNvbnN0IHVuc2lnbmVkIHJ3CiAsLi4uKQp7Ci4uLgp9
CgpUaGlzIGdpdmVzIGFuIGVycm9yOgoKbWludXM6IHBhcnNlIGVycm9yOgogIEZpbGUgImRyYmQv
ZHJiZC1rZXJuZWwtY29tcGF0L2NvY2NpL3JlcV93cml0ZV9feWVzX3ByZXNlbnQuY29jY2kiLCBs
aW5lIDM1LCBjb2x1bW4gMjIsIGNoYXJwb3MgPSA1NDgKICBhcm91bmQgPSAnb3AnLAogIHdob2xl
IGNvbnRlbnQgPSAtICAgICwgY29uc3QgdW5zaWduZWQgb3AsIGNvbnN0IHVuc2lnbmVkIG9wX2Zs
YWdzCgoKRG9pbmcgaXQgd2l0aG91dCB0aGUgY29uc3RzIHlpZWxkcyB0aGlzOgoKIGludCBkcmJk
X3N1Ym1pdF9wZWVyX3JlcXVlc3Qoc3RydWN0IGRyYmRfZGV2aWNlICpkZXZpY2UsCi0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRyYmRfcGVlcl9yZXF1ZXN0ICpwZWVyX3JlcSwK
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB1bnNpZ25lZCBvcCwgY29uc3QgdW5z
aWduZWQgb3BfZmxhZ3MsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRyYmRf
cGVlcl9yZXF1ZXN0ICpwZWVyX3JlcWNvbnN0LAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVuc2lnbmVkIHJ3LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGludCBmYXVs
dF90eXBlKQogewoKTm90aWNlIHRoZSBzdHJheSAiY29uc3QiIGJlaGluZCAicGVlcl9yZXEiLgoK
U28gLS0gdG8gYW5zd2VyIHlvdXIgcXVlc3Rpb24gLS0gbXkgcHJpb3JpdHkgaGVyZSBpcyB0byBn
ZXQgdGhlIGNvZGUKY29tcGlsaW5nOyBJIGRvbid0IGFjdHVhbGx5IGNhcmUgYWJvdXQgYW55IG9m
IHRoZSBjb25zdHMuIEJlc3QgY2FzZQpzY2VuYXJpbyB3b3VsZCBiZSB0byBoYXZlIGl0IHJlbW92
ZSB3aGV0aGVyIG9yIG5vdCB0aGUgY29uc3RzIGFyZSB0aGVyZQphbmQgYWx3YXlzIGFkZCB0aGUg
bmV3IHBhcmFtZXRlciB3aXRoIGEgY29uc3QuCgotLQpDaHJpc3RvcGggQsO2aG13YWxkZXIKTElO
QklUIHwgS2VlcGluZyB0aGUgRGlnaXRhbCBXb3JsZCBSdW5uaW5nCkRSQkQgSEEg4oCUICBEaXNh
c3RlciBSZWNvdmVyeSDigJQgU29mdHdhcmUgZGVmaW5lZCBTdG9yYWdlCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2Nj
aUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5m
by9jb2NjaQo=
