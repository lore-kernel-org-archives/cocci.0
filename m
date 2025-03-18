Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C8DC35FF8
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 10:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JL+uywl70Ka5ijggZAeoffSfCxSayq8hEb6NBY5TJsE=;
  b=QRNQRKT3qbhTr2f5lwsXUqZpiTg4Siooe+sfL47s+RwFRhJsX+8hznnT
   JREYDqAUQQ2ow0aJYiwyyCIsxQgk9oq7TmuLCbqIXpmBiCzX7/54YMZOY
   eZvnKnpejj9CBjifmADwATzoFVoOL2R94QkYCRSiVVkwq7zT5Hg/15HRi
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
   d="scan'208";a="213438080"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 11:07:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 00226E0D1F; Tue, 18 Mar 2025 11:07:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BF392E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 11:07:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=JL+uywl70Ka5ijggZAeoffSfCxSayq8hEb6NBY5TJsE=;
  b=Pzo+eyJvddEYw7oYtwbrjRubPdYNMxqJiGVnkXLfNbENMFhwAah/WZpz
   0wQ4SHUlbax2w0GZ58kyzdGH+mvlP3S+W3MeZ1oTedOa02ZdIHsH25v5F
   QT1RqG9V/d3IXxVFIpuaRaKoHp+uZOq2REA4l9/6ymjLRVg92zHv/j4xj
   o=;
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213438052"
Received: from lfbn-idf2-1-133-189.w83-202.abo.wanadoo.fr (HELO [192.168.1.23]) ([83.202.217.189])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 11:07:33 +0100
Message-ID: <12c566c7-878a-4c2b-b96d-f6e35e440be3@inria.fr>
Date: Tue, 18 Mar 2025 11:07:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <20250317125450.29e4b586.olaf@aepfle.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <20250317125450.29e4b586.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] make check results differ in gadget_sorting_hook
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2607
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/12c566c7-878a-4c2b-b96d-f6e35e440be3%40inria.fr>

Hi Olaf,

Thanks for the report. This should be fixed as of 350974c47, which is 
not yet on the GitHub master branch. I can't reproduce the error on the 
latest commit on GitLab, 4093aad2.

Cheers,
Victor

On 17/03/2025 12:54, Olaf Hering wrote:
> Hello,
>
> a copy of coccinelle built with ocaml-pcre and another one build without
> ocaml-pcre give different results in make check in gadget_sorting_hook.res.
> This is the only difference, Str.regex fails to pass while Pcre works.
>
> Any idea why that is the case, with git commit cca22217d1b4316224e80a18d0b08dd351234497?
>
>   gadget_soa_select.res         : CORRECT
> -gadget_sorting_hook.res       : CORRECT
> +gadget_sorting_hook.res       : INCORRECT: diff token: any_sort_func VS soa_gather__particle_data_soa_t
> +File <COCCIOUTPUTFILE>, line 21, column 1, charpos = 555
> +  around = 'any_sort_func',
> +  whole content =      any_sort_func(P);
> +File "tests/gadget_sorting_hook.res", line 22, column 1, charpos = 624
> +  around = 'soa_gather__particle_data_soa_t',
> +  whole content =      soa_gather__particle_data_soa_t(P, P_soa, 0, NumPart);
> +
> +    diff (result(-) vs expected_result(+)) =
> +    @@ -18,7 +18,12 @@
> +
> +     int main()
> +     {
> +    +  /* FIXME: this is a transitory gather-sort-scatter hook solution */
> +    +  soa_gather__particle_data_soa_t(P, P_soa, 0, NumPart);
> +    +  soa_invalidate_soa__particle_data_soa_t(&P_soa, 0, NumPart);
> +       any_sort_func(P);
> +    +  soa_scatter__particle_data_soa_t(P_soa, P, 0, NumPart);
> +    +  soa_invalidate_aos__particle_data(P, 0, NumPart);
> +
> +
> +       /* FIXME: this is a transitory gather-sort-scatter hook solution */
>   gadget_triplets_typedef.res   : CORRECT
>
>
> Olaf
