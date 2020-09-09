Return-Path: <SRS0=pcGb=CS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC392C433E2
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 20:09:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34002080C
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 20:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="C8QTVjVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34002080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 089K9Hqg013541;
	Wed, 9 Sep 2020 22:09:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4C5D55F8F;
	Wed,  9 Sep 2020 22:09:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A91AF4316
 for <cocci@systeme.lip6.fr>; Wed,  9 Sep 2020 22:05:05 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 089K53uC001005
 for <cocci@systeme.lip6.fr>; Wed, 9 Sep 2020 22:05:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1599681903;
 bh=SqagCAbWnEQ9wjCPF0JvX+TFNtXaxOcC2PQ2iBFlStE=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=C8QTVjVRHMvuL9caQsdIWi3uK4t291jScXzg6xUERfXYE1GJKUiM6SDQRIpipAygo
 WJ54D0N8B1Vlc3Tch7HcaxapSPdzkKKKu0ZPDfBc4WF07j+iVTYUjbMgohEwiO3iRe
 H4AUc7Cnq7LNl/cKen+XfucpHD3VwMZc9CNgcR+c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.79.254]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MbyZa-1k0Dc1040s-00JKVj; Wed, 09
 Sep 2020 22:05:03 +0200
To: Jaskaran Singh <jaskaran.singh@collabora.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b5578545-0567-8555-30db-d95a6b7bec1d@web.de>
Date: Wed, 9 Sep 2020 22:05:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:f1/Lq4ryLnc0vFh2yh5O3iG/2pemFfo+3c493ZDgKtB6robMKLj
 iIltZ50XbqYmsLgn3DcTnIl3Ky1RV8jsdU1LebVc351iztvQS6duGZSudjO774kkuTTn3fW
 QJ9Xehoi9hCviX9Y9BziCvJ9HnOPsMLaPRb8AZUiMRvmc4jDlgRMlwH6WNh3gUpbx+v5/WP
 5nl220WrSQITlrQbWv/Mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ePJHfBRiRk=:UUQ7dGxTc5peJjA7L31q5M
 l+fYshyQmeIaqKMe+zK5XaZZConZBO+ecSa0zpjTC3Tx/BsdOpZMnHKoOUtExDJq4+cT88Fwa
 UaRTCBTAPzwpwWBha80kHvD/TE8RzpWzvRZY2wqAWHchgBlV34A/9P+J+RdRpuq2R437ta/1I
 UMdoKJLac3u6orRReyL8I2s0Agh61FK5yHlY7gMyfc5q4HYh/JuMqkgHQaqypad2xTZNoGCaA
 yt0K3dk6Ey0+5hbRqrZVlmKEvX8MEL6CMiCTyFpxfTw4Unyi6lJ1v9hXxNhwJ7tCtqTUcT1QC
 O0ENG+gDUl5wupYQRU4IejcaznaLkSMdq5vKygRUUaBiykAqxE4nLeFSLu3FOu++IO2yyjPqq
 Pm/JDE76KX3RRGQFr3/V/pidRGlEFKgt+489oUhvbd9ckcnAvCsaa0hhkQ30IhuaScNE7IAnP
 wTUK6D/y2JBHzEITkK2/hxyh4iWW061j1RDdlMuQFWHh9yODY9Rz5hjPE9pM90c03OtJvdjTw
 jfbrOiFoTKJVf58xzYiD/M+IK+f2hZkTEXTzDXWZjY9egr5xv+owFOSvFoWkubQRdA//cbp6R
 sGyUz58iWWDds0R0tOdqbMJyasSVrzd9Z4PxoshGH3eEYAlADM7vPubrWkc9gPSBA3IPDTYlm
 czDYbe8Kw8XpbL+SvxoYzGMb4H6tN8frntyGliWFKV1Iy3PZg8JQxrpt4zKMWLkgNu7KjHF5A
 DHKrOmUN2Ernsmml3wHJepghE4iyrkx8y19Tr1meIVxHla10mpWk2LTuZsj6778oGPR0qKo0S
 hJQ9DD9QZhySgOstGdUMro2pHVJHoKoY0TnkvAeuwzsCZ+vmlkRz80AAemXhGOXscek433EaC
 pn7y5YuifWC45/RhiVww0WlUL0cKzgF/vHDC0SXf3f23rqhUWeucmAQ/rhpKPrAetBgMh4Fif
 Gq8vHzYauTI7PAO52N4EkqfVRhl2zCLlz/ETpt75XQoCKmz129ds77nqGGRENvpbM/S/xnIzm
 tcfSUSQ3Sh0D7f1zryWwh3562xVrgSedZtlc5BCR/iNrzMQTURwXs1D3S98OSVYhd16aa4+QF
 5LKLaJBG3kpX3W+vzQjp7GkYg0zcNETjUIGZOObe2GdWM6W3VH+NaGABrHRqTmVBjLQJE5MtM
 cVtWiFh34po3wlpGZC3eLdsbOoVTfhsv/iiUk71zSu+MVzZMlZNgnCMEexY47rIjnmXwpJ36j
 JkyHf4IXHXklvSDMDj3vo0eAQsJTGBC9miHhF1A==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 09 Sep 2020 22:09:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 09 Sep 2020 22:05:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 09 Sep 2020 22:09:15 +0200
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [RFC PATCH 1/3] parsing_c: includes_cache: Implement a
	name cache
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

> Implement a name cache and includes dependency graph to optimize
> performance for recursive parsing of header files.

Can such information trigger any more evolution besides the contributed
OCaml source code?


>   The names of the above are stored in a "name cache", i.e. a hashtable
>   to map the name to the files it is declared in.

How much does hashing matter here?


> - A dependency graph is built to determine dependencies between all the
>  files in the codebase.

Can such information indicate a need for its own programming interface?


> - In the type annotation phase of the C subsystem, if a function call,
>   struct/union field or identifier is encountered, the type of which is
>   not known to the annoter, the name cache is checked for the name.

Is there anything in common with symbol tables?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
