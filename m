Return-Path: <SRS0=Ekfz=33=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C900C2D0B1
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:15:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C32220726
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9MK1YR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C32220726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0176FOVo006333;
	Fri, 7 Feb 2020 07:15:24 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 69E5177EF;
	Fri,  7 Feb 2020 07:15:24 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2B5DC772B
 for <cocci@systeme.lip6.fr>; Fri,  7 Feb 2020 07:15:23 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:436])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0176FJlx013904
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 7 Feb 2020 07:15:20 +0100 (CET)
Received: by mail-pf1-x436.google.com with SMTP id 185so739002pfv.3
 for <cocci@systeme.lip6.fr>; Thu, 06 Feb 2020 22:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=2oIJ/9+Wdznz5JwXSGSH98pjxWJV1VvrSxJKy0S3YZA=;
 b=K9MK1YR94vwyq+YFLhtou5a0aU4Zady1BPa280VaIh+oIJKIX7pFGH3+LewVTRmKit
 Rx6kiJDuFZ9H1tSLtnVIW60Sm1kfyBIew3FarvW+8Wu04aEslakbaAjNXHEX6x8AwUNk
 L08pXZ2VtkiIS3creW794O0cxbaFgKq3sEn/qU62BM4ocpzU4L2uWjaAQpXQtREWLvVx
 HzI+zRBErtYIWfcCnfzuWwefHsQAgE0l4LeOPXoOI8Rcqby4huItRR04YJA/exxDOplG
 eH9lHxEJlP5bBYPy6r/G4XQYOE+qSDPZAZLt6dXqfvKdKgYEIdZINk+G30OY+TKNq8KS
 lIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=2oIJ/9+Wdznz5JwXSGSH98pjxWJV1VvrSxJKy0S3YZA=;
 b=azLUDF9aHVQK3vJK5OfM7I2UZdKbcpIqsxNo3QKblgjEPFAhh0tmNRfAXB8OoXECLN
 oylpiS8RpSc5ta0trVi5PMDC8BZFUZzZLwIWZmK+G4tx5eVMnGp0xZcMqRrv5u7/GW7w
 7ZQucdmelZjjkXY45uzOtfeLJcDAp7pCOQWWuchIn7XHl/hZfqbf/uT2pAchdJcvCo0A
 tTLwTYmT9cbJrE5luOFTAObWPG+/px/yyLpiMomX8Zm3TLgFZMmXq/bgjAi8XarP29+9
 mbiP51dpgnazgSy9iXOEmYdVaR1UqnQj5a7QyI4YIkReEVr1Y6Hf/xCfp1yZFzMFI8n/
 Wy7w==
X-Gm-Message-State: APjAAAVAWgoqzSOHpimpiWKrdOnSpcwYntAcrUCcZVPdtpo1nciW4LA5
 Y2qyeIonCVvl31ZaMQnTFx4=
X-Google-Smtp-Source: APXvYqw6wzqbvJmMBT+9pQAOugQrUxw/f93fr+EFyAsRCvHZJitoKbnXIGvBCjs+aV7ABGN96erGkQ==
X-Received: by 2002:a65:5c44:: with SMTP id v4mr8165922pgr.340.1581056119264; 
 Thu, 06 Feb 2020 22:15:19 -0800 (PST)
Received: from localhost.localdomain ([2405:204:30e:4a31:b268:7a3:7dc6:f288])
 by smtp.gmail.com with ESMTPSA id
 v10sm1342660pgk.24.2020.02.06.22.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 22:15:18 -0800 (PST)
Message-ID: <6e7b556fe05500b5c4f0852b5a7b65f9c762f5ad.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Date: Fri, 07 Feb 2020 11:45:13 +0530
In-Reply-To: <964378a7-ddd3-a1f8-e567-f3c4392b14a5@web.de>
References: <132f414d-397f-fb9a-ff6e-5360df827147@web.de>
 <f7da90d8cc0e609a2a81e7a041cc98afedb215b6.camel@gmail.com>
 <964378a7-ddd3-a1f8-e567-f3c4392b14a5@web.de>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Feb 2020 07:15:24 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 07 Feb 2020 07:15:21 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [2/2] tests: Add test case to match const pointer
 variants
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

T24gRnJpLCAyMDIwLTAyLTA3IGF0IDA3OjA3ICswMTAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToK
PiA+IFdvdWxkIHRoZSBmb2xsb3dpbmcgYmUgYSBiZXR0ZXIgc3ViamVjdD8KPiAKPiBUaGUgYWx0
ZXJuYXRpdmUgaXMgbmljZXIuCj4gCj4gCj4gV2lsbCBvdGhlciBpbXBsZW1lbnRhdGlvbiBkZXRh
aWxzIGJlY29tZSBhbHNvIG1vcmUgaW50ZXJlc3Rpbmc/Cj4gCj4gVGhlIGluZm9ybWF0aW9uIOKA
nEFsaWduIEMgQVNUIGFuZCBDb2NjaSBBU1TigJ0gd2FzIHByb3ZpZGVkLgo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2NvY2NpLzIwMjAwMjA1MTMwMzI3LjY4MTItMi1qYXNrYXJhbnNpbmdoNzY1
NDMyMUBnbWFpbC5jb20vCj4gaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvcGlwZXJtYWlsL2NvY2Np
LzIwMjAtRmVicnVhcnkvMDA2ODQwLmh0bWwKPiAKPiAqIFNob3VsZCB0aGUgcG90ZW50aWFsIGZv
ciBkaWZmZXJlbmNlcyBpbiB0aGVzZSDigJxBU1TigJ0gYmUgY2hlY2tlZCBhbnkKPiBtb3JlPwo+
IAoKQW4gZWZmb3J0IGlzIGFscmVhZHkgYmVpbmcgbWFkZSB0byBkbyB0aGlzIGJ5IG1lIGFuZCBK
dWxpYSA6KQoKPiAqIEhvdyBjYW4gc3VjaCBpdGVtcyBiZSBjb21wYXJlZCBzYWZlbHk/Cj4gCgpO
b3Qgc3VyZSB3aGF0IHlvdSBtZWFuLiBJZiB5b3UgbWVhbiBob3cgdGhlIHR3byBBU1RzIGNhbiBi
ZSBjb21wYXJlZCwKaXQncyBqdXN0IGEgcHJvY2VzcyBvZiBkYXRhIGNvbGxlY3Rpb24gYW5kIGRl
YnVnZ2luZy4KCkNoZWVycywKSmFza2FyYW4uCgo+IAo+IElzIHRoZXJlIGEgbmVlZCB0byBleHRl
bmQgdGhlIHRlc3QgZm9ybWF0Pwo+IGh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2Np
bmVsbGUvaXNzdWVzLzEzNAo+IAo+IFJlZ2FyZHMsCj4gTWFya3VzCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lA
c3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8v
Y29jY2kK
