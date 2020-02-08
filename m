Return-Path: <SRS0=lWmI=34=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73160C35250
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 12:56:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37E320726
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 12:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="efVdC5Yw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37E320726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 018CuEOs018834;
	Sat, 8 Feb 2020 13:56:14 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 02B7877F9;
	Sat,  8 Feb 2020 13:56:13 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 62C537718
 for <cocci@systeme.lip6.fr>; Sat,  8 Feb 2020 13:56:12 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 018CuBDe024460
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 8 Feb 2020 13:56:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581166569;
 bh=eFCp2ZsXl5GRe+rQacu2867+/eGHHb03YJdq+3z6aNc=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=efVdC5YwQew6Z32ZCOZoITxYY3iGnIraQ0uPn72R2B0/HXTpV8AsPfLCtEVYAADU1
 qOio2l+EqnP5MAQYIjB0VtQVd5Teni+ufvPduMW6MkxDiWJqSbkZPOseI0GwLBddqe
 f/6BxCNQap4VvMnDZPJD2RbuQGZnt8WU2eCryLJ8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.138.97]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWRoI-1j26SI3t74-00XbPJ; Sat, 08
 Feb 2020 13:56:09 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
References: <88e09c8a-e39f-2722-9f87-333d2c14a7a2@web.de>
 <6f51f690d06cdd2278900480bd079cd90895ec43.camel@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <66a4ff09-d5a7-1057-dc62-de131e60ae72@web.de>
Date: Sat, 8 Feb 2020 13:56:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <6f51f690d06cdd2278900480bd079cd90895ec43.camel@gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:PMp355Xxpdw1ANPzn0ZIwiKnWnosepjMo0hU9Ypl97Oel00o7sF
 OdbHyaYBHMkIV0Ny2tJrOPmILR/f5q6VP+G2nElNmEZZ4YOEDSPknNeLiXZ2X2Yj+A9XIBL
 3OvsnBKuNiUM31B3a935IleV97IQTNDdoNcrVDob6KuYeu72RzxV62k7mBEjl6u755vGNK2
 FNfSGAAvPid9Wt6lQWFQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HPJ6HsqEuGI=:jiLW2RdpFEzHbStGJrRodd
 I+75S0QsIBuQpZYfkwcr6CK9TO4f82qSdPZqaP0TZOVZahBd7JfLKNW7HVfaWY7Dp/49evmoB
 fRSRi8UyjULc2LihR8oEOdPBdITLNecbvRMJePfyK6dpJ639C0SFGWAPx2bm+x7ootkEMPz3J
 NDC17dmtGxVnO6qt913fEe8HodhW82JvRmUhJFDDC/Bibk/3IqFN5m2tyruJ7Ngxaky4Z66Fv
 lePXm/5Q0qHKWn+0sZ8Rz+UeOPAdFytqg8T5tN9OYQXH7onmA8Sir5bTkth8uIIbbaQN9tPBe
 eTngzUT/Fd+nf+JGC+e1ZrvQOPG5LYpoEJtxbM42TG8az+jKVWw+h11yWRxKEK5KkbJG35dSr
 nqhQomv6DeUm6FxtNpX85BwuZXSSDBcTwUY2BNpUS7/d8nP8+FeF2t9DDGUzV2TzWUXue477K
 vpI0AHywUYjYi7+ZNCC970SlbcxuTuOMKlf+Fn7mBHVV+KqcVW5jVVpgimlcfS6WxGMK9wzhz
 QYbAkSvm8K0Oapb7dKPemdCklcsL+9VBIEOoF2+S56mgh0FU5eDi86/hgGUqMJZ8iJN6u8dCR
 rbwF+2p8ugbXdeZA4wolPiUnvpCKg2st6o0J6AXtqvRiDysY04wLwzCbL2tKhYcIay2EsAJYn
 zzWx6L+DRfTPMYBQSsVKyeNdnMoo2lkh4qFhdNwA5BmWwHBxhN7Kf3tsbflRaJJPl8/nfx1c1
 Cu48mfmJAIWgPaV+65g1TAmiy2qvts4VTdqC9lxxJ9ylufof9raOb7Lymn5cB1u2gT7oWCrMg
 p25H03FgnazOQPenihkZp+7M8Oek7HhzbfvxMT/OSFN7iAUJPTH74pz94tLuv3yTToZpBJo5R
 qQnwcXHCk5dEVA0Z6tRzcJOUdrBJtQeifmdqy+2hqJAPMRZl7JXwBUXftZKPrxJOEk5u7FU/N
 6HFwKkVMBP/DXwVYFSXyLbSDWRhF9qG2yntHUmRzjdWgCFBN0XNRShwP64bM0eIjMo1dVK67h
 MghusfLls96oRLA3/jdzKFos3yf+xHFhDVHQBpcaivorHqOZw/CCzd4cHnWC/rkL8lV5Hr6r6
 1GN/1mj9j8KduitPrfBdHenRDpNScR0a+DjFFX+kWr/ycazNUhRVy2Z4wvohJg8jPpR8P0fhB
 KyaZIm8nLE5CLkIYAVUBCcdsI25PAVhMACmirokWz5Kzqt1uhRUDqUUE4+CxEz/RW3nkGyrWq
 FvPrd0HmbuXHfqNZa
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 08 Feb 2020 13:56:14 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 08 Feb 2020 13:56:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] Linux dev-tools: Handling complex types and attributes
 in Coccinelle
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

> A little collection of scripts/tools I've written[1],

Thanks for your link on another bit of background information.
https://github.com/jajajasalu2/cocci-type-test-suite

Would you like to point any related information sources out?


> and the invaluable OCaml debugger :)

This development tool can help occasionally.


I am curious if your contributions will influence also other known open issues
for this software in positive ways.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
