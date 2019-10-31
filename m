Return-Path: <SRS0=W2E7=YY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03974CA9EC3
	for <cocci@archiver.kernel.org>; Thu, 31 Oct 2019 12:27:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07ED22087F
	for <cocci@archiver.kernel.org>; Thu, 31 Oct 2019 12:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="LGfOuWds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07ED22087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9VCRgfr020497;
	Thu, 31 Oct 2019 13:27:42 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2753077CB;
	Thu, 31 Oct 2019 13:27:42 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BB30877BA
 for <cocci@systeme.lip6.fr>; Thu, 31 Oct 2019 13:27:40 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9VCReIo007404
 for <cocci@systeme.lip6.fr>; Thu, 31 Oct 2019 13:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572524860;
 bh=b3QLqTjOAR6B6+Wpf/EMQV5TokSyEuMxrZt+3W5XYgg=;
 h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
 b=LGfOuWdsyhfZMMKogLGYVdc0ZNfqkmeDE7bd1wPtf/9NLpmxYzsvxGag51zib2H+Y
 yEYXj2DYGxY/p7wURhX1/nxEl+HGGs/O0Giv7QwV1fBs1F7gUx7XnqisiuD/JNAyWn
 trS6nXyvhvq7dGNa2la+0AvKrgb/iwRg/9k5iZu0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.137.160]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lkh7Q-1hrvGJ3Wo0-00aToV for
 <cocci@systeme.lip6.fr>; Thu, 31 Oct 2019 13:27:39 +0100
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <708207db-69d7-8962-e507-cd705142d0c4@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <226b4ce7-8284-ed03-a478-98e3e532cb15@web.de>
Date: Thu, 31 Oct 2019 13:27:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <708207db-69d7-8962-e507-cd705142d0c4@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:BVOW00ynAxiGeDNCz8qsm3NYWB4LVFybZY5/MFTG6ZfFcjY+d9H
 qBsTlTg/fNHo0XvirHnCZut4cCmlVHlxt8MLfEKmIm1pHwBO+sNhazKl1ry8sxl6V1tnu55
 bsRh6v9WaoJpeyUk5S3UcSHtQk5WCApiW3FJ4Bo7kkS1cvySzcz8VNqMp6aa4dBLzxqTY8T
 ACUQWsKQI1F/BlYXGEx+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vmFNNOVoLR4=:iqzKGSeaLAuvXRusAtRNPT
 nRvVGnQncuv67sSpunJss27tHzQZnmAabn7cQMkUvqx544RruVwYoZXgRoUqTOwwxZ0SYTeHw
 AZ/2WbE63TYWT+DmYYtDWRIuKAarxzUkORxWOk6xKOokz9I2BSgF3X75OpFqlD0KnE8xNjQ49
 52vwugd59JEZfwshSfnaMbiSgdtVLS+NMYZ+Jr7hWBxOdiXCJEF8IhB49n8Hfc2klcjvZjwV8
 eaK91o/NYE34xQADvXE7b1iqKUY+VIpU2W/2iRKQXRq6VhTZkrkyHfdQLT4Z0zet0DQMhhBHy
 61jrVBVAPztXFwupgHD0+8lWvh5wxc4hfPgAgaDPvN7qXwUSUvt9zUn+F0yW90tGPzI8rbIW/
 Z16fXQOWztJuTJadJkRSHuyaQzVHAIs660Gkccn1bVdntN099qdsf5dr+w6Ye5NpvXyHNy2BL
 DugUoB6NoIwkyoN/lBe1XY58V6e6/JpopAEggPLlgaEaAqsrH7t+mWRjiLiB0JWgVk1z8wcE8
 1ysfWEtEIY8QRIysNmqocQMswF3sHY+A0LZ2bHfQBMdxt3rV9MSHf+ExvF+q919mkNmXza/KE
 HBgblo92SQKrzCll0hBcYtR2QDMzrQ/HI/DwYLp3GTB+R1QI+tqTZjQcV2ISRhq6DpTi/AUdA
 k9ZqeqO4V38qKHngnirPskldXdMSJBVfzdsMfovrnHtVgu/9H3QRRb34BgGyaq0mQZvmUmut3
 gciu0yFeE4ac+xJnGbZBAKIa4g+Stf9oktGEKuO0AOX9Y53DyARQvoL9H/8ztlVXsegOKTFbk
 NVl+64AZQlqlv8ZS3BEX63vADhq8/ONrMo74fu8u44tZFTwlbN4o5Z8MzF/JfuJ+5wtREs+eu
 +IXIPZxt9v/CIr0dVUsOEXU86dBp8z/oRxfYkVIdCHy9ai2stBMBPA22/bBQGeDLSnBzR6kWi
 UTdX33UXtcRPO6zHm3fzOplYpOlirbwIt+xaTZdJVDiTc1HMigaxTUMC60CrmKccY3lIyJlPY
 z05kW7FNtVyYieluymbHDJtrLGpiCmHi5hFYggj4+zeD/PsU7uWGQSVulGeTMGg4L9jQLs1L8
 OF4wNYF4njhrTuZi/mnDNN2ifO0NEaLOxqeaE3LUN9g732OI4E3NGZb3Wl9VAHIpOgDUTXnol
 LAG+wEVBOTy1AL1RgIzP9Th5Y8LFHdwdZPHmKnWCPldr45tAlx47TmjpiwASUWska/g7Bw26O
 WmSBFsSnu8CzUAN3yVdXA7ivztIP7Kf8Rt7jkZSN9meYsgqWr/VEJK19Ncr0=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 31 Oct 2019 13:27:42 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 31 Oct 2019 13:27:40 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Moving exception handling code to the end of a function
 implementation with SmPL?
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

PiAgIFVuZm9ydHVuYXRlbHksIEkgc3R1bWJsZSBvbiB0aGUgZXJyb3IgbWVzc2FnZSDigJxyZXBs
YWNlbWVudDogYWxyZWFkeSB0YWdnZWQgdG9rZW46Cj4gICBDIGNvZGUgY29udGV4dOKAnSB0aGVu
LgoKSXQgbWlnaHQgYmUgdGhhdCB0aGUgdHJhbnNmb3JtYXRpb24gYXBwcm9hY2ggd2FzIHRvbyBn
ZW5lcmljIGZvcgp0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIGZ1bmN0aW9uIOKAnG1lZ2FzYXNf
bWdtdF9pb2N0bF9md+KAnS4KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuNC1y
YzUvc291cmNlL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhcmFpZF9zYXNfYmFzZS5jI0w4MjU4
Cmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRz
L2xpbnV4LmdpdC90cmVlL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhcmFpZF9zYXNfYmFzZS5j
P2lkPWU0NzJjNjRhYTRmYTYxNTBjNjA3NmZkMzZkMTAxZDY2N2Q3MWMzMGEjbjgyNTgKClRoZSBm
b2xsb3dpbmcgU21QTCBzY3JpcHQgdmFyaWFudCBjYW4gZ2VuZXJhdGUgYW4gdXNhYmxlIHRlc3Qg
cmVzdWx0LgoKQHJlcGxhY2VtZW50QApleHByZXNzaW9uIHJlc3VsdDsKaWRlbnRpZmllciB3b3Jr
Owp0eXBlIHQgIT0gdm9pZDsKQEAKIHQgd29yayguLi4pCiB7CiA8Ky4uLgogaWYgKC4uLikKKAot
ewotcmVzdWx0ID0gLUVOT0RFVjsKIGdvdG8KLSAgICAgb3V0X2tmcmVlX2lvYworICAgICBlX25v
ZGV2CiA7Ci19CnwKIHsKIC4uLgotcmVzdWx0ID0gLUVOT0RFVjsKIGdvdG8KLSAgICAgb3V0X2tm
cmVlX2lvYworICAgICBlX25vZGV2CiA7CiB9CikKIC4uLis+CiBvdXRfa2ZyZWVfaW9jOgogLi4u
IHdoZW4gZXhpc3RzCiByZXR1cm4gcmVzdWx0OworZV9ub2RldjoKK3Jlc3VsdCA9IC1FTk9ERVY7
Citnb3RvIG91dF9rZnJlZV9pb2M7CiB9CgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2Nj
aUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5m
by9jb2NjaQo=
