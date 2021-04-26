Return-Path: <SRS0=upig=JX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD868C433B4
	for <cocci@archiver.kernel.org>; Mon, 26 Apr 2021 16:29:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D4461185
	for <cocci@archiver.kernel.org>; Mon, 26 Apr 2021 16:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D4461185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13QGTPa9020276;
	Mon, 26 Apr 2021 18:29:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 893EF7634;
	Mon, 26 Apr 2021 18:29:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 53ED33CA1
 for <cocci@systeme.lip6.fr>; Mon, 26 Apr 2021 18:25:37 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13QGPaK0006835
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 26 Apr 2021 18:25:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1619454333;
 bh=d80J3u9WJDZiDuzXXWPfEIwPFgtWJJ4AngjaTXENNOw=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=W+vi5qLE5WZ06nvrWZRLpP7u6LJtW0UD0FGn0P5sIX36axVWzk4nMKWtX4YK5em5l
 YO2enCAUpUf2xub2xtfouLtVo5hApopEiDKXcZYvMeZiYIik7HeNqEbCHzeRaC6COj
 X+iaEwEc/HPquAe7lM0+fazthySowxFbyGulR/ds=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.5.15]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LsyOA-1lTfT51DBK-012WFB; Mon, 26
 Apr 2021 18:25:33 +0200
To: Julia Lawall <Julia.Lawall@inria.fr>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20210425115532.2447295-1-Julia.Lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <2198aa36-13d3-08e8-4c11-ca85bba34fad@web.de>
Date: Mon, 26 Apr 2021 18:25:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210425115532.2447295-1-Julia.Lawall@inria.fr>
Content-Language: en-GB
X-Provags-ID: V03:K1:wf8NYMRHvWJaOHAQCyX0o3/dfiOJyO4mfA/yS4nG/QyamCvVTt8
 1VwAudJ4PskYBF1zqkuVFGi2Aba5vgVPwD206kJCecg4r8JHiIG4guDYzAkjflr22eOuW16
 6clpPBBJlFF8ilW482E4T4aOUr4iYKxFfWkM6NNHtEGyeSWv7OI04e5PoX4UBPy+QkS/Wto
 6UEtrbrQDCrG6/gpNPpmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:czUsEPUt+vc=:nlD3EPL12AANogXDb4YVJr
 KJXYf8yLYFRoz4eZy59hTojsqVDGj9TiwUu8GDVAI8Gsc4iH78fS7aj/rmHSxFWHwoVn9aHj1
 sYvwmlsl5PlWGuzWjCZT7SZhdK4gvmulU7yP+T9jkrx9MN5gYMf0r8OpB5g46G7AIxsClcwbE
 837axNowUeQLVhbtgSXjgiyoVvnaKkktLvEJcFjO7BP7khmQecZgUpaV7XguKPtX9OjdqbNlc
 sgJi5o34Y49fM5EoR7IEK7F6mva2qIEuC2BEvmPo5+DBfiCpA0Aw4qFd+ZO85eVmDr8ac6BuG
 nZhqmaYsojdeN32BYneQ0mOMkZOeheg886WxAxPLPRrUdfFTDcZ5ITmtpyhWxE/Ni/smOlVMq
 uRUPntjw+jSXTV/kbE+XhhUr9DpE1ImaGEw5BwtrgmHrkZrkVleBG0Shci6q9Td5jUp9EwIFz
 9h7v6/MsDZpBADQUnjbeMRw+bcQLcuUauVzpuIXLL9QdjtbGWIgaxEDi3mkfqdlmgHQLv20bs
 gQ23rZxmMMzj0LJhTxKC/E4khw5ylW+/e48C+Y87sHvERvTCSyqbfU8NCaSXgbKXq8+lrcDTQ
 0E/MqgioWQ4ZltYZMupzzLPb7uwgbAOrLLYW72YmpQkRabUyQuYAa8WKij/OKRWy6A3W1qbTh
 6tD5x7L9G8iIEvmZWBfbkO3ttSCQWV51a4IqsY93oPmxzZWZhys1eEwyRdech3xgeIReKRMyD
 5a+8bgmn0f9yCFDxf2p9PqS0iMfYrQmHTWGTd7uZltRAOYiy5YugQ3HZwcBiLgS4ysqfqHa55
 PhUeQr0F9yKlMeMxg7EyAmEmOni75jehJQ9/aqAULaOrUwbZ2nJ7P2ywkzpc4ItSvm4Y5qpnv
 5O+ItYRMUU3oSvfxeNW3PFRSTM90XB605VNsNB6JMCx0ZjL6NJOiHco3oXiwITD28WRPmuy4l
 PQLW/Tl0SlrxXyla67+eWsgdDtrc6WRNwvLG1/WoU2L5wdfFmbf3uZb68E3UMbEyDKjZUEzsU
 Ke1/GOoY7vcTeGBxUmGQCy3wjBJ6S+6JbHew2mAwLJJLy93ptMGQWG5KEKl7QAbX4xLIHTkws
 Cn0QZwI2valPauUK5eNxqU+Oc8VXCrgV9fTRO76h/BXVj3YMgPNetPuLK/kejNDe4Pz/n1bzl
 U+M1UletgBVMPMjSQCZpUh/9FUXqoknaqfv18bCaNfWLCuMnXIBcM/rjhBhzxy/tO1FMfCufq
 +YZEnRcPJfIMPuj8k
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 26 Apr 2021 18:29:26 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 26 Apr 2021 18:25:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 26 Apr 2021 18:29:24 +0200
Cc: Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: api: semantic patch to use
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

4oCmCj4gKy8vIEtleXdvcmRzOiBrd2QK4oCmCgpXaWxsIGFueSBpbmZvcm1hdGlvbiBiZWNvbWUg
bW9yZSBoZWxwZnVsIGFuZCBzdWNjaW5jdCBmb3Igc3VjaCBhIFNtUEwgc2NyaXB0IHZhcmlhbnQ/
CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczov
L3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
