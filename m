Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99972C35FFC
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 13:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SqeiTbeeIJTHWM1qmTOHa9yQCac8zqBKDLNH5P+LKv4=;
  b=qS1IumDizeQsOMrVcUWdLo3yjLUrtDukpREccboDrElObp/g1EyqEmDu
   qv5Gt7Vgybd6fosU7UlEDJ2rwi0HQFKZlZIQ0/taVv1XTZnOxGdIj5INP
   USMuIoZ0SlL5R1nDEs1lAwMyjTE5m4DYMDRTVDFg3vtpxMNTV9owkBYIo
   0=;
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
   d="scan'208";a="213715853"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 14:47:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DE51DE0D1E; Wed, 19 Mar 2025 14:47:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 72E4CE007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 14:47:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SqeiTbeeIJTHWM1qmTOHa9yQCac8zqBKDLNH5P+LKv4=;
  b=rBxg51gtsNgKwQTP3R+M3bLeFVvSdB0hoP/b6KZNOXn7jvmvWNDRiQZJ
   NMchu08rxjY/vXCpeuy1nuquurDlX9wIB45Uz/1znNrcorj39glNvm6kg
   U/BKgAU4Eon/TCC2DPEazb+LKCzrpsgUdkIGG0hmYHvNRmUlTVRihcZbL
   0=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="112034175"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 14:47:19 +0100
Message-ID: <f38a49dd-05e6-46c0-b333-fc20d0fa3164@inria.fr>
Date: Wed, 19 Mar 2025 14:47:18 +0100
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
 <2798795d-41c3-4e18-981e-43ea961a32fb@inria.fr>
 <d1bf70ea-ce34-2ec2-45ba-90fe7bf26068@inria.fr>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <d1bf70ea-ce34-2ec2-45ba-90fe7bf26068@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] the future of bundles in coccinelle.git
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2655
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/f38a49dd-05e6-46c0-b333-fc20d0fa3164%40inria.fr>


On 19/03/2025 14:33, Julia Lawall wrote:
> If installing a package is essential that should be documented,
>
> But the goal is that the minimum number of packages should be required.

I understand your point of view. If we don't want to rely on opam, and 
since we can't assume every distribution / package manager will package 
relatively obscure software such as stdcompat, our only options do 
indeed seem to be bundles or instructions on how to manually install the 
software first. So I do get it, even if the many distributions that 
package Coccinelle seem to manage it ok.

Victor

