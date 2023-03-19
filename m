Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6461C7618A
	for <cocci@archiver.kernel.org>; Sun, 19 Mar 2023 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=a3IC+Jbdke2zFjkXaKrpDzJQxAG2X/WqzSUzJAxxK10=;
  b=TR6UUko2u8OLI0PE8DxhB6Wi8eg2L1UtwqZD+ov3GgiguEkwNTPSSTnn
   i6esXqXMRqCzNbp20yIm14QwAIYhByDeepIaJ9Kp72Son1TPs3TfwanS5
   M0n7THvLoBAoxn9VulRAaVI1BSgf8iKWaSVn4gQItee/5nxHaCQW1lVi4
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.98,273,1673910000"; 
   d="scan'208";a="97942946"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2023 15:14:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2DB84E0AEF; Sun, 19 Mar 2023 15:14:38 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6B55DE0A9B
	for <cocci@sympa.inria.fr>; Sun, 19 Mar 2023 14:36:30 +0100 (CET)
IronPort-SDR: 64170fdd_UoPiMKnh8DenmI1qmieUJoPDMp2hmonhJMfIiMM8HoNDNSk
 3wWCK8FzQih9prbERw7UZNwIm/wLOFsqNUA0buQ==
X-IPAS-Result: =?us-ascii?q?A0GxAQA+DxdkmGMefHNaHgEBCxIMQIFEC4IugUowBAuFG?=
 =?us-ascii?q?ZEBMZd8hAKBVoF+DwEDAQ1EBAEBhQUChTUCHQcBBDAJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQEAQECEAEBAQEBAQEBHhkFDhAnhXWCNykBg38BA?=
 =?us-ascii?q?gMjBAsBRhALFAQCAiYCAlcGAQwIAQGCeoJdArNAfzOBAZ9agWeBFCyMbReEM?=
 =?us-ascii?q?EKCDYEVJwwDgnQ+iByCZwSZDAqBNHWBIA6BPYEEAgkCEWuBEghngX1BAg1lC?=
 =?us-ascii?q?w52gUsCZU8nJQQOAxkrHUACAQs7Oj81BgMLIV5rAgkjERMFAwsVKkcECDkGH?=
 =?us-ascii?q?DQRAggPEg8GJkMOQjc0EwZcASkLDhEDT4FHBC+BZAYBJiSeLzimD591FYNvg?=
 =?us-ascii?q?VmfGAYPBC6DapMekjcuhy2KUoU9IKd6gWI6gVxwFYMjTgMZD445kxUBSTdsA?=
 =?us-ascii?q?gcBCgEBAwmLQwEB?=
IronPort-PHdr: A9a23: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
 IEodE/GDygS
IronPort-Data: A9a23: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
 wRAO0QDOXk=
IronPort-HdrOrdr: A9a23:wVueEaE8Kiuyc1aDpLqEw8eALOsnbusQ8zAXPo5KOH5om7+j9/
 xG+85rrCMc6QxhPk3I9urtBEDtewK5yXcx2/h3AV7AZmbbUQmTQb2KhLGKq1fd8m/Fh4tgPM
 xbEpSWZueAbmSSwfyV3CCIV/4kwN2O8KXtreDCz011RQUCUcpd0zs=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,273,1673910000"; 
   d="scan'208";a="50608738"
X-MGA-submission: =?us-ascii?q?MDGS7na/Gtit3W5hTZJHwGcu3uxX74/RhviomZ?=
 =?us-ascii?q?cIuHfzFOzZOdRL/XrAbfbDsVgfTBmVm5/V38LZgK3WloiarCOOy/El/L?=
 =?us-ascii?q?ocFW//bSimzChLwdG8ju7++SYz9aaVxxUaGWdhScaozJsKaAwXLDVu70?=
 =?us-ascii?q?P5C8hjZBfwJEE9+RmVxlU4mw=3D=3D?=
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 14:36:27 +0100
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Ve8VpRZ_1679232982;
Received: from 30.0.143.175(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0Ve8VpRZ_1679232982)
          by smtp.aliyun-inc.com;
          Sun, 19 Mar 2023 21:36:22 +0800
Message-ID: <167179d0-e1ea-39a8-4143-949ad57294c2@linux.alibaba.com>
Date: Sun, 19 Mar 2023 21:36:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
 linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Kai Shen <kaishen@linux.alibaba.com>, Leon Romanovsky <leon@kernel.org>,
 Yang Li <yang.lee@linux.alibaba.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] RDMA/erdma: Fix exception handling in
 erdma_accept_newconn()
Reply-To: Cheng Xu <chengyou@linux.alibaba.com>
X-Loop: cocci@inria.fr
X-Sequence: 899
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/167179d0-e1ea-39a8-4143-949ad57294c2%40linux.alibaba.com>



On 3/19/23 4:15 AM, Markus Elfring wrote:
> Date: Sat, 18 Mar 2023 21:08:58 +0100
> 

<...>

> +disassoc_socket:
> +    erdma_socket_disassoc(new_s);
> +    sock_release(new_s);
> +    new_cep->state = ERDMA_EPSTATE_CLOSED;
> +    erdma_cancel_mpatimer(new_cep);
> +put_cep:
> +    erdma_cep_put(new_cep);> +    new_cep->sock = NULL;

Thanks, but this causes an use-after-free issue because new_cep will be
released after last erdma_cep_put being called.

Cheng Xu

>  }
>  
>  static int erdma_newconn_connected(struct erdma_cep *cep)
