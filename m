Return-Path: <SRS0=13qy=BU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D56C433E0
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2020 20:47:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBCD20656
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2020 20:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="OScmKCwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBCD20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07AKlWRR018156;
	Mon, 10 Aug 2020 22:47:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1436C7780;
	Mon, 10 Aug 2020 22:47:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AA7D25F8F
 for <cocci@systeme.lip6.fr>; Mon, 10 Aug 2020 22:17:09 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07AKH7YE021557
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 10 Aug 2020 22:17:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1597090614;
 bh=+xiiCtf6VEAAiSOfwKLkd0kBQMj0b8QB+3l2RJO550c=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=OScmKCwryaYGYvMeh2T0gjhSqDXUtqOfRhHtNmYvw/wFui6lSrsUHq+9e549TnRcr
 YmHxxgmVz9kJE0iOtDR1tgznq+hV18eQXNnl5MEF/em/4mDpck3o2cvkId1baUt6a/
 FI74c9IX9H8+LAErWpg3gsK+ss4jSXgXrxqh52Eo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.64.233]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXXN7-1kDFNZ14Up-00Z2jY; Mon, 10
 Aug 2020 22:16:54 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-doc@vger.kernel.org
Message-ID: <478715f8-87dd-7b4d-d3fd-01585f5f3bd7@web.de>
Date: Mon, 10 Aug 2020 22:16:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:o62DjEkJIfymRMe+boez9WkRB1YfpZwcBadiYST1ButCoFYM574
 9zcuhZ/CSl7dDl1Fam9vXLQmpA5UYbT0uwBaqzhwaUE2uNXXDWz3UqHseismtUCZy3lKySR
 +4a4+YqCz3eTD0OynK7xkxjPt4cI035hawjprmIhop+8Gj0zMPD9M/LXf4X/0RGOOm6NMK1
 GU3dXG67Inhcupq1y0qpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RGn+QeeupFo=:A5NJegNhyaN9P6/IKdYozZ
 tG8P8j8e83E5Zr9ULMle6P5FFhrJLwlnxtvEhZ3nLKCVzar0BamW3ph0zQPs5ral8XXLjw19x
 ywb2lXhLBjMZ3Z6UicH2Ku6VU29CuNItEf4RbbBaHrkyYJgg893QaDTk4dotIcAhIcCUUVlQo
 IoEqHAOHepgcDTOadmni4LBcpaJvNGfDxgoEGG4HbMhvrTEZzbC3lHag1YAm76LuJjjs2xt3J
 EJNmEqyMx7rdjmRIH5T0ieVUytv/NQKeI/behA8H7D9SGBtNKzzewXpAeCVSDX1lWd3bCMq7T
 9043U+NOoryiTmcjfQkLadmm8lDDciUOaNUqiVF+vmYmlmpKj/IHPATlG8hJ+ScDgQi8rxSt/
 aZUWqVkpeF3qZxUIzEsHN6DYf50wZZvXNcTlDbL8Vz0v3SEx/euJyVIYjRDzk2Zdj3KxhFj3O
 pyS8+OdltEEKPmq3Z5O3UU0ZDDgFrBKnSqXrNxdcGhTBzkKnCVB31KQn6f1mtd0oBOkNXSqxo
 krySzbVpq9+I4I73q1PJhtep6EGCq6dt5t6vswM8pOIIV+7zHVJv7oDxLTh1HQIx1rFJX8o/t
 IIDdbzqy9UaWZ3B/sDslCQSKIjN30FMOLUwCS9vbJ+hnOGk56HFrPFeI6ZwHmGiOwjVrPAVL+
 dUYdB36P6dj1bcv2YXSD+udv0gmqV3Y0JRyrGVzFsBQbeFu27O9kH3gDSGVcNtdcDvVeHtHs6
 jw+sK93gsI3TvgGOs2SuvWRHIgi/6PdPGIiX93JP6lhcNY8vDemYYIDEawf5WLuM/IIaarP2T
 W1rSpIbuRs+h4qpD2DKXc3iL9YUlJffInp5TgWH3rJ/Tt623BXv0TKF8UGEdTKZDkhn6drJMo
 IWsuesb9J5WmWk8OrXn5ISmeGEaAIQ2iKcUKwZVViaDMOf5FUioSS9fsrEptkTp/iJ+oMVMlM
 h73YQZ9Zj5e+vmkoVqnPefCMe6lII+3Ca8D9Lyvg+PT3d1Jr1knZ1kczdprT2eS+ArzcvNuwV
 Dc7IuTw2mKB/f7InBtd3A+eKZHFDRuT8C7V8DmMiRE/6EKbHUnoQW22PP1ESsvAY+hCpFXtZw
 MayXXmhFwsbguUfLwsN3urQrCJIolyg+CMhVo39TIOAApbAnTumf9Pl4TAkPrgIRsxuBGwb9+
 supKn05fIgkCvm/Y//fPKhV+NYfpYD4qSC96cSPTTrDINRCis7ZyeeIBxpe02giAi+NOQ3ISf
 DXYNqMX1kEUMZ3aczIaDIyKYmxTRP30j+q085Pg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 10 Aug 2020 22:47:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 10 Aug 2020 22:17:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 10 Aug 2020 22:47:30 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [Cocci] [PATCH v3] documentation: coccinelle: Improve command
 example for make C={1, 2}
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

PiB0aGUgdXNhZ2Ugb2YgdGhlIG1ha2VmaWxlIEMgdmFyaWFibGUgZmxhZyBieSBjb2NjaWNoZWNr
LgoKKiBDYW4gaXQgYmUgY29uZnVzaW5nIHRvIGRlbm90ZSBhbiBpdGVtIGFzIGEgdmFyaWFibGUg
YW5kIGEgZmxhZz8KCiogV291bGQgeW91IHJlYWxseSBsaWtlIHRvIHN0cmVzcyBoZXJlIHRoYXQg
YSBmbGFnIGNhbiBiZSB2YXJpYWJsZT8KCgo+ICtUaGlzIHZhcmlhYmxlIGNhbiBiZSB1c2VkIHRv
IHJ1biBzY3JpcHRzIGZvciDigKYKCkNhbiB0aGUgc2NvcGUgZm9yIGEgbWFrZSBjb21tYW5kIGJl
IHNlbGVjdGVkIGFsc28gd2l0aG91dCBzdWNoIGEgdmFyaWFibGU/CgoKV2lsbCBjbGFyaWZpY2F0
aW9uIHJlcXVlc3RzIGZvciBwcmV2aW91c2x5IG1lbnRpb25lZCBiYWNrZ3JvdW5kIGluZm9ybWF0
aW9uCmluZmx1ZW5jZSB0aGUgcHJvcG9zZWQgZGVzY3JpcHRpb25zIGFueSBmdXJ0aGVyPwoKUmVn
YXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0
ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
