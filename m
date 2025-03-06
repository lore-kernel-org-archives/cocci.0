Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA7FC28B26
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 09:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YzZO3wDzpjcySBHX16yE2+GH8M8Ok9Y4fUhDEG70824=;
  b=bVShA+Ue4wwQ4NTjpQHVmkF9gKdWnNNCE0OhFaPA9JNZF2ijJhpjEAxs
   r6WY79ERGMkt2xCKzNFZlLNlXfKsyf2IBDbtwLX0GJPD3AZEKnsnSioPg
   C2er1fj1KnMBwUbuJrC/oMT0u6lAMjKBrGiKa3qGqycomAxX8VAdlMkzF
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208";a="211492084"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 10:10:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 65059E0D3E; Thu,  6 Mar 2025 10:10:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6AB06E0260
	for <cocci@sympa.inria.fr>; Thu,  6 Mar 2025 09:48:02 +0100 (CET)
IronPort-SDR: 67c96142_D0700LeQkc/iPbbJQxtAOdYKLHGKKo0ugDrp4BG9ShbrB2v
 B6+/JMJZ5Hwpy//ugZdTM7lTgsgmhi5QgXa8IHg==
X-IPAS-Result: =?us-ascii?q?A0EeAAANYMlnj9lUsotaHQEBAQEJARIBBQUBQIFABwELA?=
 =?us-ascii?q?YJDfVozBAtIhFaIfIZTgiEDkkyFbIVcFIERB1IPAQMBDTkLBAEBAwEDhQACi?=
 =?us-ascii?q?xgCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBA?=
 =?us-ascii?q?QEBOQUOO4V7DYJiAYETEXQwAgEBAQEBAQEBAQEBAR0CDX0BAQEBAyMECwENA?=
 =?us-ascii?q?QE3AQ8LFAEDAgImAgJWBgESgwIBgmQDEQauYXp/M4EBggwBAQbcIIFlAwaBG?=
 =?us-ascii?q?i4BhWuCYwGJaHonG4INgRWDKj6EKoN0gmmCM0WBJAGDPah1UnscA1ksAUsKE?=
 =?us-ascii?q?xcLBwU5KEhDA4EPI4EjBTRBOoILaUk6Ag0CNYILE10fgiuCF4I3hD2DMoEQg?=
 =?us-ascii?q?WODb4IRgV0DAxYPAYMfdxyERjuEaRcdQAMLbT03FBsGojIBOoNHgh4YIoEhg?=
 =?us-ascii?q?QeWQLAHhCWBY4o1lTBNE4E4gjiNCYY6kxEuh2WPcnkii2qBeZsugWgBOIFcf?=
 =?us-ascii?q?QiDIk8DGQ+OIRmIdMJuQTUCOgIHAQoBAQMJkByBSwEB?=
IronPort-PHdr: A9a23:HeSF6hJ12iGO0EPHKtmcuG1sWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEv7M11BSQBdqBtLptsKn/jePJYS863d65qncMcZhBBVcuqP49uEgeOvODElDxN/XwbiY3T
 4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6JvjvGo7Vks+7y/2+94fcbghGmjaxe69+I
 Am5oQnMqsUbg5VuJ6QswRbVv3VEfPhbymxvKV+PhRjw4du+8oB++CpKofIh8MBAUaT+f6smS
 LFTESorPWMo6sD1rBfPVQSA6GcSXWUQiRpIHhPK7ArmUZfrsyv1rfRy1S+HNsDrV780WDCi7
 6B2SB/0jSoMKjA0/H3LhsF2kalWuwyqqQBhzIHIYYGVLPt+cb3bfdMGXmpKQ8JdWzVcDo+gc
 4cDCuwMNvtaoYbgvVsDtRWwCwmyCu7x1zFGhXH20qIm3Os8Hg/J3hctH84NvXnOsNn5KLseX
 OKzwaLVzTvDdfRW2TLl5YbObB8hpveMVq9sf8rWzEkgDQXFjlKOqYz+PDOU1vkGvm+f7+V+U
 uKvjXUqqwJvrTi1wMcjlI3JipgSylDe+iV02YA4LsC3R0Bne9CrCodQtz2EOItsRMMvW39kt
 SI1x7AHt5O2YjQGxZU7yhLDdvGJc4iG7xP/WOifPTp1i2xpdbOhihiy70StxOLxWtS73lpUs
 iZInd3BumwL2hfO5MaHTf598V2g2TaJzw3T6f9LIVoylaXFL54t2LkwloAcsUnFAyT4m132g
 beLekgq/uWk8fnrb7flq5OGNIJ5hRvyProzlsG9Geg0LxQCU3SB9em+1LDv50n0TKtQgvA2k
 aTUto3RKNofpq6kGA9Vzpgs6wyiATen0dUXg2EKIE5DdRmalYbmIUvOL+r9Dfqng1SjjjNrx
 /feM7L8DJXMIGLPkKzmfbZg8U5T1BQ8wcpc551KELEBJuz8WkvruNzfFB85PBS4w+fhCNpjy
 oMTQX+DD6GdPa/IrFOF5OEiL/OPaYIaojrxNeUp6vz2gX88g1AdfK2p3ZUNaHC/G/RrO0GZb
 mTrgtcHCmoKvRQxTPbsiFKcVT5ffXGyX7gz5j0jDoKpFp/MRpqxj7yZwCe7AppWa3hbBlyUC
 3fna52EW+sQaCKVOsJujjsEWqS9RI8gzhyurw/7y79/LuXO4CEYtJTj1MJ05+LJjx0y+yZ0X
 Iyh1DSmT2xykSs4Wndi16Byp0NszUqr1al+nuweHNhS7fpDW0ExMpuKi6RfAsrxRxmJU9OHU
 legTZ3yJDgrTc8qhfIKbVx8HdqKkR3JmSanVew7jbuOUbg59aSU5X/0LsB61W3FxeF1i1QhR
 ONMOHegi6o58BLcUd2a236FnrqnIPxPlBXG832OmC/X5BkwuG9YVKzEWSpafU7KtZHj4UiES
 bayCLMhOw8HyMiYK6IMZMe6xU5eSqLFP9LTK3m0h3/2HQyBk7eBa4zCeGgH2ijZTk8enFNb5
 m6IYDA3HTzpuGfCFHprHFPrbVnr9Lx6pXS9Zkw51QeHawtmzbXmsgUNi6m6TPUelqkBpD9nq
 zhwGwOl2MnKDtObuwd7VKlSfpUm50pd3m+ftAFnOJGkaad4iTbyaixRuEXjn1VyA4REy40xq
 W8yiRB1IuSe2U9AcDWR2dbxPKfWIy/85kLnbamewVzY3NuMn8VHoP0lt1Xuuh2oHUs+4j1m1
 ddSyX6V+pTNCkIbT5vwVk898xUyqavdZ2Ex4Ibd1HskNqfR0HeK398uAsMmxwymctMZN7mLV
 UfzH8AcG8myObkygVH6JhkAPe1U6Os1J5b/LKrAgfH7erY82mj/0jcigsg1yE+H+itiR/Sd2
 p8Ex6vdxQ6bT3Lmi1zntMnrmIdCbDVUH2ylyCGiCpQCA886NYsNF2qqJNW6g9tkgJu4EXpV8
 1iLBF4c3sKtPx2IYBaulR0VzkkRrXG9zGG8wjtyuzIktKyS2GrJ2euoJ39lciZbAWJli1nrO
 429idsXCVOpYwYenxyg/U/mxqJfqcyTNkHrSFxTN2jzJmBmCO6rs6aaJtRI49UuuDlWV+K1Z
 RabTKT8ql0UyXGrE2xbzTE9Pzak3/ex1xh3j2S1L3tpqnfdP8Zqyl/T6cfdSvhYwjcdDHAj2
 H+OWQj6b4Xvp4zL357Y+vizTWegSoFefUyJhcubuS236HcrSRyzkvavm8H2RA0z0Cv1zd5vB
 m3DqBfxZJWu1rzvaLk2OBA3VBmst4wgQ94t9+l4zIsd0nUbmJiPqH8OkGOpdM5exbq7dn0GA
 zgC39/S5gHhnkxlNHOAgYzjBRD/ioNsYce3ZmQO12cz9cdPXe2Q4btCtSh4uFy1qUTWe/c3z
 X8NjOAj7nIXmbRDvAcqyA2eD6oUEE0eOjbj3UftjZj2vOBcY2ChdqK13Ux1kIW6Db2MlQpbX
 W7wZpYoGSIjptU6Kl/H12f/r531YNSFJ8xGrQWayl2T6oodYIJ0jPcBgjBrfH7wrWFwgfBul
 gRghNm7pNTVdj8rpv//W0UJcGSpP4sS4m2/1P0P2J/Jj8b/QtM7Q2puPtOgTOr0QmtO6LK7b
 0DQQHtj9z+aAeaNRFPCrhs+6S2UVc32f3CPeCtAkYokG0TbfR0ExlFNOVdy1p8hSlLzm5anK
 R8koGxXvAOk4hpUlrAxaEO5CDyD4l31MHFvEdCJJR5SpGmu/m/zNsqTpqJ2FiBcpNi6qRCVb
 3acbEJOBH0IXUqNAxbiOKOv7J/O6brQAO32NPbIbbiUzI4WH/6V2ZKi1Jdn9DeQJ42OOHdlF
 fgyxktEWzhwBc3YnzwFTyFfmTjKaoaXoxK1+ys/qc7akryjQAX0+Y6GEKdfK/1j9Q/wmqCeL
 eWdwiV0MzBV0tUL33CJgLkT0VgOij1/IjmgFbNT0EyFBKnUm6JRE1sac3Yqb5oOtv1smFkRf
 5SC1YCQtPYwlPM+BlZbWEa0n8ioYZZPOGShLBbdA03NMr2aJDrNysWxYKWmSLQWgv8H0n/48
 TudDULnOSyO0jfzUBX6e+VBiyezPxFEvoy5NBF3BiKwKbCuIg3+K9JxgTAslPcsgWjWMGcHL
 TVmW09DsfuL6j5Cifg5GGFb6Hdha+6elGzKiouQYoZTuvxtDCNukutc63lv0LpZ4hZPQ/ltk
 TfTpNpjy7lDuuqC0DxqVFxJsDkZ3OpjXG1uN7qf7Z5dQ33JuhEA92OdD1INvdQ3UrUHVIhTx
 8LJmaa1Ly1NoYu8wA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:MGxRlq0fDBHdqteXKtB2ZAqjBL8kLtp133Aq2lEZdPU1SL36qy
 nApp4mPHPP5Qr5O0tBpTnjAse9qBrnnPYf3WB2B9uftWLd2VdAWbsSibcKtAeQfBEWmNQz6U
 4ZSdkaNDSmNykZsfrH
X-Talos-CUID: 9a23:gH+mumw+89BtLSNMGDxiBgVOP9gnfib5w0vwGESlAHlmE+XESA+PrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3A34HbiAy1kP1eW0WSVQSAZVRHgSWaqIKSU0NXwM5?=
 =?us-ascii?q?fguSFaAhpagyjqBecbqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208";a="211482147"
X-MGA-submission: =?us-ascii?q?MDHlt12yWXIalKIPZdQ7ujOp96r0WMBeMEX1fB?=
 =?us-ascii?q?dGdEuKYlf21MkAI5yBzcqgXegcIRtskEUzwiUaLJemafCWBVRzAEAPIJ?=
 =?us-ascii?q?rq6QJwTxqiCVOLp482LQDTxVhgsRsjoLzSyCufFRINXnLtwZRUANXs9J?=
 =?us-ascii?q?auV7DmL/pmF9i/JlCP6ccXYw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 09:48:01 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9A3095C5543;
	Thu,  6 Mar 2025 08:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E539C4CEE0;
	Thu,  6 Mar 2025 08:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741250879;
	bh=J+PDjpUqfvf57ViyFi5yPq7UxVpHRWHfqW+jl+tEfWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Clg2cLtdb6GNixf2GL7cU41I+Dixm63vAKvHkIx2m2D6kz5olpYI2+XvyNJPMpQts
	 Ncl41mdckfamKfXDNI4ua9AB+VLwXgeMOuNck6dRLhY/6H837vexzW1SCNWdVVyEQX
	 lE8LPPAhe6vZFKA59CjrjkdvyI2ErQ/wXY7JDQp2GnK+Ukfw2DGJLg8xmZSGE9HpO0
	 mTwBL0FGQ+/c5EAw0nEjsl9V7HvzvLk9WEwk7tXi2v+YSpQ5o4GwxN3UQNF+JFKMe7
	 8oUiZoGW3TvyYADzE9LiZeWkevy7yrr2q9BS4Rfrx1lAg4BX2E+txzEK1bbiS04O8A
	 b/FcndbLFSksw==
Date: Thu, 6 Mar 2025 10:47:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Cheng Xu <chengyou@linux.alibaba.com>,
	Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Yang Li <yang.lee@linux.alibaba.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <20250306084754.GR1955273@unreal>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
 <167179d0-e1ea-39a8-4143-949ad57294c2@linux.alibaba.com>
 <20a1a47c-8906-44e8-92e6-9b3e698b1491@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20a1a47c-8906-44e8-92e6-9b3e698b1491@web.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] RDMA/erdma: Prevent use-after-free in
 erdma_accept_newconn()
Reply-To: Leon Romanovsky <leon@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2564
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250306084754.GR1955273%40unreal>

On Wed, Mar 05, 2025 at 03:20:41PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 5 Mar 2025 15:07:51 +0100
> 
> The implementation of the function “erdma_accept_newconn” contained
> still the statement “new_cep->sock = NULL” after
> the function call “erdma_cep_put(new_cep)”.
> Thus delete an inappropriate reset action.
> 
> Reported-by: Cheng Xu <chengyou@linux.alibaba.com>

Cheng, please resubmit this patch, I'm experiencing the same issues as
Christophe has here https://lore.kernel.org/all/20a1a47c-8906-44e8-92e6-9b3e698b1491@web.de
and it looks like Markus continues do not listen to the feedback.

Thanks
