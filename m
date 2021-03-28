Return-Path: <SRS0=v4mC=I2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C4DC433E1
	for <cocci@archiver.kernel.org>; Sun, 28 Mar 2021 09:16:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FC961972
	for <cocci@archiver.kernel.org>; Sun, 28 Mar 2021 09:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FC961972
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12S9GXtN008165;
	Sun, 28 Mar 2021 11:16:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0C74D77C4;
	Sun, 28 Mar 2021 11:16:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A4FA63E8A
 for <cocci@systeme.lip6.fr>; Sun, 28 Mar 2021 08:15:23 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12S6FNX8013260
 for <cocci@systeme.lip6.fr>; Sun, 28 Mar 2021 08:15:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1616912123;
 bh=qmJIOkvo67SpQOyrKdqmqDTV4A5XOTc1wkpNexTJ66U=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=B+MViOQZzDIr52/GE+Qhbl02VU7wOSNapxrtpuhaFG0D2yXVitR7qxWKzB9gf/S36
 YlcAOdmU3TdBSrJBkBu2H4a4CTblcGwQP+Ue4Z+JoIAJSynTe65nlKaIg5rtEq0C1b
 HvstOwlkib1VMan7DKNVjAhKRV9b9NBaIu30FCD8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.73.126]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MC1RI-1lHdGM3uUK-008veZ for
 <cocci@systeme.lip6.fr>; Sun, 28 Mar 2021 08:15:23 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <0e878958-6245-a3b2-b892-5b67b1cb598f@web.de>
Date: Sun, 28 Mar 2021 08:15:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:XFlXZw+6RX8fIfj7kc0hiGTDKm6LFOaMwrVvWJBvHIC4nEL6K6i
 SrIPJZMGV2ZcXeLtE4OcoEmqGZEv1k1yIPPx8Rao6Uvo+PmV3iN7WRt+D3TmVdOpqfl1p4N
 JDxWhAXc7bwV1x+4vncme2MwGMt9mRkjKdXhRCkSREHJ/YZJ98mn9nNlwSehwOvO1uN9hQm
 tzoIVgkowl7jrBTuiScDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jm5K4iQwghg=:VTG8W9EQd217vQiYKsVXGu
 CbrfFj8cFuNKBb9D3ddhb/FoF/BwTTXyXYD56vhggYmN3xcjntWFSF7ELDNAyhH8gn48zh3ZS
 kJ9CcE1PA4SomrjQgAu/H7eaj/l2y3XlhvldHOPntV+kv23kGhCziVNjRAFcN34+KSxWI8hu/
 QI2cgKt/MYApCwp13oBFRSoH5NHf6koxRz2gu4IzmtxYzxc3IJJuM5QTMh5asT2LnXuD8ZeRO
 USb+LmdUS8MgyVXSrJFkaTIwauA6VLFG8NnT+bgWF5Nq7+U5xj0yQNzK8svfpdgBTgRda3+P+
 ir3cj7uQJwsbRtatnDrXcLBAWQYAXL51z9YQ25NSI/XOuFu/CFRThAx0LbFNWJ3S0ZYEjVemN
 oFr4KYurRTtXMDjb3ZilQO98Gyy5lRjkiTo7xXVtzWPw8/1GN2opHN6ku+2GlpbYpHJ4kv837
 OTh0qn8qZDw+PRnrxNT9Km4ANidxWwx1UD5kTo65mNkIkL8DeULfSxW3fAnZs++aMGmHWwvUB
 xPsutYUFBhJ5Z/YRQzPVE45O/EWiwmw8d7+DXkt/SJBORHrEKMFh1aztVOQYJOF8Lm4AyZ0Vz
 i/zbZaN7UWhH6bpllqSGUmrOwAW+INr4tGcmMZsii7CgCXJv0dFejaxIr/k4NvUA2K+qADgw/
 +P8ke8lagAK/quUdatUwBBBFLkxRhaGI84Kd++mpcFEx4NIH6IxTCvJK5kBwFodVJ2iLSCLD3
 sMZAnGw9FxOMml7qxyoo4jfm11p57ASBiIgcpg7teAkS7lgoYwdcTyUEEwA4FAITeFdcWBUrg
 8t1eKXG14Wid0Rn65C0kUtmcBG8ktmqz5eaDbi2WvOLkIJH50t9IdyrahCBY4XhHI2b8SB0N1
 7B0/3fg0DuATnsnT4EO7wK0irTJa08NHupr3cn4NrqEHSS0wx8gCIRbfxTWCozMAkxP0mr4ab
 rEAYu1vQGDnrZ1C6xjgTMgFrw9sLs8c4YljIicfqaOs1+1GAyerHnkQ4HWL7fDzTmXe54xzG9
 gOvKs/feawxCXG9pem8I9wrKXW3nCB1u/CEJFjlUCE8TjoFkCj+Z8isU3o2ZjgPZnmH/o/Z7o
 zLIqcb5CGMc8IdEfDufLR6X4RVA/mLzwOGPNmJH3fRUKm1X227eLRYaMdCQUidHyX5Yr1wI4D
 6bV+pg4PcmYaUvXNZekdiMGi2Jym94pEsu1884uirwGtgapvxjfV1k6GwJbd50VFrxUrls8WD
 nT/fUnoHwsTLwaLM2
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 28 Mar 2021 11:16:33 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 28 Mar 2021 08:15:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 28 Mar 2021 11:16:31 +0200
Subject: [Cocci] Searching only for header files with the Coccinelle software
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

SGVsbG8sCgpUaGUgQ29jY2luZWxsZSBzb2Z0d2FyZSBjYW4gc2VhcmNoIGZvciBoZWFkZXIgZmls
ZXMgaW4gYWRkaXRpb24gdG8gc291cmNlIGZpbGVzCmlmIHRoZSBvcHRpb24g4oCcLS1pbmNsdWRl
LWhlYWRlcnPigJ0gd2FzIHNwZWNpZmllZC4KaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUv
Y29jY2luZWxsZS9ibG9iLzI4NzM3NDE5NmRhOGM3Y2ZkMTY5ZTcyMWEyZDIzZjFlNDYyNDIyZjEv
ZG9jcy9tYW51YWwvc3BhdGNoX29wdGlvbnMudGV4I0w0MwoKSG93IGNhbiBpdCBiZSBhY2hpZXZl
ZCB0aGF0IG9ubHkgaGVhZGVyIGZpbGVzIHdpbGwgYmUgc2VhcmNoZWQgYnkgdGhpcyB0b29sCmZv
ciBzcGVjaWFsIHNvdXJjZSBjb2RlIGFuYWx5c2lzIGFuZCB0cmFuc2Zvcm1hdGlvbiBhcHByb2Fj
aGVzPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0
cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
