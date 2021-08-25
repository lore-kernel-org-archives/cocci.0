Return-Path: <SRS0=IoeI=NQ=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E155CC4338F
	for <cocci@archiver.kernel.org>; Wed, 25 Aug 2021 10:56:57 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A3361100
	for <cocci@archiver.kernel.org>; Wed, 25 Aug 2021 10:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99A3361100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="525157409"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Aug 2021 12:56:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ECE59E02D5; Wed, 25 Aug 2021 12:56:53 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3C1F1E002F
	for <cocci@sympa.inria.fr>; Wed, 25 Aug 2021 12:56:50 +0200 (CEST)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AAK8Vkxcjtk5Lq+prCmDZFpUVlGM+I97LVj580XL?=
 =?us-ascii?q?Ho4xHfqnrxZn+JkuXvawr0AWRG9SCoK8bw8Pt8InYEVQa5piAtH1QOLdtbDQiz?=
 =?us-ascii?q?fssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB?=
 =?us-ascii?q?1JuPoEYLOksi7ze+/94PPbwlSgDexfLx+IRW0oA7MqsQYnIxuJ7orxBDUuHVIY?=
 =?us-ascii?q?eNWxW1pJVKXgRnx49q78YBg/SpNpf8v7tZMXqrmcas2S7xYFykmPHsu5ML3rxn?=
 =?us-ascii?q?DTBCA6WUaX24LjxdHGQnF7BX9Xpfsriv3s/d21SeGMcHqS70/RC+v5Ll3RhD2l?=
 =?us-ascii?q?CgHNiY58GDJhcx2kKJbuw+qqxhmz4LJfI2ZKP9yc6XAdt0YWGVBRN5cWTFfDIO?=
 =?us-ascii?q?yb4UBDOQPMuhXoIb/u1QAogCzBRWuCe711jNEmnH70K883u88EQ/GxgsgH9cWv?=
 =?us-ascii?q?XrTttr1LqQSUf2uzKLVwjvDa/1W2S386IjOfRAqvPaBU7VqfsrLykkvChjFgk+?=
 =?us-ascii?q?fp4zhMTOVzOUNs26U7+d7W+OglXUopxtsrTex38ohjJTCiY0JxF7e7yp53Jo1K?=
 =?us-ascii?q?sOiSE59edOqHoVduSGHOoV2Qc4uX2BltSg1x7AJp5O1fDUHxYgoyhPBavGLbZa?=
 =?us-ascii?q?F7xb/WeueLzp1gGxodb2/ihuy9UWtyenxW8+p21hEqSpFl8PDtnEL1xHL68iHT?=
 =?us-ascii?q?OF9/ka71jqV2QDT8OdJKl03m6rDM5Mt3KM8moQJvUjdACP7ml/6gLKUe0k+5+S?=
 =?us-ascii?q?k9vzrb7Hoq5OGKoN5hAHzPr4ul8G/G+g0LxUCUmqd9O+hzrPs51f5T69PjvAuk?=
 =?us-ascii?q?qnWrpTaJcMDq668BA9Vz5oj5wyxDji4y9sUh2QII0xddBKGiYjmJU3OLejmAfu?=
 =?us-ascii?q?inVigiilny+7EM7H7H5nALGLPnKr8cbpl7k5T0gszzdRR55JODbEBJer+VEjru?=
 =?us-ascii?q?9zCDR85Lhe0z/zoBtV52IMeQ2OPAqmWMK7Jv16H+PkgL/ORa4ALoDr9MeQq5+b?=
 =?us-ascii?q?yjX8lnl8QZa2p0oEZaX+iGvRmJ16UYHvtgtcECmgKpBAxQPbriF2ESz5TZmy9U?=
 =?us-ascii?q?7gy5jEhEIimF5vMRpixgLyd2ye2BoFZZmdaBV+QEHflbJ6EWvcJaCKKOMBtiD0?=
 =?us-ascii?q?EVb67S48gzx6irgH6y6A0ZtbTrw8FsZPqnPx8+OTXkVlm9yFwDs3b12iSRmVwt?=
 =?us-ascii?q?mIOXT4/mq5l9x9T0FCGhI1xmf9FDpR+4/1TUwE1fcr5xvZ5Fsu0dwbPZNaPR36?=
 =?us-ascii?q?5T9/gDTxnHYF5+MMHf0soQ4bqtRvExSf/RuZNz9Rj5bQx9b/AmWf8LYBxxiSev?=
 =?us-ascii?q?EHOp0YrSI1DOD//7kaa3xfeDcjFnhfB/5s=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AwKmvvahOA7v3OcGMPIEjLyCrPXBQXr8ji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHMoB1173XJYVoqNU3I+urhBED/ex3hHPdOiOF7AV7FZmXbUQ?=
 =?us-ascii?q?CTTb2Kg7GM/wHd?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BDAgCYahphhwsR49RaHQEBAQEJARIBB?=
 =?us-ascii?q?QUBQIFZAoMLFVc6MYRHkUAtA4QYjUaMBgsBAwENNQkBAgQBAYRhAoJrAh0HAQQ?=
 =?us-ascii?q?1BQ0BAgQVAQEFAQEBAgEDAwQBEwEBAQwNDgg6JIVoDYI1KQGDZAECAgEjFQgBA?=
 =?us-ascii?q?REbCwEECwsaAiYCAlcGDQYCAQGCbQGCVAEDDiULp2yBMYEBggcBAQaBPgEDAoE?=
 =?us-ascii?q?VghIfLCJQgVoDBoEQKo1zJxCBVUSBPAyCQjA+hBxBgn6CZINLggdbgg2fR4tdk?=
 =?us-ascii?q?XAtB4IAgSuBNwuIe5QABhQmg1MSi2OGAQ4GkRgroiSZB4F4gXwzGiRPgjUBATJ?=
 =?us-ascii?q?QGQ6OIAwNCYQDgQuJIj8yOAIGCwEBAwlsAQGGQYJGAQE?=
X-IPAS-Result: =?us-ascii?q?A0BDAgCYahphhwsR49RaHQEBAQEJARIBBQUBQIFZAoMLFVc?=
 =?us-ascii?q?6MYRHkUAtA4QYjUaMBgsBAwENNQkBAgQBAYRhAoJrAh0HAQQ1BQ0BAgQVAQEFA?=
 =?us-ascii?q?QEBAgEDAwQBEwEBAQwNDgg6JIVoDYI1KQGDZAECAgEjFQgBAREbCwEECwsaAiY?=
 =?us-ascii?q?CAlcGDQYCAQGCbQGCVAEDDiULp2yBMYEBggcBAQaBPgEDAoEVghIfLCJQgVoDB?=
 =?us-ascii?q?oEQKo1zJxCBVUSBPAyCQjA+hBxBgn6CZINLggdbgg2fR4tdkXAtB4IAgSuBNwu?=
 =?us-ascii?q?Ie5QABhQmg1MSi2OGAQ4GkRgroiSZB4F4gXwzGiRPgjUBATJQGQ6OIAwNCYQDg?=
 =?us-ascii?q?QuJIj8yOAIGCwEBAwlsAQGGQYJGAQE?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="525157397"
X-MGA-submission: =?us-ascii?q?MDEMG5yRDv2xhL+eXGG3C8UsAY5ZLzJV8C6mCV?=
 =?us-ascii?q?QKbd9tR6qxazh5RJ3lHjZtOWZPJ+sxOLXkuqYLt4/LP84OGqbPSzmelW?=
 =?us-ascii?q?zpZABmuPOes9jN0iydc8dR2WjGzmiIKJ34QXiBCLJ/AUvogQhmPay6qU?=
 =?us-ascii?q?XWV/LtI5qdY8c9PL1jctSotw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 12:56:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1629889008;
	bh=m6UTms47/MuBLfAgu3uHEb3dZlnFjclp7hdpPZhIAVc=;
	h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
	b=BDMX219t5eErjX4sSHXEMoefEfnLaLQk2RhhFfAY9+p6Qbi0Z1agzVZZyGvcXGs1H
	 tFkrS+HcQgixrUVDizEH6WrkBkIsMYSRF3SvKMw6mORGkR+C0TlOLyCEmQ3/GEjZZ/
	 wzu02jWw9W5sU+ETvQn7l4K+HK03iHeBmXm0epbo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.55.117]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8iPI-1mB7sa1SiS-00CDNp; Wed, 25
 Aug 2021 12:56:48 +0200
Subject: Re: Checking time dimension for the migrated message archive
To: Julia Lawall <julia.lawall@inria.fr>
References: <alpine.DEB.2.22.394.2108251014070.7158@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Message-ID: <379c9142-7739-e417-dece-127423b4c4a7@web.de>
Date: Wed, 25 Aug 2021 12:56:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2108251014070.7158@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:E6FAfUDizqdu//DzARWXlz3z3YJuCVNF5IlPLPxcWBxPifYtyiX
 uEacWKHFIDF6KwH/i7r+Mjp8QFmI+rbnbuQVs2pE4GwBnwolvZekan2eKXZcdH8HFkLj75P
 9+8SckiOgK8jAjRjNyJxn46MCexLbZcLQDKMcrUtQhh+x3OLmSlUOTn2HRDn/k22IVRg6zp
 AZ8/CxKNUQ8i1zbsSQUXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q7AuxZCy/8Q=:rn3zUNbNmy+9KyXPNdxCqj
 jqiQrP/2ErWTZ+BSoByqmwpvhXUJxWSb2GSoE1mU5uCuUbkQD0QQn+uXDMdbXFJIdSa3c1oYO
 yeR8K34bBuMrQYB8JQKtDBox3An3siHkMGMSepzmYPmPcoFgkDNPsiPRtJNOOSIYSklaYiZr7
 CCeBi1+wK/F2wh18SNeIjeVnaQShtxC1vcqLEX2tfqEm46b40WveSyduulIVnB6SScxuY0f3i
 5lptcZnIUbluBHQ+CamgD6Km1mFDEYROs8utwU+cv+TAAr8F92EHqDApG8hKZnuGhITxPc/k/
 h+LLLOCj9EtxmB8j2GBPmQ/2foQExlXid1b6N7olddL0xKhA2sENVIlKgTBZUeC/6gUUcyC7c
 KwfKRGSg4gOuVZG7FvVdroeFk3zEsjbFjRofLhPY52nfBSBYfsNBLfo7GuLyZtAv4AVK+Rxzo
 nZN0UIz2xWjugYEnpCvRfd5H3MfTn+YdzZ5YCils83mnlGlm5nW0ThEqRLkx9KsnGBIphx4Gp
 Ln52ZZ42K+oJfIMKw294pQm9pzgifwdB+bu9esyUBCZxNWpiaPQsTykXw2EqvN/938o0V2dbc
 ySoo7WSbzOpknPn3zW7W1hbsSX4krpe0KZhpBU8H8UFF6W5RHpcLXULL+Yl7Nud8zoo5twDpS
 NVIB4HWEpl+lXDME8tZcHMApesLgnHt7uRLTYFrwRrVSfBQHRO8XXriDZOOBH+Ae8V0H5NGAz
 bNGyvLxNDzbaJuoOhgYxJOF/7VsUe7RxQwRhqGkVVZJm4na46LDrBvAqL5CcOBQUpXc7+43e/
 kS4ik1E63uO1MsKv4EdtpulCMr5XZLxMgZUpyA17SwFGKnuxLFYbz/M3/SpYWcPiIgO9Qu9oh
 RUb9aIt0cZgGZtE9kpFVZY4ZN0Yv57Ai8ca0JtD2laGZiBgD9k81Hty58ciIjHiQeYOLROKWW
 jhmnex6b9gPclKKhFNW2ruWzwThs8aBSVu1ZLzTEhu+py+qqCIDPI/K3fkBIHTlJx+XNeXq9U
 +Vy1xqCm9OHRPijjIZ/50Pw+9VvYtmnbOwe7lwXBQjikas2C/4612cLcUQM7SFjmbT/gQC2aD
 WlkcUWUhdQGsXFcFhaBRb+A6qUoWUy1UbNAWJPPFdtIbRCVgN6n+gviBA==
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-08/379c9142-7739-e417-dece-127423b4c4a7%40web.de>

> The Coccinelle mailing list has been migrated to Inria (cocci@inria.fr).
> This mailing list uses sympa rather than mailman.  It should be configured
> so that everyone can view the archives.

Thanks for another information.


> Please let me know if there are any problems.

Did you limit the amount of messages in the archive to this year (or even
new data because of the switch) intentionally?
https://sympa.inria.fr/sympa/arc/cocci/2021-08/

How do you think about to extend the time range for searches in the history
according to discussion contents?

Regards,
Markus
