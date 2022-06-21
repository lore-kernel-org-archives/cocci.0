Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FD8C433EF
	for <cocci@archiver.kernel.org>; Tue, 21 Jun 2022 22:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:references:in-reply-to:message-id:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=iir5kiJDOnqzasUgq3Wu3Snqhl+7vi8hZ6M7L789ZjE=;
  b=dWSovqTOTx65qHN+gqmBOOcaOWgw0fSl2izOCSqphRbOnJKvfx7LSK/N
   EX7Ngj9emcV4xZfxzMW8JO1FcxkrYVqpHQtwJMoO8cI2zqkP+UoKJLq7R
   PzQNfC6zb2KJVE+fpmlnRwMBCAaAf8KZ3gbda4eegUyg6UhPDAMtsx1ra
   U=;
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
X-IronPort-AV: E=Sophos;i="5.92,210,1650924000"; 
   d="scan'208";a="42261144"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jun 2022 00:47:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ABD56E00BA; Wed, 22 Jun 2022 00:47:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AFA98E0094
	for <cocci@sympa.inria.fr>; Wed, 22 Jun 2022 00:47:35 +0200 (CEST)
IronPort-SDR: kMqlXjiySsKV+4OgEZ4w8rG6MKut4k3oQizjMm6X1n0LwCelewXNMvj+AaFCBA/SDVBewLK2kF
 JyRx/WI1tzrQJbAAkeCbbyobdcKDR8le5kwUfda1x3TQ8L0QXk4oSxcc9ZLvezog+XUIdM7OZz
 7GFtEAOQwOAFO71Aiuh9uXPqAc+g7uEKTTUzu6PYDE3dFhItt8X6p+nRLJYF97lERqM5CkE9iq
 KYsSS1+2Xyxa52q+4RpGdT3ltY35BfstyATebNS/m3IPJEtvTvaqHf4LOwnP/gOwiLIoy9FM+w
 PYTTd69saNeSo40fZ3/1Q7iC
X-IPAS-Result: =?us-ascii?q?A0AoAABwSbJifzDaVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAQGCIoEBVi4ETwOEDj2IIV+IDAOBE4sRkEcUgWgLAQMBCwEBOwUCB?=
 =?us-ascii?q?AEBPoRFAoVJAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?AETAQENCwkHCAoHDg4FYAFhAwFEgU+BdAsDMQ1AFgGBXikBg2MBAQEBAgEMB?=
 =?us-ascii?q?hEEGQEbGAUBAwELBgMCCw0CAiYCAhARAhEBBQEcBhMiglyCZAEDDSMDBAuQW?=
 =?us-ascii?q?I8cgQRCijh6fxYFF4EBggkGgUABgwoKGSgNajqBHwIBBgkBCBJtLAGGHIdee?=
 =?us-ascii?q?iccgg2BFTaBBoE3Nz6CIIIKARmDVoJlBI1DigaCCwQOCw8DAwIiAxotIwICA?=
 =?us-ascii?q?QELAgYGBAYDAQEGAwkCBAISAgIEBxgKEggUAwIGAiAFAQcFAQQDEgYMEAEBC?=
 =?us-ascii?q?AYGAQQCCgECAgUFDAMBEQEEAgYCBAQEGBQEAgQHBgIJCQcFFgsECgIWARwCB?=
 =?us-ascii?q?gwFAwICAgICBBUHAQ0FAgIEBwgCBwYDAgkCAwUHAwMEBwwGDA4BAwEHAQQFA?=
 =?us-ascii?q?w0EAQEGAgsDBQoCAQIDDAEBBwQIAQECAgoCAQQCBwECBQMCAwgDAgMDAgIBA?=
 =?us-ascii?q?QQRAgMEAwQCAwEFAQEFAwIFAQMDAgEDAwMCAQQDBgkKBAgBBAQBAQERAgcHA?=
 =?us-ascii?q?gYDAwICAgIFAQINAQIBAgQDCAYCAxQBAgQBCgEFAgMJAgcDAQECBwUKAgcFA?=
 =?us-ascii?q?gcCAgQBBQMNAQMFAgMBAQMDAgQBAgEDAwkBAwIDAwICAgIFAgMCAgIJAwQBB?=
 =?us-ascii?q?wMCAQEEBQEEAwECCgQEAwQCBAIHAgcCBAcCAQQGAwcGBAIBBwEBBAoEAwMDA?=
 =?us-ascii?q?QEHAQIFAgIDAgYSBgcCBAEDBAQKAgIMAgcBAQIBAQEBAgMCBwUMAQEBAwIDB?=
 =?us-ascii?q?gIFAgIBAQMICAMCAQQBBQMBBAUDBwIBBQkCCQMDCQMBAQUBAwEJAwMDAgkDA?=
 =?us-ascii?q?QICAgsEAwgDAwIDBAICAgIBAwIHBQgEAQQKAgICAQICAgQCAQMaAQIDBQICC?=
 =?us-ascii?q?QwBBAICAwEDAQECCAQJBAIDBAIBAQMCAQICAQUCAw0GAQEBAQIDAwECAwEGB?=
 =?us-ascii?q?wIIAjMTAQMDAgECAgIFAgIBAgMCAg0BAQEEAgECAQIGAQMBAgIDAQMBAgIGA?=
 =?us-ascii?q?gwDCAIHAQUDAwICAwEBBQ8FAgEEAgECBgUCAQEBBAEDBAQIAgIBAwMCDgIEA?=
 =?us-ascii?q?QQBAgEBIwMEAgMBAxcBAgECAwMDBAYHBgIBAhMBAgEBAQUBAgEBBAIEBAcKA?=
 =?us-ascii?q?wICAgYDAwUBAQIDAgEBAQcMAgICEwIECgkDAQYBCgYGFQMBAQQCAgECAgIKA?=
 =?us-ascii?q?wECAgEDAgkCAQIBBSQDAQEPJAEBAgIBAgIDBAcCAQQGAw0CAgEBAQUGDQMCA?=
 =?us-ascii?q?wgMAgkDAgIDBQECAgIEAQIEDAoBAgIBAgIEBQUDAgEIBAUNBQkLAQICAQMIA?=
 =?us-ascii?q?QQDEQIGAwUFAwMCAQkBBQIDAQIBAQMBBAEDBAYBAQIDAgIBCAICAQEDAwQDA?=
 =?us-ascii?q?QIGAgIIAgMCAQQCAwMBAQEEAgICAgIEAwgDAgEIBwUBBgECAQQDAgIBAgcBB?=
 =?us-ascii?q?AEJAgEDAwUDBAEKAw8DBQMBAwMCCA0KBAQBBQgEBAkCBAUCBQMCBAIDAwICC?=
 =?us-ascii?q?AMCBAMCDQMCAgYDBAIIFAcCAgMCAgUCAgICAgUEAwECAgIFAgIFAgUEAQUBA?=
 =?us-ascii?q?gICAQICAgQBAgIHBAIDAQMEDgMDBAICCQECAgEEAwEEAgQEAwECAQQDAQEEA?=
 =?us-ascii?q?gIEAQICBQUGJwEBBRhMmkwtBgEBLE4TARMIECAPUUU4BR2SbjeNZItflAZrY?=
 =?us-ascii?q?IIRZ4sfjneGLpZVkg6Wbo0ug1qQdw+EfwIKBwYQIxKBLIIVTSMVOzGCNxM7A?=
 =?us-ascii?q?QIBAQENAQIBAQMBAgECCQEBAo4dDBYVgzuFFIVMPzQCAQEBNgIGAQoBAQMJg?=
 =?us-ascii?q?jqDCiYTCwGFUIMoAQE?=
IronPort-PHdr: A9a23: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
 10Dxraqdewu
IronPort-Data: A9a23:nddi5a6Vjiu2+ptFTLsU4AxRtPnBchMFZxGqfqrLsTDasY5as4F+v
 mAWUGyFP/veYjSkeN9+YIuw80wCupGAn9VgGwM/qCtgZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2OaEvfDjW1nX4
 Y2o+pWFULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 PZMn5O3CikxBIjzvbgTaRZ+EhlVEIQTrdcrIVDn2SCS50jPcn+pzvc3SU9qbcsX/eF4BWwI/
 vsdQNwPRkrb1qTmnfThE7kq2pRLwMrDZOvzvllp0zjDBPwOTpXKQqGM7thdtNs1rpwUR6iHP
 pZDAdZpRCj7WCVXNgsQNI0ZsNWroXO4fjt+uV3A8MLb5ECKlFAruFT3C/LRc8ODQcF9jEedr
 HjPuWX/GBATctKFoRKO9Xmnh8fUjCbjUcQTEqe5/7hkmjWuKnc7DRQXUR62o6D8hBLuHd1YL
 EMQ92wlqq1aGFGXosfVfBySr3nHkAYmfuV1T+MA5yeM8oH5ylPMboQbdQJpZNsjvc4wYDUl0
 F6Vgt/kbQCDVpXFGRpxEZ/E/VuP1TgpwXwqPnBbEFNUizX3iMRi0UKVF4cL/Lud14WtQVnNL
 ya2QD/Sboj/YOYO3qS/uF3F2nei+siPQQky6QHaGGmi62uVhbJJhaT4uTA3Dt4adO51q2VtW
 lBaxaByC8hQU/mweNSlGrllIV1Qz6/t3MfgqVBuBYI90D+m5mSue4tdiBkneho0Yp1aI2W3O
 h6C0e+02HO1FCv6BUOQS9LhY/nGMYC9fTgYfquJMYYWOcQZmPGvpXE1ORb4M5/RfLgEyPljY
 /93gO6jCnEVDakP8dZFb7Z17FPf/QhnnTm7bcmjkXyPiOPCDFbIF+ptGAbRNogRsfLcyC2Io
 o03H5bbm313DreiCgGJqtV7BQ5RfRAG6WXe8ZM/mhireVo4RgnMypb5ndscRmCSt/0Kz72Yp
 S7mAxEwJZiWrSSvFDhmo0tLMNvHNauTZ1piVcD1FVr3iXUlf6i166ITK8k+cbU9pb5syPd1S
 78OfMDZWqZDTTHO+jI8a5jhrdw6JE77217WZyf1MiIie5NARhDS/oC2cwbq8h4IBHXluMY7p
 YqmyQ6GE4EIQB5vDZqNZf/2lwGxsHERlfhcRUzNJtUPKkzg/JI7eSP0h/4zZcoLLEyblDed0
 g+XBzYepPXM89dlqomX2fjcot7wQeVkH0dcE23K1pqMNHHXrji53ItNcOeUZjSCBm75/aOVY
 +8KnfzxNfswmkkT79hxHrNt+qIJ59X1oohcwAk5Tm7AaE6mC+85L3SLgZtPu6lKyuMLsAe6Q
 BjUqNxTOLHMNcG8VVBNdEwqaeOM0fxSkT7XtKxnLEL/7S5x3byGTUQCYEXW2XIFdON4YNE/3
 OMsmM8K8Ajj2BAkBdCL03JP/GOWI31cDqgq6sMADInwhlZ5w11Oe8aHWCr/4ZXKZtcVd0d2c
 nmbg63Ng7kazU3HKiJhGX/I1OtbpJIPpBEakwNYdgrRwoLI1q0twRlc0TUrVQAJnB9J5OR+Z
 zpwPEpvKKTSojpliaCvhYx3992t2fFYxqDw97fNvGjQTk3tW26UaWNhaaCC+0cW928adT9el
 F1dJKAJTh6yFPwdHANrMaKmlxAnZdN0/wzG3sugGqxp2rEkNCH9jPbGiXUg8nPa7ABYuKEDj
 eZv9ed0L6b8MEb8ZkH955ayjdwtdfxPGICOrTyNMk/E8aEwtQxeAQSzFn0=
IronPort-HdrOrdr: A9a23:efK7/6G9SE/yNbmEpLqEIseALOsnbusQ8zAXPo5KOHhom6uj5r
 +TdZUgpGPJYVMqMk3I9urwXpVoLUmsl6JdwY5UJru6WRmjpW3AFvAY0WKA+UycJ8SdzJ8m6U
 4IScEXY72AbmSSz/yKmTVQe+xA/DDtytHOuQ6x9QYJcShXca16qw92BgGHe3cGPDWuxqBUKH
 Nf3Kd6TvabFkj/p/7UOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,210,1650924000"; 
   d="scan'208";a="42261142"
X-MGA-submission: =?us-ascii?q?MDEpYddSEEQLx/5UtWpVNo+CTuuRrUL4U70slf?=
 =?us-ascii?q?wRnkqjqElBeQEDgOA6RgilwUiIEEl8LBGrdWG3twltS9nIUH9e7GPLox?=
 =?us-ascii?q?brz3Gp7I07vOuvissSeoZBoB9Vu9j9uDAV5XI9EFZrg4VtPKXKB1DIbo?=
 =?us-ascii?q?E0/v7ei3JLfefL1H/+uzUC7w=3D=3D?=
Received: from mail-ej1-f48.google.com ([209.85.218.48])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 00:47:35 +0200
Received: by mail-ej1-f48.google.com with SMTP id fu3so30469639ejc.7;
        Tue, 21 Jun 2022 15:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iir5kiJDOnqzasUgq3Wu3Snqhl+7vi8hZ6M7L789ZjE=;
        b=H48+Z2n+yiwE/CwDKy8N+G94S7XjnXAwul3BuyMa+K/yNg++FR1A8QCeHD+g17AqzL
         cxKZFmWEGH3dLt1ij0P1+FAsEg49/RDxROqaRO7+/EHrgvuiW0Qm6SYq7M7tIN2+PeGO
         ikFsL4hgnPvXHv4oOzwQ+G8uB+2+2nzyqLSbSzOLTCMbCAgBwl+p2Vxv/iusEcG0n97X
         CiZ0kL8Gw/GGW1EyjaApzJyoGYobu+CCICBscgu4lUHurYNrS9EIc/x7dFn+hOPEG1+E
         NF/FBx9mD/ZznRpqLveDuEbajhnDnVvOOQLckMZiVuLcz45P3coRWpT90WYPwXkSvmu+
         5p7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iir5kiJDOnqzasUgq3Wu3Snqhl+7vi8hZ6M7L789ZjE=;
        b=21yMrI25lVW+VnlZfmtTdA38jhn4FvfNyBLBYr/IUksMKd2l4oPiLZGRKpJzmPa3Cw
         rC8QhHPUH1aiko5meituo5hMABvFAF+mqG3Dq2tAsm1tgQoPWDdmSDivsS4GenlrE4FN
         qBp8GylslZ5lqQ/2R47s7Qd69rhQEeru+y5vJ+g4oizsORA/5u4MgFKcgr7p0OfxEIUq
         1dh6VdW7yX8fYpGve5Ori8iCf6NswsUS5GHz04VypusAX2OgiCsczFRzCQ4kGE4ddqD2
         lQiSk8aNp4jJBGg6374Yjnu1xMBD4RO19sZP7Bh70YzC6WENoWUv4xAlJZPdq3PBmXF3
         0r1w==
X-Gm-Message-State: AJIora+9GMtWsL2k6K3KGxO0fZPzMAhiJVoxvhf5TZLdtPH8+/3YEvNs
	eqzAZJlZ2ZWj+HkSSew8cpYGk82dgnx6iA==
X-Google-Smtp-Source: AGRyM1sxqaYjpZ8Oi0bsXueJ3Y5AQbW2Sqa56H6p9200ZsVEvH3ca6fSArHLQepyIU4HPgcOSZTyNg==
X-Received: by 2002:a17:906:9b86:b0:6fe:d37f:b29d with SMTP id dd6-20020a1709069b8600b006fed37fb29dmr317558ejc.327.1655851654051;
        Tue, 21 Jun 2022 15:47:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d5-20020a170906344500b006fed062c68esm8088399ejb.182.2022.06.21.15.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:47:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
	(envelope-from <avarab@gmail.com>)
	id 1o3mei-000ZMJ-Mn;
	Wed, 22 Jun 2022 00:47:32 +0200
From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Date: Wed, 22 Jun 2022 00:44:49 +0200
References: <patch-1.1-7d90f26b73f-20220520T115426Z-avarab@gmail.com>
 <220520.86tu9k1iwq.gmgdl@evledraar.gmail.com>
 <alpine.DEB.2.22.394.2205201525400.2929@hadrien>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <alpine.DEB.2.22.394.2205201525400.2929@hadrien>
Message-ID: <220622.86zgi5ljln.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Matching VAR followed by foo(VAR) with no other use of
 VAR in the function
Reply-To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 450
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/220622.86zgi5ljln.gmgdl%40evledraar.gmail.com>


On Fri, May 20 2022, Julia Lawall wrote:

Late reply, but this was very useful, and I have some findings &
improved rule based on your feedback.

> On Fri, 20 May 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>
>> I came up with the below patch today to find code in git where we e.g.:
>>
>>     struct strbuf sb =3D STRBUF_INIT;
>>     /* code here that doesn't use "sb" at all */
>>     strbuf_release(&sb);
>>
>> I.e. "unused" code that the compiler wouldn't spot. The rule quoted
>> below works, briefly:
>>
>>     - T I =3D INIT;
>>       <+... when !=3D \( I \| &I \)
>>     - \( REL1 \| REL2 \)(&I, ...);
>>       ...+>
>>
>> But I noticed that it didn't spot some other cases, so I tried this:
>>
>> 	diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unuse=
d.cocci
>> 	index 52c23e15310..25c322fa1ff 100644
>> 	--- a/contrib/coccinelle/unused.cocci
>> 	+++ b/contrib/coccinelle/unused.cocci
>> 	@@ -10,6 +10,5 @@ identifier REL2 =3D~ "^(release|clear|free)_[a-z_]*$";
>> 	 @@
>>
>> 	 - T I =3D INIT;
>> 	-  <+... when !=3D \( I \| &I \)
>> 	+  ... when !=3D \( I \| &I \)
>> 	 - \( REL1 \| REL2 \)(&I, ...);
>> 	-  ...+>
>
> This is what I would have suggested.  What you had before looked at the
> whole function, and not just the region between T I =3D INIT; and \( REL1=
 \|
> REL2 \)(&I, ...);

Ah, in this case that's really important though, because for these APIs
you can "use after free", i.e. it's resetting a struct on "release".

>>
>> Which helpfully catches other cases, e.g. now we spot this, which looks
>> like an artifact of me using <+... (one or more lines?):
>>
>> 	diff --git a/graph.c b/graph.c
>> 	index 568b6e7cd41..ba57f56fcb1 100644
>> 	--- a/graph.c
>> 	+++ b/graph.c
>> 	@@ -350,8 +350,6 @@ struct git_graph *graph_init(struct rev_info *opt)
>> 	                        graph_set_column_colors(column_colors_ansi,
>> 	                                                column_colors_ansi_max);
>> 	                } else {
>> 	-                       static struct strvec custom_colors =3D STRVEC_I=
NIT;
>> 	-                       strvec_clear(&custom_colors);
>> 	                        parse_graph_colors_config(&custom_colors, strin=
g);
>> 	                        free(string);
>> 	                        /* graph_set_column_colors takes a max-index, n=
ot a count */
>>
>> But that modification also produces some broken patches, e.g.:
>>
>> 	diff --git a/builtin/rm.c b/builtin/rm.c
>> 	index 84a935a16e8..7e2b4355713 100644
>> 	--- a/builtin/rm.c
>> 	+++ b/builtin/rm.c
>> 	@@ -395,13 +395,12 @@ int cmd_rm(int argc, const char **argv, const cha=
r *prefix)
>> 	         * any file at all, we'll go ahead and commit to it all:
>> 	         * by then we've already committed ourselves and can't fail
>> 	         * in the middle)
>> 	         */
>> 	        if (!index_only) {
>> 	                int removed =3D 0, gitmodules_modified =3D 0;
>> 	-               struct strbuf buf =3D STRBUF_INIT;
>> 	                int flag =3D force ? REMOVE_DIR_PURGE_ORIGINAL_CWD : 0;
>> 	                for (i =3D 0; i < list.nr; i++) {
>> 	                        const char *path =3D list.entry[i].name;
>> 	                        if (list.entry[i].is_submodule) {
>> 	                                strbuf_reset(&buf);
>> 	                                strbuf_addstr(&buf, path);
>> 	@@ -417,13 +416,12 @@ int cmd_rm(int argc, const char **argv, const cha=
r *prefix)
>> 	                                removed =3D 1;
>> 	                                continue;
>> 	                        }
>> 	                        if (!removed)
>> 	                                die_errno("git rm: '%s'", path);
>> 	                }
>> 	-               strbuf_release(&buf);
>> 	                if (gitmodules_modified)
>> 	                        stage_updated_gitmodules(&the_index);
>> 	        }
>>
>> 	        if (write_locked_index(&the_index, &lock_file,
>> 	                               COMMIT_LOCK | SKIP_IF_UNCHANGED))
>>
>> I.e. here &buf is used between the two lines, so this wouldn't compile.
>>
>> I suspect this is all because that "WHEN !=3D &I" isn't doing what I
>> expect it to do, but I can't find what I'm missing.
>
> I think that the problem is due to the continue.  Try adding when strict,
> which should force it to check all of the execution paths, including the
> ones that look like error handling code.

Don't you mean the opposite? That you need to remove "when strict" to
have it check all paths?

I updated the rule & applied it here with "when strict":
https://lore.kernel.org/git/patch-v2-1.2-d14036521ab-20220621T223954Z-avara=
b@gmail.com/

But as you can see here without "when strict" it finds more cases, and
those are all ones where a "continue" or "return" is in the code matched
with the "...":
https://lore.kernel.org/git/patch-v2-2.2-4130dc15287-20220621T223954Z-avara=
b@gmail.com/


>> I also tried to come up with a rule for matching a similar pattern where
>> code like this does nothing useful:
>>
>> 	static void foo(void)
>> 	{
>> 	        struct strbuf sb;
>> 	        strbuf_init(&sb, 0);
>> 	        // fprintf(stderr, "%s", sb.buf); // not if this is here
>> 	        strbuf_release(&sb);
>> 	        // strbuf_reset(&sb); // nor this
>> 	}
>>
>> And came up with:
>>
>> 	@@
>> 	identifier I;
>> 	@@
>>
>> 	- struct strbuf I;
>> 	  ... when !=3D \( I \| &I \)
>> 	- strbuf_init(&I, ...);
>> 	  ... when !=3D \( I \| &I \)
>> 	- strbuf_release(&I);
>> 	  ... when !=3D \( I \| &I \)
>>
>> Which seems to do the right thing, but given how the rm.c case behaved
>> above I don't understand why it won't fire if I uncomment that code
>> (which is good!) but the strbuf_reset(&buf) case above isn't caught.
>>
>> Full diff quoted below, and also at
>> https://lore.kernel.org/git/patch-1.1-7d90f26b73f-20220520T115426Z-avara=
b@gmail.com/
>>
>> On Fri, May 20 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> > Add a coccinelle rule to remove variable initialization followed by
>> > calling a "release" function. This rule automatically finds the sort
>> > of issue patched in[1], and more.
>> >
>> > We happened to only have occurrences of strbuf_release() matching this
>> > rule, but manual testing reveals that it'll find e.g. the same pattern
>> > if "string_list_clear()" were used instead.
>> >
>> > 1. https://lore.kernel.org/git/042d624b8159364229e95d35e9309f12b67f817=
3.1652977582.git.gitgitgadget@gmail.com/
>> >
>> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> > ---
>> >
>> > This overlaps but cleanly merges with the small series that [1] is in,
>> > but just adding a coccinelle rule to catch this seemed like a good
>> > thing to have. We even have another such case in builtin/merge.c, near
>> > the change made in [1]!
>> >
>> > FWIW I wrote this working rule too, but there were no in-tree hits for
>> > it, so I didn't include it:
>> >
>> > 	// Unused declaration + malloc + free()
>> > 	@@
>> > 	identifier I;
>> > 	type T;
>> > 	// malloc(), xmalloc(), calloc() etc.
>> > 	identifier MALLOC =3D~ "^x?[mc]alloc$";
>> > 	@@
>> >
>> > 	(
>> > 	- T *I;
>> > 	  ... when !=3D I
>> > 	- I =3D MALLOC(...);
>> > 	|
>> > 	- T *I =3D MALLOC(...);
>> > 	)
>> > 	  ... when !=3D I
>> > 	- free(I);
>> >
>> >  builtin/fetch.c                 |  3 +--
>> >  builtin/merge.c                 |  4 ----
>> >  builtin/repack.c                |  2 --
>> >  contrib/coccinelle/unused.cocci | 15 +++++++++++++++
>> >  diff.c                          |  2 --
>> >  5 files changed, 16 insertions(+), 10 deletions(-)
>> >  create mode 100644 contrib/coccinelle/unused.cocci
>> >
>> > diff --git a/builtin/fetch.c b/builtin/fetch.c
>> > index e3791f09ed5..600c28fdb75 100644
>> > --- a/builtin/fetch.c
>> > +++ b/builtin/fetch.c
>> > @@ -1113,7 +1113,7 @@ static int store_updated_refs(const char *raw_ur=
l, const char *remote_name,
>> >  			      struct fetch_head *fetch_head, struct worktree **worktrees)
>> >  {
>> >  	int url_len, i, rc =3D 0;
>> > -	struct strbuf note =3D STRBUF_INIT, err =3D STRBUF_INIT;
>> > +	struct strbuf note =3D STRBUF_INIT;
>> >  	const char *what, *kind;
>> >  	struct ref *rm;
>> >  	char *url;
>> > @@ -1281,7 +1281,6 @@ static int store_updated_refs(const char *raw_ur=
l, const char *remote_name,
>> >
>> >   abort:
>> >  	strbuf_release(&note);
>> > -	strbuf_release(&err);
>> >  	free(url);
>> >  	return rc;
>> >  }
>> > diff --git a/builtin/merge.c b/builtin/merge.c
>> > index f178f5a3ee1..bb6b0580659 100644
>> > --- a/builtin/merge.c
>> > +++ b/builtin/merge.c
>> > @@ -375,7 +375,6 @@ static void reset_hard(const struct object_id *oid=
, int verbose)
>> >  static void restore_state(const struct object_id *head,
>> >  			  const struct object_id *stash)
>> >  {
>> > -	struct strbuf sb =3D STRBUF_INIT;
>> >  	const char *args[] =3D { "stash", "apply", NULL, NULL };
>> >
>> >  	if (is_null_oid(stash))
>> > @@ -391,7 +390,6 @@ static void restore_state(const struct object_id *=
head,
>> >  	 */
>> >  	run_command_v_opt(args, RUN_GIT_CMD);
>> >
>> > -	strbuf_release(&sb);
>> >  	refresh_cache(REFRESH_QUIET);
>> >  }
>> >
>> > @@ -501,7 +499,6 @@ static void merge_name(const char *remote, struct =
strbuf *msg)
>> >  {
>> >  	struct commit *remote_head;
>> >  	struct object_id branch_head;
>> > -	struct strbuf buf =3D STRBUF_INIT;
>> >  	struct strbuf bname =3D STRBUF_INIT;
>> >  	struct merge_remote_desc *desc;
>> >  	const char *ptr;
>> > @@ -589,7 +586,6 @@ static void merge_name(const char *remote, struct =
strbuf *msg)
>> >  		oid_to_hex(&remote_head->object.oid), remote);
>> >  cleanup:
>> >  	free(found_ref);
>> > -	strbuf_release(&buf);
>> >  	strbuf_release(&bname);
>> >  }
>> >
>> > diff --git a/builtin/repack.c b/builtin/repack.c
>> > index d1a563d5b65..52f8450f1be 100644
>> > --- a/builtin/repack.c
>> > +++ b/builtin/repack.c
>> > @@ -609,7 +609,6 @@ int cmd_repack(int argc, const char **argv, const =
char *prefix)
>> >  	struct child_process cmd =3D CHILD_PROCESS_INIT;
>> >  	struct string_list_item *item;
>> >  	struct string_list names =3D STRING_LIST_INIT_DUP;
>> > -	struct string_list rollback =3D STRING_LIST_INIT_NODUP;
>> >  	struct string_list existing_nonkept_packs =3D STRING_LIST_INIT_DUP;
>> >  	struct string_list existing_kept_packs =3D STRING_LIST_INIT_DUP;
>> >  	struct pack_geometry *geometry =3D NULL;
>> > @@ -955,7 +954,6 @@ int cmd_repack(int argc, const char **argv, const =
char *prefix)
>> >  	}
>> >
>> >  	string_list_clear(&names, 0);
>> > -	string_list_clear(&rollback, 0);
>> >  	string_list_clear(&existing_nonkept_packs, 0);
>> >  	string_list_clear(&existing_kept_packs, 0);
>> >  	clear_pack_geometry(geometry);
>> > diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unus=
ed.cocci
>> > new file mode 100644
>> > index 00000000000..52c23e15310
>> > --- /dev/null
>> > +++ b/contrib/coccinelle/unused.cocci
>> > @@ -0,0 +1,15 @@
>> > +// Unused init assignment + release()
>> > +@@
>> > +identifier I;
>> > +type T;
>> > +constant INIT =3D~ "_INIT";
>> > +// stbuf_release(), string_list_clear() etc.
>> > +identifier REL1 =3D~ "^[a-z_]*_(release|clear|free)$";
>> > +// release_patch(), clear_pathspec() etc.
>> > +identifier REL2 =3D~ "^(release|clear|free)_[a-z_]*$";
>> > +@@
>> > +
>> > +- T I =3D INIT;
>> > +  <+... when !=3D \( I \| &I \)
>> > +- \( REL1 \| REL2 \)(&I, ...);
>> > +  ...+>
>> > diff --git a/diff.c b/diff.c
>> > index ef7159968b6..57997937071 100644
>> > --- a/diff.c
>> > +++ b/diff.c
>> > @@ -1289,7 +1289,6 @@ static void emit_diff_symbol_from_struct(struct =
diff_options *o,
>> >  {
>> >  	static const char *nneof =3D " No newline at end of file\n";
>> >  	const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
>> > -	struct strbuf sb =3D STRBUF_INIT;
>> >
>> >  	enum diff_symbol s =3D eds->s;
>> >  	const char *line =3D eds->line;
>> > @@ -1521,7 +1520,6 @@ static void emit_diff_symbol_from_struct(struct =
diff_options *o,
>> >  	default:
>> >  		BUG("unknown diff symbol");
>> >  	}
>> > -	strbuf_release(&sb);
>> >  }
>> >
>> >  static void emit_diff_symbol(struct diff_options *o, enum diff_symbol=
 s,
>>
>>

