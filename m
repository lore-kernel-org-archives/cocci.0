Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01999C433EF
	for <cocci@archiver.kernel.org>; Sat,  2 Apr 2022 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=FkN+tNbxU9/ejpMUJB/SdfAQYhIjiXtAyCLNTQjZm88=;
  b=Hb9ol6+yEnHQWwFirmfTQzOt6kuJnM5QrkBT0ebqPaHuF1jz6Y2AvMlh
   7TDyWb2SEmW1WRLdYmF50PsvPURGy71kYnHeFsAT2xixaXd3+pkg/bhhc
   fV5b89ozoY1IyYI1i+8puXEnz+mBy7LlWrQVsJc/gjr/f9Nwr8fNbrPrT
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,230,1643670000"; 
   d="scan'208";a="29688335"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Apr 2022 17:47:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 05343E0297; Sat,  2 Apr 2022 17:47:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 25255E00A8
	for <cocci@sympa.inria.fr>; Sat,  2 Apr 2022 17:47:07 +0200 (CEST)
IronPort-SDR: uyJ8OnQ39cptYC1Nwke1Ni9AeOFLq1ihZ7QFfRM+yVR3WQwM3fOQ2VF5HMSIW17f3cyQmn4lJ7
 BJYHWR4tscbA8xBhbYwCh4IEdDhSJrm0HsgqBrYI7IcjkARmjrG98d/82FXUNkDmgcPsaaacSA
 dVImGvLeHLcAXN73UoUyEfb9/L/DekZTUrKrKPZs0uubrb+9Q3uItNSoK+idKb8I0+9pxax0Fm
 GaWfQQbXda76h0MmwbrbTNPsWjigYeEUI90ZGhvlw9I4j1jVv+ILO8OjWP75Qd4tFiDmnlZlpL
 6wpMUCapu4d7m7l4q9xoCsdi
X-IPAS-Result: =?us-ascii?q?A0BZAwDUb0hif6nQVdFaHgEBCxIMQIQCgVUrBIUjsAkBA?=
 =?us-ascii?q?wEMAUMEAQGJYwIdBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?AETAQENCwkHCAoCBQ4OBWABRWSBT4F3CAMBPYI1IoQEEQQRdgImAjYBBQEWG?=
 =?us-ascii?q?QgBAR6CYoMXBKJAgQQ9izJ/MoEBhGyFEAkBCH4sjnUcgg2BPAyIR4JNgmUEn?=
 =?us-ascii?q?E2ib1yeJoNThBabUgYPBS6DYpJjFIElkFGFbZBxpmMCCgcGECOBVVCBLjMaC?=
 =?us-ascii?q?BsVgyVNAQIBAQENAQICAQIBAgECCQEBAo1zAQEBjno+bAIGCwEBAwmQBgEB?=
IronPort-PHdr: A9a23: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
 57Ek6ehcF9/
IronPort-Data: A9a23:CN5VuaJjCoVMS/6SFE+R65MlxSXFcZb7ZxGr2PjKsXjdYENS1TMOz
 TNNCG6PPvmMYDH3c48naI/np0IOusWDzNVmHVEd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhX1vX4
 YqaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhnshr9
 cttqb2KSCgXO4DNvN8NczJRDHQrVUFG0OevzXmXtMWSywjCcSKpzawwXQc5OooX/usxCmZLn
 RAaAGpVP1bT2qTsmOL9E7c97iggBJGD0Ic3q3xu1zzcCuhgTZ3FQr7i6tpR3TN2jcdLdRrbT
 5BIN2o/N0+aC/FJEl0lEtFjruLvuiLiTSRqul+0ga4bwFGGmWSd15C0aIaPEjCQfu1emU2Tp
 0rd7mHhC1cbMsaewHyL6BqRavTnmCr6XMcWFuT9+Kc00RucwWscDBBQXly+yRWktqKgc9NHM
 XEK2jYPl6kdykmGT/3GTz2TqWHR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9hDoO5J9eqdsCh
 g/hoj/5OdB8mObKFi/Fp994uRv3aHdFdzZTDcMRZVJdu4GLnW0lsv7Yoj9e/EOdi9T0HXT0w
 WnPonFg1vMciskE06j99lfC695NmnQrZl5rjuk0djj9hu+cWGJDT9LygbQ8xagbRLt1tnHb4
 BA5dzG2tYji962lmi2XW/kqF7q0/fuDOzC0qQcxQ8lxq2nwoCP6LdA4DNRCyKFBYpZsldjBM
 B+7hO+tzMI70IaCMfcnMtvpVazGM4CwRY6/Bpg4keaikrAoLFPdlM2fTUGX2G/pnSARfVIXa
 P+mnTKXJS9CU8xPlWLoL89EiOdD7nlnmQv7GM6mpzz6juL2TCPEEd8tbQrVBshkvfPsiFuPr
 753aZDRoz0BC72WX8Ui2dRMRbz8BSNrW86eRg0+XrLrHzeK70l6UKCBmepxItM990mX/8+Rl
 kyAtoZj4AKXrRX6xc+iMBiPsZvjAsRyq2wVJyspMQr60nQve9f946IWdp9xdr4irbQxwflxR
 vgDWsOBHvUfEmSdq2pBNcHw/N54aRCmpQOSJC76MjUyephXQQaWqNLpew3Y8jYDU3isvswkr
 rz8jQ7WGMJRRwlrAMvMRuioyle94SoUlO5oDhnMI99OaAPn940zc379ifo+IsctLxTfx2TFj
 1vMUElA/eSU+t076tjEg6yAvryFKeomExoIBXTf4Ja3KTLepzLxy4F3SPyPeCvFWm6pqr6pY
 v9Yzq6tPaRfzkpKqYd1D51i0bk6u4n0v7ZfwwlpQCfLYlCsBu8yK3WKx5MT5KhEx7scvQnvH
 0zWpIgcNrKON8foVlUWIVN9POiE0PgVnBjU7Og0cBqmvn4ppOLfXBUAJQSIhQxcMKBxbNEvz
 9AntZNE8Ae4kBcrbouLg3wG7WiKNXBcAawruotAXN3ugwsvj1VAONnSU3Gnpp6IbNpIPw8hJ
 TrN3PjOgLFVx0zjdXsvFCiSgbAM28xW4B0ankUfI1mpm8begqNl1hNm9zlqHB9eyQ9K0r4uN
 2VmX6GvyX5iI9u6aAl/s2GQ98VpARSY/gn1yQJMmjSHHg+nUWvCKGB7MuGIlKzcH6SwYRADl
 Ix0Ck68OdopQC019iQ3UE9h7ffkSLSdMyXczdu/EZ3t84YSOFLYb2zHWYbMgx/mB94hwkbAo
 IGGOQq2hbLTbUYtnkHwN2VWOXn8hvxJyKyujMyNJJ80IFw=
IronPort-HdrOrdr: A9a23:H4QDNaGGjd8CWDyYpLqE2ceALOsnbusQ8zAXPjNKOHhom6uj5r
 uTdZUgpGfJYVkqKRIdcLy7Sc+9qBDnhPxICOsqXYtKNTOO0ADIEGgL1+XfKlbbalTDH4BmpM
 BdmuRFebjN5JtB4PoSIjPTLz/t+rW6GWmT6tvj8w==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,230,1643670000"; 
   d="scan'208";a="29688332"
X-MGA-submission: =?us-ascii?q?MDF5/6Fo5irXJDDAn10atAtv8WVl4WAxvMjnVi?=
 =?us-ascii?q?MbNzj8Q+RKh5IApSHei6RtJA5j2JOjPYGjHInvXsORkkbuZCCglO7zUH?=
 =?us-ascii?q?z+qwIsD4bvK6PCYF2jNJLzNSCQHadG7T5lCBm3dEBl8NqsbfUZiOCwvZ?=
 =?us-ascii?q?Y4BEpDhWxkbuO4ng9gBV5G5Q=3D=3D?=
Received: from mail-lj1-f169.google.com ([209.85.208.169])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 17:46:53 +0200
Received: by mail-lj1-f169.google.com with SMTP id 17so7537906ljw.8
        for <cocci@inria.fr>; Sat, 02 Apr 2022 08:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=FkN+tNbxU9/ejpMUJB/SdfAQYhIjiXtAyCLNTQjZm88=;
        b=Pd8ImyWQlBG4cKlV9/M301q2SX7otiMUQHPuFXvoFzMO4E5sWHjtg3sq4miFdC2FT1
         GaUI/rNrsetFA22AwszIu+z7UV4Y32KyckXJj55YYSvmLgawmOvD2HgHRVYtA+xgn4XQ
         xncBj5WoIMgJDuFMgfcwVzbojteli5fXvBpdEUhMxdgPHr0yQqtwYdaqH83qwhDlrSOk
         Aidsp5eUSkp/x4MqapBjVZ2TRepKCs2gCoYuxEojapSvTDHb5J8EWqBZAxhvy/WciJkq
         F2lMAl4PZJxruILM3cS6xaBjOlYg2EdkFh/Kh3CBLUnYFsa8grYFdUpYrp0pQvr5/ifK
         /Xdw==
X-Gm-Message-State: AOAM531/BEOXwL/ESdw8aaDXnbQoSyaRm6keSdleOwXzzTprwBTHkDKR
	QIkBix7vNmPbuiC8baH62TKowQkX/YE=
X-Google-Smtp-Source: ABdhPJznSZJzZXCbf7w9nbBG9NQkzfAq4DKOavGMqojT3oV+W0feDw0evOFhw7uZsUgvvPWxvmmhpg==
X-Received: by 2002:a05:651c:248:b0:245:5b3d:9abb with SMTP id x8-20020a05651c024800b002455b3d9abbmr16332140ljn.366.1648914411868;
        Sat, 02 Apr 2022 08:46:51 -0700 (PDT)
Received: from [10.68.32.117] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id q2-20020a196e42000000b0044a7c896e54sm558243lfk.209.2022.04.02.08.46.51
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 08:46:51 -0700 (PDT)
Message-ID: <604dee67-dbd0-2994-f6a3-b06675c931b6@linux.com>
Date: Sat, 2 Apr 2022 18:46:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: cocci@inria.fr
From: Denis Efremov <efremov@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [cocci] coccinelle match fail
Reply-To: Denis Efremov <efremov@linux.com>
X-Loop: cocci@inria.fr
X-Sequence: 332
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/604dee67-dbd0-2994-f6a3-b06675c931b6%40linux.com>

Hi,

for some reason this pattern doesn't match.

/// git checkout 96518518cc417bb0a8c80b9fb736202e28acdf96
/// spatch test.cocci net/netfilter/nf_tables_core.c

@err exists@
identifier data, expr;
@@

nft_do_chain(...)
{
	...
*	struct nft_data data[NFT_REG_MAX + 1];
	...
*	expr->ops->eval(..., &data, ...);
	...
}

These 2 lines doesn't match simultaneously. If you comment out one
of them the pattern will match. Could you help me to understand
what could be the problem here?

Thanks,
Denis Efremov
