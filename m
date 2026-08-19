Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF8FC5DF81
	for <cocci@archiver.kernel.org>; Wed, 19 Aug 2026 15:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=MZogemnyNtCfeJGGXfi8Og2tkSbd+8UJGPupNxliDNE=;
  b=VXKclCu8ZSGGwmONTPXp6w6QzGeQJ3A2t0bczfxaAcUYGtVgSHDO84Y/
   HzCkbVrrHRmnWFTV7KY3QPVGN/2GqKSBXwhOITOjwGzI2v+zpZjOQfnRD
   siqOBI+7P54izTM4fFvxXt84okBcVVbmpwjvvW2eSOmbQ44no6Mv9Z9YJ
   Y=;
X-CSE-ConnectionGUID: co+8xPMxSWmJJiKq+P35qg==
X-CSE-MsgGUID: ebeRx/t1S++R4hkxEA+xag==
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
X-IronPort-AV: E=Sophos;i="6.25,231,1779141600"; 
   d="scan'208";a="290695144"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Aug 2026 17:06:04 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8C52581773; Wed, 19 Aug 2026 17:06:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A90C380E87
	for <cocci@sympa.inria.fr>; Wed, 19 Aug 2026 17:06:02 +0200 (CEST)
X-CSE-ConnectionGUID: Crt6NGXoTuibF5zASu3TtQ==
X-CSE-MsgGUID: 8zPynaFRSz+or7T18R7hTg==
X-IronPort-AV: E=Sophos;i="6.25,231,1779141600"; 
   d="scan'208";a="290695100"
Received: from 82-67-29-39.subs.proxad.net (HELO [192.168.1.180]) ([82.67.29.39])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 17:06:02 +0200
Message-ID: <cfce7bfa-bead-443f-a418-8e79e9f1cef3@inria.fr>
Date: Wed, 19 Aug 2026 17:06:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cocci <cocci@inria.fr>
From: Victor Gambier <victor.gambier@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [cocci] Coccinelle 1.3.2 release
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3683
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/j_6IUbzbu_sZ-DDVcjlxZg>

Hi everyone,

We are releasing Coccinelle 1.3.2.

Here is the changelog:

Language:
- Minor tweaks to improve accuracy
Features:
- Add --c-internals and --cocci-internals flags for debugging
- Use pcre2 instead of pcre
Bugfixes:
- Fix performance regression introduced in 1.2 resulting in >2x improvement

Thanks to everyone who contributed!
Victor

