Return-Path: <SRS0=nOoP=WC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E10FC31E40
	for <cocci@archiver.kernel.org>; Tue,  6 Aug 2019 07:04:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7831A20B1F
	for <cocci@archiver.kernel.org>; Tue,  6 Aug 2019 07:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YIvB78lO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7831A20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7673lVV005189;
	Tue, 6 Aug 2019 09:03:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C3D9F7788;
	Tue,  6 Aug 2019 09:03:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7D1D27786
 for <cocci@systeme.lip6.fr>; Tue,  6 Aug 2019 09:03:45 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7673hhA014236
 for <cocci@systeme.lip6.fr>; Tue, 6 Aug 2019 09:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565075022;
 bh=cBQXBlUoIsgvVUmNym3NCtWKcO3Q40ii9BLiZXDyH4E=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=YIvB78lOHMShYtK1e01QLwuj6L7GZMKIH8sA7kGEOfYQhtdodU1S0w9LX8aUOATBr
 gQdRbRll0EZUxpRaGNxZxhKQLw4I4awXh4m+Bmd47nKsEVe8QG/kWx2N77h49S0R7J
 UvqRyoaONJ0qhiJnw0ByeD39LeqZxqdfo77Nsq3g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.79.190]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5Oct-1iGILJ0YQB-00zVzw; Tue, 06
 Aug 2019 09:03:42 +0200
To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <656aeb1b-9c94-a428-bb0e-4397a0432651@linbit.com>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6a333f77-5132-940a-4b1a-d6c474345ea6@web.de>
Date: Tue, 6 Aug 2019 09:03:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <656aeb1b-9c94-a428-bb0e-4397a0432651@linbit.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:kXglIdTz740MAWNTc2XSDqPSew77q0cf3t5q9U8oZu6rylLkb6e
 TpWeMr1koUefc1noPuXp9tFtH7rRSdZgKuePHAxQtU0qYIQZkhcHOpj88IO4mfgQIi4Zfmj
 BoYf0bMBCwT5ZSUYgAHkVk/O/ZXhnTXy7llsmjnqjRGcXJqZAp4fhStNnsQLkBFPFJcoA7S
 6txGaJ/CkSRmsINfdhTwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r0FzSJ4ZsTM=:CoBBqcfecXn2Iagg2k5+jC
 WOvIfusWO0oDGqPk/FtHXrn3uy1UNcpojlhXJGAHV91viiKd3MhaRV4Dvk4gDtYwDo8D3p+t8
 eWVKCfdAaoAu/gzamlEG5S3NQMjVDb2YDb5PcsodahTQY9YFl5uPrDFzLii/Wm6HV4e5J0Cif
 Oye6YHuLwehKDuiFB+Y0Z/E9RdPD6PUiYZc3+NFarAf8CU+itw8HhUlZBFP8wHHbTdsaEyH22
 OsblLoAcVy8J5nIL3WkuTMSaJZgVgUQQes+ZKlIaN8DZttuiaAZEoCjUmbd4tYFXp0pUPPSyr
 ynVADzC6vydNlBLa+2czbgCBu85LqEQ6WTyEUJIHbZLtqUdsJ5kKAgsPuJQRQhYV8cY18bHvQ
 yBdWlWu6S/8aF2ZPM0F0nckHj5JDb5ClPp+adtGkPUvbN92agBhbb36VGDPLRdyx33TkQD0m/
 9uhseMHF9nuqEw9u0iQTXw1ZqAb65bUFWyZcJ4QIRtW6LOplpulSHKxop+yjE2IqavAzSFb//
 H6kVt/DSM47NgOoE5VvaUJZ+4pP0+kr9ri7xadVMDErF158RjfjCyU5Cf3bvK7mb8URni83ud
 XHDoBhb4ZDTLyS3zD2lPl8a0UXWqaBvN7fYBplbmy86olEzRzlXZZvXrBwf5KjO3/P97b5MGW
 yb3STEESNwrX6WpnQpJ0QUHTzyeQLtLfVebggj2vwzCEb9pd9Lb0qogiMeX+Osz9TB3VqjG/X
 kxPJ0pSsEXyPgYkV9SYJdLXh5GpQ3gDKhF+KCWvM51Ud7NlCUWotVE8ANGtu0TD8Etw+IBatG
 bKV9A7zY0Nb5QVYPPXvC7vK16+/YLgC0pxWpZKBViaa+e6AHP8fejJXbVObAEPdde8mAMooDw
 KM1htQiAJ3SfsvRsKIiQe60+Bqi8sn9m6wyGOlOTb5YbNtnwPXvCB8jp6iGvYPl1VF0rx7arg
 MjFJ7yrH6MKzjhYKQFyt33h250df/uHjIJaK2PvQvgh4QIrmpXjh4wvRqYrJHrxkauFdP0VM2
 6gvx+0k4uPr21Ps4XYq4HfWHbk2xiQj1LZONGFiG+Xi6Y5Co77UxdsS4GrEpU0hdBiUvmBco+
 xJKMDEGknIlPhbrQUYafRp/ctGbUBTRntlfY6ip+TdLz847tk438MsX6UXanpPUs4ksJnrc09
 rrwQw=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 06 Aug 2019 09:03:48 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 06 Aug 2019 09:03:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Make rule depend on comment
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

>     if match:
>         coccinelle.km = match.group(1)

I suggest to add a bit of code like the following.

    else:
         cocci.include_match(False)


How do you think about to use an other SmPL rule variant?

@addition@
expression context;
identifier find_kmap_tagged_function.fn, parse_kmap_tag.km;
@@
 fn(...)
 {
 <+...
(kmap_atomic
|kunmap_atomic
)(context
+, km
 )
 ...+>
 }


Would the use of an additional position variable influence the run time characteristics
in positive ways for this data processing approach?


> This works just fine, except for the case where no "tag" was found.

Would you like to extend corresponding case distinctions any further?


> Ideally, I would like for coccinelle to not touch the function at all if it doesn't
> have a "tag". I'm not sure if this is objectively the best solution, but it seems
> the most logical to me.

Did you check any development possibilities around constraints for metavariables?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
