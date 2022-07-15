Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E0CC43334
	for <cocci@archiver.kernel.org>; Fri, 15 Jul 2022 09:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:references:in-reply-to:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Kwqq6V7YdQP26/WXySPNDewn0n0ylJhYwJEb8MSnW/A=;
  b=E4iGkOy97LyFR5TX8e4IRWZRUh28s05jwV9L2czNInHqwT7yJ0Tp+qMY
   3lxr0CfaZjR3W9LTIUQ2UUiPgaSIS+zZhdCAXlHLs+Z3R5yVOZneInkjY
   M7MuRQRjoKK/AAOFzXLeEzAbyuFanecAiacSKZC0Z0uryW7zInqqCw40M
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.92,273,1650924000"; 
   d="scan'208";a="45668025"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Jul 2022 11:51:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BCDEBE02E3; Fri, 15 Jul 2022 11:51:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 52D63E0260
	for <cocci@sympa.inria.fr>; Fri, 15 Jul 2022 11:51:31 +0200 (CEST)
IronPort-SDR: CBXXU8hxTEqX74VNQCMF7debv1CBmPbUT8L1i7b3g/Zr2YuqTmm487N39aB0fb1em2v4r2v+Yr
 7nbblJbt8U3OlGK8a9BjCpU6bqVL2xLi5YVC/l6PkhqmklqzY8OJmESYEMf9WKOBq3CX+fmEgO
 MKsleaehOEh4SGSu8caBV06ytufgwDK2l4I0xz+D2+smYX2EYtUc9WqXXlADmP+tKP4TKvmG6I
 Hh92ZbyTm3v+76StsJ9RxcHnIoGswoKD1W1eTSjYN1w6A/g/kJZzTK/ysOs7twIsRSYQD/4VAG
 uFTtUOnOaRwgFdr07kGavTz+
X-IPAS-Result: =?us-ascii?q?A0D0BQBON9FifyraVdFaglgCgiKBAVYuBFCNTYgQjCwMh?=
 =?us-ascii?q?haKJ4F8CwEDAQsBATkHAgQBAYFRgm9FAoUOAh0HAQQxCA4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAETAQENCwkHCAoHDg4FYAFhAwFEgU+BdAsDM?=
 =?us-ascii?q?Q1AFgGBXikBg2QBAQECARIuARsdAQMMBgULOxATEQEFARwGNYJcgmQBAw0jA?=
 =?us-ascii?q?wQMnzmBBEKMRwUXgQGCCQaETQoZKA1qOoEfAgEGCQEIEoEZAY4Geiccgg2BS?=
 =?us-ascii?q?4JEMD6CYgKIGwSbUAQOCw8DAwIiAxotIwEBCgIGBgQGAwEBBQMJAgQCEgICB?=
 =?us-ascii?q?AcXChIIFAMCBgIdBQEHBQMDEgYMEQEIBAYBBAIKAQICBQUMAwERAwIGAgQEB?=
 =?us-ascii?q?BgUBAIEBwYCCQkHBRYLBAoCFgEVAgYMBQMCAgICAgQSBwENBQICBAcHAgcGA?=
 =?us-ascii?q?wIJAgMFBwMBBAcMBAwOAQMBBwEEBQMLBAEBBgIJAwUIAgECAwkBAQcECAEBA?=
 =?us-ascii?q?gIDAgEEAgcBAgUDAgMIAwIDAwIBAQQNAwQDBAIDAQUBBQMCBQEDAwIBAwMCA?=
 =?us-ascii?q?QQDBgkKBAgBBAQBAQEPAgUHAgYDAwICAgIFAQIMAgECBAMGBgIDEAECBAEKA?=
 =?us-ascii?q?QUCAwgCBwMCBgQKBAIHAgIEAQUDDQEDBQIDAQEDAwIEAQIBAQMIAQMCAwMCA?=
 =?us-ascii?q?gICBQIDAgICCQMEAQcDAgEDAQQDAQIKBAQDBAICBwIHAgQHAgECBgMFBgICA?=
 =?us-ascii?q?QcBAQQKBAMDAwEDAgUCAgMCBhIGBgIEAQMEAgoCAgsCBwEBAgEBAQECAwIHB?=
 =?us-ascii?q?QwBAQEDAgMGAgUCAgEBAwgIAwIBBAEFAwEEBQMHAgEFBgIJAwMJAwEBBQEDA?=
 =?us-ascii?q?QkDAwMCCQMBAgwEAwgDAwIDBAICAgIBAwIHBQgEAQQJAgICAQICAgQCAQMaA?=
 =?us-ascii?q?QIDBQICCQsBBAICAwEDAQECCAQJBAIDBAIBAQMCAQICAQUCDgYBAQEBAgMDA?=
 =?us-ascii?q?QIDAQYHAggCMxEBAwMDAgIFAgIBAgMCAgwBAQQCAQIBAgYBAwECAgMBAwECA?=
 =?us-ascii?q?gMCBgkCBAEFAwMCAgMBAQUPBQIEAgECBgUCAQEBBAEDBAQGAgIBAwMCDgIEA?=
 =?us-ascii?q?QQBAgEBIwMEAgMBAxcBAgECAwMDBAYHBQIBAhMBAgEBAQUBAgEBBAIEBAcKA?=
 =?us-ascii?q?wICBAMDBQEBAgMCAQEBBwwCAgITAhMDAQYBDgUUAwEBBAICAQICCgMBAgIBA?=
 =?us-ascii?q?wIJAgECAQUgAwEBDyQBAQICAgIDBAcCAQQGAw0CAgEBAQUGDQMCAwgBDAIHA?=
 =?us-ascii?q?wIBAwUBAgICBAECBAwJAQICAQIEBQUDAgEIBAUNBQkLAQECAQMHBAMRAgUDB?=
 =?us-ascii?q?QUDAwIBCQEFAgMBAgEBAwQBAwQGAQECAwICAQYCAgEBAwMEAwECBgICBwIDA?=
 =?us-ascii?q?gEEAgMDAQEBBAICAgICAwMIAwIBCAcFAQYBAgEEAwICAQIHAQQBCQIBAwMFA?=
 =?us-ascii?q?wQBCgMPAwUDAQMDAhUKBQEFCAYJAgQFAgUDAgQCAwMCAggDAgQDAgsDAgYDB?=
 =?us-ascii?q?AIHEwcCAwICBQICAgICBQQDAQICAgICAgUCBAIBBQECAgIBAgICBAECAgcEA?=
 =?us-ascii?q?gMBAwQOAwMEAgIHAQICAQYBAgcDAQIBBAMBAQQCAgQBAgIFAgIBBAEDAQIGA?=
 =?us-ascii?q?gQDCgICAwICAgYIAwMMCQIDBQIGAQECBwQCAgsBBgIHAgIBAgMRAQMCAQQFB?=
 =?us-ascii?q?QMDAwkCAgMCBAICCgEBAQMCAgEFBQIEBw0CAgICBAICAgECAwICAQECAgQEC?=
 =?us-ascii?q?RIBAQIDBgMEBgMFAwIKGAEGAgIBAQICAgMDAgYCAQIIAgQBBAUCAQICAgIEA?=
 =?us-ascii?q?QMGAgMBAQIBAgIDAwMCAQQCBAMDAQECAQICAgMCAgIFAgIBFgIBBwYBAgICA?=
 =?us-ascii?q?gIDAgIBAgIEBicBAQUYTJ4lYYIfrHKUemGCE2eLIpUnlliSD5Z4jTOZbQIKB?=
 =?us-ascii?q?wYQIxKBLgOCEE0jFWyCN04BAgEBAQ0BAgEBAwECAQIJAQECkg+KYD80CzACB?=
 =?us-ascii?q?gsBAQMJgjqDCiYTCwGFVIMoAQE?=
IronPort-PHdr: A9a23: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
 BwNk+qQEA==
IronPort-Data: A9a23:AA5buawA72vNBKW5zdh6t+f2wCrEfRIJ4+MujC+fZmUNrF6WrkVTm
 DAfWmuDPPiJNDajKI8kO9m2pB8FucCDmIRiTQQ5rFhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOCU5NfsYkidfyc9IMsaoU8lyrRRbrJA24DjWVvS4
 I6q+qUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPhP0
 dRc9puxTjt5M6rpyMhHYiRpHwZhaPguFL/veRBTsOSWxkzCNnbumrBgUBtwMoof9eJ6R2pJ8
 JT0KhhXNkHF17/wmuvrDLU27iggBJGD0Ic3s29p1zjTJfkjSJHHBa7N4Le02R9s254QTa6HN
 qL1bxIwfjOYRjceCGsLI8wRvuesnlfYd35h/Qf9Sa0fujCPlmSdyoPFNNPKc9iObddUm0yCr
 yTH+X74C1cULrS3wj2O+XOEnf7KhSq9WYQIFbT++OQCvbGI7mkaCRlTWFni5Pfl0AixXNVQL
 0FS8S0rxUQvyKC1ZufkXgz7p3+Dgk4RXP8AP7cL1TCB7bWBtm51GVM4ZjJGbdUnsuo/Sjory
 kKFkrvV6dpH4O39pZW1puf8kN+iBcQGBTRdOnJcHGPp9/Gm8d5j1EueJjp2OPft1oWdJN3m/
 9ydQMEDa1g7iMcK0+C2/wmCjW724JfOSQEx60PcWWfNAuJFiGyNN9zABbvzt64owGOlor+p4
 iRsdy+2sr1mMH11vHbRKNjh5Znwjxp/DBXSgER0A74q/Cm39niocOh4uW8jexczaZpfJmOwP
 ic/XD+9ArcDbBNGiocnM+qM5zgCkMAM6Py+C6+INIsWCnSPXFbfoX4/DaJv44wduBF0zftX1
 WazfsGrAnIXYZmLPxLnL9rxJYQDn3hkrUuKHc6T503+jdK2OSDIIZ9YbwPmRr1otMus/VSOm
 /4CZpvi40sFDIXWPHKMmaZNdgBiEJTOLcqpwyChXrXTfFQO9aBII6O5/I7NjKQ8xv4KzLySo
 C3tMqKaoXKm7UD6xcyxQigLQNvSsVxX9BrX5AQgYgSl3WYNe4Gq4PtNfpc7Z+h1++lqzPoyR
 P4AIp3SDvNKQzXB2jIccZit9Nw4JEr33VqDb3i/fTwyX598XAiWqNLpew3Y8iNRXCe6sM0Jp
 aKti1HASp0ZSgU+V8vbMar9z164sXUHtvh1Wk/EfotadEn2odplLiXwirk8JMRVcUfPwT6T1
 gC3BxYEpLmV89VlroWR3a3d9tWnCepzGEZeDlL317fuOHmI5HenzK9BTP2MImLQWWbyz6OoO
 rdYwvT6B/sYxQoYvod5FYFr+qIw/d7YobFXk1Z/F3LRYlX3U75tLyXU3cRLsaERlLZVtRHsA
 RCK89hefLiLYYbrTARXKw0iYeCOk/oTn2CKv/gyJUz74g5x/aaGARoOZUjS0HQFIesnKp4hz
 McgpNUSt161hC0sP4vUlStT7WmNciENXvl1rJ0cG4O32AMnxksYOs7ZAy7ypZyNMpBCbhNsL
 TiTi67Pwb9bwxOaIXY0EHHM28tbhIgP6E8Wlg5cfwzRl4qXnOIz0T1Q7S8zElZfwCJB3r8hI
 WNsLUB0efiD8joAaBKvhIxw99ytxSF1+3AdD3MMnWzdCkSqDynDcDd7NuGK80QUtWlbe1C3O
 V1eJHnNCV7XkAPZh0PemnKJb9TsSNVw8kvJn8XP8wGtAcwheTS86kOxTTNglvYkaP/dQGXIo
 OBr+KB7bqiT2ev8ZUEkI9Hy6In8gyxo6ICPrT+NMU/J8azhlOmO5AWz
IronPort-HdrOrdr: A9a23:Pz+RfKjhKi+XUrMjSmEnJbXFZHBQXg4ji2hC6mlwRA09TyVXrb
 HLoB17726JtN91YhsdcL+7Sc+9qB/nhPxIyKkXeayvRQz3/HavRbsSlrcKoAeQZhEWlNQtr5
 uIGpIWYLaRfDtHZITBkXCF+r4boeVvm5rY4ts2oU0dKD1CV7tt9ENwBAqdDyRNNXF77FkCeK
 Z0JPArm9NtQxsqhw2AaEU4Yw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,273,1650924000"; 
   d="scan'208";a="45668019"
X-MGA-submission: =?us-ascii?q?MDG7HoE2t+aAix930NlrqOyzY5WGZfmUnPPSfv?=
 =?us-ascii?q?6DxLP0m7UyxcBU/KAZ+AmDkQ0leQQQSZZoJaVkMX0SAgaGOFFzPk6YY0?=
 =?us-ascii?q?mQlGclbAZ7D4etDtZJMurHRcEglkFrcTlP1hW65mqWCWy5PxHbqXCUir?=
 =?us-ascii?q?9U+czumVTmaI0+77nGlmBdvw=3D=3D?=
Received: from mail-ej1-f42.google.com ([209.85.218.42])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 11:51:30 +0200
Received: by mail-ej1-f42.google.com with SMTP id va17so8149661ejb.0;
        Fri, 15 Jul 2022 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Kwqq6V7YdQP26/WXySPNDewn0n0ylJhYwJEb8MSnW/A=;
        b=BkEmo/YdfziujYjCRVwzT4plhDsK0jEhAhZjXkpcxbJ5C46m3RcW7fJcD7y/Y7uBQ6
         brdam4A6SLdBYd+TDIfBqYBpJGzV/kzSphw/9ZDsmVsXk77Ws4Umt8TZmOzLGLRdaW70
         aDsISv2X4JQ8AqG+gq7cCBRqJlG7odkCGkGv1/laPqXj2xAhrneefeqDTX67UoBzb7A8
         AMiU1gLxAP+RWuPoGr56do9sh1N1bGCoDkl+BoiTI1kuPd7InkTr5v5n0y+bKwn5RSa/
         CFF2ip9vuh5nOn9apeBkfQrPk3naqqd2xtyUWJylJ5ePzMz0w80yclnBE3l4fnTa+0kY
         YrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Kwqq6V7YdQP26/WXySPNDewn0n0ylJhYwJEb8MSnW/A=;
        b=Ra+7KBMFmu/tODy8DKxQL9bCRXLaqBGItk/1QFHtO18u/x7qDyL+OZEa6eQCGnr94a
         NHE15oTcrAP6dPnZTBI7/q/Was5FFiX2nDR+oQ5/u2T1yQHYQ4l/ruze6IPC4eiTcyFi
         uQvyeCAf8h0kPlKQQmjbUalt3iV5+jFfnlCASNgyBNJEMPBE39eKjNwT+foWd7Br1k2d
         6yC2Ve+z/DlDmrWXWt4lfmrsqOa2n22qKCOWQETs4Msv7Jw8x6eZxod2lj9rIJ+xV9VT
         9qtkLozx4bnTic/zSIB5Lsk7FeTmI6RN8JKcqyUuai192etW1jf5fWq74oVppi9H14/S
         uIQA==
X-Gm-Message-State: AJIora8E7HluElZiNOuZN3EFkuRC+FgeH8CLY8kyQyhgupOZnY0tEzpK
	ZL7D9ng+EWLm9tsICVtTnAnPAxgiOqSpYw==
X-Google-Smtp-Source: AGRyM1vfsd4YILvFmquE6bbLDHWz9E18xL/VsJ0QIrsPLbGbgCl8BgipureUK/Gl7mRw4TNJBsbHrw==
X-Received: by 2002:a17:906:6c82:b0:709:f868:97f6 with SMTP id s2-20020a1709066c8200b00709f86897f6mr12746790ejr.555.1657878689657;
        Fri, 15 Jul 2022 02:51:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w5-20020aa7d285000000b0043586bee560sm2490818edq.68.2022.07.15.02.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 02:51:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
	(envelope-from <avarab@gmail.com>)
	id 1oCHyp-002dGW-TN;
	Fri, 15 Jul 2022 11:51:27 +0200
From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Coccinelle ML <cocci@inria.fr>
Date: Fri, 15 Jul 2022 11:50:43 +0200
References: <220714.86bkts2fz9.gmgdl@evledraar.gmail.com>
 <alpine.DEB.2.22.394.2207141138450.3019@hadrien>
 <220714.867d4g2ewo.gmgdl@evledraar.gmail.com>
 <alpine.DEB.2.22.394.2207141246300.3019@hadrien>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <alpine.DEB.2.22.394.2207141246300.3019@hadrien>
Message-ID: <220715.861qum1z6o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [cocci] How do I disable formatting for the "+"-side of a rule?
Reply-To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 494
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/220715.861qum1z6o.gmgdl%40evledraar.gmail.com>


On Thu, Jul 14 2022, Julia Lawall wrote:

>> Thanks, no it just changes the spacing of the "=", i.e.:
>>
>> 	+       struct ref_array array = {
>>
>> v.s. with --smpl-spacing:
>>
>> 	+       struct ref_array array<TAB>= {
>
> Strange about the tab.  There was no intent to have alignment.
>
>> (Or similar, I think it's aligning to the "=" above it?)
>>
>> But the rest is the same, i.e. a \n after the "{", the "0" on its own
>> line etc.
>
> Coccinelle now just does what you asked for.  If there is one element in
> the initializer, it doesn't add newlines.  So no need for the
> --smpl-spacing argument.

Fantastic! I just tried with your
https://github.com/coccinelle/coccinelle/commit/bcc39cff36dcc8bbad3e2131fd92addc3ffa4ee5
and it formats it as expected, thanks a lot for the help & quick fix!
