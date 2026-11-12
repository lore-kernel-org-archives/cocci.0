Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6572606A33A
	for <cocci@archiver.kernel.org>; Thu, 12 Nov 2026 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=UEl8M+1P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=htpHXCItYYjt3kYKK9UV4GeL3DHXeb2e8wKaPbUY5YQ=;
  b=UEl8M+1PsIzIKKUCfmPbpP8Vkjl7KI5Jyjd9IUDYKgJNEZLUQNnX6sQH
   TN3kCcGgNQm15I5piS0vEHtGOQZQk6OnjYTPHYTIcola67wxsdDH/+pg+
   cvKupX842M1taeyvwnWE3A1/LRB2BukJDBs5P//utNH/iTG3bvdNMe1sM
   A=;
X-CSE-ConnectionGUID: IXp94+aUSSSl4y57QbbztQ==
X-CSE-MsgGUID: TL0xoQgATSa5tNoTJjRUeg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305075757"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2026 13:29:18 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3CE7B81BBA; Thu, 12 Nov 2026 13:29:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3745A813A8
	for <cocci@sympa.inria.fr>; Thu, 12 Nov 2026 13:29:13 +0100 (CET)
X-CSE-ConnectionGUID: a/eflmWPTDy9gDmeRJxjLQ==
X-CSE-MsgGUID: OEFYAmJVT76bRu5smP319g==
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="162459198"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 13:29:13 +0100
Message-ID: <e94be607-8aeb-493b-8dec-8415e05551b1@inria.fr>
Date: Thu, 12 Nov 2026 13:29:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: picca@debian.org
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <d4be4d6fe184ccc6147abbe3da5cacc1@debian.org>
 <b225b777-9216-635a-76b8-fc46f6d6a3@inria.fr>
 <45e0468b84f19a5d75ea99fb434113c0@debian.org>
 <0faa3236-0ab2-45d3-953e-6168ce6c8d76@inria.fr>
 <0e99b58f1f63d6ff89889c6f132d4e2e@debian.org>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <0e99b58f1f63d6ff89889c6f132d4e2e@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Bug dans la parseur de coccinelle ?
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3795
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/oTrmKmtTpI-71EYX98Ky5Q>
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you. I cannot reproduce the error. Could you send me the file 
"hkl/ccan/array_size/array_size.h", as well as the output of `spatch 
--version`?

Victor

On 11/12/26 13:26, picca wrote:
> Le 2026-11-12 13:12, Victor Gambier a écrit :
>> Thanks. What command are you running to get this error?
>>
>> Victor
>>
>> On 11/12/26 11:47, picca wrote:
>>> here it is
>>>
>>> Fred
>>>
>
>
> spatch --in-place --sp-file reffactoring.cocci ana_read.c
