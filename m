Return-Path: <SRS0=/zSI=Z4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0854C43603
	for <cocci@archiver.kernel.org>; Fri,  6 Dec 2019 19:37:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542F6205ED
	for <cocci@archiver.kernel.org>; Fri,  6 Dec 2019 19:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="pwIM7oku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542F6205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB6JarSd009690;
	Fri, 6 Dec 2019 20:36:53 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 234B177D9;
	Fri,  6 Dec 2019 20:36:53 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B880577D8
 for <cocci@systeme.lip6.fr>; Fri,  6 Dec 2019 20:36:51 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB6JapbY003057
 for <cocci@systeme.lip6.fr>; Fri, 6 Dec 2019 20:36:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575661010;
 bh=yICeQt5ccZ/G4sjWMOma6Fv9upciM3dRkgDVVj0vBSc=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=pwIM7okusgnQwxjT2j2e6SERE8EdAwPvQv/9x7hQ3Q9mBK8/hurKXysImFQMaTc1A
 4Ex9Gc2fOkfq5WfCsdAoEWpl2FJnDBNiKRVCzNVLQc4idnG9shNVsHMmu0iG4iZ0Mk
 POFloBtFNiZoFimeyR+AiOS+8FRRFtJ/Sv5f4GoM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.146.60]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2dTd-1hnocJ1VDh-00sPcu; Fri, 06
 Dec 2019 20:36:50 +0100
To: stracelabs@gmail.com
References: <CABvP5W0QkSgJRZRL4xu-DdtQ0RKkQuR-5wVn2QhvjUZCZVooUA@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2fd55ca1-c959-eb56-10b1-d01627464276@web.de>
Date: Fri, 6 Dec 2019 20:36:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABvP5W0QkSgJRZRL4xu-DdtQ0RKkQuR-5wVn2QhvjUZCZVooUA@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:kdmv+oWk8zuzPkEVmmZQ27G8Em4EWp0I3OkL1NnWxu7jY8sT94d
 1omVtyQcWjxWmP1P3Zep6L7wFk1raDNkltNc7ARL021/wXuW5vXJcy/cF/mW73j2HbJdKPP
 kUFjqjFr3zuUNtgtBLkPJsm8/Rc031YpyW+cEJJaZf2pEDfzQwhrMd3YqC3LA5++PqXt4GZ
 08atThaLyrTcQAqNQRLGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gR6nVadUZi8=:D8F5/txgOCMDGAwwEt9VGZ
 hh2ba1ombNgbCJqGrMcr4scZp0BlhaSeX4bAGw29/jsBaMElTQ0ns6C1hGD9EYXhe3z4BVznj
 rTWg5dk+91TmyY6vtBQPKI/Q6ywJDGVXQTpUf6n0hbMHqPFH6nT0hvHZP6Pbe+VKAOcIHGzvc
 CjpKuUM4uItKfpSdDxub027z3fugjdU8Fh2al0KOXIk/o9tGgT7r1cTm/dVQcyJiAod7vSkR/
 DbJUjMjjH0Jigojn1MldPu1gvql9uz0DJ7bdd3f679RT+LxoyMks4Lpud0I5NNl5u6ffCBWTr
 ALdTh6obMJgjjBeebBTW61wgsWSfeCBmMRF+TJsdq6cVN+9Wupl/H6CnJd0sY6R5J8gPd4+MM
 AIj8hU06enA7VLfU9MZ3luSyBo3e7RhC0JsAZzkrEtttG3ReRh5YH+0WUvi8Q7RdH7kIaRito
 sgvwq8L92j5eRxkBaaMn3HNLjX7n71eCMLf7Bfg/Ik8nzDaN4uqOLktohrFjI+6+2N2dfAA1T
 IBtlbBdfy8pWph7EVFFJV4L7pv/RtcOfz1SwQGPYdHeAOnG4H3mKGkC4kai4cSOjymy+n2ZQd
 c+ktay7WexwQ2GKf4usw3XW92aKx/jpJE3VqNl2ykiLATf2MqkjehpH/tLEwwqkZenXtibm+5
 PyFAUIWFowXtQ19lVIpQcfOcb5bej0xqaFG3EMgJ3XHfjXe7FnRg7/ryRvJI3Of5fh6Og7aEl
 NGUP1vi2MsLoI4X/S4XYZ8xRTJr0UOco1/ozDqX0WTSd5aEkzzz/zUQQrlLrOfMPuMB0+qMAK
 HCtAnDo2PbQ1whJL9v0Wdvs1FRkrtuf7k2yzdi8SGmUTs5see/iWbMrt1jBu/Lncv6X4jFBlC
 YyCX6yFDubJn87YTVsogiPejxVSi645MKBSy7ieRI5ZlrzHOTrAwdiHoqOWy6M0L4POsi3kOn
 NhOfEGpLo+cvBD0K8gTj18q96FRU/IKo1cp2nmC3pJrjdQEWucjLGBe5ZSUTP3k8sHpILeXq1
 gbC0KJKRKi+MgDLApBQq+TjJqozAZD5tfYc/FhWL3f2VviCI1agFBdhTiA28mhV5cxiO+GBxJ
 HU6FXF47J0nnc41JwbvQIO3yJ7XcYxIhdAnhE/pbgjn214lcbaKYkeNUJ0lP4B0VR3wDv3uzQ
 N/FbKdjDDjgyBef2ezIQtEG1z3cuTtVc3ihefseTQdj/vjniA+Bzm55QVoMuoWGnTyE64J2vj
 XMFAubAeRCdHp3/wAvSNXB2Gje0Mrq4yK2EC7vwNJPzgwcdiyTfbmaUKFSGs=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 06 Dec 2019 20:36:53 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 06 Dec 2019 20:36:51 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Changing format string usage with SmPL?
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

PiBUaGVyZWZvcmUsIEkgY291bGQgZmluZCB0aGUgJWZtdCBhbmQgcmVwbGFjZSBieSB3aGF0ZXZl
ciBJIHdhbnQgYmFzZWQgb24KPiB0aGUgKmV4cHJlc3Npb24tbGlzdC4gKmN1cnJlbnRseSBzdHJ1
Z2dsZWQgb24gdGhhdC4KCkFyZSB5b3UgYWxzbyBsb29raW5nIGZvciBkaXJlY3Qgc3VwcG9ydCBv
ZiBzdWNoIGV4cHJlc3Npb24gbGlzdHMgYnkKQ29jY2luZWxsZSdzIHByb2dyYW1taW5nIGludGVy
ZmFjZSAoc2VlIGFsc28g4oCcbWFuIGNvY2NpbGli4oCdKT8KClJlZ2FyZHMsCk1hcmt1cwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5n
IGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxt
YW4vbGlzdGluZm8vY29jY2kK
