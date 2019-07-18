Return-Path: <SRS0=WAkC=VP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4441C76195
	for <cocci@archiver.kernel.org>; Thu, 18 Jul 2019 12:55:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106BB2173E
	for <cocci@archiver.kernel.org>; Thu, 18 Jul 2019 12:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cqxvM325"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106BB2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6ICsuBR010588;
	Thu, 18 Jul 2019 14:54:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BC98D7790;
	Thu, 18 Jul 2019 14:54:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 391257780
 for <cocci@systeme.lip6.fr>; Thu, 18 Jul 2019 14:54:55 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6ICspWg023848;
 Thu, 18 Jul 2019 14:54:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1563454477;
 bh=Pr3yCBSMC/eDqRyfZblnMBsouognLzOFVijXQGgUyBw=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=cqxvM325SCT09tSlos8rGwoIVqpPJs6grfbLs8DPNNZ+9T0F8girIZNtCzkj+aeOm
 E379q3meW573mU+8Awsuqo/fQa17Z07x0F7JC5jCVHN/RRVtwUPGlpPuuAjIM4iclH
 7MBbWJcqTC4prEzw2Vot5J31tan+XpHj41TV3f+o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.59.79]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFt4k-1hcWgl0C06-00EyiR; Thu, 18
 Jul 2019 14:54:37 +0200
To: Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
References: <1563246347-7803-1-git-send-email-wen.yang99@zte.com.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dafd7602-09df-2697-508f-99a937280f9d@web.de>
Date: Thu, 18 Jul 2019 14:54:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563246347-7803-1-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-US
X-Provags-ID: V03:K1:gYGXOdPpFlCXP0jDk5J3KYJyJRwJLG/fOvaS8+TggfZMJocRCdU
 1ApSWshMyc5f8UXo3P5Zdbt3sU6TTW8Nn7O7o9gK099DSALBaCzE4AI9xjyDVJrBel1upRc
 826xAQ3VpjP9FzWczq2kXxXzSc3TdspPrTevWK5YBGWjIcZpicTYalv14s9EqfbYqjzlszl
 1haqQPxbvmshXVn9o3EtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hLRkVc+TU2g=:atdp2aJV4yeOcdlzFETyAx
 H3nA2NOft9kbQckg8oYOS6ABL15/zaGy1kOK6L7Gs1kyhAHLobnBc/F5URPpThn8M7WuLKwoK
 jfM8sBoiZcuBQtz49rn0KSZjvC4k0rXuTkzdBcZBW09+6Ra44SgL4x2tHYZ3osaIp8dfkJ2ZL
 UjoLsIgh89+7yD5GGlYZWBeFDQwvVw2w032PfJQcmVMzuXaVlHM4m80zfnU2TjsrDSKAVYwmi
 V2XdqcbfDGdoa9qce9zaGOFuYGIOjl8XbYnBhzXimLh+2G3wovc53dn3Lyrmd5Skj5kFWtcTn
 rVRpw+hwcc7t1TfoEt6lYzQFDsYxZXotzYzGtjBK7zHyH9diRbL1z5NfjgCXlLkS/sBVbhyB3
 oo7c3W8iTPmYfZ6iKRtOwoPA09lD912CYsIEzbpxPAqlVH+Y1m7q1zdyu9OL2pQmCiW834uSl
 MHlCZyOWVfrPU7n0Lq4jX0tq3dlwvOWfdSsWgGDjybuNhEVAw4QXsC2EjblFciCrxZYGU64BX
 6XAjfyFOepfaEzPBtd/6bV4D1DsE49x1L8vA3a3l4PmYM4AQH0XIGlwlYMjK0MRy2EgQDPsmO
 naI/XRt44coTAbtlbrv+pd5Dmublvih/jUohKREdb24DYZSmzGnfZlgfDxjEKXwpWAwUqFC0a
 T67M34DT0GSWN7QL3uq80ihQ7fBN3AVoFfw8DPqQsy3wbzkeUNV2DA0l/EXxDDOUkwKT0z5RJ
 Bl4WoYp26pXU/fqP2kKkoG5zTuewBkEmw8TLtUCo0x4ETk75n8DG4BvrLNlPOQKV7COdopnXT
 9A1uFsgEjojTiXbrGUo8zCzHLcchBddwcvXyKOSXE6iDoQZ3nf4eV9hX/FocmJWndphB+v5IM
 NrwlqrqFHmYh/lmx/DwxJsQRXRQpq5UVuLgEj9d5fOnupVdkLDkA4TaxZxmsTzRZuHFW/q70r
 TFc+J6KPMtX5Bd38+oXsYZKnLSX2YLtrJZ4TaLi1BK1zQBTaJ2wyrrCyttOLn0Dz7DRqNuUWI
 IoDnvXmhgYELLw4xfqhSYxbeHjBEztCJB3IsxbkZoRednbWCubPWRjd9S43kpOOsSlBwk8HHF
 p51AOrG4Hfydlpr/PSnNNyfV07jUZFxLOaC
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 18 Jul 2019 14:54:58 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 18 Jul 2019 14:54:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>
Subject: Re: [Cocci]
 =?utf-8?q?=5Bv3=5D_Coccinelle=3A_semantic_code_search_for?=
 =?utf-8?b?IOKAnHVzZSBhZnRlciDigKbigJ0=?=
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

PiBGaW5hbGx5LCB0aGlzIHBhdGNoIGZpbmRzIHVzZS1hZnRlci1mcmVlIGlzc3VlcyBmb3IgYSBu
b2RlLgo+IChpbXBsZW1lbnRlZCBieSB0aGUgcl91c2VfYWZ0ZXJfcHV0IHJ1bGUpCgpJIHN1Z2dl
c3QgdG8gdGFrZSBhbm90aGVyIGxvb2sgYWxzbyBhdCBpbmZvcm1hdGlvbiBmcm9tIGEgY2xhcmlm
aWNhdGlvbiBhdHRlbXB0Cm9uIGEgdG9waWMgbGlrZSDigJxDaGVja2luZyBzdGF0ZW1lbnQgb3Jk
ZXIgZm9yIHBhdGNoIGdlbmVyYXRpb24gd2l0aCBTbVBMIHN1cHBvcnTigJ0uCmh0dHBzOi8vc3lz
dGVtZS5saXA2LmZyL3BpcGVybWFpbC9jb2NjaS8yMDE3LVNlcHRlbWJlci8wMDQ0ODMuaHRtbApo
dHRwczovL2xvcmUua2VybmVsLm9yZy9jb2NjaS9hbHBpbmUuREVCLjIuMjAuMTcwOTA3MTUxOTI0
MC4zMTY4QGhhZHJpZW4vCgpVbmRlciB3aGljaCBjaXJjdW1zdGFuY2VzIHdpbGwgaXQgYmVjb21l
IHNhZmVyIHRvIGRldmVsb3AgU21QTCBzY3JpcHQgdmFyaWFudHMKZm9yIHN1Y2ggc291cmNlIGNv
ZGUgc2VhcmNoIHBhdHRlcm5zPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0
ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2Nj
aQo=
