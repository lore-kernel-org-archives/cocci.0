Return-Path: <SRS0=OUc2=KA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B511C43460
	for <cocci@archiver.kernel.org>; Wed,  5 May 2021 08:58:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BA7613BA
	for <cocci@archiver.kernel.org>; Wed,  5 May 2021 08:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BA7613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1458wh4N002719;
	Wed, 5 May 2021 10:58:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8C7B477DD;
	Wed,  5 May 2021 10:58:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 56D2D3DD8
 for <cocci@systeme.lip6.fr>; Fri, 30 Apr 2021 18:26:14 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13UGQDPP029870
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 30 Apr 2021 18:26:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1619799955;
 bh=xM7j+OV8aiUK2+R/QEx2Vlbi5StDWt01Pzwkw4ysC2A=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=LuUZ3+WMYqVFpk2gWguVey865tzZadLhJqiZrn/nYATtVuwnD8zUUl4wC7wKWo6XQ
 TnHOhTgsMhODE6tn7n61Y1EKr9oNIPZzcvyenvtfVJ7QEf5hoA1hxmhOAmgJyYBax5
 M44HWsq5lTdPW4GWYiVLB0ISs8aQ2+WNBlppsuug=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.73.65]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Letkl-1lE92i0zJn-00qgER; Fri, 30
 Apr 2021 18:25:55 +0200
To: Julia Lawall <Julia.Lawall@inria.fr>, Johan Hovold <johan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix
 <nicolas.palix@imag.fr>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Qilong <zhangqilong3@huawei.com>
References: <20210429174343.2509714-1-Julia.Lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <7c6ef35f-b9ec-face-467b-ac1b29a3a3c3@web.de>
Date: Fri, 30 Apr 2021 18:25:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429174343.2509714-1-Julia.Lawall@inria.fr>
Content-Language: en-GB
X-Provags-ID: V03:K1:WQHhlnyiFSUZPNJ/oGT5+0rBoiNuSZ1qeuwOBePIp6oRQh+H3pr
 xwUnLG8X22cefxQAgbHFQnds9lltpjNWqMLGQV6gw3i9aKOEcbWoWf9RUGJII6OELoV9FG2
 mdzvubhFvId7/4fCsBMWMxWCRLCLoJzW1udjaLmiB74Cxd+E3y1MDxWX3WyBniEAOC8o/6T
 1Q5ZJoMGP6d9MXAMN8iIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EGGiqhxmyoo=:YsJAa4vtoS1BC2rSff5jFP
 PwF7uCgnTr+6IID7977g8DTaG/p8dgCWFLx81/9Zp7kQZSBCNl4sA/rTtk6ZvYFyhhcHcw5Gs
 /aMizZptHkYxOBmwN0cs2iZRhFFWf8PDf8XvM82RpuxlNn0mar1b+giRObr+8XU246lucYZ9U
 Ch7DNLezSzxK2wu2jxu8sR6qy3CbNaM7YPUJ6Lc4hDngBN2g0y79V/RzFwhRqV17DMz2YAQYX
 qXnaaDF0POwPHd7dTVbbqloniciovU3P7jvjM8f8kNwYQLh5G7SnGuSNT2T4iIQ+cA4b6/ka5
 sP9gLqI92gww5xdGaDtkr9aw6+fbh2I3b54V8WO7NUyPmY5N4UFkHfZ+vnts8vWQPdojoFEh3
 Ni6Ku6f1gyngOK+Q3boViROMn8CnwaSFHMRq301qooavIrpTR7mGj5Km70udHilX6ylAvx9cJ
 kV6rT9F+77MNL1hMZW3KOarKpn5vHbogwFTzf+FE18UfX3zVCWutqDBx1TcEF1Ob72iIpv2EA
 +mJ/rHssRnTwH24VebC5T5PnLBJY3QJgeLFUbL33/QsNOV+gxQu1iSZdbRRLzq8+eMFQ/+dkc
 QxqcScOordWiaB1uG+z0jK9Dajho+DgMqyOM3ZpER3QaSJTnOTq2PbeO5vrhgheOjjKpsuAM/
 LHl8XH4oBKNEmVlrFaUNQzfMhEOhv2MKLaTGRjHhfuP2yAlKC6ComHnjOHVoLtPMLtWIU7kzg
 9tEPfedrLaBHQxwHLYP4zyKZX3Te1S7lL286UVZ1LORh07NqOYYNWAEJUtDTUCDeIBcwDBv+f
 5sUuH/PEN2c6MkAF/OXPXylcuofNsETfQqN2tdG4VFNKBh4t5tpL3nT7yjVd4w0RPLKArabFk
 AOTnffxqyW0lg6gFp4ZNdEZAf47hqX2/vqpq0X8jb296E7otJzbPYnuLbhp/T7yo4XNdoRiHQ
 B82E3Z+MgF2+cQMEryNglqGdvumxOnyevaeTf6oKCTNXXK03BMF/KD5/X8DlWGHzXKNIgKeCE
 KTUbfcGnOQ+QCAltZV6SN3LqWBNyshF2cMXOAVGwutCjqnqkbMhKtr7IfLrH2O12trcrVdmRt
 OmOiEYYCVEoc746Et1P97aHs+R3nLO5FBBIqby7aHpNOHguEY9vfv1dkQhIF5k8UobWRP9DQq
 V3LZK9w/jXTkLs5JTa9uq6Jr5CxRyiksTIn2wbmbLbeOnheSNIwlyYPUgawdxGTdX54aFoOns
 NbkD/dszUZqtj/oGJ
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 May 2021 10:58:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 30 Apr 2021 18:26:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 05 May 2021 10:58:42 +0200
Cc: kernel-janitors@vger.kernel.org, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v5] coccinelle: api: semantic patch to use
 pm_runtime_resume_and_get
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

PiB2NTogcHJpbnQgYSBtZXNzYWdlIHdpdGggdGhlIG5ldyBmdW5jdGlvbiBuYW1lLCBhcyBzdWdn
ZXN0ZWQgYnkg4oCmCgpUaGFua3MgZm9yIGFub3RoZXIgc21hbGwgYWRqdXN0bWVudC4KVGh1cyBJ
IGZpbmQgYW4gb3RoZXIgdmVyc2lvbiBudW1iZXIgY29uc2lzdGVudCBpbiB0aGUgcGF0Y2ggc3Vi
amVjdC4KCkRvIHlvdSBjYXJlIHRvIGluZmx1ZW5jZSB0aGUgcnVuIHRpbWUgY2hhcmFjdGVyaXN0
aWNzIGEgYml0IG1vcmUKZm9yIHN1Y2ggYSBzY3JpcHQgdmFyaWFudCBieSByZWR1Y2luZyB0aGUg
bnVtYmVyIG9mIFNtUEwgcnVsZXMKYWNjb3JkaW5nIHRvIHNvZnR3YXJlIGRlc2lnbiBwb3NzaWJp
bGl0aWVzIHdpdGggU21QTCBkaXNqdW5jdGlvbnM/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0
CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xp
c3RpbmZvL2NvY2NpCg==
