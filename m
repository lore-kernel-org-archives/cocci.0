Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F7EC35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 13:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8023Z2c75ykI4gufLJ71rcnYNrFMtKr0yR8nFsAKc8c=;
  b=AkRTjppf/Ifkpy+bWdfBml8IGVvZyqKkmdQI0MMzkxY5jwirJDq5vjDm
   MFLGK8N/dDlRrXTW5oBDA47fFbXpsefgAGWFpuanDKPtSdxQojcbxrhS1
   /v1MU/h9R3fkS8ak258UbpRy2Hn7Tt2j6hKtEIU6luUJuNl8ZMOQ6PBwp
   o=;
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
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213707213"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 14:11:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E6236E0D1E; Wed, 19 Mar 2025 14:11:16 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0EC23E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 14:11:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8023Z2c75ykI4gufLJ71rcnYNrFMtKr0yR8nFsAKc8c=;
  b=PXgCZNH5J+RKGXZyiKGB0LFUrrc4sJsIQMYGR0/Gh1fVBS7GZE/J7TuN
   gno3bev+X7696dZpmKek+ulh7rt5UiLMsuR3ysB8awCCdwGsA2KtUosIu
   v44iVIwFz1u30CwxNNBgW/un0pr8bFJ2ctjICNxjxI57GKgfyL2iIGUJ9
   I=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="112029847"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 14:11:12 +0100
Message-ID: <7508d3f9-1b01-4e4c-84cc-14b075d62d1a@inria.fr>
Date: Wed, 19 Mar 2025 14:11:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olaf Hering <olaf@aepfle.de>, Jacob Keller <jacob.e.keller@intel.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <20250318111305.281abcca.olaf@aepfle.de>
 <2b3232fa-ad32-c17f-8e97-8144c648c19c@inria.fr>
 <27f57368-6a2d-4ea4-8a81-b8bee42e2d5d@intel.com>
 <20250319134816.3b7d026c.olaf@aepfle.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <20250319134816.3b7d026c.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] the future of bundles in coccinelle.git
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2649
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/7508d3f9-1b01-4e4c-84cc-14b075d62d1a%40inria.fr>

For what it's worth, I am also of the opinion that we should get rid of 
the bundles.
They create issues, both on the developer side and the user side, and I 
don't think the problem they're supposed to solve is a real problem.
I don't like them very much. I also believe that building the Flatpak 
locally, which is now possible, is a better way of building Coccinelle 
without worrying about dependencies.

Victor

On 19/03/2025 13:48, Olaf Hering wrote:
> Tue, 18 Mar 2025 14:52:42 -0700 Jacob Keller <jacob.e.keller@intel.com>:
>
>> Why not go the other route and optionally use the bundles?
> What is there actual purpose, what does (any) bundle actually fix?
>
> As you said, every bundle becomes stale. The way it is implemented
> means one can not even test them because the one from the environment
> takes precedence.
>
> If one wants coccinelle, use the package manager to install it.
> In case it is unavailable there, get a copy of opam and install it.
> In case one has to actually work on coccinelle.git for whatever reason,
> there can not be any convenience, except 'opam install coccinelle'
> which will install all required development packages.
>
> In the context of Packman I had to deal with way too many packages
> that bundle something which has to be provided by the system.
> Every single one was and is a mess to work with. Today my first reaction
> when I see any bundle is: purge that repo from disk and do something else.
> Which is what I'm going to do now.
>
>
> Olaf
