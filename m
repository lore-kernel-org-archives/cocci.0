Return-Path: <SRS0=bjme=D6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443ADC4363A
	for <cocci@archiver.kernel.org>; Fri, 23 Oct 2020 15:09:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D615208B6
	for <cocci@archiver.kernel.org>; Fri, 23 Oct 2020 15:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IY5uWK1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D615208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09NF91aQ028762;
	Fri, 23 Oct 2020 17:09:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C999075B4;
	Fri, 23 Oct 2020 17:09:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E4EBF45D8
 for <cocci@systeme.lip6.fr>; Fri, 23 Oct 2020 17:00:58 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09NF0wxZ016904
 for <cocci@systeme.lip6.fr>; Fri, 23 Oct 2020 17:00:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603465257;
 bh=r7G9EorEfD35PyUy5KD9vrM2KvWlc2q2dFxTEfFVNrw=;
 h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
 b=IY5uWK1/+I3vvX+nFH1geFAaBD7GbTFk3+E4Fjxuiz16RYKVM1AXOuOFL0ybkzcsm
 5eZKzOUwv87PjGocX7S2eL0jh59AWSBYQK93F9P104VnVuWV4x7FogbsxB0P+GDybn
 kwDCFQWRg+loA0yO67ZbuGs0VRHA50PyjFTuDI48=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.17.186]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqoAk-1jrg0B24N0-00eIq7; Fri, 23
 Oct 2020 17:00:57 +0200
To: Mansour Moufid <mansourmoufid@gmail.com>
References: <CALogXGVr7OYtWhrsZg7gnO+czzu6eM_GGThYSCYezgUmVjwqZA@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <13dbaaf7-6655-7939-e173-310c45d1878e@web.de>
Date: Fri, 23 Oct 2020 17:00:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CALogXGVr7OYtWhrsZg7gnO+czzu6eM_GGThYSCYezgUmVjwqZA@mail.gmail.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:2yly8rQpIEoTs8OHEHR/swrl5XbXSWrvBUlRcs2cCh7iVrOQ5q+
 +idjH/7u/NsT52UTBFK3mGVvvrHEjEfTl7numUTYkXFaWGjH2hlBzFERVeOED/5M9NNwC7Y
 cjKaRPjOojd1IioYbWODHhaIeG2nX2Af9V7gPIay1BjKw9TxTbal3bjQrTo9x2bsNRMw9wu
 aVSST6xKePIns5JgeG+nQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fBGanoBVBJs=:8LKLUztd1imLVu2qhfRiz2
 0h5mFELcu6raFro86EWhprwBD7d7x0ZMHXXkUHR/9sS+VHC2MUNuv6BdLRvPI2epjIPqVURB6
 sMX+pItUaDj5sBl91DxXPWJdGV5YFWB/FddXTYs+6EZ+BPN6XZQG8hg0omk7Xa8D0uzlVcUAz
 owWub/FMBqU9bAsHkSQH6zO3t5vnv7lIvancpPwgsdfoKK+nvZsf4bf+gWw64JZo87+AEN6fR
 RZQFgCAEn/zq5DNYKii+1h+ay1hkxd+IUkQTMgv91dfEb8Msff6EpSXfnSMx9Ng4XMgqXUiP2
 f/NjYWdzq+X3rsLThGWw5mOSOBNPsrjV8BeFoc1wF949JupEx24OCzzcWwH5ivBMHuFWy58Qy
 z3bp9bdGax3PuQeZT8VTSfv5/+41Xls9nl1mFeWwXd6b6zMvH/e7lKOswkC9mmqeAl/ltultv
 86r4udLz1oB2Oz2Ncpi41PpewbmO/cB8jgC8W1Hhd4OzKrw3cweEnak7T8w+N5vgir/rF+qES
 gjwymKrc4tp3srwY6Y6sZh8N2zL8OzFz9umt2uRHHcmQVeWXFctlj3qAL8mcvp7/y28Thm5ox
 I4xV73NrQnir05WJ+wGggsC+rZgJlzWJn4XU2kEHLvU2KXqopVAFx+YSlIu4UDiiI2qAcpDWv
 cz6AJKEXDSgJw0rISiyc4sr4HkX/yVzq/eS7nfmi/8OkAz4tlvKk/+E9PPhxwYDtBi8p7h2Yz
 H+OwMUAeWI7JcYgb1rkKL9OuXAqT13RElXMNnLRnBOCIRf2K2FlK3wemaZ1TqB7VO5ynnbTJ9
 W3RFKeLfbJ/BZi9pNN1B9P/Gj2Fp310DTo5dY47XePtN5AyicY2CWhEdDyuTyj2HHjrNq1RK8
 2UXG34ERg7J/R6pvUggg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 23 Oct 2020 17:09:02 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 23 Oct 2020 17:00:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 23 Oct 2020 17:09:00 +0200
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Adjusting replacement lists with SmPL?
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

PiBJJ2QgbGlrZSB0byBhZGQgYSBzdGF0ZW1lbnQgYWZ0ZXIgYW5vdGhlciB3aXRoaW4gYSBwcmVw
cm9jZXNzb3IgZXhwcmVzc2lvbiwKCkhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gcmVmZXIgdG8g
YSDigJwjZGVmaW5lIGRpcmVjdGl2ZeKAnT8KCgo+IGJ1dCBzcGF0Y2ggYWRkcyB0aGUgbGluZSB3
aXRob3V0IGFuIGVzY2FwZSAoYmFja3NsYXNoKS4KCkkgaW1hZ2luZSB0aGF0IHdlIHN0dW1ibGUg
b24gYW5vdGhlciB0YXJnZXQgY29uZmxpY3QgaGVyZS4KaHR0cHM6Ly9naXRodWIuY29tL2NvY2Np
bmVsbGUvY29jY2luZWxsZS9pc3N1ZXMvMTM5CgpEbyB5b3UgcmVhbGx5IHdhbnQgdG8gYWRqdXN0
IGEgYml0IG9mIHRleHQgYWNjb3JkaW5nIHRvIGEgcHJlcHJvY2Vzc2luZyBkZWZpbml0aW9uPwoK
Cj4gICAgICNkZWZpbmUgWChhKSB4KGEpOwo+Cj4gKEkga25vdyB0aGUgYWJvdmUgaXMgbm90IHRl
Y2huaWNhbGx5IGNvcnJlY3QgYnV0IGl0J3Mgc3VwZXIgY29tbW9uLikKCkkgc3R1bWJsZSBvbiB1
bmRlcnN0YW5kaW5nIGRpZmZpY3VsdGllcyBmb3IgdGhpcyBpbmZvcm1hdGlvbi4KV291bGQgeW91
IGxpa2UgdG8gY2xhcmlmeSB0aGUga25vd2xlZGdlIGFib3V0IGNvcnJlY3RuZXNzIGEgYml0IG1v
cmU/CgoKPiAgICAgQEAKPiAgICAgZXhwcmVzc2lvbiBlOwo+ICAgICBAQAo+ICAgICAgICAgeChl
KTsKPiAgICAgKyAgIHkoZSk7CgpIb3cgc2hvdWxkIHRoZSBzY29wZSBiZSBzcGVjaWZpZWQgdGhh
dCBhIGNoYW5nZSBzaG91bGQgYmUgcGVyZm9ybWVkCm9ubHkgZm9yIHByZXByb2Nlc3NvciBjb2Rl
IChyZXBsYWNlbWVudCBsaXN0cyBmb3IgeW91ciB0cmFuc2Zvcm1hdGlvbiBhcHByb2FjaCk/CgoK
PiBJIGNhbiB0aGluayBvZiB0d28gc29sdXRpb25zLCBpZiBhbiBleHByZXNzaW9uIGlzIGluc2lk
ZSBhCj4gcHJlcHJvY2Vzc29yIHN0YXRlbWVudDogYWRkIGEgYmFja3NsYXNoIGJlZm9yZSBldmVy
eSBuZXdsaW5lLCBvciBza2lwCj4gdGhlIG5ld2xpbmUuCgpXb3VsZCB5b3UgbGlrZSB0byBjaG9v
c2UgdGhlIHByZWZlcnJlZCBjb2Rpbmcgc3R5bGUgZm9yIHN1Y2ggYW4gdXNlIGNhc2U/CgpSZWdh
cmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3Rl
bWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
