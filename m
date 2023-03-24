Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9880C6FD20
	for <cocci@archiver.kernel.org>; Fri, 24 Mar 2023 18:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=00A67wpDP1gotk9mR1d6qiW0CG6G98ynt9yJtScsAwQ=;
  b=TJd8nrQv3G0HH2q2NPZIrGERWpowcOznHtUXtyGnXkqDRZX3hA12um9X
   SfHfgYWmRqUlSMzup0GPihsAxaF+6SoHQm9cNZ0Oh9tr3TlcSAyyaAzwX
   JhP470fhpTJECKVirYZjqGysv6wMwJhmoGraCGQ6b/aL/rJhhVMUYx4mw
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,288,1673910000"; 
   d="scan'208";a="98999420"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Mar 2023 19:19:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 99E6BE0D42; Fri, 24 Mar 2023 19:19:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 32835E0D40
	for <cocci@sympa.inria.fr>; Fri, 24 Mar 2023 19:19:17 +0100 (CET)
IronPort-SDR: 641de9a4_1sTUzGEeenKEnpkI1piBxyculhiQfyjBB+N6T45q1XN35U5
 lFBxQrZO/M6Pn0HIyktNMfQeQ5QvWkgUpb/HAeg==
X-IPAS-Result: =?us-ascii?q?A0GLAwDL6B1khwsR49RagQmBT4IugUsvBAtGhFORAS4Dh?=
 =?us-ascii?q?C+HLIc6hGeEAoMWPg8BAwENQQECBAEBAwQ4gVOCcwKFOgIdBwEEMwYOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGgkXBw4QBSKFaA2CN?=
 =?us-ascii?q?ykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHUz0BAgIBIx0BAREmA?=
 =?us-ascii?q?Q8JAhoCJgICVwYBDAgBAYJ6gigBAw4jB5V9nBeBMoEBgggBAQacCh8sIlOBX?=
 =?us-ascii?q?gmBFC6NBIM2eicPgVVEgTyDAz6ERINYgmeCKodWhCOCdYgtCoE0dYEgDoE9g?=
 =?us-ascii?q?QQCCQIRa4ESCGuBfUECDWQLDm+BSwJkTIEaJQQOAxkrHUACAQs7Oj81BgMLI?=
 =?us-ascii?q?QZYawIJIxETBQMLFSpHBAg5Bho0EQIIDxIPBiZDDkI3NBMGXAEpCw4RA1CBR?=
 =?us-ascii?q?wQvW4EBBgEmJJ1WAhU9fgkmlFySQJ4ONAeCKIFVgVkMnwwGEy6DfYxmhiUOB?=
 =?us-ascii?q?pIjLoctkA8gp3qBeSSBXDMaJIM2TwMZD44rDgkVg26PCQE9QDQ7AgcBCgEBA?=
 =?us-ascii?q?wmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ffLsM61110WpXTlwMSJSbwqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,288,1673910000"; 
   d="scan'208";a="51185626"
X-MGA-submission: =?us-ascii?q?MDHix0/ZPLaTTVDfzBoeEUr4gMR2KAtWh06Nqf?=
 =?us-ascii?q?ICOOVVD+F4Mpp/2HHJtAL+QKlLKdX7CGsI7gQGMhDITRveRjjSwf42n9?=
 =?us-ascii?q?oFAg7mSGlCldDms+vCyYyvUgokEQkLv8e9diaS2xTc104EeCbuHC7gp3?=
 =?us-ascii?q?70/m2qxQSmXrbdm/rD1O3PNQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 19:19:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679681952; i=markus.elfring@web.de;
	bh=00A67wpDP1gotk9mR1d6qiW0CG6G98ynt9yJtScsAwQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mvQNbnQKavf8KLZ+ydyxDtj2jKHDzVyt7fH5p+vLdXSmYD0U2tIaBa8OKqRPiUUgh
	 qkfERyFt+G1jzWUjrLntB7CDqPTIDWte77RI+Gsk3/LIcA7GxjAd+jdEyHXrjeOXqc
	 7aZlS84ydC6h3JLYHtaaOuyDaIDY5OPwulLP4HksTe6hZ3YKbdox84ceRBUJlglBU3
	 efE7xixRatfffzJwPjlKF3YQOXdsBA2toLwgjKQ1+xIN/bP4QXk81LbPT5P2uv5Fse
	 cgnMeI5ZT5rfCJ1JB9IgwMSaLBuswhG9n4DOiNrtG6Od/NISHT0qZedMw1Kpy2MmRu
	 PFEU33+xxQ2kw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melax-1qDSf43TTZ-00aODC; Fri, 24
 Mar 2023 19:19:11 +0100
Message-ID: <7a523efc-a82b-a1a1-e846-6047226cc968@web.de>
Date: Fri, 24 Mar 2023 19:19:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, kernel-janitors@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 Stylon Wang <stylon.wang@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e6656c83-ee7a-a253-2028-109138779c94@web.de>
 <ea0ff67b-3665-db82-9792-67a633ba07f5@web.de>
 <32674bac-92c2-8fc7-0977-6d2d81b3257f@amd.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <32674bac-92c2-8fc7-0977-6d2d81b3257f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bMnv5agBssFzngTxa6JeEgTiLBePDIU/LFByM6gCbi49wlzsdY5
 XpmDpV/eOKA4qx/7u88hINiOpiTEO/wBDPobzGJRf7+KQVPBiahULRHI1XhAypOAAb+8f2D
 +IdcxUQ5xYewKfHVN0ePDdq97WECjmfGA8aVki/y/CUWL9xKUX53cNHhk+zBMPZY/jH1RUw
 PXa/OdfFr5mUgWLDVCeMg==
UI-OutboundReport: notjunk:1;M01:P0:dI49UMzWgEE=;rxBivc1evzhpimVGxxb01klR7FM
 WaogUt1Lax+oUuycoCP/VHuXdTAgxg9J4U0PMlbnDwZZT+9jugx8aUxzL58L2S/syyP0YTYEG
 MrS+ksAWRmVdwfLinruOrM5Z4j0SucT3tgnAhtWaoOs92EsAt1mY4Dzsqv2ImPIHgRY6KHU2f
 BHS7kTjB974XyC4I5HxHrUTdfSUIYKx9Ow5AnwhdunjH+NkYsJwyyynFYrIz6f1W6W4+ZxYEX
 UU0TNslRwOPAI34S5PFbjf8CptNE0aKqEEReHyN8ALvOOacWwregsZkcFfen8CjYsUZNXH+Ha
 O1/40B6H/1IJGdgGuuOX5PWlo7YH0Sr7TVIVui8MGK1E3mjmu5ZjUp26OuLKgrCnZIROGvghI
 +cQDw2nclwTNn8+UuUPehNcHoowkZz+w800BUVw5B1pq29N2MlXS+AHG0Y65sH2OSckPMk9z4
 ZjbDYyxlemcifwENOLEeCye2WXgqzCIKvmit8jyQxeYmV2K0jL81BWZZMIoVTWSmpBgIgelMk
 jweNNIvJ8OYgb6E0UlL7TDXW5pwr5tQcRUe/MV7U6h5jDArufPnGIVQQt/leGEbFv1Jv5LKws
 HnPFg9SCc3i5hsWEYvDjZqkG/92+1gj4SEc7FTarvgt63NI4smNb+dKwFd3mYCsBP5T5om0HL
 Cff8rmFh8IXQ2sDUfnhGIEsd7khYwJs7M7MYGW74ra9DY7e69UvDa5wZwnhKTRp54NzsKEPRs
 FGbYh/bxoQdXxZIfTka1N1c5PXmWlV0ZlC40th1y5jOImBOBieNxJ845HnzQewf30oMpJ2SAB
 NtGfwDnDIsmzv77unM4ok1RvTMWwl0xzwczx6k2BWQ6QIMvVHsGh2r0uJNOAV0mhHaymuCEwu
 G1wnsTJwrzx7vWJ15JPVFzmojvxHoPlgAIMdvWVrQZUPK1CWSVA3hhOdQ
Subject: Re: [cocci] [PATCH resent] drm/amd/display: Fix exception handling
 in dm_validate_stream_and_context()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 921
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/7a523efc-a82b-a1a1-e846-6047226cc968%40web.de>

>> The label =E2=80=9Ccleanup=E2=80=9D was used to jump to another pointer=
 check despite of
>> the detail in the implementation of the function =E2=80=9Cdm_validate_s=
tream_and_context=E2=80=9D
>> that it was determined already that corresponding variables contained
>> still null pointers.
>>
>> 1. Thus return directly if
>> =C2=A0=C2=A0=C2=A0* a null pointer was passed for the function paramete=
r =E2=80=9Cstream=E2=80=9D
>> =C2=A0=C2=A0=C2=A0=C2=A0 or
>> =C2=A0=C2=A0=C2=A0* a call of the function =E2=80=9Cdc_create_plane_sta=
te=E2=80=9D failed.
>>
>> 2. Use a more appropriate label instead.
>>
>> 3. Delete two questionable checks.
>>
>> 4. Omit extra initialisations (for the variables =E2=80=9Cdc_state=E2=
=80=9D and =E2=80=9Cdc_plane_state=E2=80=9D)
>> =C2=A0=C2=A0=C2=A0which became unnecessary with this refactoring.
>>
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Fixes: 5468c36d628524effbb89a9503eb1a2318804759 ("drm/amd/display: Filt=
er Invalid 420 Modes for HDMI TMDS")
>
> Please truncate the hash to 12 characters.

May longer identifiers (or even the complete SHA-1 ID) occasionally also
be tolerated for the tag =E2=80=9CFixes=E2=80=9D?

How do you think about the proposed change possibilities?

Regards,
Markus
