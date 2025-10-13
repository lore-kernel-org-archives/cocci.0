Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CF4CCA476
	for <cocci@archiver.kernel.org>; Mon, 13 Oct 2025 12:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=jVZde6vu3Rjta6XdJlDh+HmMY82ohbH0K2r8RuARsOY=;
  b=JE2Hf7dSGCBAGyZmwEv6toEBV6Q3HpLKInMs4lrZyilrKxn5fnavCDIA
   MIUh2VTWKKvgWH+KyuNfAhF0dXXrJHX1h6blBvB8iP0b38sKB0Oe3BoJ6
   MOD3uYg4I/BuIWgY/D1Yx0KsoK6Cpf/hELmgIPgKixrmTrgSBNGLg0Sad
   8=;
X-CSE-ConnectionGUID: L0EZur3vRR+8uHQG6Kw94g==
X-CSE-MsgGUID: ndAIwnwcRlii9SyOIME3Gw==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="243881914"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Oct 2025 14:04:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 59531E0B0D; Mon, 13 Oct 2025 14:04:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 82DCAE0171
	for <cocci@sympa.inria.fr>; Mon, 13 Oct 2025 14:04:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jVZde6vu3Rjta6XdJlDh+HmMY82ohbH0K2r8RuARsOY=;
  b=VGWXs1zS1G3ULr4V/di9YI/CDhl+KgFucCUIH9mHqA1p9zfIgcr500Oh
   kXpV0/x2GA8LP2F80tf3O1zL5Oja7UQkGEQ3apSnbVzHsFKtYx3puzfRy
   9Kzi3jySNkC9XUNm3yZe65mJ+1CpgTYUUNKgd+UZotYO5rgcp/rS8J50H
   0=;
X-CSE-ConnectionGUID: Fpqw7rysTS+9II7uuyFAOw==
X-CSE-MsgGUID: /CxxsVvWQRWGPUoPGoB96A==
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="243881894"
Received: from bb116-15-226-202.singnet.com.sg (HELO hadrien) ([116.15.226.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 14:04:41 +0200
Date: Mon, 13 Oct 2025 20:04:37 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, linux-cifs@vger.kernel.org
In-Reply-To: <335b0fe9-313f-4e3d-a01d-1954f3c46489@web.de>
Message-ID: <805f36f6-ea15-cbc9-f510-45856eb6f6d7@inria.fr>
References: <335b0fe9-313f-4e3d-a01d-1954f3c46489@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-343112014-1760357082=:3281"
Subject: Re: [cocci] Improving source code parsing for =?UTF-8?Q?=E2=80=9C?=
 =?UTF-8?Q?fs/smb/client/dir=2Ec=E2=80=9D=3F?=
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3067
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/805f36f6-ea15-cbc9-f510-45856eb6f6d7%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-343112014-1760357082=:3281
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 13 Oct 2025, Markus Elfring wrote:

> Hello,
>
> I would like to point another questionable test result out
> (according to the software combination “Coccinelle 1.3.0”):
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> /usr/bin/spatch --no-includes --parse-c fs/smb/client/dir.c
> …
> parse error
>  = File "fs/smb/client/dir.c", line 964, column 0, charpos = 25270
>   around = '',
>   whole content =
> badcount: 283
> …
> bad: static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
> …
> fs/smb/client/dir.c:211: passed:#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
> fs/smb/client/dir.c:280: passed:#endif
> …
> nb good = 679,  nb passed = 7 =========> 0.72% passed
> nb good = 679,  nb bad = 283 =========> 70.79% good or passed
>
>
> Under which circumstances will data processing become better supported for such files?
> https://elixir.bootlin.com/linux/v6.17.1/source/fs/smb/client/dir.c#L178-L455

If you want the problem to be solved, please make some effort to narrow it
down to a smaller number of lines.  Like 5.

julia
--8323329-343112014-1760357082=:3281--
