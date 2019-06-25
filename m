Return-Path: <SRS0=4esG=UY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6906C48BD4
	for <cocci@archiver.kernel.org>; Tue, 25 Jun 2019 17:09:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F2C20883
	for <cocci@archiver.kernel.org>; Tue, 25 Jun 2019 17:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="QfLU40xL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F2C20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5PH9Uee024352;
	Tue, 25 Jun 2019 19:09:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 701CE7770;
	Tue, 25 Jun 2019 19:09:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 150CB76AC
 for <cocci@systeme.lip6.fr>; Tue, 25 Jun 2019 19:09:29 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5PH9Q5P028350;
 Tue, 25 Jun 2019 19:09:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1561482566;
 bh=lCvecLf+E4CGiG+mT/DvSVjC/HzHDuPjOKptJdQ+a/I=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=QfLU40xLKZU/NOLjZixY4lKaOar5YWxINw/NNnMLIdRQRmv1zfM2UziC39/Zar1dV
 LFoa1WIP6VyDl7d0NDLxSGs+VJQ607B1hPGPYSspDxaHGu2bpKryyF1dkRpOA4w3VS
 RbAAuvJJVIGbSDYEnE71kk7LKgEj5RMOzIlU55bU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.103.88]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M09uu-1iZzT80vWe-00uKe5; Tue, 25
 Jun 2019 19:09:26 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <43dc8f93-4c20-32da-f5c2-6f26bc4ef627@web.de>
 <eb86530e-4d1b-c080-fc7c-341d24acb8ef@web.de>
 <alpine.DEB.2.21.1906251636360.2556@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5f15c180-7b30-c8eb-5192-9ff7a9ba814d@web.de>
Date: Tue, 25 Jun 2019 19:09:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906251636360.2556@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:h6Zp2AKNLFQhupPvYJeVrdqJY0XnyXv2dcUsL7yJ7soO9mLfjr+
 lc0cAKgynRHGCTqmCbV445Pe15dj1/G/JU/PBoMhL4+7Ts6lLR5axci96muZVk0yfXVtv3L
 NW37mpCEjRDTd0Mw/of/KO/pGXvwJVQ1/piTtSBYs8he2bZ/jgCYE/D/9wsjQgLXvZVluty
 c5cqJjR5DDCfnjBpx2H/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TUxrypvfDSE=:oZ9MWhBNEGc9XBriWWaZ3m
 WlduipfFIBYNpjRMIy6Xz1JcEFmelzvpI7QCm9hQG0s1sCZBiKFtyzyh7H+JVRZZnQt9NcOeR
 x1BcpZ+6IHTusoufN5Qni/7zqbEjIBOornZuo8nFVtApSlVcBQcUGxIOn4bP3CxFXAPcBwjOL
 q4bh/UQn4yT1Y0chnHfjrBP6y0ReTS7dd22QtBU8ez8QewFaLnsMs3H4XS1brBBnZoti8SFan
 e1VReus2R4GjuW/0tNH45C3AYni/E98vZI86cI/yz2SjW3SSfQ6MKHrOgRp30v+5hZIRFfJ9g
 67qOYAPPEUxNJQ1eLE92NVO2ebOiYCOCf78EPk3YAkPZNnngGGVGuKcoFRDkfldS+EacIVTRa
 rJ97PvWwK4PjK3nFP4++Z1Jp1A2ULjRhj4003Ej3aA/VCEfyYgYJvLDpmlkaaVK10UXbpfZNe
 VS013JaJXTvzFqVWyfcaKzMfVejfUWDefpJPLOmEOoFOnl+jz/Ng0N7kNXat7z4jzv9PmhA34
 nxJEO9I4xtHwOfVj8Yh1t4/bPzin5RbbZGTnb6Zc9aA5gIsZo4y4ePjMshE2V2U78rhWJ0Shn
 3p/ydWYZshecnIM37tcvSpgPEDGcXO/rSIFVDlXNe6i+YjTQUbnclwyCMWqYbE/+MAeroLKs1
 YlPoqLwyR+NLDUMMcSnpNpVzb061wEcABO0EmJmlgH2rwBoaDk2rqYbbNPgdINLcgBy84KC6S
 9O29pme3csCYBybiP7w80CWFP3TVC2J6dla25j0ZILQNPGSE7Nbt7ULer0dhKaPgiSvIbJ3pz
 Nq3vQTpkT8iH4Wp2xs35vfnib906kJSUCWeXfufR1fgWoCNPJkbJ479+EyXD47W4hptfeSm+z
 F5tIC6h8XaH5uDJSGF1WqAvF75CLQIuu1baoLnm8W2miXPQQnC4NYBb1FA8jNuw1zHY7TLJbp
 /1S90pTh64/hu2nioAYgzZX7TgXzf3VBa+aF0vzb3xtYm1hS9RLMdI7RRsWBP7TAEsoHqwWPP
 WWwjCLnoiEhW+bolndoTGZ2GGx9MliegvCg3vQNywPo48gfuuwuBE3MY+mEY0vw8rN4xAWBxs
 QaYvgiOZJnVpXucmbKOBrtMR88L/Q/li2KN
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 25 Jun 2019 19:09:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 25 Jun 2019 19:09:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] More precise distinction of types for source code
 searches?
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

> @@
> expression x;
> constant c1,c2;
> @@
>
> x = c1;
> (
> x = c1;
> |
> *x = c2;
> )

Thanks for your suggestion of the possible usage of a SmPL disjunction.

* Does it indicate a search attempt to match the first assignment statement twice
  (for the implementation of exclusion of duplicate source code)?

* How many implementation details will become relevant for the corresponding
  documentation of the Coccinelle software?


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
