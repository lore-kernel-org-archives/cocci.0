Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDA5C38A2D
	for <cocci@archiver.kernel.org>; Tue, 25 Oct 2022 20:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=K39i3ILbNgZxFhiM4McBtCsSx3N2lmFn6vhBAIg2/Lk=;
  b=qhP5odcxZGilBs0idi/6iCIbaYF6UU75ePBXMIPF12OCzjyq2EKyfoNS
   OJrNnBRrF2BU5ZwyKyHFK/LHXbSdNPQlCc5HTgT2cQORgXfOdT2JeqVka
   N5hp4WBQEPJzCGUkJL7icIHetV/ADhluz6JJAEJT/65WyD3/vgU1Tmdjy
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.95,213,1661810400"; 
   d="scan'208";a="71493876"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2022 22:35:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A5997E0152; Tue, 25 Oct 2022 22:35:18 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 086F8E0130
	for <cocci@sympa.inria.fr>; Tue, 25 Oct 2022 22:35:17 +0200 (CEST)
IronPort-SDR: 63584884_LMPvKTTO+g+2dNwhnEue9m56RKXPcJIPnL47ZdFsRWsZq4z
 E1++9Y3zoC6UGic+/kGPP+dSWdA9uH7RfAhoJOA==
X-IPAS-Result: =?us-ascii?q?A0BsBgCNR1hjfzGAVdFaHgE8DAILFYFPgi2BBFMuBFCET?=
 =?us-ascii?q?pEci0KBB4YjjDAPAQMBDAFEBAEBhQUChHYCHQcBBDMGDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQEARMBARgJGQcODgUkhWgNgjUpAYNkAQEBAxIRH?=
 =?us-ascii?q?QEbHQEDDAYFCw0CAiYCAiMRAQUBHAYKK4VIAQMwAwSePoEEQosygRUFAhaBA?=
 =?us-ascii?q?YIJBoJigW0KGSgNaAOBWgIHCQEIfy2IZIM/g0l6JxyBSUSCLYFiMD6ERBWDQ?=
 =?us-ascii?q?oJmBJIpgzMBAwUUDwMDAiEDGSsdAgkDIw8DCwkIExcoBgMBAQwHRgQcHwMBA?=
 =?us-ascii?q?Q8kAQECAgIDBAcCAQMGAwwCAgEBAQUGDQMCAwgBEgMCAQMFAgIEAQIECggBA?=
 =?us-ascii?q?gIBAgQFBwIBCAYFDQUJCwEBAgMHBAMRAgUDBQUDAwIBCQEFAgMBAgEBAwYEB?=
 =?us-ascii?q?AEBAgMCAgEGAgIBAQMDBAMBAgYCAgcCAwIBBAIDAwEBAQICAgICAgMDCQIIB?=
 =?us-ascii?q?wUBBgECAQQDAgIBAgcBBAEIAwMFBQkPAwUDAQMDAhQKBQEDCAYIAgQFAgUDA?=
 =?us-ascii?q?gQCAwICCAMCBAMLAwUEAgcTBwIDAgIFAgICAgIFBAMBAgICAgICBQIDAgEFA?=
 =?us-ascii?q?QICAQICAgQBAgIHBAIDAQMEDgQDAgIHAQICAQYCBwMBAgEEAwEBBAIEAQIFA?=
 =?us-ascii?q?gQBAwYCBAMKAgIDAgICBgUDAwoIAgMFAgQBAQIHBAICCwEGAgcCAgMQAQMBB?=
 =?us-ascii?q?AUFAwMDCQICAwIEAgIKAQEBAQICAQcCBAcPAgICBAICAgEDAgIBAQICChIBA?=
 =?us-ascii?q?QIDBgQGBQMCCBgBBgIBAQICAwMCBgIBAggCBAEEBQIBAgICAgQBCAIDAQECA?=
 =?us-ascii?q?QICAwMCAQQCBAMDAQIBAgICAwICAgMCAgEPAgYGAQICAgICAgICAgEFAQIBA?=
 =?us-ascii?q?gQCBwIEAwIBAgIFAgICAwEBBgIECwEDAgcGAQMCBwUCAwEEAwQDAwUGBQwIA?=
 =?us-ascii?q?QUBAwEeAwICCAIHAgEGBQEPAwICAwICAQQKAgMFAgQCAQQJBwIEAQIJAwIGA?=
 =?us-ascii?q?gcFGAECAgcEDAoCAgIFBgIEAQEBAQMBAgEBAgMEAgMCBAUBBQIBAgUEAgIBA?=
 =?us-ascii?q?QIFAgwBAgEHBgIHAgICAgMBBAIBAgEDAwIDAQEBAwYGBQQEAgMDBgICAgYCA?=
 =?us-ascii?q?gMCEgMHAgYDAgQBDQ4FBAUIAQIBAQcCBAIHCQ4CAQYBBQICAwICAQQBAgEGA?=
 =?us-ascii?q?wECAgICBQgFAwQFAwkMAwEBBAMCAQIBBAMCAwcDAgQEAwECAwQGBgEJAwICB?=
 =?us-ascii?q?gMCAgINAwQCAgECAQIDBAQGAgICAQICAgIDBAICAQEDAwMCAgIDBAIDAwsGC?=
 =?us-ascii?q?ggCAgIDAgEFCwQCAwIBAQMGCQIEAgIGAQIEAgICAgICAgMBAQMKBAIBAgMCA?=
 =?us-ascii?q?gYDBgIBAgECAQkFAgEJAwECAQIBBAEDBgQBAgIECQIDBwUEBgQCAgICCAICD?=
 =?us-ascii?q?gMDAgEBBAICBAUCAgsCAQIHAgUBAQMFBwICAQICAQQDAQkEAQICAwIBAQMDE?=
 =?us-ascii?q?QMDAwEEAgIFAwMNCQYCAgEDAgMBDQMDAQIBAgMBBQUXAwIBCAcDEwMCAQEDA?=
 =?us-ascii?q?gECAgMGBAEIAgIDAwMCAQIFAgQDAwEFAgEBAwEFAwIOAwIDAwMCBgECAQECA?=
 =?us-ascii?q?wIDAQwEBQEBAQEXAQIDAgQCAgEBAgUBBAMBAQIBAgMCAg4GAQQFDgUCAQIfA?=
 =?us-ascii?q?pkSgQITTIElOHrCD2ODCaBHMpZrFJITlyOnSwIKBwYQIxKBQySBW00jFWyCN?=
 =?us-ascii?q?k4DGQ+SEopgPzQ7AgYBCgEBAwmKWwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Z87q6ZhLYxbNrz/dJbFY+4UvJI=
IronPort-HdrOrdr: A9a23:rljhI6sT1fQViABaBjiHlTyr7skDVdV00zEX/kB9WHVpmwKj5q
 eTdZMgpGXJYVcqKQodcLW7UpVoLkmsk6KdjbNhWItKGTOWwVdAT7sSkbcKoQeQeBEWn9Q1vc
 wBT0E9MqyJMbETt6fHCWKDYrQdKbe8gcSVbKvlvgpQpMJRB52ILT0VNu9WKCJLrcB9a6YEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,212,1661810400"; 
   d="scan'208";a="35538301"
X-MGA-submission: =?us-ascii?q?MDHlmlvRZoLMRzsRLjwnBgMdqeMhWmHuUD+EHg?=
 =?us-ascii?q?/K7kQ7HXv8Qabapd0S4HqbVhXlPE56NoCnfrIEuzM5Yo8frnDeBWOXby?=
 =?us-ascii?q?GMlnQh46ySMyxtTf01R0mkDBYIQ1KBpYi/RowfsQXDCAiSS0f7XBmhRk?=
 =?us-ascii?q?SIIt0z4PHs6/vp6ZgxG5dtuQ=3D=3D?=
Received: from mail-wm1-f49.google.com ([209.85.128.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 22:35:16 +0200
Received: by mail-wm1-f49.google.com with SMTP id l14-20020a05600c1d0e00b003c6ecc94285so1215049wms.1;
        Tue, 25 Oct 2022 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K39i3ILbNgZxFhiM4McBtCsSx3N2lmFn6vhBAIg2/Lk=;
        b=IDMdZIysUsB9QjN0ZP4n/HwWHyLzTtVMibJEqtpZgSm0cmb1L5Wgr4GFPNIOq6cHFA
         sw72m2Mlt4W9Da+2yZEHXRMitSMHsZmzXRauW4Y63yzqhekQMN/S73MA1mq2tgM8B9t9
         Qhe97NS+yw81AMxMorlov08wFPfH/LeGEeUaR5uXLs7EHX6bTvxPU33S9TDy0gEqqN2s
         Sh1rG8jOJlgcnq7x5n8Er4MSrRvDLPNqrDN7hYqMVNJ75lRCy3HUWkOzhL6uttYdQpK2
         Oh0/F8D5EYyT1N6fhG41pe9tVmkRkRpLWds+avX+uHeBqL8L2r6ceV1xIeLbhfMNBEhs
         POyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K39i3ILbNgZxFhiM4McBtCsSx3N2lmFn6vhBAIg2/Lk=;
        b=QpmI3T3G0etrzUU+cdryXE86EnoCU84DpC1WAquTocw51tTUFv66hwokQ7oNvUhlXN
         wB0yeaFWeHaOJNZFbjSrvNv5vIkxTawyYc/a07nPaMSnozKKYEoIWete8Zv6cHBNsKbH
         MILAkiNAJOO7ms58U4denTVSm09EuGPfoe4n1PJhxMxY/PLyj05F9Y3cSvOqSKOuR85u
         zUReCJcn9iP3qrNIYVIM+NYn6HFkecWL+R3ex6XmaMwJVeZoRkmJrZZxfNF9PWoVHqnh
         KLn+5ZoDJmmgtah7bHuaan8TSlwNRf9ghavQ/ikNlym0bEmw0sr05wkeIfdpPX3DUR4B
         cfHQ==
X-Gm-Message-State: ACrzQf2/ShDms0NLsHZGhxG5GloAxROedKDchPpBzofMbu8xgV6ieBTD
	3IAYlwNm+6BaTlrzgAkgxtBafBx9Rio=
X-Google-Smtp-Source: AMsMyM4+s42P9GMTiPY0fTLOjx0GK3trtnzql5ukOM8z+2obHeeMsr3Xm8ZjousK1u9M6XkA1ofnOg==
X-Received: by 2002:a05:600c:4209:b0:3cf:4452:2301 with SMTP id x9-20020a05600c420900b003cf44522301mr75655wmh.104.1666730115460;
        Tue, 25 Oct 2022 13:35:15 -0700 (PDT)
Received: from [192.168.1.191] (ip-89-177-205-85.bb.vodafone.cz. [89.177.205.85])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c314a00b003b47b80cec3sm12294898wmo.42.2022.10.25.13.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 13:35:14 -0700 (PDT)
Message-ID: <f0cc086369f9d48bf5ee47349d936335cac13005.camel@gmail.com>
From: Jan Tojnar <jtojnar@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, Thierry.Martinez@inria.fr
Date: Tue, 25 Oct 2022 22:35:12 +0200
In-Reply-To: <3ee3239d-4b72-9239-893e-b08acbae7df9@inria.fr>
References: <e3746c66c0f9c0747620dd7536c98ca6deb5399b.camel@gmail.com>
	 <3ee3239d-4b72-9239-893e-b08acbae7df9@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
Subject: Re: [cocci] No longer possible to build with system dependencies?
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 688
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/f0cc086369f9d48bf5ee47349d936335cac13005.camel%40gmail.com>

On Tue, 2022-10-25 at 16:54 +0200, Julia Lawall wrote:
>=20
> This problem should be fixed now.

Thanks, d9ce82a556e313684af74912cf204bb902e04436 fixes the issue for
stdcompat but it still does not work for pyml.

If I remove the `/dev/null` redirection from pyml=E2=80=99s configure test,=
 it
reveals the following error:

    File "configure_test.ml", line 2, characters 0-0:
    Error: Syntax error

Looking at the contents of `configure_test.ml`, the square braces do
not appear to have been transferred:

    Py.Class.init ~parents:

Apparently, three braces are sufficient to make it work but why that is
the case eludes me. m4 language is simply beyond my comprehension.

