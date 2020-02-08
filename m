Return-Path: <SRS0=lWmI=34=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F8FC35250
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 13:48:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD44217BA
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 13:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sury.org header.i=@sury.org header.b="HvfJpjTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD44217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sury.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 018DmRlX018189;
	Sat, 8 Feb 2020 14:48:27 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 734FF77ED;
	Sat,  8 Feb 2020 14:48:27 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 845117718
 for <cocci@systeme.lip6.fr>; Sat,  8 Feb 2020 14:48:26 +0100 (CET)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 018DmOC1016737
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 8 Feb 2020 14:48:25 +0100 (CET)
Received: by mail-pf1-x441.google.com with SMTP id k29so1241826pfp.13
 for <cocci@systeme.lip6.fr>; Sat, 08 Feb 2020 05:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sury.org; s=google;
 h=from:content-transfer-encoding:mime-version:subject:message-id:date
 :to; bh=c028CG4q0R5WOicLFSKIt9wcjc4akfLuO7V6iBC9kbY=;
 b=HvfJpjTLv8y1MPWFx3x+s6Ikd++7w0EKGFnFyMUbQzDEjbZ/PewRAtUxklespdXt9S
 eWsymO7vSdmLg+QWrz3Ttb+gpBH3GalDn44y0BguY+hRhhB7c14/HtP/eqD0jQW346xA
 qGnmPrkInTmScnLwAIKRU/zMv/cb7aKkrp4VvErczge25ykOMAWiy5dOc+tzne3fvYQg
 KTjtJbt7tWbVOVexWDzg8vJefD4dwOM9oU86HSOyXQl2cmm/ogUOm6JrBzKOkqmn2+L+
 /m304pLqDKE95GsWfr1fRoHmcaGyb5rHO7OR4PwYAHSVX40FrBIeE1nfs36CJgmsT6dB
 JrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:message-id:date:to;
 bh=c028CG4q0R5WOicLFSKIt9wcjc4akfLuO7V6iBC9kbY=;
 b=KUGSVpV5IMhK7NYvU7cGXp4THBuCz90J2o/3PEvBhMDqoE9SJSbmCWynj/RTvpbwMi
 ppBHlWIYNLhPDUaZAhkNhZHVPeuVRsYb0WZi0K+4LiipEQ4U9EqhEpdikZoxf2blYXAT
 b4TLsEsB/CvLvJMAKN2/mss5AhWmI9+dbyqUFfqhB7PGrPaT+Pe8Ccuzd9rsbrBw/Zbe
 grhi/w8GyrZgO+p0mlT7qRMjk8sRjbIQft7LZDUCv5Bq2nAZ3yIRuYgkoBJCqNnmtJbi
 +xGCvzvzGAvVLMtIsLdu8uNi2g2yJ1fmstCx8AX2tMwuv1vADosvChrtGuyKetkSfBi6
 rK4A==
X-Gm-Message-State: APjAAAWYpSZCSm9rSVBSlDzGTJarbO9PaUdcTKKi8yHoPWp4uMv7M33A
 Em0FDWYGk/dq6+pGiA4A6rXSO5JhYmNKFw==
X-Google-Smtp-Source: APXvYqwoR71WLXKzFZrPP0Pr+4FBgiN4em+c6MDXw+9/x/tqBpJR5zMC1zFptXfeXbPMFvZ24AZ1TQ==
X-Received: by 2002:a63:8b41:: with SMTP id j62mr4582927pge.2.1581169703716;
 Sat, 08 Feb 2020 05:48:23 -0800 (PST)
Received: from [10.6.6.237] ([172.83.43.139])
 by smtp.gmail.com with ESMTPSA id k5sm6142258pju.29.2020.02.08.05.48.22
 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Feb 2020 05:48:23 -0800 (PST)
From: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Message-Id: <70EEB3FF-CB74-4DA5-9F59-08E72604E312@sury.org>
Date: Sat, 8 Feb 2020 05:48:21 -0800
To: cocci@systeme.lip6.fr
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 08 Feb 2020 14:48:27 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 08 Feb 2020 14:48:26 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Replacing the type casting
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

SGksCgpJIGhhdmUgYSBjb2RlIGxpa2UgdGhpczoKCmBgYApzdGF0aWMgaW5saW5lIHZvaWQKZnJl
ZXN0cnVjdF9pbl9uc2FwKEFSR1NfRlJFRVNUUlVDVCkgewogICAgICAgIGRuc19yZGF0YV9pbl9u
c2FwX3QgKm5zYXA7CgogICAgICAgIFJFUVVJUkUoKChkbnNfcmRhdGFfaW5fbnNhcF90ICopc291
cmNlKSAhPSBOVUxMKTsKICAgICAgICBSRVFVSVJFKCgoZG5zX3JkYXRhX2luX25zYXBfdCAqKXNv
dXJjZSktPmNvbW1vbi5yZGNsYXNzID09IGRuc19yZGF0YWNsYXNzX2luKTsKICAgICAgICBSRVFV
SVJFKCgoZG5zX3JkYXRhX2luX25zYXBfdCAqKXNvdXJjZSktPmNvbW1vbi5yZHR5cGUgPT0gZG5z
X3JkYXRhdHlwZV9uc2FwKTsKCiAgICAgICAgbnNhcCA9IHNvdXJjZTsKYGBgCgphbmQgZHVlIHRv
IHZhcmlvdXMgY29tYmluYXRpb24gb2YgYSBDIHN0YW5kYXJkIHJlcXVpcmVtZW50IGFuZCBlbmZv
cmNlZCBjcHBjaGVjayBydWxlcywgSSBjYW7igJl0IGNoYW5nZSBpdCB0byBhIHNhbmVyIHdvcmtm
bG93IGZvciBhIGxlZ2FjeSBjb2RlLgoKQnV0IEkgYW0gdHJ5aW5nIHRvIHJlcGxhY2UgdGhlIHNw
ZWNpZmljIHR5cGUgY2FzZSB3aXRoIGEgZ2VuZXJpYyBzdHJ1Y3R1cmUsIHNvIGl0IHdpbGwgbG9v
ayBsaWtlIHRoaXM6CgpgYGAKc3RhdGljIGlubGluZSB2b2lkCmZyZWVzdHJ1Y3RfaW5fbnNhcChB
UkdTX0ZSRUVTVFJVQ1QpIHsKICAgICAgICBkbnNfcmRhdGFfaW5fbnNhcF90ICpuc2FwOwoKICAg
ICAgICBSRVFVSVJFKHNvdXJjZSAhPSBOVUxMKTsKICAgICAgICBSRVFVSVJFKCgoZG5zX3JkYXRh
Y29tbW9uX3QgKilzb3VyY2UpLT5yZGNsYXNzID09IGRuc19yZGF0YWNsYXNzX2luKTsKICAgICAg
ICBSRVFVSVJFKCgoZG5zX3JkYXRhY29tbW9uX3QgKilzb3VyY2UpLT5yZHR5cGUgPT0gZG5zX3Jk
YXRhdHlwZV9uc2FwKTsKCiAgICAgICAgbnNhcCA9IHNvdXJjZTsKCmBgYAoKVGhlc2UgYXJlIG15
IHJ1bGVzIGN1cnJlbnRseToKCmBgYApAQAp0eXBlIFQ7CmV4cHJlc3Npb24gc291cmNlOwpAQAoK
LSBSRVFVSVJFKCgoVCAqKXNvdXJjZSkgIT0gTlVMTCk7CisgUkVRVUlSRShzb3VyY2UgIT0gTlVM
TCk7CgpAQAp0eXBlIFQ7CnR5cGUgUjsKaWRlbnRpZmllciBjb21tb24sIHJkdHlwZTsKVCAqdGFy
Z2V0OwpleHByZXNzaW9uIHNvdXJjZTsKQEAKCiAgUkVRVUlSRShzb3VyY2UgIT0gTlVMTCk7CiAg
Li4uCiAgUkVRVUlSRSgoCi0gKFQgKikKKyAoZG5zX3JkYXRhY29tbW9uX3QgKikKICBzb3VyY2Up
LT4KLSBjb21tb24uCiAgcmR0eXBlID09IC4uLik7CiAgPCsuLi4KICB0YXJnZXQgPSBzb3VyY2U7
CiAgLi4uKz4KYGBgCgp0aGUgZmlyc3Qgb25lIHdvcmtzIGxpa2UgYSBjaGFybSwgYnV0IHRoZSBz
ZWNvbmQgcnVsZSBmYWlscyB3aXRoOgoKYGBgCmluaXRfZGVmc19idWlsdGluczogL3Vzci9sb2Nh
bC9iaW4vLi4vQ2VsbGFyL2NvY2NpbmVsbGUvMS4wLjgvYmluLy4uL2xpYi9jb2NjaW5lbGxlL3N0
YW5kYXJkLmgKcGx1czogcGFyc2UgZXJyb3I6CiAgRmlsZSAiY29jY2kvcmRhdGEuc3BhdGNoIiwg
bGluZSAyMSwgY29sdW1uIDIyLCBjaGFycG9zID0gMjUxCiAgYXJvdW5kID0gJyknLAogIHdob2xl
IGNvbnRlbnQgPSArIChkbnNfcmRhdGFjb21tb25fdCAqKQpgYGAKCkkgbXVzdCBiZSBtaXNzaW5n
IHNvbWV0aGluZyB2ZXJ5IG9idmlvdXMgYXMganVzdCByZW1vdmluZyB0aGUgdHlwZSB3b3Jrcywg
YnV0IGFkZGluZyB0aGUgYCsgKGRuc19yZGF0YWNvbW1vbl90ICopYCBsaW5lIG1ha2VzIHRoZSBy
dWxlIGZhaWwuCgpUaGFua3MsCk9uZHJlagotLQpPbmTFmWVqIFN1csO9Cm9uZHJlakBzdXJ5Lm9y
ZwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2Nj
aSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2
LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
