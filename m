Return-Path: <SRS0=uzOD=X6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE2FC3E8AB
	for <cocci@archiver.kernel.org>; Sat,  5 Oct 2019 11:18:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A402084D
	for <cocci@archiver.kernel.org>; Sat,  5 Oct 2019 11:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="TeiRHBn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A402084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x95BII7N016219;
	Sat, 5 Oct 2019 13:18:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F2F5477AA;
	Sat,  5 Oct 2019 13:18:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4CE6E77A9
 for <cocci@systeme.lip6.fr>; Sat,  5 Oct 2019 13:18:17 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x95BIGsY009262;
 Sat, 5 Oct 2019 13:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570274276;
 bh=wc8ZKrREN2JvcgL+XN8AGZz0/9mX994+e/rc2Npyur4=;
 h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
 b=TeiRHBn+y0RljCHXZuCvWiHcibXy1btflElffWtpdqJrkbPBxwSoMCqOxP1r6F26b
 5cruIJpTKgA/+MIbopLBUDAsq/QCAUoBGb5VaUcuJ9wqz3iXcK3X5F+nQxlYWJiEsV
 9/84cDYhE58dXX/20dZYKLkafdiT/vGSI4njuqiE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.178.111]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lcxfc-1hqPjA29VA-00iAq7; Sat, 05
 Oct 2019 13:17:56 +0200
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu
 <jeyu@kernel.org>, Julia Lawall <julia.lawall@lip6.fr>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?=
 <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <21684307-d05c-1856-c849-95436aedeb86@web.de>
Date: Sat, 5 Oct 2019 13:17:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:xEzJk+LKJMSjE8AA4JD6AAGoJKidki0S6DqmnE2RCwb84FyrCVb
 4yHdFK+zmm1ghxVVcp4Up8ODgbZZaSkBJAsP6n+QhHH4jSBvA3KLp+YQQE8USrSOfuF6Dsw
 +tFqnjW6WkaoJq4guejTmxT04rFOluRbLhpgkM8Mpo1eaqTjY8mWyPVlqRFZ6T5eQPkiJy+
 ILy+vilDUaGi3VlY0FZwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LKAAEvLv4+s=:Cuj02HyWu5I9Pjfu3OZgXX
 t3gy1w5PVUyGa3mxKyEEHnQXg8xsZ0uGJAyJGG3oLujfJu/X9lsUf1HlVoLKQBAdsnoim4BEH
 0YU0gVrdvpVhwz9RNxbwq6yaTLtDgVQhuzMH/ANut2FCItCvn3a022Llpla5D2VdFP/LEF4XY
 M771aGzOYAyqXnWnvuOwJCM1ZdcAPg6Thz2eeIigBGDRlx1BcW/efxSXdA/ZqN3t/jMQp3RPQ
 FAiFps8lbhyvds+ijnAF+5Th5yDqwpY74g2uZBvJcPej3XE86O75rKfWE+CcwQixtfLvUSMym
 5fb1NWZ6TdrbHR4nSFphItFoZkUpWxqgE2EPdTO47dPPpUDmO+XNkG/fUYYyENB12cJNUqY3g
 e3+ENzRyWmTApkScK6Ki1o22KkILc77g3ZHPrlNJH/2yerNmXbI9Bz4x0dAptLk6EpLzzZ8eg
 mZpKeq7QgKamlX7TmpFKOtyxgwFyW4BSZio9e+V0gLXQkm7y9dLKkpp67HsSZ512vF8CUDqsk
 n1aX0XCHanQzGRA+mvkP2+sE/sghWFiHVRRUQm7w/WIzfzAfE2j08sCKolAB+vQHSyjY4OsoK
 sLZ3I5McmUnvp5pVN++xJS3GRq9xjQNGWZzHE01OzhbIlmj2LMyscXr9InUtrlAZKNEjcTwI4
 ydnfMj4kjqag7CabHtfZwC5FEJ87hhzAKXffmYRVE+QiO7hLPDrPzxiej9W1wxEkdLuhR/I/9
 7pVOz8yVr9+WYQXfSEAEiDVZ9O8ZjTYssK9g3qrauSBSf7TaD1QU3/ObXhKlsNhkrNqzx+9CY
 HkcFswHROZtG0DGlukgrej79Fkg07ptAMQVautx3wBkY+2IifkGw/jyPIcsedI9mPCnzYSQTt
 xN6Dtcgq7b0l53+/6PIC5llYaaV3YPXCQsqrz+FL4i8gqH1rU3bM9frwyvkWVXilWkkgz0rEY
 Ho04kcpziiyiPBqVXQzWvrzXL+q15WtSygu4IbOsQUHN++6EbuGF0wFfMGlXFBZDIzHqYAIg+
 hVwLWabZ4g/KaMBddw1DA+VlkJPt2mQ8egVrVlptieTmwRplfyWHlO1eNINZTgzrFTKJuKkiE
 hUyGSNdSKfZb9zqIhLZb+CM5sDBKK5DH4z+efpYbYsyBGy4yDE2sGHfGy5AKdVA2t4GSksXi+
 tCXkCvR6qb8HIeX98lDAYYeRyaXEKIOLd5a1QvxfLqAgqnXDTVhaOjyAxvLr1wX8C0g3+/GbY
 VU2rFEZaEwksT522xcljpYfzzJPHv/Uo5n+aBOsVl4s+oMDHqlLiZldTXLGU=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 05 Oct 2019 13:18:18 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 05 Oct 2019 13:18:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
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

PiBZb3UgZ2F2ZSBBY2tlZC1ieSB0byB0aGUgb25lLWxpbmVyIGZpeCAidmlydHVhbCByZXBvcnQi
LAoKSXQgd2FzICh0ZW1wb3JhcmlseT8pIGFjY2VwdGVkIHRvIHVzZSB0aGUgc2NyaXB0IOKAnGFk
ZF9uYW1lc3BhY2UuY29jY2nigJ0Kd2l0aG91dCBzdWNoIGEgdHlwZSBvZiBTbVBMIHZhcmlhYmxl
LgoKCj4gYW5kIEkgYW0gaGFwcHkgdG8gYXBwbHkgaXQgdG8gbXkgdHJlZS4KCldvdWxkIHlvdSBs
aWtlIHRvIHRha2UgdGhlIGNoYW5nZSBwb3NzaWJpbGl0eSBpbnRvIGFjY291bnQKdGhhdCB0aGUg
Y29jY2ljaGVjayBzeXN0ZW0gY29uZmlndXJhdGlvbiBzaG91bGQgYmUgYWRhcHRlZCBpbnN0ZWFk
PwpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxk
cy9saW51eC5naXQvdHJlZS9zY3JpcHRzL2NvY2NpY2hlY2s/aWQ9NGVhNjU1MzQzY2U0MTgwZmU5
YjJjN2VjOGNiOGVmOTg4NGE0NzkwMSNuMjU3CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNv
Y2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3Rp
bmZvL2NvY2NpCg==
