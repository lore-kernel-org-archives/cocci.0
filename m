Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FDFC433F5
	for <cocci@archiver.kernel.org>; Sat,  8 Oct 2022 07:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=y482c9KYKPLEs+Kl13ykbudpYNohmEbf6xP4dg/Q9jo=;
  b=iNkINhgMxM6eYz79M1o1RSiSqzN5XSJoYJHwDfLyzNhnyJKWI5VekRsF
   toxISIYv8J1TDE6TaKTMyZWQq7YEt/jReBQr/Lq/Q8oPF7/I/O8+9HBCf
   9XUYymUcDN/bsu7jf29yMO1lcdHjwzWIYAhCNrkDOHTjo9ofBYriKyCSz
   o=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="5.95,169,1661810400"; 
   d="scan'208";a="56593225"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Oct 2022 09:36:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0B385E028F; Sat,  8 Oct 2022 09:36:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 89050E0121
	for <cocci@sympa.inria.fr>; Sat,  8 Oct 2022 01:11:49 +0200 (CEST)
IronPort-SDR: 6340b234_p1aez25yE39hkKReDRk3+zkCScv1i5Ch7o4oiYsg13Sr/xq
 JGT0Vfx4kg7Hz+HAeNwVfUbAB3J1yJ9YHRi+u/w==
X-IPAS-Result: =?us-ascii?q?A0B5AwARsUBjfy7YVdFagQmBT4IkgQFWLgRQjUyFcpQSi?=
 =?us-ascii?q?yuBfAsBAwEMATcLBAEBgVOIKAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBEwEBGAkZBw4OBSSFaA2CNSKEBCgGAQE4gRQBBQE1IoJcg?=
 =?us-ascii?q?yADEJ4dgQRCizCBNIEBgggBAQaBQAGETYFcAwYJAQiBK4tPg2WBIRyBSUSBF?=
 =?us-ascii?q?YYzgkaDQYIumjg4A0QdQQMLdxgDFAMFIQcDGQ8jDQ0EHQwDAwUlAwICGwcCA?=
 =?us-ascii?q?gMCBhMFAgJNNAgECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJ?=
 =?us-ascii?q?hcHEzMZAQVZDgkhHCgNBQYTAyBvBUIPKC9pKx0bB4EMKigVAwQEAwIGEwMiA?=
 =?us-ascii?q?g0pMRQEKRMPLQcpcQkCAyJrAwMEKCwDCSEfBygkPAdYOgUDAhAiPQYDCQMCI?=
 =?us-ascii?q?liBKSYFAw0ZJggFNxsECDwCBQZTEwIKEgMSDy1KD0pAPZoMgQuBCYE5F4Fno?=
 =?us-ascii?q?3KeaINogUkMiWiVMBGWV5IelxCNQJoGAgoHBhAjgT46gVszGggoCIMiEgE7A?=
 =?us-ascii?q?xkPlyaFaiE0AjkCBgsBAQMJixgBAQ?=
IronPort-PHdr: A9a23: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
 d/KxvqbwNJq+NLO+s4dGs2SL9iIYiJJDA==
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:DRQ+iavUx8bZkQSeNkKzAbg57skDTdV00zEX/kB9WHVpm+ij5r
 iTdZUgpGbJYVMqMk3I9urwW5VoLUmsl6KdgrNhW4tKPjOW31dARbsKheCD/9SJIUzDH4VmpM
 NdmsZFebjN5JtB4foSIjPULz/t+ra6GWmT69vj8w==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,168,1661810400"; 
   d="scan'208";a="25818574"
X-MGA-submission: =?us-ascii?q?MDECLxGVHB7z212+6+BmxWA+jFo7dHmIyqJ5jT?=
 =?us-ascii?q?jnWFiTAzfKliBpR0jpd9SRGhdjzZ08fNunhG6P6UGlKdvis9/SmCeUr8?=
 =?us-ascii?q?7zl0Zk/vk87Cb1z2f3Qi6DaMe9UTguyV4bESLuXJ23sY94E8Rg53e9TS?=
 =?us-ascii?q?nR9EDXqJ7VQAWOhtKGTUyOeg=3D=3D?=
Received: from mail-pj1-f46.google.com ([209.85.216.46])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 01:11:48 +0200
Received: by mail-pj1-f46.google.com with SMTP id fw14so5549431pjb.3
        for <cocci@inria.fr>; Fri, 07 Oct 2022 16:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y482c9KYKPLEs+Kl13ykbudpYNohmEbf6xP4dg/Q9jo=;
        b=lTuEfFeG4wAMZUz4pJNjCwcvMAGWCCoXmseB6PtozvKvyT5OYI2y/VMu9U5JoNyJAZ
         yXHKipJTIqrm8MNaFNagVjhkSwWghzpvL5eAibM0/Rmzq4zFaDWKOj9xSDdTjExnHzLi
         8IEtfAvhEaUn2m1fJnpytVYsdo+OXLEnxFFi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y482c9KYKPLEs+Kl13ykbudpYNohmEbf6xP4dg/Q9jo=;
        b=7yOLle9B7YIvVcC9we8sERMNaxWR1f1Lu7JfID6LK5U7UTA+Hww5KRli/1iORuDMkD
         QruyomVEAmHyoZtXCZsLzq+UrW70sF95d+D8OI9br/p6xHxigAtr+i7IOEYimsT4ZqP5
         PaCTgjNJNZPrlewea55677r3dl6sj+QDL/t13MvYP4n+GZCiFsqSUSxoHyvf7bwrhNYz
         Wm/3Dz6MLvktvxmDSO2j4NxU60BWE7PWt6a6LJB+vBnmmBUR4Yjxw18iWmeAoCvvYsC2
         FjPsmC1AVxqSSlNUghypWP5tfW6W7WOJHmrAE5RgqTNYtqDopDyrPjeWquLpEEcJSXKc
         UOoQ==
X-Gm-Message-State: ACrzQf2HJbliS5dIqvyyZ84YtItOgLcYZLjtfYXdjCJ7dXSZGgvhzFUz
	BTP3BB8/IosmMSWC1XpXUtQ/lF6o9R2LVQ==
X-Google-Smtp-Source: AMsMyM72ymIPEEQDuxupqGYuqTh5bJ5N3xouPxqaguZwhzbrgyIS6F/RcjHjwZ288Y/T//kycef17Q==
X-Received: by 2002:a17:903:24f:b0:178:bf4f:fc7c with SMTP id j15-20020a170903024f00b00178bf4ffc7cmr7338295plh.124.1665184306244;
        Fri, 07 Oct 2022 16:11:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 67-20020a620446000000b0054ee4b632dasm2139486pfe.169.2022.10.07.16.11.45
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 16:11:45 -0700 (PDT)
Date: Fri, 7 Oct 2022 16:11:44 -0700
From: Kees Cook <keescook@chromium.org>
To: cocci@inria.fr
Message-ID: <202210071600.078A2101@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] how to check a for "don't care" state of a variable?
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 617
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/202210071600.078A2101%40keescook>

Hi!

I was looking at doing some conversions for this[1], and I wasn't sure
how to check for removing a variable assignment if there was either no
more uses or the next use was an assignment itself.

i.e.:

	var = 1;
	other = func(var);

turns into:

	other = func(1);

but this would not:

	var = 1;
	other = func(var);
	report(var);

without getting confused by:

	var = 1;
	other = func(var);
	var = 5;



@multi_line@
identifier randfunc =~ "get_random_int|prandom_u32|get_random_u32";
identifier RAND;
expression E;
type TYPE;
@@

(
-       RAND = randfunc();
        ... when != RAND
-       RAND %= (E);
+       RAND = prandom_u32_max(E);
|
-       RAND = randfunc();
        ... when != RAND
-       ((TYPE)RAND % (E))
+       prandom_u32_max(E)
// This is wrong: we need to check that RAND is either assigned or never
// accessed again
)


I thought I could do this:

	... when != RAND
	<... RAND = EXP; ...>

But this appears to be invalid syntax...

-Kees

[1] https://lore.kernel.org/lkml/202210071241.445289C5@keescook/

-- 
Kees Cook
