Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02999C433F5
	for <cocci@archiver.kernel.org>; Thu, 12 May 2022 06:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=85t2Bfuo4qv2WNoOn7Nu6sDtfu3wBSM0UoafjUX1CBE=;
  b=MBlf8/nl0XuyJN64fg4sZApo1HjMw1IlWIQWzo2G1svFhleJdFSjnbE/
   14oNQcKG2/k0LPu87LA0dnIoPcDu13YKUFrK8Eqv6oYDNuXhFiq9Esq9f
   yHW87bJHWiFeaKwte0nIcA1FMZGdT0kknKtLzkAPiOG5al8tBfYCFPXuz
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.91,218,1647298800"; 
   d="scan'208,217";a="35866866"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2022 08:42:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 75FD3E0267; Thu, 12 May 2022 08:42:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 28972E0048
	for <cocci@sympa.inria.fr>; Thu, 12 May 2022 08:42:50 +0200 (CEST)
IronPort-SDR: D8ClfveO3myPc9T1deGc4AV/ZhkQY0C5ZJ2fBRjduG2hTfcy870vmBdy/q0EMv08+JCH+ZVdp9
 TRY3lHPXak2IHL134EDGrmwyxu/2NINfQLIZ8Iry8KY3xAZCgTXydFdtHJ4GPhPQ7wRdUiq/vU
 7Xy7wIhWtm+TiGoNFy3StUfgyypC7IptRp3XzYG/X4LA4C56rLQwgE1BPwpyUk3QpfNmMDuwuY
 uo8y0SNDfRDtqhEMK93ifoseWnoV/bvYtsOF7Akb+8sh1ZiIekSdCDwfAkEAdPDdDSS9Lfw6UT
 asZvz+Z26ooXzlmlh17fkRNT
X-IPAS-Result: =?us-ascii?q?A0CPEQCjq3xifzXZVdFaHAEBATwBAQQEAQECAQEHAQGBP?=
 =?us-ascii?q?yUCgToCZjMBgR4uBAtDhE6BI49riyeBBYl5hlOBaAsBAwENEgEvBAEBhQICd?=
 =?us-ascii?q?gGERwIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBD?=
 =?us-ascii?q?QsJBwgKBw4OBWABYQMBRIFPgXQLAzENgjUpAYNkAQEBAgESER0BGxILAQMBC?=
 =?us-ascii?q?wYFBAEGNwICIgERAQUBHAYTIoU+AQMNJJ5/gQRBizKBFQUXgQGCCQaESwoZK?=
 =?us-ascii?q?A0VUgOBWQIHEoEoAgEBhhWBJAEBhyMnEIFVRIFLgnQ+hAaEFIJlBJMJgjEEB?=
 =?us-ascii?q?wMEBgEGDgMDAhAUAQIBDEgODwgFEgIDNAICAQELAgYGBAYDAQEGAwkCBAISA?=
 =?us-ascii?q?gIEBxgKEggUAwIGAiAFAQcFAQQDEgYMEQEKBgYBBAIKAQICBQUMAwERAQQCB?=
 =?us-ascii?q?gIEBAQYFAQCBAQFBgIJCAcFFgsECgIWAR0CAQYMCAICAgICBBUHAQ0FAgIED?=
 =?us-ascii?q?wIHBgMLAgMFBwMDBAcMBgwOAQMBBwEEBQMNBAEBBgILAwUKAgECAwwBAQcEC?=
 =?us-ascii?q?AEBAgIKAgEEAgcBAgUDAgMIAwIDAwICAQEEEQIDBAMEAgMBBgEBBQMCBQEDA?=
 =?us-ascii?q?wIBAwMDAgEEAwYJCgQIAQQEAQEBEQIHBwIGAwMCAgICBQECDQECAQIEAwgGA?=
 =?us-ascii?q?gMVAQIEAQoBBQIDCgIHAwEBAgcFCgIHBQIHAgIDAgEFAw0BAwUCAwEBAwMCB?=
 =?us-ascii?q?AECAQMDCQEDAgMDAgICAgUCAwICAgkDBAEHAwIBAQQFAQQDAQIKBAQDBAIEA?=
 =?us-ascii?q?gcCBwIEBwIBBAYDBwYBAwIBBwEBBAoEAwMDAQEHAQIFAgIDAgYSBgcCBAEDB?=
 =?us-ascii?q?AQKAgIMAgcBAQIBAQEBAgMCBwUOAQEBAwIDBgIFAgIBAQMICAMCAQQBBQMBB?=
 =?us-ascii?q?AUDBwIBBQkCCQMDAQgDAQEFAQMBCQMDAwIJAwECAgILBAMIAwMCAwQCAgICA?=
 =?us-ascii?q?QMCBwUIBAEECgICAgECAgIEAgEDGgECAwUCAgkMAQQCAgMBAwEBAggECQQCA?=
 =?us-ascii?q?wQCAQEDAgECAgEFAgMNBgEBAQECAwMBAgMBAQYHAggCMxYBAwMCAQICAgIFA?=
 =?us-ascii?q?gIBAgMCAg0BAQEEAgECAQIGAQMBAgIDAQMBAgIGAgwDCAIBBwEFAwMCAgMBA?=
 =?us-ascii?q?QUQAgQCAQQCAQIJBQIBAQEEAQMEBAgCAgEDAwIOAgQBBAECAQEjAwQCAwEDF?=
 =?us-ascii?q?wECAQIDAwMEBgcGAgECEwECAQEBBQECAQEEAgQEBwoDAgICBgMDBQEBAgMCA?=
 =?us-ascii?q?QEBBwwCAgITAgQKCQMBBgEKBgYVAwIEAgIBAgICCgMBAgIBAwIJAgECAQUlA?=
 =?us-ascii?q?wEBDyQBAQICAQICAwQHAgEEBwMNAwIBAQEFBg0DAgMIDAIDCwMCAQMDBQECA?=
 =?us-ascii?q?gIEAQIEDAoBAgMBAgIEBQUDAwECCAcFDQUOBicBAQVnA49HiGzDODQHg06BP?=
 =?us-ascii?q?QYMnjoxqFOWZaM+g1YQIxKBQoF/TSNQMYI3TgECAQEBDQECAQEDAQIBAgkBA?=
 =?us-ascii?q?QKSD4pgQjE7AgYBCgEBAwmNDgEB?=
IronPort-PHdr: A9a23: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
 BExjQR6bKIm8zK+uz8K
IronPort-Data: A9a23:mKv6f6gDG/Q98Y6OTOV8lfdqX161XBYKZh0ujC45NGQN5FlHY01je
 htvXm2BOf7eZWOhfNlybY3np00F6pLdnddjHgBv/Ho8EnxjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKieUsxIbVcMpB0J0HqPoMZkxN8x6TSFK1nV4
 4mq/pSGYATNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NplraKpawc3F7X3n8s+aTpRIh8nIJFq5+qSSZS/mZT7I0zudnLtx7BwFxhzM9BDvOlwBm5K+
 LoTLzVlghKr3brnhuLmDLM12YJ+d6EHP6tH0p1k5TjdAO09SJbPWaKM7tZC2TY2j9xPNfnbb
 ssdLzFoaXwsZjUUZwdJVsJjwo9EgFH6VhcJt3i5rJMmwFTa4B021JyyF/XaL4niqcJ9xx7E/
 Aoq5V/RCRYRP9230iuA6nvqh+nVnCq9Vph6KVGj3vtjgVnW2HdKTRNLDh20pv62jkP4UNVaQ
 6AJxsYwhbAM7W6rUPDlZBqXg0Snty8iAsdsP/JvvWlh1ZHoywqeA2EFSBtIZ9onqNI6SFQWO
 rmhz4KB6dtH4O39dJ6NyluHhWjtZnVNfAfucQdBHFRVuYCyyG0mpkuXFo4LLUKjsjHi9djNL
 92iqSE/g/ANlpdO2fjgu1/AhD2oq97CSQtdCuTrsoCNvl8RiG2NPdTABb3nARBoct3xor6p4
 iJspiRmxLpSZaxhbQTUKAn3IJmn5uyeLBrXikN1Ep8q+lyFoiD+J9oBu2EleBkxba7onAMFh
 meD6Gu9A7cDbBOXgVNfPupd9uxxkPe4Soy7PhwqRoMXOMksHON4wM2eTRfIgzqFfLkEnqY4N
 pOWGftA/l5LYZmLOAGeHr9HuZdynn5W7TqKGfjTkkr6uZLDOyb9YepUaDOmM7FihIvZ8VW92
 4gFa6OilU4EOMWgOXm/zGLmBQpVRZTNLcum9ZI/my/qClYOJVzN/NeLn+x7J9w+z/Q9eyWh1
 ijVZ3K0AWHX3RXvQThmoFg5AF82dZog/389IwI2OlOkhyoqbYq1vfUQcpI2ef8s8+k6lax4S
 PwMesOhBPVTS2Sfq25NM8Wl9IEyJg62gQ+uPja+ZGdtcpNlQTvP8IC2cwbq8h4IESfq59A1p
 Ket11+ATJdaH1ZiAc/aZeiB1VS0uXRByut+U1GZcNZWcUTotoNtLnWp3PMwJsgNLzTFxyebh
 17GW0dG+bGVrtZsotfThK2Co4O4KMdEHxJXTzvB8LK7FSjG5W78k4JNVeC/ezqCBm75/aOVY
 /oMk6PxPfgBq1Z9s4RmFoFtw69jtcDkoKVXz1g9EXjGMwarB7dnLiXU1MVDrPcWlLpQuA/zR
 FnWv9cHYvOGP8TqFFNXLw0gN7zR2fYRkzjUzPI0PESqu3MtreTfCR1fb0uWlShQDLppK4d5k
 +0vj8gbtl6kgR0wP9fa0y1ZqzaWInobX/l1v50WGtWw2A8iy1UHf4eFTyGru9eAbNJDNkRsK
 TiR3fKQi7NZz0vEUnwyCXmdgrYH1MpW4EhHnA0YOlCEutvZnftrjhdfxjI6E1ZOxRJd3uMvZ
 2VmOiWZ/0lVE+uEWSSCY4ytJ+2FLBiQ+0i01UBQ0WOEFA+nUWvCKGB7MuGIlKzcH6SwYRADl
 Ix0Ck68OdopQC019iQ3UE9h7ffkSLSdMyXczdu/EZ3t84YSOFLYb2zHWYbMgxTiCMI1wkbAo
 IGGOQq2hbLTbUYtnkHwN2VWOXn8hvxJyKyujMyNJJ80IFw=
IronPort-HdrOrdr: A9a23:f728rau3q+xe/8Gh7aUfXds87skDFdV00zEX/kB9WHVpm6uj9/
 xG/c576faasl0ssR0b8+xoW5PvfZq/z/JICOAqVN+ftWLd11dAQrsO0bff
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,218,1647298800"; 
   d="scan'208,217";a="35866856"
X-MGA-submission: =?us-ascii?q?MDFcligOtazoSIhImAtjy11I5wqQBCLdxU3d+i?=
 =?us-ascii?q?x2lEqO5HxH12wzNi56Zn8XFlALt3W3jtcFvfsIfB521zi5o6l465Dyvb?=
 =?us-ascii?q?6qNUECWnkQvXAfNMwCOMTWgRSnl4QJQXZK5BvAExaHqJeRGyAD7VJ9OH?=
 =?us-ascii?q?n0z7lHUP+U0ghIvToVCLGZsg=3D=3D?=
Received: from mail-vs1-f53.google.com ([209.85.217.53])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 08:42:49 +0200
Received: by mail-vs1-f53.google.com with SMTP id w124so4205974vsb.8
        for <cocci@inria.fr>; Wed, 11 May 2022 23:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85t2Bfuo4qv2WNoOn7Nu6sDtfu3wBSM0UoafjUX1CBE=;
        b=Gf0z/ErziIsW1tGtM1a+qGSqq8PLsp9EN+vyA7t6nMT2MR6+DtPHfFD5+2GtDBQjYr
         Lj6Umn3zisGc+5YQsCId+J3oil8QSbuc4OBkrJGv6f1Gj13Y4Oh77BbV8lu6BH97UGCL
         oR3Rjtk2Y6ZMdW+tAq0inPmg5Uxxseuthxfx9qcd2yxGvH+BtFHcPjFWzVpAJ/fejyHn
         +aFCFDqer4mPqMBP19XGIk56hzRkA33xYAKd5a2Ulr5t8EONWNTMfp23/2VFJWjCS2MY
         6GY6SUfxotQqIRLwr/55wjY1nJYSZP8Z23uWr6i8TPuCzIkTqI9k4+20xezDTB8zbCg/
         FW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85t2Bfuo4qv2WNoOn7Nu6sDtfu3wBSM0UoafjUX1CBE=;
        b=YZTZ1Ef6sBCUgb9kuYnY0l/jTXzWK7/jj8vFB4TJ43MlG01TiLLBA8rlTLIEgFckuX
         +GXmjqsB9G2YPTFEvmsg420XP046KU9DMONKirM4ZF5vABbtgcn7gma6CmssAQ7aMYUR
         MkQEP3JTDrEhBH4kEx3Tf99ECXFt+F57Lv2WUgFPiIdRyh/ZEWE97ymWT/QyvEN/Mv8D
         9UKFdaffu0l6mr7eIGRLczfKWdNjzHdUROY/UBZVwBVBkuprXBWiVacY6W7PN3CQF1Gc
         JnU09+emueu0yXN5SGRS40Bav3UfsEnibj9b3ZMUB1sxfWaXLwJvgbH2bgfyL8Z0RWTj
         EAUg==
X-Gm-Message-State: AOAM5315jfgKyI2KdZh7vFDjYY6U/APVpwtHdpUeSuH7RSeZk9qABAQ4
	WqSnbYW/2RsqCcjumzG2afUe7cOKL1T6nqrqDoQ=
X-Google-Smtp-Source: ABdhPJxEy76kxuvhdFwSE0OGfcxKO8CvR5P6HqaUtA+s/aL99vBstm7oZqaMzTFJBL50AuuryAyCXK0bISFuYx7z37I=
X-Received: by 2002:a05:6102:e96:b0:32d:3ecd:36f3 with SMTP id
 l22-20020a0561020e9600b0032d3ecd36f3mr15510059vst.71.1652337767973; Wed, 11
 May 2022 23:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
 <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de> <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com>
 <alpine.DEB.2.22.394.2205100957160.2667@hadrien> <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101123120.2667@hadrien> <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101236050.2667@hadrien> <CAPp5cGQzYtDVjE-K_Vpt3cbqYW-cwNTLmt_KwdpMdds9L7rXug@mail.gmail.com>
 <a4e74094-c6de-d23f-4d42-3b68c73687ea@web.de>
In-Reply-To: <a4e74094-c6de-d23f-4d42-3b68c73687ea@web.de>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Thu, 12 May 2022 08:42:12 +0200
Message-ID: <CAPp5cGS1DTUwCi9jNpjY_cA+cbMML+J1YNhy6yqPZ0ju+q9Q-Q@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Content-Type: multipart/alternative; boundary="000000000000b584e305decadd86"
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Alessandro Carminati <alessandro.carminati@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 386
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/CAPp5cGS1DTUwCi9jNpjY_cA%2BcbMML%2BJ1YNhy6yqPZ0ju%2Bq9Q-Q%40mail.gmail.com>

--000000000000b584e305decadd86
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good day, Markus.
This mailing list has been quite beneficial to me.
I learned a lot about coccinelle thanks to Julia, who helped me.
Still, I do not want to monopolize it for my own purposes.
So I put a halt to the discussion.
I have further intentions for coccinelle use in the future, which means
I'll probably bother you with different topics again. Coccinelle is a skill
I'd want to master.
For the time being, thank you all for your help.

Alessandro


Il giorno mer 11 mag 2022 alle ore 20:11 Markus Elfring <
Markus.Elfring@web.de> ha scritto:

> > I'm planning to stop bugging this mailing list, =E2=80=A6
>
>
> Why do you think in such a direction at the moment?
>
> Would you like to benefit from this communication interface any more?
>
> Regards,
> Markus
>
>

--000000000000b584e305decadd86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Good day, Markus.<br>This mailing list has been quite bene=
ficial to me.<br>I learned a lot about coccinelle thanks to Julia, who help=
ed me.<br>Still, I do not want to monopolize it for my own purposes.=C2=A0<=
br>So I put a halt to the discussion.<br>I have further intentions for cocc=
inelle use in the future, which means I&#39;ll probably bother you with dif=
ferent topics again. Coccinelle is a skill I&#39;d want to master.<br>For t=
he time being, thank you all for your help.<div><br clear=3D"all"><div><div=
 dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><=
div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">Alessandro=C2=
=A0<br><div style=3D"display:inline"></div></div></div></div></div></div></=
div></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">Il giorno mer 11 mag 2022 alle ore 20:11 Markus Elfring=
 &lt;<a href=3D"mailto:Markus.Elfring@web.de">Markus.Elfring@web.de</a>&gt;=
 ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt=
; I&#39;m planning to stop bugging this mailing list, =E2=80=A6<br>
<br>
<br>
Why do you think in such a direction at the moment?<br>
<br>
Would you like to benefit from this communication interface any more?<br>
<br>
Regards,<br>
Markus<br>
<br>
</blockquote></div>

--000000000000b584e305decadd86--
