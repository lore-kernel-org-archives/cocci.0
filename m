Return-Path: <SRS0=FQJD=7Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AFEC433E0
	for <cocci@archiver.kernel.org>; Fri, 12 Jun 2020 12:10:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2149620792
	for <cocci@archiver.kernel.org>; Fri, 12 Jun 2020 12:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="nBGpE4Tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2149620792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05CCAgi8007700;
	Fri, 12 Jun 2020 14:10:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3735544A7;
	Fri, 12 Jun 2020 14:10:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0A0A03BAB
 for <cocci@systeme.lip6.fr>; Fri, 12 Jun 2020 14:10:41 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05CCAeWr005430
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 12 Jun 2020 14:10:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591963839;
 bh=50yf1rgjSBKMRtz7IkSJ4yHpqSpurXQLfBbd2yI3jck=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=nBGpE4TgW+5GNhgR0lcAaHAQ6d5Iakf1v2EWCL8Z3zOGQwpAl37SloCCDJJLKl6mq
 35ltIQ5RWoWh6kSPFIpGT98O+JHstvOHB1R8cRAAC01BbMx23lQ3zdLDAF+DCNPKe9
 OZsz4LZzuHaurYtyOy/oJ0ZzA6nKJo7FwYaFIMik=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.95.40]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjPPs-1j3U043xzG-00kyq0; Fri, 12
 Jun 2020 14:10:39 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
Message-ID: <c1b2ff4b-5d8f-ec79-c02c-958cb54c27c5@web.de>
Date: Fri, 12 Jun 2020 14:10:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:hufinwPi8V2TlO8EjDvXtFPtBV3uPvShnSAD6HvMQyx2p9WnEVp
 6FGoXUgMzOvT17fXt4CMm30lPvkeE7MdaAPWzro3p0skXtKA4dF3Y8RUIGb++PfqiCcWHSF
 bMUm4IEf9U3HBBnAAQB64rwJlS996cOpL1kbslm4dTmm3N45T5p/QYKiqSh4bsodHxCVQIf
 2OxicaWK/p1bCJUqrewGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:31u4vHu4VNw=:Ah5hCmkZMF0cshLC5iIQke
 g6UQWCfeMUQUTYlvvPaj1W+Ll5MqD/N/VQJFL8OzK0hZys8LGW4JXCfSBop8aWHG/6+dag+PK
 XiArNVZq5VpaZ1Hjui9A+WXs/t3BPCBcdEKH9j9b0V6ii9Pn01QWFvvwZttHkiGREcs/jw8Gn
 OeIrirmcMcgfJH3z5uMUAX1KV7oOQjb2BuGkrM74Ko4csoPkAneAZ4jorEquWzg43N9lRlMVR
 i7XsQ5OQX0DU09m0/GEJZFziE9HoHw2J+tbR1SffUQcP2iOlwi0RoSE4pWTt+pGQV7yxT/RE6
 uXE9n2VUTVXx0W06kDk3/+Qm8r6DZjVU2j1w5rAnBG0a53UL13bQ3jvs4r1E9uYm8mGDgxEbB
 jrYO+ObcvaBdeIoWqW34xgwMZzZQm0ee5a8AWeKlxVfV4hrT7YeXYQK28lspVMAAmy028U3cd
 Uar5jkCdHJGRtTpLVH1SDTlOxGSruku1uyYwptUGsVwA+lo6FQTRHNWlzQIcn179ExaRCrs/V
 Ztdn8XVKcwBV0xChBsAqdzCAG4OKfvbWIvtnEQVlk93HrMDHoiT3rWqxc+3jqb36QiL2pHhmz
 TF+6yIrGV2dlGehpYyAqNOSPkl5NDbnFGXQEP8i0Q/UbMe3RI8HEKVmqqsRmmpVQtFBdHHgwr
 aka/x5lw1Ryzua49sfU4ZAE6imozBM/XrRziLw3OuvBZn4BumXM4QqdB2igdR756Gegyx9Y0l
 OUji5Y6IoSKShOHTqT8mNQn1peKhxMe9L3WdpRGwQhURzpB0t8yitl6YDAVHhuoeLcaiRdCUQ
 mQFAzJIBDDGBgj3fT0ah1Q8mrNnaaV26Ia3ehisQx22GrffVfHVU+OmFxIvKqZxNar/AAeS+w
 HI7GjUJh5eKT3DCjkAoXvQmrhBjS6jj+o+iS/Jh57zr56tU5W1xU0ktAacftz37jGPX45G3ai
 qpTMV7lHhwIUKlbdxF6Mvt0c6oIIrL+hFcKBYQqqv7Ua3PpN2/U0/BEG49FXtfeUnElPAuMRp
 PC44ddq7eeFFB0jmY3gC1VwkNLPPsAgXnfjNhDZWShXGScRfmDANW+Z4cogYWatbYbl66tD6O
 Q4N7n6NYayjS+ljAYLqHpUF8tUvySv3jnIG9RCTlozDgm9J1oFhQhmhADTXhi+UYp53AfGHQ/
 Qyj2vwvFyWAY1yGxYOhPk5xN1cfByGViobg0dlVp6YKHizIfemVnSvJHROhpaJnPfl/GiEdoo
 mRtc77AxS7iTIQUba
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 12 Jun 2020 14:10:42 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 12 Jun 2020 14:10:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 1/3] parsing_cocci: arity: Apply mcode2arity on
 macrodecl/param attrs
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

PiBUaGUgZm9sbG93aW5nIGNvbW1pdHMgaW50cm9kdWNlZCBzb21lIHBvb3IgbWFuYWdlbWVudCBv
ZiBhdHRyaWJ1dGVzIGluCmFyaXR5Lm1sOgo+IAkwOGYxY2Q5ZmI4M2VjNDAwNDM1ZTBhZDhmZGY1
NzllYzhmOWMwZjIxCj4gCWI0Yjg2NTNiZDVhOTYwNzkyMmUwMDUwZmUyZmVkZTEwZDQyMmIyMTgK
Ckkgc3VnZ2VzdCB0byBzcGVjaWZ5IGFsc28gc3ViamVjdHMgZm9yIHN1Y2ggY29tbWl0IHJlZmVy
ZW5jZXMuCgoKPiBBcHBseSBtY29kZTJhcml0eSB0byBtYWNyb2RlY2wgYW5kIHBhcmFtZXRlciBh
dHRyaWJ1dGVzLgoKVG8gd2hpY2ggaXRlbSBkb2VzIHRoZSBpZGVudGlmaWVyIOKAnG1jb2RlMmFy
aXR54oCdIHJlZmVyPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
