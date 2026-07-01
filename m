Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE735C43458
	for <cocci@archiver.kernel.org>; Fri,  3 Jul 2026 08:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7DKV/SEW//yn0UiIpDnUslQDMVwhvr4SfKR0fDRkBvE=;
  b=IBl0qXZF9+OkXToHikck4QL1UcPfyCnc724M2UvYhgqEfOyX8hUkmyr0
   cqeYqCIC0IQDwUGPdMvY59ZH8pyVh6AH9wauDD8pvAZ7EBY2jkJd0wHlk
   MjNK8sBkXi+vyFVM1pFfiRh9ReUxFsVFv7pTJqtAj4bG89TbIE7e15ojf
   A=;
X-CSE-ConnectionGUID: 3HlvZsCkSwmM/vmZYbrBdQ==
X-CSE-MsgGUID: NWKSrJWoS4OevsHPXpYgeA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,145,1779141600"; 
   d="scan'208";a="284704529"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jul 2026 10:29:47 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C75CE80137; Fri,  3 Jul 2026 10:29:47 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 84B6C81CB3
	for <cocci@sympa.inria.fr>; Thu,  2 Jul 2026 00:20:24 +0200 (CEST)
X-CSE-ConnectionGUID: 3P/jeCFWRcalaKVeUuhJKA==
X-CSE-MsgGUID: tHQ6RnXMQHGLVQitjnLoKA==
IronPort-SDR: 6a4592a8_hE9a/CSXhnm66etYpTsvtY3dsZbETXZduMQ8ZsxnTFIOW90
 +eKFBWvvTBpikfywEWbFPLSKxKVjpZq1HzqWQNQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ErAwCXkUVqgxEsKNhaHQEBPAEFBQECAQkBgWUCgj+BC?=
 =?us-ascii?q?l40BwhJBIRUiHuIfKAZDwEDAQ0UAhEdDQQBAQECBIR/Ao1NIAYBBDMGDgECB?=
 =?us-ascii?q?AMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEBOQcOO4ZPD?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEdAg1+AQEBAyNWECMCAiMDAgJFEQYTgwIBg?=
 =?us-ascii?q?nMDBQy9K4EygQGEftlFgWwGFIELLgGFcIJqAYFwiQJCP4FOhg2HD4JqBIIig?=
 =?us-ascii?q?QyRQQmBQRwDWSwBVRMXCwcFgWYDgQZuMh2BIz4XNFgbBwWBHYFrgQSEeiMfA?=
 =?us-ascii?q?zl/gS91WGYVMDWBAgESHgqBUoEfAwttPTcUGwSOTRcPg3dQgW+lY4t4lReEJ?=
 =?us-ascii?q?wWBYYo7lgeqbJkIjBCBepVnhVEBgX0kgVxNIxWDIlADGQ+OLQ0JiHPJQicyA?=
 =?us-ascii?q?gE6AQEHAgcOAwuBaJA0gUsBAQ?=
IronPort-PHdr: A9a23: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
 gnQw1N+
IronPort-Data: A9a23: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
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:dc/q26vPLT01CtC67wVjH+Ud7skDytV00zEX/kB9WHVpmwKj9v
 xG+85rsSMc6QxhPU3I9urhBEDtexzhHNtOkOos1NSZLW/bUQmTQb2KhLGKq1aLJ8S9zJ8+6U
 4KScRD4bPLY2SSwfyKhzWQIpIA7J2i/L2h7N2usUtFfEVKR+Vc5wkRMHflLmRGADJdHJI8Gd
 6l+sZaq36BdB0sH72GL0hAZPLbr9nH0KjregELHHccmXOzpALt0rLhCRif2VM/flp0sMsf2F
 mAqQDi/KWktLWewgTf23S71eUqpDL+8Ko5OOW8zvIJIiipsAanY4x9R6aP1QpF2N2S1A==
X-Talos-CUID: 9a23:6GMKb2+YH3/w66dpv7SVvxUsXcIoWVPi9nzZJ0abN2tUVb23anbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AjUZdFQ5uBGcsYSEiY2Oc7hW1xox0w53wMkY9tKw?=
 =?us-ascii?q?mlO26DC1sOTG5ixeeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,142,1779141600"; 
   d="scan'208";a="151027010"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHe+tyK8BKrSundcKNMCWDxgtqbmf2gcTL+/p?=
 =?us-ascii?q?YIqjFsUQ2LnCQYpF2v7EHVEcLq4t6JQD6fGNw33T1r9ajAYQ5IbKRcAK?=
 =?us-ascii?q?UlPK2iCJpGRg86mkQvrhSui5maxLYVX6hh5B4tV+OZFunMzQjeH6pwMQ?=
 =?us-ascii?q?mgpRt+k3dc8YihHqUuz+o67A=3D=3D?=
Received: from smtprelay0017.hostedemail.com (HELO relay.hostedemail.com) ([216.40.44.17])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 00:20:23 +0200
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 5EEB01C3810;
	Wed,  1 Jul 2026 22:20:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 4C6FA2002D;
	Wed,  1 Jul 2026 22:20:18 +0000 (UTC)
Message-ID: <ca5bdfaf3b5f4a785bccccd910c7c04c33089e13.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
Date: Wed, 01 Jul 2026 15:20:16 -0700
In-Reply-To: <20260630190843.3563858-17-liam@infradead.org>
References: <20260630190843.3563858-1-liam@infradead.org>
	 <20260630190843.3563858-17-liam@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4C6FA2002D
X-Stat-Signature: jayhejacek6u9nrq9cor3jgbc3sqgwzu
X-Rspamd-Server: rspamout07
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19oKT5EuoVNOwEAW9DodiG6J1G9wwSrbHo=
X-HE-Tag: 1782944418-78515
X-HE-Meta: U2FsdGVkX1+yj4rqGuFsCuDrqu9SyZnwqYi8xdmNpGspe787Wh/h+2xGvJHM3n12pjV70AZVauF8htJULRA2OtyOabiQt9gFRKeBtOi/JyHOpFHu7xmWwv+PoRtpv+LlMf1ZZ3EjQkc6zcT3cv/R1qb8skVCYe/iVqKHQewKjDOP+Cl7gTx/fdmO2Q97ny0cG88y5xKDhW9728Ccv12KPntXMcNtWY7MGArT74/Q+DFw0XBipBmAKR1pAVKBKc2+ckS7TqldbosQOd6+guaDtudEAnaWM+xVq9xRUAoWZ2X7Ase67UWSBbRSgXCn54Lg7brMRWD5fDmEN6Q+OSwpXh1aI6Ehyr2anNebUciVhTkeixIZnXZnD1KUV/EpiewWC/pulzr5huL0qN3wIYLDPQ==
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] Possible cocci test & that should be |
Reply-To: Joe Perches <joe@perches.com>
X-Loop: cocci@inria.fr
X-Sequence: 3592
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/CMLK-WnNuNvCwKyspIpYpw>

Hi Julia.

A suggestion for a possible (new?) test.

On Tue, 2026-06-30 at 15:08 -0400, Liam R. Howlett (Oracle) wrote:
> The GFP flags in two tests are obviously incorrect.  Make the tests
> correctly run by updating the GFP flags.
> Link: [https://lore.kernel.org/all/d9cbb89faa5bdb71d451781d214a51ce8923a8=
3e.camel@perches.com/](https://lore.kernel.org/all/d9cbb89faa5bdb71d451781d=
214a51ce8923a83e.camel@perches.com/)
> Reported-by: Joe Perches <[joe@perches.com](mailto:joe@perches.com)>
[]
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/=
maple.c
[]
> @@ -35234,7 +35234,7 @@ static noinline void __init check_prealloc(struct=
 maple_tree *mt)
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) =3D=
=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_NOWAIT) =3D=3D 0);

Is it possible for cocci to find uses of enums/constants
that are anded together where the result is a likely
unintentional 0 where presumably the & should be an | ?
