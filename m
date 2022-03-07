Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35085C433EF
	for <cocci@archiver.kernel.org>; Mon,  7 Mar 2022 20:55:18 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24873086"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2022 21:55:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9F528E00BB; Mon,  7 Mar 2022 21:55:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 69EB0E004B
	for <cocci@sympa.inria.fr>; Mon,  7 Mar 2022 21:55:13 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24873082"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 21:55:13 +0100
Date: Mon, 7 Mar 2022 21:55:12 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
In-Reply-To: <52d3cc40-8526-d031-6b5e-703dc7015ac9@web.de>
Message-ID: <alpine.DEB.2.22.394.2203072149430.3091@hadrien>
References: <818d2b72-e28a-ba5e-661c-cba9fe9914ca@web.de> <70ad3def-a4f-14b4-cb70-acfe4a516d9b@ewheeler.net> <52d3cc40-8526-d031-6b5e-703dc7015ac9@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-124220127-1646686513=:3091"
Subject: Re: [cocci] Checking the isomorphism =?UTF-8?Q?=E2=80=9Cptr=5Fto?=
 =?UTF-8?Q?=5Farray=E2=80=9D?=
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 183
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203072149430.3091%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-124220127-1646686513=:3091
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 7 Mar 2022, Markus Elfring wrote:

>
> > Is E2==0 enforced somehow?
>
>
> I guess ‒ not yet.
>
>
> Will any more extensions become relevant for the Coccinelle software
> so that the semantic patch (or isomorphism) language would be safer for
> the shown use case?
>
>
>
> > What is rule27?

There is a dataset called bigtests that was derived from the EuroSys 2008
paper that has a collection of rules with names with numbers, such as 27.

FWIW, rule27 is as follows:

@@
struct BCState *b;
struct IsdnCardState *i;
identifier f,g;
@@

<... // needed to get f and g bound at the same time
(
- b->BC_SetStack = f;
|
- i->bcs->BC_SetStack = f;  // have to help the type checker along
|
- b->BC_Close = g;
|
- i->bcs->BC_Close = g;
)
...>

@@
identifier str;
struct BCState *b;
struct IsdnCardState *i;
@@

(
i->bc_l1_ops = &str;
|
b->cs->bc_l1_ops = &str;
)

@@
@@

struct bc_l1_ops str = {
  ...
+ .open = f,
+ .close = g,
};


julia
--8323329-124220127-1646686513=:3091--
