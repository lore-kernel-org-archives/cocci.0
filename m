Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D74C4725D
	for <cocci@archiver.kernel.org>; Mon, 22 Jan 2024 07:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XZ2nz3JBuGT1gBLqsXE8VgXk0KCKqzgbkm3ks4acA2c=;
  b=Gdb4QbUHq38nkNzv6oCh6hFDtXq4BkpVQDsJpg294cNN4GxaCE2NWXkp
   D/RNqQqTeykwViIpadutrOxxEsdVA664bcSn0hURPoooEc/yjLoIQAd0g
   YCCF/yIoMnPHtUrYiv0+rx6r9A7hxuKeoKi4fGCrwIOKzf4c8z3RfVmF9
   U=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@suse.de
X-IronPort-AV: E=Sophos;i="6.05,211,1701126000"; 
   d="scan'208";a="147851263"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jan 2024 08:51:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 06E33E0CD6; Mon, 22 Jan 2024 08:51:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 311EAE004E
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 17:55:58 +0100 (CET)
IronPort-SDR: 659ecc1d_7pGqtr1f3K/h1vCs1McinoUJPmUuIEcVG/fZex8fnrf8ebT
 gDCZpSv1+wRrCnYRPmp2C93SWnX3XoORT0R+1RQ==
X-IPAS-Result: =?us-ascii?q?A0EFAAABy55lmIPfh8NaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE+AgEBAQELAYFmKiiBUjIEC0iEU4h8iGqYJ4dYDwEDAQ1EB?=
 =?us-ascii?q?AEBAwEDgUyDMwKHPwIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABAQEBAQEBAR4ZBRAOJ4VsDYJcATKCBywNfAECAgEjBBkBATcBB?=
 =?us-ascii?q?AsLFAYCBSECAg8BBEgMBxmCZ4IsAw4jBAO2VH8zgQGCCgEBBrAjIoI2CYEaL?=
 =?us-ascii?q?gGIGgGJKIEhFQaCDYEVNYJ1PoRDg1uCaIIag0KQM1J/HQOBBQRcDxsPHjcRE?=
 =?us-ascii?q?AUODQMIbh0CMTwDBQMEMgocCyEFE0IDQAZJCwMCGgUDAwSBMAUNGgIQGgYMJ?=
 =?us-ascii?q?gMDEkkCEBQDOwMDBgMKMQMwVUIMUANlHzIJPA8MGgIbHg0nIwIsQgMRBRACF?=
 =?us-ascii?q?gMkFgQ0EQkLJgMqBjgCEgwGBgldJhYJBCUDCAQDVAMjdBEDBAoDFAcLB3uBJ?=
 =?us-ascii?q?wMZKx1AAwttPTUUG0WXbYErVpR2gyiPdZ8mgjuBYKFglyYOklouh1CQT6hmg?=
 =?us-ascii?q?XkkgVwzGggcFIMiTwMZD44gGYETAQiCdo9gJzU7AgcBCgEBAwmJIoFGAQE?=
IronPort-PHdr: A9a23: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
 cXUmeT/JWUamzox1dABHMWSJM/VaBIc
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:h0xNf6svKaedYJQ0ZhlQLTy37skC94Mji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJh5o6H6BEGBKUmslqKdkrNhR4tKPTOW81dASbsP0WKM+UyGJ8STzI9gPO
 JbAtBD4b7LfBJHZKTBkW+F+r8bqbHpnpxAx92utkuFJjsaCZ2Imj0JbjpzZXcGITWua6BYKL
 Osou584xawc3Ueacq2QlMfWfLYmtHNnJX6JTYbGh8O8mC1/H+VwY+/NyLd8gYVUjtJz7tn23
 PCiRbF6qKqtOz+4gPA1lXU849dlLLau5R+7Y23+4YowwfX+0aVjbdaKv6/VfcO0aOSAWMR4Z
 jxStEbToFOAj3qDyWISFDWqnTdOX4VmgPfIBmj8DbeSIXCNUwH48Ytv/MnTjLJr0Unp91yy6
 RNwiaQsIdWFwrJmGDn68HPTAwCrDvDnZMOq59ms5Vka/poVJZB6YgEuE9FGpYJGyz3rIghDe
 l1FcnZoPJba0mTYXzVtnRmhIXEZAV6Ij6WBkwZ/sCF2Tlfm350i0Me2cwEh38FsJYwUYNN6e
 jIOrlh0LtOUsgVZ6RgA/ppe7r/NkXdBRbXdG6CK1XuE68Kf3rLtp7s+b0woPqnfZQZpaFC7a
 gpkGkox1LaV3ieevFmhqc7gywlaF/NLQjQ9g==
X-Talos-CUID: 9a23:9pUA22+n1URVsf+XFsWVv3QFKpl1NWX49SfZIU++N1Z5bpufRkDFrQ==
X-Talos-MUID: 9a23:tdFAnAnpd7HOAlX4B7DTdnp/FpdO3YKWCXoPrqQKlcCBNgFfFBiS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="76412373"
X-MGA-submission: =?us-ascii?q?MDGkLs0tVpBF/6nNSEJIsd73OcMhr1sT2kBrKf?=
 =?us-ascii?q?4RaCtQ92x0Uyytl61VWVNuXMcT4XEz4uwBZjq47yErvMLjdzLxiMap+A?=
 =?us-ascii?q?Zha1C54a7PqpHhRH9uLTCNEMREtUhY5iYg0soWENL1l1KtQ5yHPmj3L0?=
 =?us-ascii?q?l8+umyNciX1TwKHYHlB3VWqg=3D=3D?=
Received: from smtp-out2.suse.de ([195.135.223.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 17:55:57 +0100
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D29FB1FD7C;
	Wed, 10 Jan 2024 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704905741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZ2nz3JBuGT1gBLqsXE8VgXk0KCKqzgbkm3ks4acA2c=;
	b=McKduXR5XJlHNDuXtSKc4Zkjj1j1siVD+uikzNtdzT0k/pDuikD34No2BtI0/Vp4VNTp+Q
	2Cnm4tTGFSCyJQEVbqJ+XY6I0KsuBIsjc5MU3A+vF+oQzoI+Zs3vVqC+ZN0/83800md8aH
	ZPdq9TukGnqxLlEhv4bhh0uFqybglgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704905741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZ2nz3JBuGT1gBLqsXE8VgXk0KCKqzgbkm3ks4acA2c=;
	b=SGEq7OYdjLs8b4CeO/imUlggK4/nQfOPpzfpoJBjAK3Tnnoj8V+PAr8v7DW/umSQ6+7nhw
	gYjczUMjdgDhgDBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704905741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZ2nz3JBuGT1gBLqsXE8VgXk0KCKqzgbkm3ks4acA2c=;
	b=McKduXR5XJlHNDuXtSKc4Zkjj1j1siVD+uikzNtdzT0k/pDuikD34No2BtI0/Vp4VNTp+Q
	2Cnm4tTGFSCyJQEVbqJ+XY6I0KsuBIsjc5MU3A+vF+oQzoI+Zs3vVqC+ZN0/83800md8aH
	ZPdq9TukGnqxLlEhv4bhh0uFqybglgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704905741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZ2nz3JBuGT1gBLqsXE8VgXk0KCKqzgbkm3ks4acA2c=;
	b=SGEq7OYdjLs8b4CeO/imUlggK4/nQfOPpzfpoJBjAK3Tnnoj8V+PAr8v7DW/umSQ6+7nhw
	gYjczUMjdgDhgDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 158EC13CB3;
	Wed, 10 Jan 2024 16:54:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +R2jLsDLnmWJDAAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 10 Jan 2024 16:54:24 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org,  io-uring@vger.kernel.org,  Hao Xu
 <howeyxu@tencent.com>,  Jens Axboe <axboe@kernel.dk>,  Pavel Begunkov
 <asml.silence@gmail.com>,  cocci@inria.fr,  LKML
 <linux-kernel@vger.kernel.org>
In-Reply-To: <aa867594-e79d-6d08-a08e-8c9e952b4724@web.de> (Markus Elfring's
	message of "Wed, 29 Mar 2023 17:46:03 +0200")
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
	<aa867594-e79d-6d08-a08e-8c9e952b4724@web.de>
Date: Wed, 10 Jan 2024 13:55:53 -0300
Message-ID: <878r4xnn52.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FREEMAIL_TO(0.00)[web.de];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,tencent.com,kernel.dk,gmail.com,inria.fr];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] io_uring: Fix exception handling in
 io_ring_ctx_alloc()
Reply-To: Gabriel Krisman Bertazi <krisman@suse.de>
X-Loop: cocci@inria.fr
X-Sequence: 1473
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/878r4xnn52.fsf%40mailhost.krisman.be>

Markus Elfring <Markus.Elfring@web.de> writes:

> Date: Wed, 29 Mar 2023 17:35:16 +0200
>
> The label =E2=80=9Cerr=E2=80=9D was used to jump to a kfree() call despit=
e of
> the detail in the implementation of the function =E2=80=9Cio_ring_ctx_all=
oc=E2=80=9D
> that it was determined already that a corresponding variable contained
> a null pointer because of a failed memory allocation.
>
> 1. Thus use more appropriate labels instead.
>
> 2. Reorder jump targets at the end.

FWIW, I don't think it makes sense to have the extra labels or re-sort
without a good reason. kfree works fine with the NULL pointers, so there
is no bug to be fixed and moving code around for no reason just makes
life painful for backporters.

Also, the patch no longer applies.

> 3. Omit the statement =E2=80=9Ckfree(ctx->io_bl);=E2=80=9D.

From a quick look, this might still make sense.  can you confirm and make
that change into a separate patch?

--=20
Gabriel Krisman Bertazi
