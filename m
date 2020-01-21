Return-Path: <SRS0=kxF3=3K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC74C2D0DB
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 09:57:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDF120882
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 09:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hd+VnX1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDF120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L9v11A007328;
	Tue, 21 Jan 2020 10:57:01 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F13A177E1;
	Tue, 21 Jan 2020 10:57:00 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B099577DB
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 10:56:59 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L9uwaI023721
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 10:56:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1579600617;
 bh=dt1jt9pSwcGGnPZLg62VDnvqmFQRxIbXRYuVwEmInNc=;
 h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
 b=hd+VnX1t8IEZyI8ag1L6umxAa27B/NGJlF9vZURe0nOrmdtNn27lnz3mCzE9V+Axg
 PPJoQD8qoMdpmE895tyyCndl4X8rs1GDiTwcuFQHGqx8qgjiDXARI5HjA+3scLYuJJ
 V4n3ABcg0NZ75X27InzSy6yAp5gFcqe4qDRa/kKQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.33.93]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUBPu-1j23SN0Iny-00QyPh; Tue, 21
 Jan 2020 10:56:57 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7f56dadb-0fde-359c-2b88-f812b0858ac8@web.de>
Date: Tue, 21 Jan 2020 10:56:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:CUC1lwa25JVFAIT1WzeiMV9Li5jUPZHH33Sdi3OlrZDrCEPwlx/
 vVJMGpBoSkPiDD5jWnsVAYMJl8q2IRG3aj72XVazB8n5a3aJo3hs2fGJI4o3oQ2A9xP2oqL
 qQ2mJ5NANNvp8Cyr1F4T9goYjf+4Xi00E5Y+usFL5box4bVTgpxE50FoFpJZM2aiJsVJhuU
 x7vO+tTizf9ypLlXYGQVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xy/kaGqoJxo=:W8GNXF7P/4OfejcyJV1VoD
 4bWrr5cFuEW0rRKTrHOK+Hjm0jX98TuDIAuaitWwgV9B22VjELTlx/aaMHQGKNcY3AlXf++od
 I/ptD0P8Xtz/yAFoYzfdnknJmX1WLQ2d8Yhr729r6BMkmy0oxQ01SssktE++oTAzvmGc7r0w9
 elmtRPrOGNL2vckpgdtQZA9sGUFglxaFsddoqxTnpq4GxzGBTWqiBkCXnmKA9rRYpFYAIxpZr
 KuyVvVMm/l4Gwe8yl9Jnn737t/huBnN39m3JDWVBrVBjDLAS6vmDmqqb+bI1lEqjVAi/tel0z
 hagoE6+hOmIL6+w4QrPIOlLYFN7ivPHLNbqUJsdx25QPOhK1LZXSaCEaeax8z85eXwTMGy1bK
 NkIbqKA6s8I5AUS+rJP4U4uD+T5evXMZliEVfJ+xLi3dwM189NUeHFiE2U0JRkMCpkv8A6KQn
 n43yq8DZQ639r8yPvGRlIbW0tzA09CIk1uAG0GbZjzcIrTNBHqaB2BpLl+HOUiZhUES9eRXmS
 7ub60R31U9+N39TCCe0/71Xe3Mb+ZbaZeGBseSQ8McwXfXYnulOBeoI3KDGUQ2gPCgoc3D4xi
 s3hxlnBRfeWTSqEBt06BL6kKrAvcab1GOmarupEJiEkf4z5h5joTqOmaIsGHUmS9hFcNxdHD/
 00oJu6bmeeQXKyNMl4HtLKx0egroRogzvYHE3Hx8OVSlK2qvVB8WCkTRNvoJj+IsSZRcWkdzu
 inBnw95kNe4W9Oz9Yxzx/9mFPWHhJyOh5oe4mwHm0kU6grd/bYFsJ26iN4HjGues3RN/I+Xoy
 nGBsMHvt8expL4z0MJwDBYNLQKOhy+MQB0XZIw8v1IKIiUmysG9NPLzlPC1bqT//1BuI5G6F0
 iZCQewH1sQmY06+V4JDxkZgFd/0jCWZsuTGZIjCGbdI2bNlV2MrvwoqZQlUqQN5hiLo0UBwU2
 Co9QciFWbi6X7pCPraFs2g9JUMXA0gGqWtpVFgQVRLnoTXwxzD0968Xtz3IaeD4627FSxDr+M
 aFspBzACQsggZmRPyNVmbkVlGIp4U0HmmAHUb/Vq5XI+jOv32mbUQxT5LAwDC1lGFODB5ua3/
 Qz0gVwNVO5fGB6jZkA4qXFb24lC8yzUfWk2mYwL1ZJri7aIsHaj6ZARIuMnqSatueusHSieXN
 7vuGWeHuSLjhukIxksbbYPv9GSgQpVr6iL54jzZ2vFyJN+U/xFof1NR1gZPXr/lPXpXkh6/T/
 YqQCbX00hwRVja+vLJhQ2PDhApNYpx0EMkO41vKX9JMesMg6OmnWsW2wERfk=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 10:57:01 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 10:56:58 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH v2 0/3] cocci: Improve management of macros
 before typedefs
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

> If <typedef> is a known typedef (such as u8 or *_t) then label <macro>
> as a CppMacro. Subsequent cases will label <typedef> correctly as a
> typedef ident.
>
> Also add bool to the list of known typedefs so that cases of

Can a wording like the following be nicer for such a change description?

  Label <macro> as a CppMacro if <typedef> is a known type definition
  (such as u8 or *_t).
  Subsequent cases will label <typedef> correctly as a type definition identifier.

  Add bool also to the list of known type definition identifiers so that cases of


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
