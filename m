Return-Path: <SRS0=mX9+=ZV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2982AC432C0
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 17:45:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7471821736
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 17:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Mj1EWItj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7471821736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATHjfFi019420;
	Fri, 29 Nov 2019 18:45:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C202677D4;
	Fri, 29 Nov 2019 18:45:41 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7B9FF77D2
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 18:45:40 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATHjcDX001221
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 18:45:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575049537;
 bh=HqBzLClRHIt29s0V6dfvR2JrIOp/OFuay0tLteTVHa4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Mj1EWItjH7D3om6LfAF+4TPgpkWj2WBCjGilbaOHSg/lVYla1ClejbjUkDFO5MK6K
 VM3TNGINsOunrbXkM8eSBHQTxmS5VKXXvwUsh4zYtsGJkDKQooUw7M19lWLrKItAUF
 0A3T6l+a06pcgJO9w3U6dXSOTZWSYFBVjjxr4fXc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.90.162]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6UxL-1hqrv8067H-00yUce; Fri, 29
 Nov 2019 18:45:37 +0100
To: stracelabs@gmail.com
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
 <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
 <509ffde0-ec26-a58c-d424-6910bc8e7473@web.de>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
 <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
 <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
 <9e9f6596-1b8d-dc4f-86cf-21094200809d@web.de>
 <CABvP5W1HPdE8=h2LGDo4etG2oWzi7DnycJczu=zVr+AKOamVdA@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <61f49d82-6e8e-1d8c-ce63-f395ec22c9bd@web.de>
Date: Fri, 29 Nov 2019 18:45:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABvP5W1HPdE8=h2LGDo4etG2oWzi7DnycJczu=zVr+AKOamVdA@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:QbcDcrtNOngJIEPgKcyIyhvEmrsr2HeYKNk4y0idITbzLcGAMfR
 pGZAek0mlKM+NhtNGFz3nfPsebMY5rwWKLZF+kdlC9LC1/Oy/WmjzPJgaCyQTcAOZcEYgXw
 DlLL8uddhTpXbi1Dc+xZpB+sW4+uDivuEc/fphqvH96NFv+4LssPPKsezRaNvIAqpnwXRab
 VhjJUmRAl5GySgkErYHug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2n+Rvr2yeaI=:pA8mkFX+mxxEyUs9/JWjig
 Qy1141LHL1U+H/QKF48kV3ok/2hnVIpQzG3EPfvidUDPyKfPWq9JeLIIA6MCTWeocB8txHU0k
 5kT13Mp8nKwPE8OxfYvIdwNkLFP1PXXIWRakoPK7jxxTJPpxzQVxpMrHJEt+7TXayPVziZRkO
 UVOxrG/ebMb5yoyNKcycpAyOJm4VNnfq/0lWZD75iDGFUTYbqChSYajiSsdWqkFunYGLkS46A
 KYkOHj6rOFfHmWA/4k7F1s2fzGyvw9lrHSwzt5H2HBVRhjzCpVqJSXkIszjEnHCEUEhXD1D96
 EjtnIRwTqBLD6kMQFp2HiIDozxLl6Xl0/ino7VbZQzp1px9Zm98GI4/52m09m3ItlZLro9Xev
 PkGEEb7cYYXVk9GeRkOG+h4/Gyr3bn6QIABBRxveA6UmnxJ8CmB5HgaWoEyEhZKScLh5yE0YL
 zlt+Rjhu8RbGXsEryalpIS8IERbHSoyMlcc/E3YygkvKz2G20y0ZYBli598Nz37TfxH4s0pKw
 ebthjvaHuKcDfx+HcqenSDMpcyBB5B/CtCrj0q0NmOIyo1L+u9p54TIZEc/0HR4n4pu6d7z7E
 pFp+TzGGhUATaM1Au8DFuypjfiMz4lQDxR3uK74kSxxU9RR0ifcwrRWmPU5Momdw20UO7lj3s
 lLLMzNii1cRnswa/Ywa154IQ/KXE5wSIO+QC4v0t480guiCLJGm/RYNiJR5Dc9OS8ZtTONngr
 mL6QfxYd17ya8E6UfQmrO/4jXCTs3g8FGFaOzrmUfSlVMUmud8PJA0VE/XeURi2RiZRcDoHIp
 Z6EPUO+exMMMvnnLsOcMSUR5T8QrVjRGj2G+xSBoEEprIyzCy4fE4YS6pIcuDerWkfmBt5Xs7
 maxHdzHF79adePSgVswwJn4qqV9ikvtFKeZp1KIxLI6IxCiYe+CzmgvD6fAl/SVMkYgH3U6p8
 ANpH3damahQbTjJ9hBttRgWezRXaN8PFsaUyIp3edVeGHqM6SHhUK5pY+EHRLPhm5xB+1Ulpo
 8TmoYha9bgYosRdsnTmd4FU4f9MeEC/xlkFMU6SCkKSZFmoIiaC2OLQdHG1/Jl9KJCucDVDDP
 haKVvkHR6U/eY5hl7CbzaEbGMjMtBk+t68d600qDaMT+oLXMmQ90Ly2B9tpAnR5x3nAjNpBkl
 fwlE6bH/e7H37NI+3HKGGuAJuCTqm28+p8dK1a+LBW8MVPrhN2WNHA7QS1AXnj7WZhn8zO640
 K6k3PVKbxc3tVLYub+NjejiaV3oqlDxYoqmalaUWMOGmWrWQmXIM4NMJ5sRE=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 Nov 2019 18:45:42 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 29 Nov 2019 18:45:38 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Replacing printf() parameters according to used data
 types
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

PiAgICAgSSBzdWdnZXN0IHRvIHRha2UgYW5vdGhlciBsb29rIGF0IHByZXNlbnRlZCBpbXBsZW1l
bnRhdGlvbiBkZXRhaWxzLgo+Cj4gSSBkaWQgaXQsCgpTdWNoIGEgdHJ5IGlzIGdlbmVyYWxseSBu
aWNlLgoKCj4gZXZlbiBkaWdnaW5nIHRoZSBncmFtbWFyIGFuZCBBTEwgc2FtcGxlcyBhbmQgZGlk
bid0IGZpbmQgYW55dGhpbmcgc2ltaWxhcgo+IHRvIGhhbmRsZSBmb3JtYXQgc3RyaW5ncyB3aXRo
IG11bHRpcGxlIHBhcmFtZXRlcnMgYXMgbWVudGlvbmVkLgoKQ2FuIHRoaXMgdmlldyB0cmlnZ2Vy
IG9wcG9ydHVuaXRpZXMgdG8gaW1wcm92ZSBjb3JyZXNwb25kaW5nIGNsYXJpZmljYXRpb24gYXR0
ZW1wdHM/CgoKPiAgICAgPiBub3QgZm9ywqAqbXlfcHJpbnRmKCIlZCBoZXJlIGFsc28sIHR0PSVz
IHwgJXMgYW5kICVtXG4iLCBpZCwgaDItPm5hbWUsIGgyLT5uYW1lLCBzMik7Kgo+Cj4gICAgIFN1
Y2ggYSBmdW5jdGlvbiBjYWxsIGlzIHVzaW5nIG1vcmUgcGFyYW1ldGVycy4gV291bGQgeW91IGdl
dCBpbnRvCj4gICAgIHRoZSBtb29kIHRoZW4gdG8gc3BlY2lmeSBhZGRpdGlvbmFsIG1ldGF2YXJp
YWJsZXMgaW4gU21QTCBzY3JpcHQgdmFyaWFudHM/Cj4KPiBJIGNhbid0IGJlY2F1c2UgdGhlIGNh
bGxzIGFyb3VuZCB0aGUgY29kZSBoYXZlIGRpZmZlcmVudCB1c2VzIHdpdGggZGlmZmVyZW50IHZh
cmlhbnRzLsKgCgpJIHN1Z2dlc3QgdG8gcmVjb25zaWRlciB5b3VyIGNvbmNsdXNpb24uCkhvdyB3
aWxsIGNvcnJlc3BvbmRpbmcgc29mdHdhcmUgZGV2ZWxvcG1lbnQgZXhwZXJpbWVudHMgZXZvbHZl
PwoKCj4gICAgIEhvdyBvZnRlbiBkbyB5b3UgZmlkZGxlIHdpdGggc291cmNlIGNvZGUgdHJhbnNm
b3JtYXRpb25zIGFyb3VuZAo+ICAgICBmb3JtYXQgc3RyaW5ncz8KPgo+IFdlbGwsIEkndmUgdXNl
ZCBpdCBiZWZvcmUgYnV0IGZvciBtZSwgaXQgaXMgdGhlIGZpcnN0ICJjb21wbGV4IiBjYXNlCj4g
dGhhdCBJIGFtIHdvcmtpbmcgb24uCgpJIGhvcGUgdGhhdCBzdWNoIGluZm9ybWF0aW9uIGNhbiBo
ZWxwIGFsc28gaW4gb3VyIGNvbW11bmljYXRpb24uCkFyZSB5b3UgbG9va2luZyBmb3IgZnVydGhl
ciBoZWxwIGFjY29yZGluZyB0byBhbiB1c3VhbCBsZWFybmluZyBleHBlcmllbmNlPwoKCj4gZXZl
biBJIHN0aWxsIGRpZ2dpbmcgdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgaG93IHRvIGRvIHRoYXQKCkRv
IHlvdSBmaW5kIHRoZSBhdmFpbGFibGUgc29mdHdhcmUgZG9jdW1lbnRhdGlvbiBoZWxwZnVsPwpo
dHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2Jsb2IvZWQxZWI4ZTA2Zjgw
MDczOWQzOTkyMTU4ZDM2OTQ1YzBjNGM2ZjBjNy9kb2NzL21hbnVhbC9jb2NjaV9zeW50YXgudGV4
I0wzMzcKCgo+IGJ1dCBJIHN0aWxsIG5vdCBzdXJlIGlmIHRoZSBDb2NjZWxpbm5lIGlzIGNhcGFi
bGUgdG8gZG8gdGhhdCB5ZXMgb3Igbm8uCgpIb3cgd291bGQgeW91IGxpa2UgdG8gcmVkdWNlIGlu
dm9sdmVkIHVuY2VydGFpbnR5PwoKV2hpY2ggbGV2ZWwgb2YgdW5kZXJzdGFuZGluZyBkaWQgeW91
IGFjaGlldmUgZm9yIHRoZSBmb2xsb3dpbmcgZnVuY3Rpb25hbGl0eQpzbyBmYXI/CiogU21QTCBl
bGxpcHNpcwoqIFNtUEwgZGlzanVuY3Rpb24KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29j
Y2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGlu
Zm8vY29jY2kK
