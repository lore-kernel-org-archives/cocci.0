Return-Path: <SRS0=VaV3=27=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C4CC282DD
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 16:36:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA5F205F4
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 16:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="HAHNRWzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA5F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00AGZmU1018702;
	Fri, 10 Jan 2020 17:35:48 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3F48777EA;
	Fri, 10 Jan 2020 17:35:48 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 215F777E3
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 17:35:46 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00AGZj6C023442;
 Fri, 10 Jan 2020 17:35:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1578674126;
 bh=ywOghj+GkZbJuOdq0nGQ9EvAYoVtkRGJ+VGaMoVlej4=;
 h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
 b=HAHNRWzvc4zS198eWuiBvvF3PtISbe4r+hbdfqIIkGVWT2JGyHIPunK+BoPMRGA1+
 h30HonLUiPFTVf5+G+OsybFL3WTLtOnZ74JAz9riJqc4ZTeMqO+v1OzYpC3dSq5EWl
 Spl3FBdGmM4dAHpMUzggMLYc2Jr0IojXMX9U/BoA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.170.191]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgOQQ-1j4soK1nVO-00NkH6; Fri, 10
 Jan 2020 17:35:26 +0100
References: <20200110131526.60180-1-wenyang@linux.alibaba.com>
To: Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <91abb141-57b8-7659-25ec-8080e290d846@web.de>
Date: Fri, 10 Jan 2020 17:35:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110131526.60180-1-wenyang@linux.alibaba.com>
Content-Language: en-US
X-Provags-ID: V03:K1:wv5p/O28eOczAM2rFvszRt4ZYLkNQgAJ/LCwgooooQwNTDjyZ9z
 dcoqh8iKryZtqqf0teCTzVeNnB5KDa4SlE93uYBrxQ3IdCwc14YyThZ+tpeWYQhpceIFhfV
 EAc04GOyGjyZRIK4PsSNP6M3k+45dv9/BfTFyejsvUoF+XRvRzDAY2+KDYxzdfyFE1e9B2w
 A/47hroxfovyMFF7YI8LA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/ohfRlFmojI=:f5AjPCCTMu/rkIYl4q9X35
 wJhFX853TXf+jM1zZwWHstfcHf07voAYPQNcdfOjFPFgQ1T3kI3dTKPcTlfF3/Jsw+OaJr2Xt
 XagwVMQuf9XjoG+O6W6QPJAr3ozg5JpN095n9wkkIOHTxOmh5ukWC9vmsEqru2e8JiQyzsIkN
 rIq2aPFb5jRAefo2aUbN8Atj65ImXNU4Ba6OdFQFCjlGHQ1BMTjpf0CtDhOhMbxHuYdst//eL
 Naek2kCMjBroxJxe/Q1qA85dJfJXS20Lgdqka/y7MHw2bXpeg5Krn1rYRC6PwqCg/+plzzYbG
 FltZoCyoV99YNoQR25XfKrzLhLjIM+32mmjd/4ytpne9j3A6UnSBAx8ZZAlsmXyJpm/phxFOI
 /cyAGHvqoSql9xiBK8p/t+MS8AmWJw+9Qht3/8zTrCLcw7CrgJq6EsxEW2WXwbW+kikHsM0tw
 Sd6PENE3QoR583hlGqWY/FZkH9dLlfFtXtfBQticH6erJpHa4Bg2zlPD1xQJ5gx6X/Rj7hFqw
 VEjfNArPLyjvcyH69cES7z2WFjGCgforhmkZO7iR4QtFCFx/wH+kzv08rjHQqlyH+HOnFgL9A
 BVZT39AYBO1csmmBMj1tm0Mbkb6z6K1bi+0dtFRE53+76Q/h+fTtG26FKTAOx32h3aMfpO0HJ
 pqNvPTvfui281JSr6QVo2oyXvqyp20qwqPt6xyGvBUolKBhoiBoHeaiSeAMd5jUOa83GNwGLh
 wzEUKvvWadk16WM+/lcc6ijQa01p8awqazNP3Zyhyy5KnKz5jgmMv9igulXWSBBP7fV8tNrJt
 rkmnUJnA2b54W49rt7M0jIL9t40OM/TsDMLCK3bcBI7AKOC/lAXF8LMvhRczc80H7HXiekSjd
 lCXof4k0m2dpXK+sKwHr4whS/L6rOs/EhYclEheMOMGhdMJOCCQ6JLxdrPBoIyqlYeV9NlrUs
 g9ul5tJ6BoaBfNPzPwvJ2ofaEzdcQjXQSOi2SKUCEdG830RuZh6IWzXLpL9ELzQsoYgTUEENX
 5HWOjnVRhqW5hpye50pYaw/YvP2zv1J8pGKMl/UV7cvycyYuvvZcmkeWJ41o1/E3iD9f6SlwL
 RatJIRw1V0Ef5+ytsGwpTDUK03VR+dWz0lGwh5g/bXQHg2k5Cw7KXen/mPpyw9kITsw1UZ2Sa
 KeUqhJgYyNYjCwAmXNxSJi/t+bgCOp0mtQGkOR0cDT+6Gjw7r5dtSXMvbT4Y3x9/5lodVM3Xh
 UYZf8NFdVj9ZuF8y6D51I+u7H1NjvXjI8PrnaFj9jOHfPo6fR9o8c/fc9kN0=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 17:35:48 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 17:35:45 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Cocci] [PATCH v3] coccinelle: semantic patch to check for
 inappropriate do_div() calls
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

PiArQGluaXRpYWxpemU6cHl0aG9uQArigKYKPiArZGVmIGZpbHRlcl9vdXRfc2FmZV9jb25zdGFu
dHMoc3RyKToK4oCmCj4gK2RlZiBjb25zdHJ1Y3Rfd2FybmluZ3Moc3RyLCBzdWdnZXN0ZWRfZnVu
KToKCiogSSBzdWdnZXN0IG9uY2UgbW9yZSB0byBhZGp1c3QgdGhlIGRlcGVuZGVuY3kgc3BlY2lm
aWNhdGlvbnMgZm9yIHRoZSB1c2FnZQogIG9mIHRoZXNlIGZ1bmN0aW9ucyBieSBTbVBMIHJ1bGVz
LgoKKiBDYW4gdGhlIGxvY2FsIHZhcmlhYmxlIOKAnG1zZ+KAnSBiZSBvbWl0dGVkPwoKCj4gK2Nv
Y2NpbGliLm9yZy5wcmludF90b2RvKHBbMF0sIGNvbnN0cnVjdF93YXJuaW5ncygiZGl2NjRfdWwi
KSkKCkkgc3VnZ2VzdCBhZ2FpbiB0byBtb3ZlIHRoZSBwcmVmaXgg4oCcZGl2NjRf4oCdIGludG8g
dGhlIHN0cmluZyBsaXRlcmFsCm9mIHRoZSBmdW5jdGlvbiBpbXBsZW1lbnRhdGlvbi4KCgpUaGUg
U21QTCBjb2RlIGZvciB0d28gZGlzanVuY3Rpb25zIGNvdWxkIGJlY29tZSBzaG9ydGVyLgoKUmVn
YXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0
ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
