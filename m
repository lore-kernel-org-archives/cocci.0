Return-Path: <SRS0=Qlnj=ST=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEDDC282DA
	for <cocci@archiver.kernel.org>; Wed, 17 Apr 2019 07:46:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5130520693
	for <cocci@archiver.kernel.org>; Wed, 17 Apr 2019 07:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dtcZf040"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5130520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3H7ju35019181
          ; Wed, 17 Apr 2019 09:45:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 312B07735;
	Wed, 17 Apr 2019 09:45:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CB07F7725
 for <cocci@systeme.lip6.fr>; Wed, 17 Apr 2019 09:45:53 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3H7jqGF013689
 for <cocci@systeme.lip6.fr>; Wed, 17 Apr 2019 09:45:52 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1555487152;
 bh=QBJILobqJg8Q+dtCzADNHyf9i3lLzD8s/3eAZqCA21c=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=dtcZf040s7H4GJjFU/JhDDhAL+W1T0TbE7HE8ax/rvhfSRuUZs3qks3T2SmEDdcPu
 UjvMCe7Esy31kgzxJSA2F9VwfrxwOvj6WhK+Kauo58JFWXQQRYfXFq5M/zLXu3/mhm
 TxpebZLQnom7Fm1LMFegjpngVgL0UZwBeJvt7C58=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.118.230]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkhUq-1ggEWC1eaq-00aXvG for
 <cocci@systeme.lip6.fr>; Wed, 17 Apr 2019 09:45:52 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <39151ab1-0310-95cb-bbcc-c5edb4a179d9@web.de>
Date: Wed, 17 Apr 2019 09:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:4dyRD4Q4F093xQkCUAQM26NVs1SXlH4sEz8OGnfBbbNK7fjpA7+
 zJI3zttEXsoQXwgZK9126wB0ZntWL1bZ9BFhIgXS71n5Xu//3BlzJFJCguZNzfbpP7DiRTJ
 DMOxQOHPkrD4tGwDdwJ7ypU/6dEbDF6GiwLli6tVOQRcG8IGJPRpopUAEpwPb+QBCuHKrQl
 4KS5IWqs9fJecdp4mI3Gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s/0KFXTJlSs=:D3qK9iJS5cF2MjoEtEC6gr
 qKyj1SY2WrF3iYmMVqPo6432M3IOgbHwQl3DKZN6pmKZgy+oaquqa6c8IOLUD5FdtaNlJXX2V
 6ySrAijctZFuA1aF538iDjgdppvYvOXaNxzhnZjCozx9+/c4Z44CUIbsQSyAq3FTR9mc32i5J
 Giz+ZcPsZDgPPQsbxKHAUTYD1CxykeX7qTbxJFfvJKRnOuxO/MxUuqiqkQ5+08L7K59kvd6Tz
 Iq851q/uNBxpmHNenE/Hf8VavPR+EJQ4WnuAinzecwPBg+HmEGWDCq3vCVvWeCtfYiu+wLWzw
 /cbB+I9dDKT6EbG/P9hebK/i0gC1E0s7HToREUzKSyx/bgADPpZcisHF1pkMrdZCNu+kTzQ8b
 4yHDAEZfnfVUjaoZjsBstNAbWESqdF0uQ9F65DrRmXe+ZTL8Pv0PcG1+c8cj3IhydkYUknM4v
 aOEZnuc9X8fyNHbP6jriJPGTZmi7ISpJgt1f9yPRDO70sqtgn38X5FxzJsEnvzNmHw5SL3Hbm
 b0rin05+n1Nvr4gegzqqqhtGj2AQMNDUxX6OHjvi6sYVdVWpJiNBuKH1etQ4/30xlQey94bBa
 VXPAyfbAXUQiW0lQWAPHWVBpacwP1Y8mqdOL6+khHptXNDQ+4YNZdIrjzdxAQO4O79542vVkT
 xsUtHm0QUt0nRQqQ0gzNOxi4suCEl4qy8DkqneIlbfmikc1ce+JvDJeXloMLFsGZpMCkh3IAF
 tf3+UbtKw3mhACRCpsW61j/C6NIzoEQuks4hkqbG/AafqYGxv8EHDfeateZHp1nZbFOA6ConD
 gapcYJF+sfRgmMQV7XIK464/egy7LIKziVanWDYouV/DcKUSTzkzmQRGB7eoMvyffKee9rAFU
 ySTlnuQB4HipiVao6oU/FjaS3hi3JJxdWuTt4ty1lBUcipVDb+4oVGxXo7B50EyGF141PhFgz
 GAFdr0X1XXA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Apr 2019 09:45:57 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Apr 2019 09:45:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Working with backreferences in SmPL scripts?
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgYW5vdGhlciBzbWFsbCBTbVBMIHNjcmlwdCBvdXQuCgoKQHJl
cGxhY2VtZW50QApleHByZXNzaW9uIGV4OwppZGVudGlmaWVyIHZhcjsKQEAKIHZhcgotICAgPSB2
YXIgKworICAgKz0KICAgICAgICAgICAgZXgKCgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29j
Y2luZWxsZS9Qcm9iZT4gc3BhdGNoIHNpbXBsaWZ5X2FkZGl0aW9uMS5jb2NjaSBUZXN0X2luY3Jl
bWVudDEuYwrigKYKQEAgLTEsNiArMSw2IEBACiBpbnQgbWFpbih2b2lkKQogewogaW50IGNvdW50
ZXIgPSAzOwotY291bnRlciA9IGNvdW50ZXIgKyA1OworY291bnRlciArPSA1OwogcmV0dXJuIGNv
dW50ZXI7CiB9CgoKSSBoYXZlIHJlcGVhdGVkIHRoaXMgdHJhbnNmb3JtYXRpb24gYXBwcm9hY2gg
d2l0aCB0aGUgZm9sbG93aW5nIHNvdXJjZSBjb2RlLgoKCmludCBtYWluKHZvaWQpCnsKaW50IHgg
PSAyLCB5ID0gMzsKeCA9IHkgKyA1OwpyZXR1cm4geDsKfQoKClRoaXMgdGVzdCBleGFtcGxlIGRp
ZCBub3QgcHJlc2VudCBhIGdlbmVyYXRlZCBjaGFuZ2Ugc3VnZ2VzdGlvbi4KSSBmaW5kIHRoYXQg
c3VjaCBhIHJlc3VsdCBjYW4gYmUgaW50ZXJwcmV0ZWQgaW4gdHdvIHdheXMgdGhlbi4KCjEuIFRo
ZSBDb2NjaW5lbGxlIHNvZnR3YXJlIGVuc3VyZWQgdGhhdCB0aGUgc3BlY2lmaWVkIG1ldGF2YXJp
YWJsZSDigJx2YXLigJ0KICAgcmVmZXJyZWQgdG8gdGhlIHNhbWUgc291cmNlIGNvZGUgYXQgYWxs
IHNob3duIHBsYWNlcyB3aXRoIHRoZSBjb25zZXF1ZW5jZQogICB0aGF0IHRoZSB2YXJpYWJsZSDi
gJx54oCdIGNvdWxkIG5vdCBtYXRjaCBpbiB0aGlzIHRlc3QgY2FzZS4KCjIuIEEgcG9zc2libGUg
ZGF0YSBvdXRwdXQgd2FzIG5vdCBkaXNwbGF5ZWQgZGVzcGl0ZSBvZiB0aGUgZGV0YWlsCiAgIHRo
YXQgdGhlIHZhcmlhYmxlIOKAnHnigJ0gaXMgYWxzbyBhbiBpZGVudGlmaWVyIGFjY29yZGluZyB0
byB0aGUgc3ludGF4IG9mCiAgIHRoZSBDIHByb2dyYW1taW5nIGxhbmd1YWdlLgogICBXb3VsZCB0
aGVyZSBiZSBhIG5lZWQgdG8gZXhwcmVzcyBhIHJlbGF0aW9uc2hpcCB0byBhIHByZXZpb3VzIG1h
dGNoCiAgIGJ5IGEga2luZCBvZiBub3RhdGlvbiBmb3IgYmFja3JlZmVyZW5jZXM/CgoKVGhlIHNp
dHVhdGlvbiBjYW4gYmVjb21lIGNoYWxsZW5naW5nIGZvciB0aGUgc2FmZSBoYW5kbGluZyBvZiBh
ZHZhbmNlZApzdGF0ZW1lbnRzIGluIG1vcmUgbWVhbmluZ2Z1bCBzb3VyY2UgZmlsZXMuCgoqIEhv
dyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gaGVscCB3aXRoIHRoZSByZWNvbnNpZGVyYXRpb24KICAo
YW5kIG9jY2FzaW9uYWwgZGVsZXRpb24pIG9mIGR1cGxpY2F0ZSBjb2RlIGJ5IHRoZSBtZWFucyBv
ZgogIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZT8KCiogV291bGQgeW91IGxpa2UgdG8gY2xh
cmlmeSB0aGUgZGVzaXJlZCBzb2Z0d2FyZSBiZWhhdmlvdXIgZm9yIHN1Y2ggdXNlIGNhc2VzPwoK
UmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9z
eXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
