Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E431C4345F
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 16:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=CGSa8KQgG7SPHhA6x+7RJs9Qvz8PoC4gK4OAFMjn6NM=;
  b=IrbFKiFFNDuq4MZ+LYSd1wIicbSaZMuPSnFsMQ5o2wSASCwVbl4Zqixr
   dg5385mfBajXncN61pVOBPc3120UkGpmDg1+aZVNu+torDzN/if3Ro/Sp
   LyDyYMcuSL1ZBPAgAOIzeUnL5BWIE7VkQM4nLdDLv5ac9tpySvomFibEj
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="161907297"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 18:07:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 85DC8E0138; Tue, 16 Apr 2024 18:07:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 711DCE0035
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 18:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CGSa8KQgG7SPHhA6x+7RJs9Qvz8PoC4gK4OAFMjn6NM=;
  b=g5XNcTpAv7hILYBSN2pmgbquExRG2Ag3vXCPqGsqiFiUtEMgUFWeL/uD
   bK8Pf/7e4G3RBAmfGLOaa1fDMU3YNsaX3vnKrUYQn8DtzOiY66XjQQ/4p
   +wCCyTchikcN2fM+6KDBIYIE13zO/s62ItLgRSaeMaGNLayTsT30JTEa5
   k=;
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="161907293"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 18:07:28 +0200
Date: Tue, 16 Apr 2024 18:07:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
cc: Wolfram Sang <wsa@kernel.org>, cocci@inria.fr
In-Reply-To: <5rctzuo7ynserxtyhsikkc4zhglcdqoysnt4kd3odethcv6f2o@2crrvxx6bx2b>
Message-ID: <762b29b1-c2ba-e9e6-1054-5d4bf54b6843@inria.fr>
References: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr> <ZhhO29XtBmBkyuQo@shikoro> <alpine.DEB.2.22.394.2404112304250.3048@hadrien> <x5daefdxp7afett3nq6j56dn3t33xwl5ul7ys4xa2u2rc7yhub@nz6zhf6yhgsd> <alpine.DEB.2.22.394.2404120831160.3229@hadrien>
 <4em54bibxo6t6cjv2uifnuqpmpubrtm6htfac2iiyhp76txmh7@o6qzyvdxm5dz> <alpine.DEB.2.22.394.2404120857440.3229@hadrien> <cdn5ct3pmn3l4yuohu6ulfndv7iy3pl5ycrdgxrgrqnd6czijn@tmoibbjtofa7> <fa25ff69-acf1-baa0-31f-936116b3cc57@inria.fr>
 <5rctzuo7ynserxtyhsikkc4zhglcdqoysnt4kd3odethcv6f2o@2crrvxx6bx2b>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] new version 1.2
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1670
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/762b29b1-c2ba-e9e6-1054-5d4bf54b6843%40inria.fr>



On Tue, 16 Apr 2024, Wolfram Sang wrote:

>
> > I can just try it, but what is CDPATH for?
>
> CDPATH is a list of directories for the 'cd' command. I have '.' and
> "$HOME" in my CDPATH. So, when I type 'cd folder', then folder can
> either be in the current dir or in $HOME and 'cd' will switch to
> whatever is first in CDPATH. A bit dangerous, but I came to like it.
>
> I still don't see why this affects dir parsing of coccinelle...

By default, Coccinelle chooses relevant files using git grep.  This
requires a cd to the specified directory.  With the CDPATH variable set,
cd to a relative path prints the full path of the destination to standard
output.  That is collected as part of the standard output of the command
(I asked for drivers/usb):

cd drivers/usb; git grep -l -w \( -e kmalloc \) -- '*.c'

I can redirect the output of cd to /dev/null.

julia
