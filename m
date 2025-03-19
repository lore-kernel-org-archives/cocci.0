Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C001CC35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mYNH4Kv1vAEHzldLiiTxoHAffqugppgP0WFIr4z5RoU=;
  b=ucgoq65SXZh5qBqtvmDkgLhQFxZ6SiQms5lE72ZyWFFAY1FeTidiZBgB
   EAPYkjiR5i/6GdjlPgrpA7sCoziIFV2fXFaOm4auO1Hnqqn9bGg2EeCA8
   9UYsF7lTi/1fcQgQg9L/xQYUd2TXedBlW6j9AAkoqoyLB59tgRN1hhKXR
   8=;
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
   d="scan'208";a="213711736"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 14:31:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 32DEEE0264; Wed, 19 Mar 2025 14:31:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8BF38E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 14:31:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mYNH4Kv1vAEHzldLiiTxoHAffqugppgP0WFIr4z5RoU=;
  b=DYGMxZCTnoWOV8dZ+MFZdbnwb6Ogk6UGDBjSYmrE7VsAZnJgmcMrGpsz
   PVW1ztFLiFWe2Drljw7O7Won7SlnrkfbKg9s2u1VTESuGzZ662Jp5TBZC
   Dd9G6Gt7NtjZreZysdx0dCKu8+xv/Oz2iYUAr2jFGfWu088BOaMoM0Pyy
   w=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="112032212"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 14:31:21 +0100
Message-ID: <2798795d-41c3-4e18-981e-43ea961a32fb@inria.fr>
Date: Wed, 19 Mar 2025 14:31:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Olaf Hering <olaf@aepfle.de>, Jacob Keller <jacob.e.keller@intel.com>,
 cocci@inria.fr
References: <20250318111305.281abcca.olaf@aepfle.de>
 <2b3232fa-ad32-c17f-8e97-8144c648c19c@inria.fr>
 <27f57368-6a2d-4ea4-8a81-b8bee42e2d5d@intel.com>
 <20250319134816.3b7d026c.olaf@aepfle.de>
 <7508d3f9-1b01-4e4c-84cc-14b075d62d1a@inria.fr>
 <2d932032-5325-ffe8-f5c-28fc35c342@inria.fr>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <2d932032-5325-ffe8-f5c-28fc35c342@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] the future of bundles in coccinelle.git
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2653
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/2798795d-41c3-4e18-981e-43ea961a32fb%40inria.fr>


On 19/03/2025 14:18, Julia Lawall wrote:
> As much as I don't want to figure out how which version of pip is required
> to install python packages, I absolutely do not want to learn flatpak.  I
> don't want to learn anything.  I just want to download the tool, compile
> it, and run it.  Avoiding cultural barriers to entry is really important
> to getting people to use a tool.

Understandable. I'll just point out that the bundles aren't a magic fix 
for dependencies - as I discovered (and since documented) in the past, 
on Debian, the pcre bundle only works if you have the libpcre3-dev 
package installed - this was not documented anywhere. So even with the 
bundles failsafe, you still need to install some (undocumented) packages 
in at least some instances, which may or may not defeat the purpose. 
Fully documenting which packages need to be installed and how to easily 
install them might be a more robust alternative in most cases :)

Victor

