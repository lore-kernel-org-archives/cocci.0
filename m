Return-Path: <SRS0=6LBi=PW=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582C8C433F5
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 20:37:12 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4406103B
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 20:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D4406103B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3ABCpinatQGNGnySWVL05iTFddtefnVEdfMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3nzQcD2iOM/aMZGvzc9B+Ooji8kkFupeDxoA1GldtrnhgHilAw?=
 =?us-ascii?q?SbnLYTAfx2oZ0t+DeWaERk5t51GAjX4wXFdokb0/n9BCZC86ykjvU20buCkUre?=
 =?us-ascii?q?dY3gqHVQMpBoJ0nqPpcZo2+aEvvDpW2thifuqyyHuEAfNNwxcagr42IrfwP9bh?=
 =?us-ascii?q?8kejRtD1rAIiV+ni3eF/5UdJMp3yahctBIUSKEMdgKxb76rIL1UYgrkExkR5tO?=
 =?us-ascii?q?Nyt4Xc2URU7vKNE6PjGBXUu6smHCupARriPZ9ZaFaMBkNzWzXx7idy/0U3XC0Y?=
 =?us-ascii?q?QwuNabN3eMCVRRCOyB4J6xPvrHdSZS6mZXDnxWbIyGEL/JGSRte0Zcj0u1wCmp?=
 =?us-ascii?q?P3fUCIzAMcB2ZweG72rS2Tq9rnMtLBMPqJ5gOtH9IwjTQDPJgSpfGK43B4tJe0?=
 =?us-ascii?q?TEYicVHHPKYbM0cARJjZRKGYVtQO1MTCZs7h8+ng3D+d3tTr1f9jaY+/Wnf1wt?=
 =?us-ascii?q?33LbiNPLaf9WLQYNemUPwjm7LuX/+HwMTcteY0zeD7nOqruDKlCL/HokVEdWQ/?=
 =?us-ascii?q?eV3hFmC7mMUDxISWB2wpvzRokSzXd9TKk8I0iojrK4/slasRdrmNzWzpHmDpTY?=
 =?us-ascii?q?eW9FUFOohrgqKz8L87w+fB2UACDpMetcvssgeQT0s30WO2dTzClRHu72PSGmB8?=
 =?us-ascii?q?a+U6zm1NCgQMmYGaSIeZQ8E5dPivMc4iRenczrJOMZZlfXtAzb8hjSLtzQznKh?=
 =?us-ascii?q?K3YgK0b+69BbJmVqRSlHyZlZdzm3qsqiNtGuVvLKYWrE=3D?=
X-IronPort-AV: E=Sophos;i="5.87,206,1631570400"; 
   d="scan'208";a="1880582"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2021 21:37:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9CD15E004C; Wed,  3 Nov 2021 21:37:09 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8A542E004C
	for <cocci@sympa.inria.fr>; Wed,  3 Nov 2021 21:37:08 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AAEfSCa6qaSXAvMqaOgPXwMPXdLJyesId70hD?=
 =?us-ascii?q?6qm+c3Fom7+j5qSTdZUgpHrJYVkqOU3I9eruBEDEewK/yXcX2/hzAV7BZmfbUQ?=
 =?us-ascii?q?KTRelfBMnZrwEIcBeUygcy781dmuRFaOHNMQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398172695"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 21:37:07 +0100
Date: Wed, 3 Nov 2021 21:37:07 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jakub Kicinski <kuba@kernel.org>
cc: Gilles Muller <Gilles.Muller@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Michal Marek <michal.lkml@markovi.net>, cocci@inria.fr
In-Reply-To: <20211103124001.68e76017@kicinski-fedora-PC1C0HJN>
Message-ID: <alpine.DEB.2.22.394.2111032134360.3289@hadrien>
References: <20211103124001.68e76017@kicinski-fedora-PC1C0HJN>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Best way to run coccinelle in a CI?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 63
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111032134360.3289%40hadrien>



On Wed, 3 Nov 2021, Jakub Kicinski wrote:

> Hi folks!
>
> I'd like to run coccicheck on all patches before they are committed
> to Linux networking trees. Is there a recommended way of doing that?
>
> I'm looking for a way to run the checks only on files which were
> touched and in the fastest way possible..

I had an intern who worked on an extension to Coccinelle to take a patch
and then only apply spatch to that file.  Perhaps I can resurrect that
code.

[Note the new mailing list: cocci@inria.fr]

julia
