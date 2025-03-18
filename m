Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE99C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 10:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=sY4E3w8oxHc8zZJNP6o/WXtJrJsZ6Uf485fffW1zwO4=;
  b=UsiGgdO99Gdc9OAzv/6rzs+CJgnWUT65BwYIhC+2X/OXxep3vXKe7/xX
   bPjA/ju92C3aQdg+Wq+bpBSHmCP0BsYTV6MvJ7jd28tYRjNzZW9uSBBC0
   MNSwq7bWof5mk5sBihanFxVJ5yStNPCdARxKhflGNkvkE+Rb18Qg9W8ln
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213443336"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 11:19:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9AEE5E0D1D; Tue, 18 Mar 2025 11:19:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8464EE0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 11:19:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sY4E3w8oxHc8zZJNP6o/WXtJrJsZ6Uf485fffW1zwO4=;
  b=DM8CJU1Aoj7j7naA4C3/mWVxI61qprzbmdkxM++3ysXLJc3nol9HGH+7
   7QvHkQMBVA4DqG/eHDWIEoLLKI3aClmagOqPpIbD2rAUjIpFn22G5EG0s
   ItOL14zGFO4QXHnxg7blyAa3mWXG9snYju6wB8Bmq9NqgCnJGb5P6xFmU
   M=;
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="111883717"
Received: from pd9ef1166.dip0.t-ipconnect.de (HELO hadrien) ([217.239.17.102])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 11:19:46 +0100
Date: Tue, 18 Mar 2025 11:19:44 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Olaf Hering <olaf@aepfle.de>
cc: cocci@inria.fr
In-Reply-To: <20250318111305.281abcca.olaf@aepfle.de>
Message-ID: <2b3232fa-ad32-c17f-8e97-8144c648c19c@inria.fr>
References: <20250318111305.281abcca.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] the future of bundles in coccinelle.git
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2610
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/2b3232fa-ad32-c17f-8e97-8144c648c19c%40inria.fr>



On Tue, 18 Mar 2025, Olaf Hering wrote:

> While looking for the proper way to import pcre2, I realized that the
> way configure.ac looks for required OCaml libraries is ... weird.
> There is no way to force the usage of the variants in bundles/, the
> version provided by ocamlfind is always preferred.
>
> I think since a while the required build environment is easy to create
> with either 'opam install $ALL_BUNDLES', or 'zypper install $packages'.
>
> Hence I suggest to remove bundles/ and all code referring to it.

No, we don't want to do that.  The idea of bundles is to limit the
dependencies.  We don't want users to have the be highly integrated into
the OCaml ecosystem.  Typical Coccinelle users don't care about OCaml at
all.

Perhaps it is just a personal preference, but when faced with some
software that eg asks me to install 20 python libraries, I choose some
other software.  I guess others may have the same reaction to software
that requires installing opam etc.

julia
