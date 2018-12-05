Return-Path: <SRS0=Yxto=OO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96B2C04EB9
	for <cocci@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06747208E7
	for <cocci@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1qQgweR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06747208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB5IWm4m023180
          ; Wed, 5 Dec 2018 19:32:48 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 45F6776DA;
	Wed,  5 Dec 2018 19:32:48 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A66D976D4
 for <cocci@systeme.lip6.fr>; Wed,  5 Dec 2018 19:32:46 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB5IWisd011102
 for <cocci@systeme.lip6.fr>; Wed, 5 Dec 2018 19:32:44 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D028320892
 for <cocci@systeme.lip6.fr>; Wed,  5 Dec 2018 18:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544034762;
 bh=z758kn+4dw37opEUD/bYhH01MSQYVcFQIZxKdCh7cgc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=G1qQgweR72JY/DzqBz+00dQIRIjeZ+VpZrsay7IUL1HQB7c362BI1kcHyfCkCMR8k
 IRWJwp0/qgjT4EXXzUaH2Ho5XtHbWiI25S9zNcIgqi6FRiU2j2QpuMmHpu5jimli6P
 lbA3dYmvWAKq/Oi9bUDkjlS5LxZfyHEgsy4qJFxM=
Received: by mail-oi1-f174.google.com with SMTP id w13so18406136oiw.9
 for <cocci@systeme.lip6.fr>; Wed, 05 Dec 2018 10:32:42 -0800 (PST)
X-Gm-Message-State: AA+aEWbAcZEUU2/AwVWnVTBpoOkDTi23EKNjw7TpVI5DA5At1dABwDjV
 XvRnLdEP/PsUEvO7IT+LOkbrKltgZB5kk4AjefM=
X-Google-Smtp-Source: AFSGD/UB8/cP90IJJBpOiFI5oiVFaWJblVBEfJhbHr+Z3CD8DnupR0lo+lEMr3SHYCEy291sOwPCEPIg0aT0o56uGjI=
X-Received: by 2002:aca:ad53:: with SMTP id w80mr14711491oie.148.1544034762116; 
 Wed, 05 Dec 2018 10:32:42 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXVLMv-5_u1uOq6re+1O3vADsrTK0+J3Fat-XN4_2DEp4w@mail.gmail.com>
 <alpine.DEB.2.21.1811151327420.2372@hadrien>
 <CAOZdJXWD0L4Qwh2raJLF25Ax0=DR06vhfGWhpQVf804YQJ5jeA@mail.gmail.com>
 <alpine.DEB.2.21.1812042124260.2383@hadrien>
 <CAOZdJXXMTrXXEKta-M0uYq3EpjVaSz2++OT1GOB5HYmx5h_TgA@mail.gmail.com>
 <alpine.DEB.2.21.1812050732260.2670@hadrien>
 <CAOZdJXX+0cVy0zC7xVgf2EE-YrP+qU_6QWJA_uhhiCqhbgAD7A@mail.gmail.com>
In-Reply-To: <CAOZdJXX+0cVy0zC7xVgf2EE-YrP+qU_6QWJA_uhhiCqhbgAD7A@mail.gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Wed, 5 Dec 2018 12:32:05 -0600
X-Gmail-Original-Message-ID: <CAOZdJXXYi=iwXuP07L2r29NmJLBUk2dyx_xU=GEz0M5xDcpd3w@mail.gmail.com>
Message-ID: <CAOZdJXXYi=iwXuP07L2r29NmJLBUk2dyx_xU=GEz0M5xDcpd3w@mail.gmail.com>
To: Timur Tabi <timur@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000849188057c4a9b8b"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Dec 2018 19:32:48 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 05 Dec 2018 19:32:44 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Can the current function name be passed to a Python
	snippet?
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--000000000000849188057c4a9b8b
Content-Type: text/plain; charset="UTF-8"

Another thing that I don't understand is why do I need to have two
rules for every Python script?  I've attached my .cocci file.  Each
Python script is in between a pair of //---- comments.  They all have
the same format:

1. One rule to specify the pattern to match
2. A Python script
3. Another rule to specify how to process the output of the Python script

Can't I combine 1) and 3) into one rule?

--000000000000849188057c4a9b8b
Content-Type: application/octet-stream; name="nv_printf.cocci"
Content-Disposition: attachment; filename="nv_printf.cocci"
Content-Transfer-Encoding: base64
Content-ID: <f_jpbie9kl0>
X-Attachment-Id: f_jpbie9kl0

LyoKICogQ29jY2luZWxsZSBmaWxlIHRvIHJlcGxhY2UgREJHX1BSSU5URigpIGNhbGxzIHdpdGgg
TlZfUFJJTlRGKCkgCiAqCiAqIFRvIHdvcmsgYXJvdW5kIGFuIG9kZCBiZWhhdmlvciBvZiBDb2Nj
aW5lbGxlLCB3ZSB0ZW1wb3JhcmlseSBjaGFuZ2UKICogdGhlIERCR19QUklOVHggc3RhdGVtZW50
cyBpbnRvIE5WX1BSSU5UMiwgYW5kIGRvIGFsbCBvdXIgd29yayBvbiB0aGF0CiAqIG1hY3JvIG5h
bWUuICBPbmx5IGF0IHRoZSB2ZXJ5IGVuZCBkbyB3ZSBjaGFuZ2UgTlZfUFJJTlQyIHRvIE5WX1BS
SU5URi4KICogV2UgZG8gdGhpcyBzbyB0aGF0IENvY2NpbmVsbGUgd29uJ3QgdG91Y2ggZXhpc3Rp
bmcgTlZfUFJJTlRGIHN0YXRlbWVudHMuCiAqCiAqIFB5dGhvbiBydWxlcyBjb21lIGluIHRocmVl
IHBhcnRzOgogKiAgMS4gQSBydWxlIHRvIGRldGVybWluZSBpZiB0aGUgUHl0aG9uIGNvZGUgc2hv
dWxkIGJlIHJ1bgogKiAgMi4gVGhlIFB5dGhvbiBjb2RlIGl0c2VsZiwgaW5zaWRlIGEgcnVsZQog
KiAgMy4gQSBmaW5hbCBydWxlIHRoYXQgYXBwbGllcyB0aGUgb3V0cHV0IG9mIHRoZSBQeXRob24g
c2NyaXB0CiAqLwoKLy8gUmVtb3ZlIHRoZSBkb3VibGUtcGFyZW50aGVzZXMgaW4gREJHX1BSSU5U
RiBzdGF0ZW1lbnRzCkBydWxlMEAKQEAKREJHX1BSSU5URigKLSgKLi4uCi0pCiApOwoKLy8gUmVw
bGFjZSBEQkdfUFJJTlRGIHdpdGggTlZfUFJJTlRGMgpAcnVsZTEgZGVwZW5kcyBvbiBydWxlMEAK
ZXhwcmVzc2lvbiB4OwpleHByZXNzaW9uIGxpc3QgeTsKQEAKLURCR19QUklOVEYoeCwgeSk7CitO
Vl9QUklOVEYyKHkpOwoKLy8gUmVwbGFjZSBEQkdfUFJJTlRfU1RSSU5HIHdpdGggTlZfUFJJTlRG
MgpAcnVsZTJACmV4cHJlc3Npb24gbGlzdCB4OwpAQAotREJHX1BSSU5UX1NUUklORyh4KTsKK05W
X1BSSU5URjIoeCk7CgovLyBSZXBsYWNlIERCR19QUklOVF9TVFJJTkdfVkFMVUUgd2l0aCBOVl9Q
UklOVEYyCkBydWxlM0AKZXhwcmVzc2lvbiB4OwpleHByZXNzaW9uIGxpc3QgeTsKQEAKLURCR19Q
UklOVF9TVFJJTkdfVkFMVUUoeCwgeSk7CitOVl9QUklOVEYyKHgsICIlcyAweCV4XG4iLCB5KTsK
Ci8vIFJlcGxhY2UgREJHX1BSSU5UX1NUUklOR19QVFIgd2l0aCBOVl9QUklOVEYyCkBydWxlNEAK
ZXhwcmVzc2lvbiB4OwpleHByZXNzaW9uIGxpc3QgeTsKQEAKLURCR19QUklOVF9TVFJJTkdfUFRS
KHgsIHkpOworTlZfUFJJTlRGMih4LCAiJXMgJXBcbiIsIHkpOwoKLy8gUmVwbGFjZSBEQkdfUFJJ
TlRfU1RSSU5HX1ZBTDY0IHdpdGggTlZfUFJJTlRGMgpAcnVsZTVACmV4cHJlc3Npb24geDsKZXhw
cmVzc2lvbiBsaXN0IHk7CkBACi1EQkdfUFJJTlRfU1RSSU5HX1ZBTDY0KHgsIHkpOworTlZfUFJJ
TlRGMih4LCAiJXMgMHglbGx4XG4iLCB5KTsKCi8vIENvbGxlY3QgYWxsIHRoZSBwcmV2aW91cyBy
dWxlcyBhcyBhIGRlcGVuZGVjeSwgc28gdGhhdCB0aGUgcnVsZXMgYmVsb3cKLy8gY2FuIGRlcGVu
ZCBvbmx5IG9uICJydWxlcyIgaW5zdGVhZCBvZiAicnVsZTEgfHwgcnVsZTIgfHwgLi4uIgpAcnVs
ZXMgZGVwZW5kcyBvbiBydWxlMSB8fCBydWxlMiB8fCBydWxlMyB8fCBydWxlNCB8fCBydWxlNUAK
QEAKTlZfUFJJTlRGMgoKLy8gUmVwbGFjZSB0aGUgREJHX3h4eCBvciBERUJVR0xFVkVMX3h4eCB3
aXRoIExFVkVMX3h4eApAZGVwZW5kcyBvbiBydWxlc0AKQEAKTlZfUFJJTlRGMiguLi4sCi1cKERC
R19MRVZFTF9JTkZPIFx8IERFQlVHTEVWRUxfVFJBQ0VJTkZPIFx8IERCR19MRVZFTF9TRVRVUElO
Rk8gXHwgREVCVUdMRVZFTF9TRVRVUElORk9cKQorTEVWRUxfSU5GTwosIC4uLik7CgpAZGVwZW5k
cyBvbiBydWxlc0AKQEAKTlZfUFJJTlRGMiguLi4sCi1cKERCR19MRVZFTF9VU0VSRVJST1JTIFx8
IERFQlVHTEVWRUxfVVNFUkVSUk9SU1wpCitMRVZFTF9OT1RJQ0UKLCAuLi4pOwoKQGRlcGVuZHMg
b24gcnVsZXNACkBACk5WX1BSSU5URjIoLi4uLAotXChEQkdfTEVWRUxfV0FSTklOR1MgXHwgREVC
VUdMRVZFTF9XQVJOSU5HU1wpCitMRVZFTF9XQVJOSU5HCiwgLi4uKTsKCkBkZXBlbmRzIG9uIHJ1
bGVzQApAQApOVl9QUklOVEYyKC4uLiwKLVwoREJHX0xFVkVMX0VSUk9SUyBcfCBERUJVR0xFVkVM
X0VSUk9SU1wpCitMRVZFTF9FUlJPUgosIC4uLik7CgovLyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCgovLyBVc2UgUHl0aG9uIHRvIGNsZWFuIHVwIHRoZSBzdHJpbmcgbGl0ZXJhbHMu
Ci8vIENvbW1lbnRzIGFyZSBzdGlsbCBDLXN0eWxlIHRob3VnaApAciBkZXBlbmRzIG9uIHJ1bGVz
QApleHByZXNzaW9uIHg7CmNvbnN0YW50IGNoYXJbXSBjOwpwb3NpdGlvbiBwMSwgcDI7CkBACk5W
X1BSSU5URjIoeCwgYywgLi4uKQoKQHNjcmlwdDpweXRob24gc0AKYyA8PCByLmM7CmMyOwpwMSA8
PCByLnAxOwpwMiA8PCByLnAyOwpAQAppbXBvcnQgcmUKCnByaW50ICdwMT0nLCBwMQpwcmludCAn
cDI9JywgcDIKLy8gQ29udmVydCBhIG1hbGZvcm1lZCBtdWx0aS1saW5lIHN0cmluZyBsaXRlcmFs
IGludG8gb25lIGxpbmUKLy8gQ29jY2luZWxsZSBzb21ldGltZXMgdGFrZXMgY2FyZSBvZiB0aGlz
IGZvciB1cywgYnV0IHNvbWV0aW1lcyBpdCBkb2Vzbid0CmMgPSByZS5zdWIocidcXFxuWyBdKics
ICcnLCBjLCByZS5ET1RBTEwpCgovLyBDb21iaW5lICJ4eHgiICJ5eXkiIGludG8gInh4eHl5eSIK
d2hpbGUgVHJ1ZToKICAgIG0gPSByZS5tYXRjaChyJyguKikiKFteIl0rKSIgIiguKiknLCBjKQog
ICAgaWYgbm90IG06CglicmVhawogICAgYyA9ICclcyIlcyVzJyAlIChtLmdyb3VwKDEpLCBtLmdy
b3VwKDIpLCBtLmdyb3VwKDMpKQoKLy8gRmluYWxseSwgcmVtb3ZlIHRoZSAiTlhYWDogIiBwcmVm
aXgKYyA9IHJlLnN1YihyJyJOW1wtQS1aXStbXDogXSonLCAnIicsIGMsIDEpCmNvY2NpbmVsbGUu
YzIgPSBjCgpAZGVwZW5kcyBvbiBydWxlc0AKZXhwcmVzc2lvbiB4Owpjb25zdGFudCBjaGFyW10g
ci5jOwppZGVudGlmaWVyIHMuYzI7CkBACk5WX1BSSU5URjIoeCwKLWMKK2MyCiwuLi4pCgovLyAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgovLyBMb29rIGZvciBOVl9QUklOVEYyIGNh
bGxzIHRoYXQgaGF2ZSBfX0ZVTkNUSU9OX18gb3IgX19mdW5jX18gYXMgdGhlIGZpcnN0IHBhcmFt
ZXRlcgpAcjIgZGVwZW5kcyBvbiBydWxlc0AKY29uc3RhbnQgY2hhcltdIGM7CmV4cHJlc3Npb24g
eDsKc3ltYm9sIF9fZnVuY19fOwpAQApOVl9QUklOVEYyKHgsIGMsIF9fRlVOQ1RJT05fXywgLi4u
KQoKLy8gR2V0IHJpZCBvZiBfX0ZVTkNUSU9OX18gYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgc3Ry
aW5nCkBzY3JpcHQ6cHl0aG9uIHMyQApjIDw8IHIyLmM7CmMyOwpAQAppbXBvcnQgcmUKY29jY2lu
ZWxsZS5jMiA9IHJlLnN1YignJXNbOiBdKicsICcnLCBjLCAxKQoKQGRlcGVuZHMgb24gcnVsZXNA
CmV4cHJlc3Npb24geDsKY29uc3RhbnQgY2hhcltdIHIyLmM7CmlkZW50aWZpZXIgczIuYzI7CkBA
Ck5WX1BSSU5URjIoeCwKLWMsIF9fRlVOQ1RJT05fXworYzIKLC4uLik7CgovLyAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCgovLyBMb29rIGZvciBOVl9QUklOVEYyIGNhbGxzIHRoYXQg
aGF2ZSBfX0ZVTkNUSU9OX18gb3IgX19mdW5jX18gYXMgdGhlIGxhc3QgcGFyYW1ldGVyCkByMyBk
ZXBlbmRzIG9uIHJ1bGVzQApjb25zdGFudCBjaGFyW10gYzsKZXhwcmVzc2lvbiB4OwpzeW1ib2wg
X19mdW5jX187CkBACk5WX1BSSU5URjIoeCwgYywgLi4uLCBfX0ZVTkNUSU9OX18pCgovLyBHZXQg
cmlkIG9mIF9fRlVOQ1RJT05fXyBhdCB0aGUgZW5kIG9mIHRoZSBzdHJpbmcKQHNjcmlwdDpweXRo
b24gczNACmMgPDwgcjMuYzsKYzI7CkBACmltcG9ydCByZQpwcmludCAnU3RhcnQnCi8vIEZpbmQg
dGhlIGxhc3QgWzogXSolcywgYW5kIHJlbW92ZSBpdApwb3MgPSBbaS5zcGFuKCkgZm9yIGkgaW4g
cmUuZmluZGl0ZXIoJ1s6IF0qJXMnLCBjKV1bLTFdCmNvY2NpbmVsbGUuYzIgPSBjWzpwb3NbMF1d
ICsgY1twb3NbMV06XQpwcmludCAnRW5kJwoKQGRlcGVuZHMgb24gcnVsZXNACmV4cHJlc3Npb24g
eDsKY29uc3RhbnQgY2hhcltdIHIzLmM7CmlkZW50aWZpZXIgczMuYzI7CkBACk5WX1BSSU5URjIo
eCwKLWMKK2MyCiwuLi4pOwoKLy8gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKLy8g
TG9vayBmb3IgTlZfUFJJTlRGMiBjYWxscyB0aGF0IGhhdmUgdGhlIGZ1bmN0aW9uIG5hbWUgaW4g
dGhlIHN0cmluZwpAcjQgZGVwZW5kcyBvbiBydWxlc0AKaWRlbnRpZmllciBmdW5jOwpleHByZXNz
aW9uIHg7CmNvbnN0YW50IGNoYXJbXSBjOwpAQApmdW5jKC4uLikgewo8Ky4uLgpOVl9QUklOVEYy
KHgsIGMsIC4uLikKLi4uKz4KfQoKLy8gR2V0IHJpZCBvZiB0aGUgZnVuY3Rpb24gbmFtZSBhdCB0
aGUgYmVnaW5uaW5nIG9mIHRoZSBzdHJpbmcKQHNjcmlwdDpweXRob24gczRACmMgPDwgcjQuYzsK
YzI7CmYgPDwgcjQuZnVuYzsKQEAKaW1wb3J0IHJlCmNvY2NpbmVsbGUuYzIgPSByZS5zdWIoJyIl
c1s6IF0qJyAlIGYsICciJywgYywgMSkKCkBkZXBlbmRzIG9uIHJ1bGVzQApleHByZXNzaW9uIHg7
CmNvbnN0YW50IGNoYXJbXSByNC5jOwppZGVudGlmaWVyIHM0LmMyOwpAQApOVl9QUklOVEYyKHgs
Ci1jCitjMgosLi4uKTsKCi8vIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCi8vIFJl
bW92ZSBhbnkgdW5uZWNlc3NhcnkgYnJhY2VzCi8vQGRlcGVuZHMgb24gcnVsZXNACi8vZXhwcmVz
c2lvbiBsaXN0IHg7Ci8vQEAKLy8tewovL05WX1BSSU5URjIoeCk7Ci8vLX0KCi8vIEZpbmFsbHks
IGNoYW5nZSBOVl9QUklOVDIgdG8gTlZfUFJJTlRGLiAgVGhpcyBoYXMgdGhlIHNpZGUtZWZmZWN0
IG9mCi8vIGFsc28gY29tcHJlc3NpbmcgYWxsIHRoZSBwYXJhbWV0ZXJzIGludG8gYXMgZmV3IGxp
bmVzIGFzIHBvc3NpYmxlLgpAZGVwZW5kcyBvbiBydWxlc0AKZXhwcmVzc2lvbiBsaXN0IHg7CkBA
Ci1OVl9QUklOVEYyKHgpCitOVl9QUklOVEYoeCkK
--000000000000849188057c4a9b8b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--000000000000849188057c4a9b8b--
