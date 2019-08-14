Return-Path: <SRS0=BekO=WK=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F981C433FF
	for <cocci@archiver.kernel.org>; Wed, 14 Aug 2019 12:23:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ADAD2084D
	for <cocci@archiver.kernel.org>; Wed, 14 Aug 2019 12:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YCqaWZzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADAD2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7ECN6re027339;
	Wed, 14 Aug 2019 14:23:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4E8A576C5;
	Wed, 14 Aug 2019 14:23:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EDF5C768E
 for <cocci@systeme.lip6.fr>; Wed, 14 Aug 2019 14:02:07 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7EC23xJ024188;
 Wed, 14 Aug 2019 14:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565784037;
 bh=t8u6NOCL16q9HtKndJQAxJduq4EJsS4RNVT1zyvjHSM=;
 h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
 b=YCqaWZzAw0SUEZtvbhQsMvYA6mJNQtr5zIIHJTHy97KzsDJmdBIZ9JI4QBqEN0BuI
 MtvWwMIXWs2bcn+VR8PcTpufbbJO0ZQhhhdcdlZ5uUGRIVK6slu3FlvG/3aTX9EaA9
 f0p8dHGm1wTBPtgY8aq1OcI02VMOc6GR4U2NvwzU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.124.172]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlJzS-1iXTM31mS6-00b6JK; Wed, 14
 Aug 2019 14:00:37 +0200
To: Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>, Martijn Coenen <maco@android.com>,
        Himanshu Jha <himanshujha199640@gmail.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
References: <20190813121733.52480-9-maennich@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d3c852b2-0e41-1a7e-2f98-d8fd23cb8c1a@web.de>
Date: Wed, 14 Aug 2019 14:00:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813121733.52480-9-maennich@google.com>
Content-Language: en-US
X-Provags-ID: V03:K1:PV3q8JAG3J44L4VLLpcjx+LJA+d2Q/O26Z4wCk/v79pZUEG7nh9
 m1L6YVDyqKxcYsDEo1kdMI3MgbeX/V+P0Gqzee44AZfe4AL3apOsTv/Vg7xoV69ns+9oPNS
 6nHNXYFSiW5jKwhQ+nlm5MSEFqWf6EALhLHVb8jUJ3nb2NbBpTqWiPRQyg4NQfk+sG9HksF
 PoUwjrb1WNlfH62NRqiKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Afb82YE9Cjs=:aTmyYmgfN5b6+tl28ALxB2
 g/LjPRzs4TRfheufbLqQj/rntkKK77N+SvXrZJCE3QCV+/AH9UfldUS/5DhNK0RPccZOFywvU
 3KhfUbCRjF4wGdWjCPJ9JIarEbeSQ+U0p73paUXJIovLf4FGNxVG/fu7UASFa3W3RuFOdLnJI
 1DdDGr23zDK6XPsxyWhVWZwLx98xYlghohVnvOyhprghXD6IA9ZUJDvTR5s819OmT0zGY6HHJ
 Uj8BxBvBdvD72KcH0iru6y/nNWQZ8xBGkNvzemIwpp7mYD+nUgAYgsmILqOfpWiD2ZKaVlhAe
 yJ7JN+Gicmz0kVNrQlHMBKWo65W9beXwMzBFcPFLOg2oPrkIIXh6dcpAkLq3hz8EVVgTuN1dH
 GfpLpK+v+HwzD2SJAnhN8JecjcEQ/C9QuBRrByh+4f6lE3C0I256aZLdShAbhxIma6B5Yhxq6
 ZrMC2GmtBdDju5fnNoOJOdMNcXph7D/43eK7IOs8anLq4nE2LS/MJoEzDhcOoksQOt1CfMKDL
 KR5x0Y8vjWK+bZB9FzORrUc4r5bZ5Q1Y4njOPJC9OdLWcXLTt+vv1LsvhQhGArn1grSinl0xi
 wDUaOJDSO2mJjd5NXX0N/zRKYFyqNJd1EKEod/mOrAWGMpORjK3iN64taFoKE2JcBaIL76ev7
 GRQ/Pu8NfAtOBtPoMKKDcYIy/5H8CkvV4OVwZURmW/25BJns71iy17MNFCWm6UvF2L1FdxQZ5
 1qsv2xxkgeWkMLWaBTlHdydOKHhL/H3CDwmQRKrF9Pxk/VxF6Lcc0ndjczIdZCgckvYgNHHax
 +jVNosPn9BioqwX5gtXfJJM6/V1FEVyIor9GnzxJwWBfk2NL4B2JSjun3gZnS9MKowG3B4I/K
 MgEtx4MxByRnJE8krxp8Xhfps00TdMelOsMidCmmrll1t6igulsyw981wkVBBx+lElpuz+DZo
 4e2Ou5SILwFHnFVCu1nZZ8+CQaB+xV6tPgzKF3nW5GBCPjCfMyq/721rDCiicv+8mtgxtBqNW
 4lJlGWmwaqRTQYJ0OyoddYMFIQsYJtAVF5leDof9DZkZuh8o/VabyEw4ZzPKZLpi+0ecrhdKI
 qiNnz2H6znKE/SU42ll39Ie9PDt5iaUxuGPiUXVwNwpE6yhvtcnwIHk3HfmILqDXtoU7jOP9h
 eJrQ8=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 14 Aug 2019 14:23:06 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 14 Aug 2019 14:02:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 14 Aug 2019 14:23:04 +0200
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-m68k@vger.kernel.org,
        Oliver Neukum <oneukum@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        usb-storage@lists.one-eyed-alien.net, "H. Peter Anvin" <hpa@zytor.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-arch@vger.kernel.org,
        linux-scsi@vger.kernel.org, x86@kernel.org,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Alan Stern <stern@rowland.harvard.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@android.com,
        ",
 linux-kernel"@vger.kernel.org, Sandeep Patil <sspatil@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Marek <michal.lkml@markovi.net>, linux-usb@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Martijn Coenen <maco@google.com>, Jessica Yu <jeyu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, linux-modules@vger.kernel.org
Subject: Re: [Cocci] [v2 08/10] scripts: Coccinelle script for namespace
	dependencies
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

+# This script requires at least spatch
+# version 1.0.4.

How do you think about to avoid the duplicate specification of this identification?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
