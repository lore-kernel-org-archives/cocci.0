Return-Path: <SRS0=EgY/=SX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63971C10F14
	for <cocci@archiver.kernel.org>; Sun, 21 Apr 2019 16:34:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E412080D
	for <cocci@archiver.kernel.org>; Sun, 21 Apr 2019 16:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="rPyZ/Nq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E412080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3LGXso0000319
          ; Sun, 21 Apr 2019 18:33:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 726FA7719;
	Sun, 21 Apr 2019 18:33:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9991D767F
 for <cocci@systeme.lip6.fr>; Sun, 21 Apr 2019 18:33:52 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3LGXqiG025153
 for <cocci@systeme.lip6.fr>; Sun, 21 Apr 2019 18:33:52 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1555864431;
 bh=sjffoFNxjJf+hCp4fB2dMztcK77G7UWOowKLo5Jq+40=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=rPyZ/Nq0x3pc1u6a0humvd7Yd73RyZqa0Hl9uXvifje4IPHVKBQHqrF25K5NQiX3s
 F+QXFEPXalnlGmf3I9sbIbFIdPQewKnV5hGoVGNpfUNN3TVBRBSch1pPPGM29gLbTx
 GObz2cTk5RnBywW9FNI9aO7SuRKXcEI3dMJMmXVg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.39.184]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M5wkL-1guEFS2XMH-00xtMO for
 <cocci@systeme.lip6.fr>; Sun, 21 Apr 2019 18:33:51 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <05692e9c-69d1-89d3-92b8-8cc0416e8760@web.de>
Date: Sun, 21 Apr 2019 18:33:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:un3K7P4ucp1HLKn5FX9dDuyVcRgBIPOLqc2MKRsg9U4fZ8Grzko
 kOVCpEWUYJVyMXkOiHDKE/wdG5HgY6/k5FRC1KgeEArVOSi3iqnSiTRknWKvwuLh8NpSq6n
 rKgE43tJYC48cffJGYQY/Qxf7lv/LXcspl850XfYuQcj/o3uJFCElOVzABt8MoMF+U8qEST
 JvkWAHd4U7kZOdMhgjDxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u9+eNf1BedA=:uSP4Knm49LXguVpb6FA+dI
 32R9srIYZkGAMTWT9k76GAIXYL7NOl4u7pNCdbJFEz4EUV2vYLD+DPzHMkjutMcbBtohsVQTs
 Lx8QQvFUfrVhzuec+F83NwjTBYMLKaSuG35HbSm1OotR6m9T9ajVlb26/VP6HPqaZxtKuWGJC
 AWTG7QrI3Jeh1nvyKHNPTD8I6aSfGBrGHiUOtNF9L8krVE2DdTLeqP3xbNRvSQUzKgolbasR7
 znbqPquzfakVoiCwG2lLiLql+XtRI5tgLE6lQ87OarYuXXxtLaYWeNJClvH3McCAdXA5uvvxH
 6ZGSzpU+hATE0g7iYR3ErSCTVdjsy6VcBPVRyJIblyE6hqpdd/Q/sP2Hl7OUgMv9JQLr3U7ul
 +B/MqOFVhfwDR7wIQ/vnDDq0yC4GziCzq/GgiIojNh6AkNlNWnF6SKnK8UN4NRGRB5VIcI4b8
 uTfQtiWCqRm0X2ysyF+cucHazDy+ZhlvdbYWmlrQuMblCs8Fa0KfymQbdad4WbNcDsQvMkNA/
 Nlj6hdt+B+ykhm/+FLYq80vCRC3iNZSDw3iAhi6xvs2r+1BVKpXYdYXATsif8zrWSr5OmiVpl
 /MdYWbj52pcx8PQ82I8GucdiBOy1UB0Wh+Pfn+yZclnD+LFIQe2eLfHIiP5UaErr69xSHngDl
 pN1L8xN1FIm4GpcXquNjz5vg9sVIty65gZjorg30OarxtDijgZtUD3yt8dSbmFdQZNPK+hGgj
 5TDbD6rYsSc8FCAid8mir8kOXA8zFtv5vS9sDNUOHatol6xkmLaJd2PUGh58Ib07klYV95gbA
 kFgwSWIuNWhhxDCDq4zBm7wrmYsC/OEceEadY2rjBrC7dyT6ZLO6QdzF5/g3zcnSLHv4IYbbG
 Ef57C+D9K4zkNEetGSs2KoHai/6nuJS6VOOqNZr6DRQhk1IxBxKyIEwuyfW+Uk38E9ENRP8q7
 qC8xHs8J+ZA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 21 Apr 2019 18:33:54 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 21 Apr 2019 18:33:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Navigation for source code positions from error messages
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

SGVsbG8sCgpJIHRyeSB0byBhY2hpZXZlIHNvbWV0aGluZyBhbHNvIGJ5IHRoZSBzcGVjaWZpY2F0
aW9uIG9mIFB5dGhvbiBjb2RlIHdpdGhpbgpzY3JpcHRzIGZvciB0aGUgc2VtYW50aWMgcGF0Y2gg
bGFuZ3VhZ2UuCkl0IGNhbiBoYXBwZW4gdGhlbiB0aGF0IHN1Y2ggY29kZSBjb250YWlucyBxdWVz
dGlvbmFibGUgcGxhY2VzCihiZWNhdXNlIG9mIHVzdWFsIHVwZGF0ZSBjYW5kaWRhdGVzKS4KCkV4
YW1wbGUgZm9yIGEgY29ycmVzcG9uZGluZyBlcnJvciBtZXNzYWdlOgrigKYKICBGaWxlICI8c3Ry
aW5nPiIsIGxpbmUgMTEKU3ludGF4RXJyb3I6IGNhbid0IGFzc2lnbiB0byBmdW5jdGlvbiBjYWxs
CkVycm9yIGluIFB5dGhvbiBzY3JpcHQsIGxpbmUgNDIsIGZpbGUg4oCmCgoKSSBoYXZlIGdvdCBk
aWZmaWN1bHRpZXMgdG8gZm9sbG93IHRoZSBwcm92aWRlZCBsaW5lIG51bWJlcnMuCkNhbiB0aGV5
IGJlbG9uZyB0byBhIFNtUEwgcnVsZSDigJxpbml0aWFsaXpl4oCdIG9yIOKAnGZpbmFsaXpl4oCd
PwpJIGhvcGVkIHRoYXQgdGhlIGVycm9yIHNpdHVhdGlvbiB3b3VsZCBiZWNvbWUgY2xlYXJlciBp
ZiBJIGFkZCBydWxlIG5hbWVzIHRoZXJlLgpCdXQgSSB3b25kZXIgdGhlbiBhZ2FpbiBhYm91dCBp
bmZvcm1hdGlvbiBsaWtlIHRoZSBmb2xsb3dpbmcuCgrigKYKcnVsZSBuYW1lOiBwYXJzZSBlcnJv
cjoK4oCmCiAgd2hvbGUgY29udGVudCA9IEBpbml0aWFsaXplOnB5dGhvbiBzdGFydEAKCgpDYW4g
dGhpcyBzb2Z0d2FyZSBhcmVhIGJlIGltcHJvdmVkPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlz
dApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9s
aXN0aW5mby9jb2NjaQo=
