Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE472C433DF
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 17:20:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48FC3208B8
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 17:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="WAEBKH9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FC3208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058HKmE8008070;
	Mon, 8 Jun 2020 19:20:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C96587783;
	Mon,  8 Jun 2020 19:20:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5385C44A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 19:20:47 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058HKkCN007379
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 8 Jun 2020 19:20:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591636841;
 bh=1SLpcfHSohglzT12sbos71QamX4xs51AXro0SmferIU=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=WAEBKH9jHxyElPSRN0bQHviw/Hw6nEZ+D+ppMq0v5f3QkKngv+k2LdZoSGSNygabT
 dB5c5Q/ibAG/Z//orx8S0zjeucrkaP6iIT1iRMz9Zi0ICpQ16pBSVBrOanh7RlJgZy
 WJVzvhqhLjuEG8ZVuBo1T3sIHiwwqLhAEQmdATjc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MF3nL-1jkDvG0WBH-00GFJR; Mon, 08
 Jun 2020 19:20:41 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Denis Efremov <efremov@linux.com>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <c3464cad-e567-9ef5-b4e3-a01e3b11120b@web.de>
Date: Mon, 8 Jun 2020 19:20:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:UldXh0j08r/ErXzgTvNm9OjZBsR+FMBLzN8+O3xRWbiECM5/xob
 uNFUc24EAM42nRupriF2EB0xtKdkfbwNorbrgXIn31pmMKysVHVgCz/irQ7dMMtMLEooNDq
 avJh93y+3672B9NeL/W/SaAGugPrzXsc7JiGgK2uHuquq3vzgpqv+isJAXCen90ZfkLSbpt
 CBtuCkw+P8HoJMahsCHIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t4icpK8lx6Y=:HFV/Pomkru1XCwzktWyK3M
 0V2/FociJuuORaGfCjBtzm0oC8n1PxcmFdcoQ3eWaG+G9ru+muEhYX5HWH6FGQ4004A5/xy5Z
 enQoIArBrh9GlLG1qqqgMNNgLMkXhb7jTuSqs6607BGo3YdlpRswulehiE5ONUy50+hx4SlZ7
 c61D5nlSz7LhGOunm9uiT7BJTi3YvWjVeVVTZ9ZIV4Fwqyc2Wr79O+BOf7ZI8ocUlKAtnkSYg
 dQL8ZhOccUH0eKx/KQbzZ1xBI7+5RU/5BnVwBPp5e6oGOo05A2D1o0x5QJGe3/kUzUwrD14Vx
 ONKs6ennmKHPVQ/XqaUU2DF/pJi9ZeMJyF39DAPoy9PuzcHCcEpMPF8qwjYVA1QemBSYH1sfK
 9FkdD66GZuQSU+owjgU+443ZQeFwq5JpIjuP3riZn2aaAso+ztO0ubuYdSLVWq8PXcZa4HCRI
 N/EfnZJI4f0u69cowQ54Mp+yDliaHfnxITPT3pgHwby/5/NnaWWt6yu9UrmO6NyVOuc58ufS/
 4d2a0No1ACBXMuoDhPZjCn16dbzT0/o+RJ/u1EhQlJnaH5mSOOHF12HPrfSzB7q/FtDjyna23
 v9aXKmjsPtFUlcyMZAXkZc2XWC1djmmAObaNQvHkEbRfbENYL/9CBnJh9dTc/FJnnRo7jBTrb
 NiNj6bmL8g1c63pJAD+djinyHMhDWgWUDCNZQo22gZ4P1IzM/79X0rpTf8gNniaTPZ9Vpbxzi
 s8sG5d5HyfBwFRglhfz7VqT/UlwCJmQFiVr8kKcmoSBXE7pd1fXflZZDxs8yxoNMzERUhAiQo
 V72A0L2oRDVKVNJXhftioHOiBSOwW/OVYM5QvWewl2zI9uIHwBPQX+IMdKR4XtqyZFTXjFsBy
 KjCLyPeZNpg44nlAeVjCYk8q9MchyNTHRIzt7YGITVVHOoglo+HFwskdl+US9ZlNngO/OZ3iE
 1KSrJgozxGJoom67vvDFmfoNG1eU/UGpL+DQNwfpmNTAV3rSPBnWKlC8i5G+p8pBbj+Glb/v+
 WSwKHCt19jLpNhnioW5o2pRBHfz6tQJh8S8B7Epw5GqkJonHlZRuz5y9E+lkDr/cvpcXQHdv3
 AeCFBA0BBv0wfJ29g6F7RwX+jR5NJD5IEEF8sN7zftlc2fiBlcPF6u4IFRK4vfgT/XfMp2Z4d
 oKM00m5QSRuhm5jjS5vSJMV4RUIKpiOoLTKfYgXxBUVgpGSrhZ1Zba3zH+/iJryCholU4cWfp
 eyilCJKcQLcmHqF6k
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 19:20:49 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 19:20:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2 1/4] coccinelle: api: extend memdup_user
 transformation with GFP_USER
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

PiBNYXRjaCBHRlBfVVNFUiBhbmQgb3B0aW9uYWwgX19HRlBfTk9XQVJOIGFsbG9jYXRpb25zIHdp
dGgKPiBtZW1kdXBfdXNlci5jb2NjaSBydWxlLgoKWW91IHN1Z2dlc3QgYW5vdGhlciBpbnRlcmVz
dGluZyBzb2Z0d2FyZSBleHRlbnNpb24uCgoK4oCmCj4gKysrIGIvc2NyaXB0cy9jb2NjaW5lbGxl
L2FwaS9tZW1kdXBfdXNlci5jb2NjaQo+IEBAIC0yMCw3ICsyMCw5IEBAIGV4cHJlc3Npb24gZnJv
bSx0byxzaXplOwo+ICBpZGVudGlmaWVyIGwxLGwyOwo+IEBACj4KPiAtLSAgdG8gPSBcKGttYWxs
b2NcfGt6YWxsb2NcKShzaXplLEdGUF9LRVJORUwpOwo+ICstICB0byA9IFwoa21hbGxvY1x8a3ph
bGxvY1wpCj4gKwkJKHNpemUsXChHRlBfS0VSTkVMXHxHRlBfVVNFUlx8Cj4gKwkJICAgICAgXChH
RlBfS0VSTkVMXHxHRlBfVVNFUlwpfF9fR0ZQX05PV0FSTlwpKTsKPiAgKyAgdG8gPSBtZW1kdXBf
dXNlcihmcm9tLHNpemUpOwoKQnV0IEkgZmluZCB0aGUgcHJvcG9zZWQgY2hhbmdlIGZvciBzdWNo
IFNtUEwgY29kZSBpbmFwcHJvcHJpYXRlLgoKSXQgd2FzIHNwZWNpZmllZCBieSB0aGUgbWVhbnMg
b2YgdGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlCnRvIHJlcGxhY2UgYW4gYXNzaWdubWVudCBz
dGF0ZW1lbnQgZm9yIHdoaWNoIGEgZnVuY3Rpb24gY2FsbCBwcm92aWRlcyBhIHZhbHVlLgpJIHdv
dWxkIGludGVycHJldCB5b3VyIGFkanVzdG1lbnQgaW4gdGhlIHdheSB0aGF0IGFuIGV4cHJlc3Np
b24gbGlzdApzaG91bGQgYmUgcHJlc2VydmVkLgpXZXJlIHR3byBtaW51cyBjaGFyYWN0ZXJzIGZv
cmdvdHRlbiBmb3IgdGhlIGZpcnN0IFNtUEwgcnVsZT8KCkZ1cnRoZXIgY29uY2VybnMgc2hvdWxk
IGJlIHRha2VuIGludG8gYWNjb3VudCBmb3IgdGhlIFNtUEwgcnVsZSDigJxy4oCdLgoKSSB3b3Vs
ZCBhcHByZWNpYXRlIGlmIHRoZSBjbGFyaWZpY2F0aW9uIHdpbGwgYmUgY29udGludWVkIGFsc28g
Zm9yCnRoZSB0b3BpYyDigJxTYWZlciBzb3VyY2UgY29kZSBhbmFseXNpcyBieSAibWVtZHVwX3Vz
ZXIuY29jY2ki4oCdPwpodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2lz
c3Vlcy83OAoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIK
aHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
