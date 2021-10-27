Return-Path: <SRS0=/5U0=PP=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EA9C433EF
	for <cocci@archiver.kernel.org>; Wed, 27 Oct 2021 05:24:35 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C03E61073
	for <cocci@archiver.kernel.org>; Wed, 27 Oct 2021 05:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C03E61073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AcuBIsarS8hfdziFH2rgNAAmrQgNeBmIOZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmZNW2jUbKyNNDf2L9AgPdu09B9T78TXz4A3HQU5rn1mQiMRo?=
 =?us-ascii?q?6IpJ/zJdxaqZ3v6wu7rFR88sZ1GMrEsFC2FJ5Pljk/F3oPJ8D8sislkepKmULS?=
 =?us-ascii?q?dY3grGlc9IMscoUkLd9AR09cAbeeRU1vlVePa+6UzCXf9s9JGGjp8B5Gr9HuDi?=
 =?us-ascii?q?M/PVAYw5TTSUxzkUGj2zBH5BLpHTU24wuCRroN8RoZWTM6bpF21E/+wwvsjNj+?=
 =?us-ascii?q?luu6TnkwiWa/XJQHIi3xMWqHkjAIqSi4ai/xrcqtHLx4J0XPQwYgZJNZl7PRcT?=
 =?us-ascii?q?S8iOabHmaEaTB9VCQl/O7dH8fnJOxBTtOTNkhWbLyuEL/JGSRte0Zcj0u1wCmp?=
 =?us-ascii?q?P3fUCIzAMcB2ZweG72rS2Tq9rnMtLBMPqJ5gOtH9IwjTQDPJgSpfGK43B4tJe0?=
 =?us-ascii?q?TEYicVHHPKYbM0cARJjZRKGYVtQO1MTCZs7h8+ng3D+d3tTr1f9jaY+/Wnf1wt?=
 =?us-ascii?q?33LbiNPLaf9WLQYNemUPwjm7LuX/+HwMTcteY0zeD7nOqruDKlCL/HokVEdWQ/?=
 =?us-ascii?q?eV3hFmC7mMUDxISWB2wpvzRokSzXd9TKk8I0iojrK4/slasRdrmNzWzpHmDpTY?=
 =?us-ascii?q?eW9FUFOohrgqKz8L87w+fB2UACDpMetcvssgeQT0s30WO2dTzClRHu72PSGmB8?=
 =?us-ascii?q?a+U6zm1NCgQMmYGaSIeZQ8E5dPivMc4iRenczrJOMZZlfXtAzb8hjSLtzQznKh?=
 =?us-ascii?q?K3YgK0b+69BbJmVqRSlHyZlZdzm3qsqiNtGuVvLKYWrE=3D?=
X-IronPort-AV: E=Sophos;i="5.87,186,1631570400"; 
   d="scan'208";a="650548"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2021 07:24:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4DFAAE001D; Wed, 27 Oct 2021 07:24:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 01291E001C
	for <cocci@sympa.inria.fr>; Wed, 27 Oct 2021 07:24:24 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AW1F26q4BXac+uQWOCgPXwM/XdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX2rauTdZggvyMczQxxZJhCo6HkBEDjexPhHPdOiOEs1PWZLWrbUQ?=
 =?us-ascii?q?CTQr2Kg7GP/9StIVydysdtkZYlSaR4BdHqZGIWse/x6mCDfOod/A=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397470564"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 07:24:24 +0200
Date: Wed, 27 Oct 2021 07:24:24 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mansour Moufid <mansourmoufid@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110270723001.2966@hadrien>
References: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Feature request: print status messages to the terminal
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 41
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/alpine.DEB.2.22.394.2110270723001.2966%40hadrien>



On Tue, 26 Oct 2021, Mansour Moufid wrote:

> Hello,
>
> This is just a small thing, but at the moment spatch prints such
> messages to stderr:
>
>     $ spatch x.cocci --dir linux-5.14.5 2>errors.txt
>     $ cat errors.txt
>     HANDLING: linux-5.14.5/arch/alpha/boot/bootp.c
>          (ONCE) already tagged but only removed, so safe
>     diff =
>     HANDLING: linux-5.14.5/arch/alpha/boot/bootpz.c
>     diff =
>     HANDLING: linux-5.14.5/arch/alpha/boot/main.c
>     diff =
>     ...
>
> It would be nice if these lines were printed directly to the terminal.
> That way, they would be visible, but not in stdout or stderr.
>
> I use --very-quiet, but I do want to see these messages, just not in stderr.

I don't want to see these messages.  I at most just want to record them
for future reference.  So I think we would need a new option to offer this
behavior.  What would you like it to be called?

julia

>
> Unfortunately I don't know OCaml, but here is how to use ctermid to
> get a stream to the terminal:
>
>     #include <assert.h>
>     #include <stddef.h>
>     #include <stdio.h> /* ctermid */
>     #include <string.h>
>     int main(void)
>     {
>         char *tty = ctermid(NULL);
>         assert(tty != NULL && strlen(tty) > 0);
>         FILE *f = fopen(tty, "w");
>         if (f == NULL)
>             perror(NULL);
>         fprintf(f, "ctermid() == %s\n", tty);
>         return 0;
>     }
>
> All the best.
>
