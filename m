Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C545D3ABD1
	for <cocci@archiver.kernel.org>; Mon, 11 Nov 2024 17:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=efIJ57EG+FR/mx3sxhLnrazIY3/9h6J3uK5MUY6f+0I=;
  b=CwSJvpXbXJdo6cMilTD7W1/bNAjFUHmWdb1qr6qyfTFa9qgVTBQK4Erg
   lQJJtevUoT3hq9Fs0JU0e99wE++NgjHS2j51A5fBcOe6Fz2vfs/8ZHR/a
   XiFeNT/UoJM6J0clHlyJWILBjcWNOInlTloJ2aFnvsbaMNqEdZj6NAuZi
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="scan'208";a="193203360"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2024 18:31:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8E3E5E0D1C; Mon, 11 Nov 2024 18:31:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 65D42E00B7
	for <cocci@sympa.inria.fr>; Mon, 11 Nov 2024 18:31:39 +0100 (CET)
IronPort-SDR: 67323f7b_kcoTv32Z+vSd8WHbiyGM3u8P+CzcOKmDTqCr0f4e6o+woPQ
 NIrMpZ1KemzxWVr0PeMP6adFSr3Iozx/1mD0+cw==
X-IPAS-Result: =?us-ascii?q?A0EmBgCDPjJnhY4kQ7laHgEBCxIMQIFIC4JEgVczBAuFH?=
 =?us-ascii?q?oh8iDBFEaACDwEDAQ1CAgQBAYITgnQCijsCHgwFLgYOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQUBAQECAQECBAYBAhABAQEBQEmFQQg/gmIBg38BAQEBAgEjDwFGB?=
 =?us-ascii?q?QsLGAICJgICVgaDFIJCIwcBr2x6gTKBAd4zgW2BGi6FaoJiAYpgJxuBSUSBF?=
 =?us-ascii?q?YMqPogeOoINIgSCQ3yEICWJFZhZUnscA1kyAUsKExcLBwU4cSIsA4JRf4E5g?=
 =?us-ascii?q?VEBglVKSoM8gV4FN0mCSmlNEAMDAwMDGAINAjaCDxVeH4JPhR2BC4Nkg06BG?=
 =?us-ascii?q?YFyMR1AAwttPTUUGwakbQGBcMcwhCSBYwyDAJxQTRODXpNckwCYd6kjgX0kg?=
 =?us-ascii?q?VwzGi6DLU4DGQ+FTohsyTtDcAIHAQoBAQMJhWkTiTuBSwEB?=
IronPort-PHdr: A9a23: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
 kxt4jY=
IronPort-Data: A9a23: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
 RvKeodG34xaNrH/d0fkVxLFTJKY0c62I/U=
IronPort-HdrOrdr: A9a23:H8xXxqzI+FCe2YQOsQn5KrPwI71zdoMgy1knxilNoNJuHPBws/
 re+MjzsiWE7wr5OUtQ/OxoV5PsfZqxz/JICMwqTNGftWrdyQmVxeNZjbcKqgeIc0aVygce79
 YCT0EUMrzN5DZB4vrH3A==
X-Talos-CUID: 9a23:ftZTXW3y1EDYBaGG1ZlwUbxfHswFbT7a0HXqZGS7Bk1CapO4cFG20fYx
X-Talos-MUID: 9a23:/W7RHAgAmkJDUgSJPFlV3sMpK+xB+ZSUFVw0ur4BvOibDigraznAg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="scan'208";a="193203351"
X-MGA-submission: =?us-ascii?q?MDF2aK0D5lypGV1agdbmdb9jZmCP2x8ZvHl2lL?=
 =?us-ascii?q?fJhC9CgPti1fGNrkGs0j7lM1hKGJ3A/epbX1qQJZsatNE+2bGOX8cvcg?=
 =?us-ascii?q?Io/ph1T7Pfi9lw/FzCLRNaOdEs6OtuCxE3rBQNL5bJi5CJGUptCXcnQ3?=
 =?us-ascii?q?y3culjPTBeJP7wkzzc5jE93g=3D=3D?=
Received: from mout02.posteo.de ([185.67.36.142])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 18:31:39 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id B5642240105
	for <cocci@inria.fr>; Mon, 11 Nov 2024 18:31:38 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4XnGn61zF7z6tyZ;
	Mon, 11 Nov 2024 18:31:38 +0100 (CET)
Date: Mon, 11 Nov 2024 17:31:37 +0000
From: Michele Martone <michelemartone@users.sourceforge.net>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Message-ID: <20241111173137.GB32356@localhost>
References: <2406a49d-1609-4af1-9af9-ee3496e48606@web.de>
 <20241111162413.GD10291@localhost>
 <1ecbac88-9afe-42a4-bb46-de3abe59b500@web.de>
 <20241111171232.GE10291@localhost>
 <a03b096b-8815-430e-bceb-9e04248c1831@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a03b096b-8815-430e-bceb-9e04248c1831@web.de>
Subject: Re: [cocci] EBNF for Coccinelle file formats?
Reply-To: Michele Martone <michelemartone@users.sourceforge.net>
X-Loop: cocci@inria.fr
X-Sequence: 1991
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241111173137.GB32356%40localhost>

On 20241111@18:19, Markus Elfring wrote:
> > If you
> >  grep '^[a-z_]*:'
> > through the *.mly files you get a few hundred non-terminals,
> > each with a handful of production rules.
> >
> > In a few words: LOTS of rules.
> 
> Is such a software situation influenced because of the usage
> of the tools “ocamlyacc”?
No -- you'd have the same problem with any tool I'd say.

> Can any advanced tools help with data conversions?
Ah-hoc hand-written scripts, I imagine.
